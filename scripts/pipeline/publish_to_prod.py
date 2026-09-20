"""
publish_to_prod.py
Publie les questions en statut 'ready' depuis staging vers production.

Garanties :
- Claim ATOMIQUE via UPDATE ... FOR UPDATE SKIP LOCKED (un seul processus par lot)
- Récupération des lignes 'processing' abandonnées (timeout configurable)
- Chaque ligne ne peut être publiée qu'une seule fois (guard published_q_id IS NULL)
- Idempotent : relancer après crash ne crée pas de doublon

Usage:
    python publish_to_prod.py [--batch BATCH_ID] [--dry-run]
    python publish_to_prod.py --recover  # Libère les lignes processing bloquées
"""

import argparse
import json
import os
import sys
import psycopg2
import psycopg2.extras

DB_URL = os.environ.get("DATABASE_URL", "")

# Délai au-delà duquel une ligne 'processing' est considérée abandonnée
PROCESSING_TIMEOUT_MINUTES = 30


def recover_stale_processing(cur):
    """Remet en 'ready' les lignes processing abandonnées depuis plus de PROCESSING_TIMEOUT_MINUTES."""
    cur.execute(
        """
        UPDATE questions_staging
        SET statut = 'ready', processing_started_at = NULL
        WHERE statut = 'processing'
          AND processing_started_at IS NOT NULL
          AND processing_started_at < NOW() - INTERVAL '%s minutes'
        RETURNING id
        """,
        (PROCESSING_TIMEOUT_MINUTES,)
    )
    recovered = cur.fetchall()
    if recovered:
        ids = [r["id"] for r in recovered]
        print(f"Récupération: {len(ids)} lignes 'processing' remises en 'ready' (ids: {ids})")
    return len(recovered)


def claim_ready_rows(cur, batch_id=None):
    """
    Réclame atomiquement les lignes 'ready' en les passant à 'processing'.
    Utilise SELECT FOR UPDATE SKIP LOCKED pour garantir l'exclusivité.
    Retourne les lignes réclamées.
    """
    batch_filter = "AND batch_id = %(batch_id)s" if batch_id else ""
    params = {"batch_id": batch_id, "timeout": PROCESSING_TIMEOUT_MINUTES}

    cur.execute(
        f"""
        WITH claimed AS (
            SELECT id FROM questions_staging
            WHERE statut = 'ready'
              AND published_q_id IS NULL
              {batch_filter}
            ORDER BY id
            FOR UPDATE SKIP LOCKED
        )
        UPDATE questions_staging
        SET statut = 'processing',
            processing_started_at = NOW()
        FROM claimed
        WHERE questions_staging.id = claimed.id
        RETURNING questions_staging.*
        """,
        params
    )
    return cur.fetchall()


