"""
audit_coverage.py
Rapport de couverture complet après publication.
READ-ONLY.

Usage:
    python audit_coverage.py [--mat M06] [--niveau NS1]
"""

import argparse
import os
import sys
import psycopg2
import psycopg2.extras

DB_URL = os.environ.get("DATABASE_URL", "")


def run(mat_filter=None, niv_filter=None):
    if not DB_URL:
        print("ERREUR: DATABASE_URL non défini", file=sys.stderr)
        sys.exit(1)

    conn = psycopg2.connect(DB_URL, cursor_factory=psycopg2.extras.RealDictCursor)
    conn.set_session(readonly=True, autocommit=True)
    cur = conn.cursor()

    # Distribution production
    print("=" * 60)
    print("COUVERTURE PRODUCTION")
    print("=" * 60)

    where = []
    params = []
    if mat_filter:
        where.append("q.v4_mat_canonical = %s")
        params.append(mat_filter)
    if niv_filter:
        where.append("q.v4_niveau = %s")
        params.append(niv_filter)
    where_clause = ("WHERE " + " AND ".join(where)) if where else ""

    cur.execute(f"""
        SELECT q.v4_mat_canonical AS mat, q.v4_niveau AS niv,
               ch.titre AS chapitre, COUNT(*) AS n,
               SUM(CASE WHEN q.niveau_complexite='Facile' THEN 1 ELSE 0 END) AS facile,
               SUM(CASE WHEN q.niveau_complexite='Moyen' THEN 1 ELSE 0 END) AS moyen,
               SUM(CASE WHEN q.niveau_complexite='Difficile' THEN 1 ELSE 0 END) AS difficile
        FROM questions q
        JOIN chapitres ch ON ch.id = q.chapitre_id
        {where_clause}
        GROUP BY q.v4_mat_canonical, q.v4_niveau, ch.titre
        ORDER BY q.v4_mat_canonical, q.v4_niveau, ch.titre
    """, params)
    rows = cur.fetchall()

    cur_mat = None
    total = 0
    for r in rows:
        if r["mat"] != cur_mat:
            if cur_mat:
                print()
            cur_mat = r["mat"]
            print(f"\n{r['mat']} :")
        print(f"  {str(r['niv'] or 'NULL'):<22} | {r['n']:>4} q "
              f"(F:{r['facile']} M:{r['moyen']} D:{r['difficile']}) | {r['chapitre'][:50]}")
        total += r["n"]

    print(f"\nTOTAL production : {total}")

    # Staging en cours
    print("\n" + "=" * 60)
    print("STAGING EN COURS")
    print("=" * 60)

    cur.execute("""
        SELECT statut, COUNT(*) AS n
        FROM questions_staging
        GROUP BY statut ORDER BY statut
    """)
    for r in cur.fetchall():
        print(f"  {r['statut']:<25}: {r['n']}")

    conn.close()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--mat", default=None)
    parser.add_argument("--niveau", default=None)
    args = parser.parse_args()
    run(args.mat, args.niveau)
