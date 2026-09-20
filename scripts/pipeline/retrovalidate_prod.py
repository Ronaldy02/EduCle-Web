"""
retrovalidate_prod.py
Rétrovalidation des questions déjà publiées en production.

Valide chaque question présente dans 'questions' (production) contre
les mêmes règles que validate_staging.py.

NE MODIFIE PAS les questions existantes.
Produit un rapport JSON + stdout.

Usage:
    python retrovalidate_prod.py [--batch BATCH_ID] [--output rapport.json]
    python retrovalidate_prod.py --ids 1943,1944,1945  # IDs spécifiques
"""

import argparse
import json
import os
import sys
import psycopg2
import psycopg2.extras
from hash_utils import stable_hash

DB_URL = os.environ.get("DATABASE_URL", "")

VALID_NIVEAUX = {
    "1e Primaire", "2e Primaire", "3e Primaire", "4e Primaire", "5e Primaire", "6e Primaire",
    "7e Fondamentale", "8e Fondamentale", "9e Fondamentale",
    "NS1", "NS2", "NS3", "NS4",
}
VALID_MATIERES = {f"M{i:02d}" for i in range(1, 25)} | {"M_CG"}
VALID_COMPLEXITE = {"Facile", "Moyen", "Difficile"}
VALID_CONF = {"A", "B", None}
VALID_RUBRIQUE = {"A", "B", "C", "D", None}


def validate_question(q, valid_chapitre_ids):
    errors = []
    warnings = []

    # Champs obligatoires
    for field in ["chapitre_id", "enonce", "choix", "bonne_reponse", "explication",
                  "niveau_complexite", "v4_niveau", "v4_mat_canonical"]:
        if not q.get(field):
            errors.append(f"Champ manquant ou vide: {field}")

    if errors:
        return errors, warnings

    # chapitre valide
    if q["chapitre_id"] not in valid_chapitre_ids:
        errors.append(f"chapitre_id {q['chapitre_id']} inconnu")

    # choix
    choix = q["choix"]
    if isinstance(choix, str):
        try:
            choix = json.loads(choix)
        except Exception:
            errors.append("choix: JSON invalide")
            choix = []

    if not isinstance(choix, list) or len(choix) != 4:
        errors.append(f"choix: doit avoir exactement 4 éléments (actuel: {len(choix) if isinstance(choix, list) else '?'})")

    if isinstance(choix, list):
        empty = [i for i, c in enumerate(choix) if not str(c).strip()]
        if empty:
            errors.append(f"choix vides aux positions: {empty}")

        if q["bonne_reponse"] not in choix:
            errors.append("bonne_reponse absente des choix")

        if choix.count(q["bonne_reponse"]) > 1:
            errors.append("bonne_reponse dupliquée dans choix")

    # niveau_complexite
    if q["niveau_complexite"] not in VALID_COMPLEXITE:
        errors.append(f"niveau_complexite invalide: {q['niveau_complexite']!r}")

    # v4_niveau
    if q["v4_niveau"] not in VALID_NIVEAUX:
        errors.append(f"v4_niveau invalide: {q['v4_niveau']!r}")

    # v4_mat_canonical
    if q["v4_mat_canonical"] not in VALID_MATIERES:
        errors.append(f"v4_mat_canonical invalide: {q['v4_mat_canonical']!r}")

    # explication
    explication = (q.get("explication") or "").strip()
    if len(explication) < 10:
        errors.append(f"explication trop courte ({len(explication)} chars, min 10)")

    # v4_conf
    if q.get("v4_conf") not in VALID_CONF:
        warnings.append(f"v4_conf invalide: {q['v4_conf']!r}")

    # rubrique_educle
    if q.get("rubrique_educle") not in VALID_RUBRIQUE:
        warnings.append(f"rubrique_educle invalide: {q['rubrique_educle']!r}")

    # stable_hash
    if q.get("stable_hash"):
        expected = stable_hash(q["v4_niveau"], q["v4_mat_canonical"], q["chapitre_id"], q["enonce"])
        if q["stable_hash"] != expected:
            errors.append(f"stable_hash incorrect (attendu: {expected[:16]}..., actuel: {q['stable_hash'][:16]}...)")
    else:
        warnings.append("stable_hash absent")

    return errors, warnings