def run(batch_id=None, dry_run=False, recover=False):
    if not DB_URL:
        print("ERREUR: DATABASE_URL non défini", file=sys.stderr)
        sys.exit(1)

    conn = psycopg2.connect(DB_URL, cursor_factory=psycopg2.extras.RealDictCursor)
    conn.autocommit = False
    cur = conn.cursor()

    # Étape 1 : Récupérer les lignes abandonnées (toujours, même sans --recover)
    n_recovered = recover_stale_processing(cur)
    conn.commit()

    if recover:
        print(f"Mode --recover uniquement. {n_recovered} ligne(s) récupérée(s).")
        conn.close()
        return True

    # Compter la production avant
    cur.execute("SELECT COUNT(*) AS n FROM questions")
    n_before = cur.fetchone()["n"]

    if dry_run:
        # En dry-run, on lit sans claim
        query = "SELECT * FROM questions_staging WHERE statut = 'ready' AND published_q_id IS NULL"
        params = []
        if batch_id:
            query += " AND batch_id = %s"
            params.append(batch_id)
        cur.execute(query, params)
        ready = cur.fetchall()
        print(f"[DRY-RUN] {len(ready)} question(s) seraient publiées")
        for q in ready:
            print(f"  id_staging={q['id']} {q['v4_mat_canonical']} {q['v4_niveau']} | {q['enonce'][:70]}")
        conn.close()
        return True

    # Étape 2 : Claim atomique
    claimed = claim_ready_rows(cur, batch_id)
    conn.commit()  # Commit immédiat — les autres processus voient 'processing'

    print(f"Claimed: {len(claimed)} question(s)")
    if not claimed:
        print("Rien à publier.")
        conn.close()
        return True

    # Étape 3 : Vérification anti-doublon (défense en profondeur)
    hashes = [q["stable_hash"] for q in claimed if q["stable_hash"]]
    existing_hashes = set()
    if hashes:
        cur.execute(
            "SELECT stable_hash FROM questions WHERE stable_hash = ANY(%s)",
            (hashes,)
        )
        existing_hashes = {r["stable_hash"] for r in cur.fetchall()}
        if existing_hashes:
            print(f"ATTENTION: {len(existing_hashes)} hash(es) déjà en production — ces lignes seront rejetées")

    published = 0
    skipped = 0
    errors = 0

    for q in claimed:
        # Guard : hash déjà en production → rejet propre
        if q["stable_hash"] and q["stable_hash"] in existing_hashes:
            skipped += 1
            cur.execute(
                """UPDATE questions_staging
                   SET statut = 'rejected',
                       notes_contenu = 'Doublon stable_hash détecté au moment de la publication'
                   WHERE id = %s""",
                (q["id"],)
            )
            print(f"  SKIP (doublon) id_staging={q['id']} hash={q['stable_hash'][:16]}...")
            continue

        try:
            # Insertion en production
            cur.execute(
                """INSERT INTO questions
                   (chapitre_id, enonce, choix, bonne_reponse, explication,
                    niveau_complexite, v4_niveau, v4_mat_canonical, v4_mat_old,
                    v4_composante, v4_conf, v4_justif, stable_hash, rubrique_educle)
                   VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
                   RETURNING id""",
                (
                    q["chapitre_id"],
                    q["enonce"],
                    json.dumps(q["choix"], ensure_ascii=False),
                    q["bonne_reponse"],
                    q["explication"],
                    q["niveau_complexite"],
                    q["v4_niveau"],
                    q["v4_mat_canonical"],
                    q["v4_mat_old"],
                    q["v4_composante"],
                    q["v4_conf"],
                    q["v4_justif"],
                    q["stable_hash"],
                    q["rubrique_educle"],
                )
            )
            new_id = cur.fetchone()["id"]

            # Marquer comme published avec l'ID de production
            cur.execute(
                """UPDATE questions_staging
                   SET statut = 'published',
                       published_at = NOW(),
                       published_q_id = %s
                   WHERE id = %s""",
                (new_id, q["id"])
            )
            published += 1

        except psycopg2.errors.UniqueViolation:
            # La contrainte UNIQUE stable_hash a bloqué une double insertion
            conn.rollback()
            skipped += 1
            cur.execute(
                """UPDATE questions_staging
                   SET statut = 'rejected',
                       notes_contenu = 'UniqueViolation stable_hash lors de INSERT'
                   WHERE id = %s""",
                (q["id"],)
            )
            conn.commit()
            print(f"  SKIP (UniqueViolation) id_staging={q['id']}")
            continue

        except Exception as e:
            # Erreur inattendue : remettre en 'ready' pour retry ultérieur
            conn.rollback()
            errors += 1
            cur.execute(
                """UPDATE questions_staging
                   SET statut = 'ready', processing_started_at = NULL
                   WHERE id = %s""",
                (q["id"],)
            )
            conn.commit()
            print(f"  ERREUR id_staging={q['id']}: {e}", file=sys.stderr)
            continue

    conn.commit()

    cur.execute("SELECT COUNT(*) AS n FROM questions")
    n_after = cur.fetchone()["n"]

    print(f"Publication terminée: {published} publiées, {skipped} ignorées, {errors} erreurs")
    print(f"Questions production: {n_before} -> {n_after} (+{n_after - n_before})")

    # Vérification intégrité finale
    cur.execute(
        "SELECT COUNT(*) AS n FROM questions WHERE chapitre_id NOT IN (SELECT id FROM chapitres)"
    )
    orphans = cur.fetchone()["n"]
    if orphans > 0:
        print(f"ALERTE: {orphans} questions orphelines détectées!", file=sys.stderr)

    conn.close()
    return errors == 0


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--batch", default=None)
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--recover", action="store_true",
                        help="Libère les lignes processing abandonnées (>30 min)")
    args = parser.parse_args()
    success = run(args.batch, args.dry_run, args.recover)
    sys.exit(0 if success else 1)
