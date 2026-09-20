"""
audit_duplicates.py
Identifie les doublons (même stable_hash) dans la table questions (production).

Produit la liste complète :
- stable_hash
- id_keep (MIN id — première insertion)
- id_dupe (MAX id — doublon à supprimer)
- chapitre, matière, niveau, énoncé
- batch source (via questions_staging)

NE SUPPRIME RIEN. Audit uniquement.

Usage:
    python audit_duplicates.py [--output doublons.json]
"""

import argparse
import json
import os
import sys
import psycopg2
import psycopg2.extras

DB_URL = os.environ.get("DATABASE_URL", "")


def run(output_path=None):
    if not DB_URL:
        print("ERREUR: DATABASE_URL non défini", file=sys.stderr)
        sys.exit(1)

    conn = psycopg2.connect(DB_URL, cursor_factory=psycopg2.extras.RealDictCursor)
    conn.autocommit = True
    cur = conn.cursor()

    # 1. Doublons stable_hash
    cur.execute("""
        SELECT
            q.stable_hash,
            COUNT(*) AS cnt,
            MIN(q.id) AS id_keep,
            MAX(q.id) AS id_dupe,
            MIN(q.v4_niveau)         AS niveau,
            MIN(q.v4_mat_canonical)  AS matiere,
            MIN(q.chapitre_id)       AS chapitre_id,
            MIN(q.enonce)            AS enonce
        FROM questions q
        WHERE q.stable_hash IS NOT NULL
        GROUP BY q.stable_hash
        HAVING COUNT(*) > 1
        ORDER BY MIN(q.id)
    """)
    doublons = cur.fetchall()

    # 2. Réconciliation des comptes
    cur.execute("""
        SELECT
            SUM(CASE WHEN id <= 1942 THEN 1 ELSE 0 END)             AS pre_session,
            SUM(CASE WHEN id BETWEEN 1943 AND 1996 THEN 1 ELSE 0 END) AS gap_non_trace,
            SUM(CASE WHEN id >= 1997 THEN 1 ELSE 0 END)             AS trace_staging,
            COUNT(*) AS total
        FROM questions
    """)
    counts = dict(cur.fetchone())

    # 3. Questions non tracées dans staging (IDs > 1942, pas dans published_q_id)
    cur.execute("""
        SELECT COUNT(*) AS n, MIN(id) AS min_id, MAX(id) AS max_id
        FROM questions
        WHERE id NOT IN (
            SELECT published_q_id FROM questions_staging
            WHERE published_q_id IS NOT NULL
        )
        AND id > 1942
    """)
    untouched = dict(cur.fetchone())

    # 4. Source batch des IDs non tracés
    cur.execute("""
        SELECT q.id, q.v4_niveau, q.v4_mat_canonical, q.chapitre_id,
               LEFT(q.enonce, 80) AS enonce_court,
               s.batch_id, s.statut AS staging_statut
        FROM questions q
        LEFT JOIN questions_staging s ON s.stable_hash = q.stable_hash
        WHERE q.id BETWEEN 1943 AND 1996
        ORDER BY q.id
    """)
    gap_rows = [dict(r) for r in cur.fetchall()]

    conn.close()

    # Affichage
    print("=" * 70)
    print(f"AUDIT DOUBLONS — {len(doublons)} stable_hash(es) en double")
    print("=" * 70)

    doublons_list = []
    for i, d in enumerate(doublons, 1):
        entry = dict(d)
        print(f"\n[{i:02d}] id_keep={d['id_keep']}  id_dupe={d['id_dupe']}  cnt={d['cnt']}")
        print(f"     niveau={d['niveau']}  matière={d['matiere']}  chapitre={d['chapitre_id']}")
        print(f"     hash={d['stable_hash'][:24]}...")
        print(f"     énoncé: {d['enonce'][:100]}")
        doublons_list.append(entry)

    print("\n" + "=" * 70)
    print("RÉCONCILIATION DES COMPTES")
    print("=" * 70)
    print(f"  Pré-session (id ≤ 1942)   : {counts['pre_session']}")
    print(f"  Gap non tracé (1943-1996) : {counts['gap_non_trace']}")
    print(f"  Tracé staging  (id ≥ 1997): {counts['trace_staging']}")
    print(f"  TOTAL                     : {counts['total']}")
    print(f"\n  IDs > 1942 non dans staging.published_q_id: {untouched['n']}")
    print(f"    min_id={untouched['min_id']}  max_id={untouched['max_id']}")

    if gap_rows:
        print(f"\n  Détail du gap 1943-1996 ({len(gap_rows)} lignes):")
        for r in gap_rows[:10]:
            print(f"    id={r['id']} {r['v4_mat_canonical']} {r['v4_niveau']} batch={r['batch_id']}")
        if len(gap_rows) > 10:
            print(f"    ... ({len(gap_rows) - 10} autres)")

    report = {
        "doublons": doublons_list,
        "counts": counts,
        "untouched": untouched,
        "gap_rows": gap_rows,
    }

    if output_path:
        with open(output_path, "w", encoding="utf-8") as f:
            json.dump(report, f, ensure_ascii=False, indent=2, default=str)
        print(f"\nRapport sauvegardé: {output_path}")

    return report


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", default=None, help="Fichier JSON de sortie")
    args = parser.parse_args()
    run(output_path=args.output)
