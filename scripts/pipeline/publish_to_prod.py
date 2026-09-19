"""
publish_to_prod.py
Publie les questions en statut 'ready' depuis staging vers questions (production).
Idempotent, non destructif, traçable.

Usage:
    python publish_to_prod.py [--batch BATCH_ID] [--dry-run]
"""

import argparse
import json
import os
import sys
import psycopg2
import psycopg2.extras

DB_URL = os.environ.get("DATABASE_URL", "")


def run(batch_id=None, dry_run=False):
    if not DB_URL:
        print("ERREUR: DATABASE_URL non défini", file=sys.stderr)
        sys.exit(1)

    conn = psycopg2.connect(DB_URL, cursor_factory=psycopg2.extras.RealDictCursor)
    conn.autocommit = False
    cur = conn.cursor()

    # Compter les questions de prod avant
    cur.execute("SELECT COUNT(*) AS n FROM questions")
    n_before = cur.fetchone()["n"]

    # Questions prêtes à publier
    query = "SELECT * FROM questions_staging WHERE statut = 'ready' ORDER BY id"
    params = []
    if batch_id:
        query = "SELECT * FROM questions_staging WHERE statut = 'ready' AND batch_id = %s ORDER BY id"
        params = [batch_id]

    cur.execute(query, params)
    ready = cur.fetchall()
    print(f"Questions prêtes à publier: {len(ready)}")

    if not ready:
        print("Rien à publier.")
        conn.close()
        return True

    # Vérifier doublons stable_hash en production
    hashes_to_publish = [q["stable_hash"] for q in ready if q["stable_hash"]]
    if hashes_to_publish:
        cur.execute(
            "SELECT stable_hash FROM questions WHERE stable_hash = ANY(%s)",
            (hashes_to_publish,)
        )
        existing = {r["stable_hash"] for r in cur.fetchall()}
        if existing:
            print(f"ATTENTION: {len(existing)} doublons détectés en production, ils seront ignorés")

    published = 0
    skipped = 0

    for q in ready:
        # Skip si hash déjà en production
        if q["stable_hash"] and q["stable_hash"] in (existing if hashes_to_publish else set()):
            skipped += 1
            if not dry_run:
                cur.execute(
                    "UPDATE questions_staging SET statut='rejected', notes_contenu='Doublon en production' WHERE id=%s",
                    (q["id"],)
                )
            continue

        if dry_run:
            print(f"  [DRY] Publierait id_staging={q['id']} | {q['v4_mat_canonical']} | {q['v4_niveau']} | {q['enonce'][:60]}")
            published += 1
            continue

        # Insertion en production
        cur.execute(
            """INSERT INTO questions
               (chapitre_id, enonce, choix, bonne_reponse, explication,
                niveau_complexite, v4_niveau, v4_mat_canonical, v4_mat_old,
                v4_composante, v4_conf, v4_justif, stable_hash, rubrique_educle)
               VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
               RETURNING id""",
            (
                q["chapitre_id"], q["enonce"],
                json.dumps(q["choix"], ensure_ascii=False),
                q["bonne_reponse"], q["explication"], q["niveau_complexite"],
                q["v4_niveau"], q["v4_mat_canonical"], q["v4_mat_old"],
                q["v4_composante"], q["v4_conf"], q["v4_justif"],
                q["stable_hash"], q["rubrique_educle"]
            )
        )
        new_id = cur.fetchone()["id"]
        cur.execute(
            """UPDATE questions_staging
               SET statut='published', published_at=NOW(), published_q_id=%s
               WHERE id=%s""",
            (new_id, q["id"])
        )
        published += 1

    if not dry_run:
        conn.commit()
        cur.execute("SELECT COUNT(*) AS n FROM questions")
        n_after = cur.fetchone()["n"]
        print(f"Publication terminée: {published} publiées, {skipped} ignorées")
        print(f"Questions production: {n_before} -> {n_after} (+{n_after - n_before})")

        # Vérification intégrité
        cur.execute("SELECT COUNT(*) AS n FROM questions WHERE chapitre_id NOT IN (SELECT id FROM chapitres)")
        orphans = cur.fetchone()["n"]
        if orphans > 0:
            print(f"ALERTE: {orphans} questions orphelines détectées!", file=sys.stderr)
    else:
        print(f"[DRY-RUN] {published} seraient publiées, {skipped} ignorées")

    conn.close()
    return True


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--batch", default=None)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    run(args.batch, args.dry_run)
