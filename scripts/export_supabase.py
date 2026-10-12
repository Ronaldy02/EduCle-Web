"""
Export toutes les données Supabase → assets/data/questions.json

Usage :
    DATABASE_URL=postgres://... python scripts/export_supabase.py

Dépendance :
    pip install psycopg2-binary
"""

import json
import os
import sys
from datetime import datetime, timezone
from pathlib import Path

try:
    import psycopg2
    import psycopg2.extras
except ImportError:
    sys.exit("Installe d'abord : pip install psycopg2-binary")

DATABASE_URL = os.environ.get("DATABASE_URL")
if not DATABASE_URL:
    sys.exit("Variable DATABASE_URL manquante.")

OUT = Path(__file__).parent.parent / "assets" / "data" / "questions.json"

conn = psycopg2.connect(DATABASE_URL)
cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

# ── Charger toutes les matières ──────────────────────────────────────────────
cur.execute("SELECT id, niveau, nom FROM matieres ORDER BY niveau, nom")
matieres_rows = cur.fetchall()

result = {"version": 1, "exported_at": datetime.now(timezone.utc).isoformat(), "matieres": []}

for m in matieres_rows:
    matiere_entry = {"niveau": m["niveau"], "nom": m["nom"], "chapitres": []}

    # ── Chapitres de cette matière ───────────────────────────────────────────
    cur.execute(
        "SELECT id, titre, niveau_v4 FROM chapitres WHERE matiere_id = %s ORDER BY id",
        (m["id"],),
    )
    chapitres_rows = cur.fetchall()

    for c in chapitres_rows:
        chapitre_entry = {
            "titre": c["titre"],
            "niveau_v4": c["niveau_v4"],
            "cartes_mentales": [],
            "questions": [],
        }

        # ── Cartes mentales ──────────────────────────────────────────────────
        cur.execute(
            "SELECT contenu FROM cartes_mentales WHERE chapitre_id = %s ORDER BY id",
            (c["id"],),
        )
        chapitre_entry["cartes_mentales"] = [r["contenu"] for r in cur.fetchall()]

        # ── Questions ────────────────────────────────────────────────────────
        cur.execute(
            """
            SELECT enonce, choix, bonne_reponse, explication, niveau_complexite
            FROM questions
            WHERE chapitre_id = %s
            ORDER BY id
            """,
            (c["id"],),
        )
        for q in cur.fetchall():
            choix = q["choix"]
            # choix peut être un objet JSON (psycopg2 le désérialise) ou une str
            if isinstance(choix, str):
                choix = json.loads(choix)
            chapitre_entry["questions"].append(
                {
                    "enonce": q["enonce"],
                    "choix": choix,
                    "bonne_reponse": q["bonne_reponse"],
                    "explication": q["explication"],
                    "niveau_complexite": q["niveau_complexite"],
                }
            )

        matiere_entry["chapitres"].append(chapitre_entry)

    result["matieres"].append(matiere_entry)

cur.close()
conn.close()

OUT.parent.mkdir(parents=True, exist_ok=True)
OUT.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding="utf-8")

total_questions = sum(
    len(c["questions"])
    for m in result["matieres"]
    for c in m["chapitres"]
)
print(f"Export réussi → {OUT}")
print(f"  {len(result['matieres'])} matières, {total_questions} questions")