def run(ids=None, batch_id=None, output_path=None):
    if not DB_URL:
        print("ERREUR: DATABASE_URL non défini", file=sys.stderr)
        sys.exit(1)

    conn = psycopg2.connect(DB_URL, cursor_factory=psycopg2.extras.RealDictCursor)
    conn.autocommit = True
    cur = conn.cursor()

    # Chapitres valides
    cur.execute("SELECT id FROM chapitres")
    valid_chapitre_ids = {r["id"] for r in cur.fetchall()}

    # Questions à valider
    if ids:
        cur.execute("SELECT * FROM questions WHERE id = ANY(%s) ORDER BY id", (ids,))
    elif batch_id:
        # Via staging : trouver les IDs produits par ce batch
        cur.execute(
            """SELECT q.* FROM questions q
               JOIN questions_staging s ON s.published_q_id = q.id
               WHERE s.batch_id = %s
               ORDER BY q.id""",
            (batch_id,)
        )
    else:
        # Toutes les questions de la session (id > 1942, soit post-session)
        cur.execute("SELECT * FROM questions WHERE id > 1942 ORDER BY id")

    questions = cur.fetchall()
    print(f"Questions à rétrovalider: {len(questions)}")

    results = {
        "total": len(questions),
        "valides": 0,
        "warnings_only": 0,
        "echecs": 0,
        "details": [],
    }

    for q in questions:
        q_dict = dict(q)
        # Désérialiser choix si c'est une string
        if isinstance(q_dict.get("choix"), str):
            try:
                q_dict["choix"] = json.loads(q_dict["choix"])
            except Exception:
                pass

        errors, warnings = validate_question(q_dict, valid_chapitre_ids)

        status = "valide" if not errors and not warnings else \
                 "warnings" if not errors else "echec"

        if status == "valide":
            results["valides"] += 1
        elif status == "warnings":
            results["warnings_only"] += 1
        else:
            results["echecs"] += 1

        entry = {
            "id": q["id"],
            "v4_niveau": q["v4_niveau"],
            "v4_mat_canonical": q["v4_mat_canonical"],
            "chapitre_id": q["chapitre_id"],
            "enonce_court": (q["enonce"] or "")[:80],
            "status": status,
            "errors": errors,
            "warnings": warnings,
        }
        results["details"].append(entry)

        if errors:
            print(f"  ECHEC id={q['id']} {q['v4_mat_canonical']} {q['v4_niveau']}")
            for e in errors:
                print(f"    ✗ {e}")
        elif warnings:
            print(f"  WARN  id={q['id']} {q['v4_mat_canonical']} {q['v4_niveau']}")
            for w in warnings:
                print(f"    ⚠ {w}")

    print(f"\n=== RAPPORT RÉTROVALIDATION ===")
    print(f"Total:        {results['total']}")
    print(f"Valides:      {results['valides']}")
    print(f"Warnings:     {results['warnings_only']}")
    print(f"Échecs:       {results['echecs']}")

    if output_path:
        with open(output_path, "w", encoding="utf-8") as f:
            json.dump(results, f, ensure_ascii=False, indent=2)
        print(f"\nRapport sauvegardé: {output_path}")

    conn.close()
    return results["echecs"] == 0


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--ids", default=None,
                        help="IDs séparés par virgule, ex: 1943,1944,1945")
    parser.add_argument("--batch", default=None,
                        help="batch_id dans questions_staging")
    parser.add_argument("--output", default=None,
                        help="Fichier JSON de sortie")
    args = parser.parse_args()

    ids_list = None
    if args.ids:
        ids_list = [int(x.strip()) for x in args.ids.split(",")]

    success = run(ids=ids_list, batch_id=args.batch, output_path=args.output)
    sys.exit(0 if success else 1)
