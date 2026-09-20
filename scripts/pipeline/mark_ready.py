"""
mark_ready.py
Promeut les questions de 'validated_tech' (ou 'validated_content') vers 'ready'.

Ce script est un POINT DE CONTRÔLE HUMAIN dans le cycle de vie.
Il ne doit PAS être exécuté automatiquement par le cron.
Il est déclenché uniquement via workflow_dispatch (action='mark-ready')
ou manuellement après revue du contenu.

Cycle de vie :
  draft → validated_tech (validate_staging.py)
        → validated_content (validate_content.py, futur)
        → ready (mark_ready.py — décision humaine)
        → processing (publish_to_prod.py — atomique)
        → published

Usage:
    python mark_ready.py [--batch BATCH_ID] [--from-status validated_tech|validated_content] [--dry-run]
"""

import argparse
import os
import sys
import psycopg2
import psycopg2.extras

DB_URL = os.environ.get("DATABASE_URL", "")

VALID_FROM_STATUTS = {"validated_tech", "validated_content"}


def run(batch_id=None, from_status="validated_tech", dry_run=False):
    if not DB_URL:
        print("ERREUR: DATABASE_URL non défini", file=sys.stderr)
        sys.exit(1)

    if from_status not in VALID_FROM_STATUTS:
        print(f"ERREUR: --from-status doit être parmi {VALID_FROM_STATUTS}", file=sys.stderr)
        sys.exit(1)

    conn = psycopg2.connect(DB_URL, cursor_factory=psycopg2.extras.RealDictCursor)
    conn.autocommit = False
    cur = conn.cursor()

    # Afficher un résumé des questions candidates
    query = """
        SELECT s.id, s.batch_id, s.v4_mat_canonical, s.v4_niveau,
               s.chapitre_id, c.titre AS chapitre_titre,
               LEFT(s.enonce, 80) AS enonce_court
        FROM questions_staging s
        LEFT JOIN chapitres c ON c.id = s.chapitre_id
        WHERE s.statut = %s
    """
    params = [from_status]
    if batch_id:
        query += " AND s.batch_id = %s"
        params.append(batch_id)
    query += " ORDER BY s.id"

    cur.execute(query, params)
    candidates = cur.fetchall()
    print(f"Candidats ({from_status}): {len(candidates)}")

    if not candidates:
        print("Aucune question à promouvoir.")
        conn.close()
        return True

    # Résumé par batch/matière/niveau
    from collections import Counter
    by_batch = Counter(q["batch_id"] for q in candidates)
    print("\nPar batch:")
    for b, n in sorted(by_batch.items()):
        print(f"  {b}: {n} questions")

    if dry_run:
        print(f"\n[DRY-RUN] {len(candidates)} question(s) seraient promues en 'ready'")
        for q in candidates:
            print(f"  id={q['id']} {q['v4_mat_canonical']} {q['v4_niveau']} | {q['enonce_court']}")
        conn.close()
        return True

    # Promotion atomique
    ids = [q["id"] for q in candidates]
    cur.execute(
        """UPDATE questions_staging
           SET statut = 'ready'
           WHERE id = ANY(%s)
             AND statut = %s""",
        (ids, from_status)
    )
    promoted = cur.rowcount
    conn.commit()

    print(f"\nPromotion terminée: {promoted} question(s) passées en 'ready'")
    conn.close()
    return True


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--batch", default=None)
    parser.add_argument("--from-status", default="validated_tech",
                        choices=["validated_tech", "validated_content"])
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    success = run(args.batch, args.from_status, args.dry_run)
    sys.exit(0 if success else 1)
