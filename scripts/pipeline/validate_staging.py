"""
validate_staging.py
Valide les questions en staging (statut 'draft') et met à jour leur statut.
Peut s'exécuter en CI (GitHub Actions) ou localement.

Usage:
    python validate_staging.py [--batch BATCH_ID] [--dry-run]
"""

import argparse
import json
import os
import sys
import psycopg2
import psycopg2.extras
from hash_utils import stable_hash

VALID_NIVEAUX = {
    "1e Primaire", "2e Primaire", "3e Primaire", "4e Primaire", "5e Primaire", "6e Primaire",
    "7e Fondamentale", "8e Fondamentale", "9e Fondamentale",
    "NS1", "NS2", "NS3", "NS4"
}
VALID_MATIERES = {f"M{i:02d}" for i in range(1, 25)} | {"M_CG"}
VALID_COMPLEXITE = {"Facile", "Moyen", "Difficile"}
VALID_CONF = {"A", "B", None}
VALID_RUBRIQUE = {"A", "B", "C", "D", None}

DB_URL = os.environ.get("DATABASE_URL", "")


def get_valid_chapitre_ids(cur):
    cur.execute("SELECT id FROM chapitres")
    return {r["id"] for r in cur.fetchall()}


def validate_question(q, valid_chapitre_ids, existing_hashes):
    errors = []

    # 1. Champs obligatoires
    for field in ["chapitre_id", "enonce", "choix", "bonne_reponse", "explication",
                  "niveau_complexite", "v4_niveau", "v4_mat_canonical"]:
        if not q.get(field):
            errors.append(f"Champ manquant: {field}")

    if errors:
        return errors

    # 2. chapitre valide
    if q["chapitre_id"] not in valid_chapitre_ids:
        errors.append(f"chapitre_id {q['chapitre_id']} invalide")

    # 3. Exactement 4 choix
    choix = q["choix"]
    if not isinstance(choix, list) or len(choix) != 4:
        errors.append(f"choix doit avoir exactement 4 elements (actuel: {len(choix) if isinstance(choix, list) else '?'})")

    # 4. bonne_reponse dans choix
    if isinstance(choix, list) and q["bonne_reponse"] not in choix:
        errors.append("bonne_reponse absente des choix")

    # 5. Une seule bonne réponse
    if isinstance(choix, list) and choix.count(q["bonne_reponse"]) > 1:
        errors.append("bonne_reponse dupliquee dans choix")

    # 6. niveau_complexite valide
    if q["niveau_complexite"] not in VALID_COMPLEXITE:
        errors.append(f"niveau_complexite invalide: {q['niveau_complexite']!r}")

    # 7. v4_niveau valide
    if q["v4_niveau"] not in VALID_NIVEAUX:
        errors.append(f"v4_niveau invalide: {q['v4_niveau']!r}")

    # 8. v4_mat_canonical valide
    if q["v4_mat_canonical"] not in VALID_MATIERES:
        errors.append(f"v4_mat_canonical invalide: {q['v4_mat_canonical']!r}")

    # 9. explication non vide
    if len(q.get("explication", "").strip()) < 10:
        errors.append("explication trop courte (< 10 chars)")

    # 10. v4_conf valide
    if q.get("v4_conf") not in VALID_CONF:
        errors.append(f"v4_conf invalide: {q['v4_conf']!r}")

    # 11. rubrique_educle valide
    if q.get("rubrique_educle") not in VALID_RUBRIQUE:
        errors.append(f"rubrique_educle invalide: {q['rubrique_educle']!r}")

    # 12. stable_hash correct
    expected_hash = stable_hash(
        q["v4_niveau"], q["v4_mat_canonical"], q["chapitre_id"], q["enonce"]
    )
    if q.get("stable_hash") and q["stable_hash"] != expected_hash:
        errors.append(f"stable_hash incorrect (attendu: {expected_hash[:12]}...)")

    # 13. Doublon
    h = q.get("stable_hash") or expected_hash
    if h in existing_hashes:
        errors.append(f"Doublon detecte (hash: {h[:12]}...)")

    return errors


def run(batch_id=None, dry_run=False):
    if not DB_URL:
        print("ERREUR: DATABASE_URL non défini", file=sys.stderr)
        sys.exit(1)

    conn = psycopg2.connect(DB_URL, cursor_factory=psycopg2.extras.RealDictCursor)
    conn.autocommit = False
    cur = conn.cursor()

    valid_chapitre_ids = get_valid_chapitre_ids(cur)

    # Hashes existants en production
    cur.execute("SELECT stable_hash FROM questions WHERE stable_hash IS NOT NULL")
    prod_hashes = {r["stable_hash"] for r in cur.fetchall()}

    # Questions à valider
    query = "SELECT * FROM questions_staging WHERE statut = 'draft'"
    params = []
    if batch_id:
        query += " AND batch_id = %s"
        params.append(batch_id)

    cur.execute(query, params)
    questions = cur.fetchall()
    print(f"Questions à valider: {len(questions)}")

    ok = 0
    ko = 0
    batch_hashes = set()

    for q in questions:
        q_dict = dict(q)
        errors = validate_question(q_dict, valid_chapitre_ids, prod_hashes | batch_hashes)

        if errors:
            ko += 1
            if not dry_run:
                cur.execute(
                    """UPDATE questions_staging
                       SET statut='rejected', erreurs_techniques=%s
                       WHERE id=%s""",
                    (json.dumps(errors, ensure_ascii=False), q["id"])
                )
            print(f"  REJET id={q['id']}: {'; '.join(errors)}")
        else:
            ok += 1
            h = q.get("stable_hash") or stable_hash(
                q["v4_niveau"], q["v4_mat_canonical"], q["chapitre_id"], q["enonce"]
            )
            batch_hashes.add(h)
            if not dry_run:
                cur.execute(
                    """UPDATE questions_staging
                       SET statut='validated_tech', stable_hash=%s, erreurs_techniques=NULL
                       WHERE id=%s""",
                    (h, q["id"])
                )

    if not dry_run:
        conn.commit()
        print(f"Validation terminee: {ok} OK, {ko} REJETS")
    else:
        print(f"[DRY-RUN] {ok} OK, {ko} REJETS (aucune modification)")

    conn.close()
    return ko == 0


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--batch", default=None)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    success = run(args.batch, args.dry_run)
    sys.exit(0 if success else 1)
