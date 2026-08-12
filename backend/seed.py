"""Script de peuplement de la base PostgreSQL.

Deux sources possibles :
  1. Fichier SQLite de l'appli mobile (chemin passé en argument)
  2. Données d'exemple minimales (si aucun argument)

Usage :
    # Depuis les données SQLite de l'app mobile
    python seed.py chemin/vers/educle.db

    # Données d'exemple (pour tester rapidement)
    python seed.py
"""
import json
import sys
from datetime import datetime

# Charger la config avant toute autre chose
from config import settings  # noqa: F401
from database import Base, engine, SessionLocal
from models import Matiere, Chapitre, Question, Realisation

Base.metadata.create_all(bind=engine)


def seed_depuis_sqlite(sqlite_path: str) -> None:
    """Migre les données depuis le fichier SQLite de l'appli mobile."""
    import sqlite3

    conn = sqlite3.connect(sqlite_path)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    with SessionLocal() as db:
        # ── Matières ─────────────────────────────────────────────────────────
        for row in cur.execute("SELECT id, niveau, nom FROM matieres").fetchall():
            if not db.get(Matiere, row["id"]):
                db.add(Matiere(id=row["id"], niveau=row["niveau"], nom=row["nom"]))

        db.flush()

        # ── Chapitres ─────────────────────────────────────────────────────────
        for row in cur.execute("SELECT id, matiere_id, titre FROM chapitres").fetchall():
            if not db.get(Chapitre, row["id"]):
                db.add(Chapitre(id=row["id"], matiere_id=row["matiere_id"], titre=row["titre"]))

        db.flush()

        # ── Questions ─────────────────────────────────────────────────────────
        for row in cur.execute(
            "SELECT id, chapitre_id, enonce, choix, bonne_reponse, explication, niveau_complexite "
            "FROM questions"
        ).fetchall():
            if not db.get(Question, row["id"]):
                # Dans SQLite, 'choix' est une chaîne JSON ou délimitée par |
                raw = row["choix"]
                try:
                    choix = json.loads(raw)
                except (json.JSONDecodeError, TypeError):
                    choix = [c.strip() for c in raw.split("|")] if raw else []

                db.add(Question(
                    id=row["id"],
                    chapitre_id=row["chapitre_id"],
                    enonce=row["enonce"],
                    choix=choix,
                    bonne_reponse=row["bonne_reponse"],
                    explication=row["explication"],
                    niveau_complexite=row["niveau_complexite"],
                ))

        db.commit()
        print(f"✅ Migration terminée depuis {sqlite_path}")

    conn.close()


def seed_exemple() -> None:
    """Insère quelques questions d'exemple pour tester l'API."""
    with SessionLocal() as db:
        if db.get(Matiere, 1):
            print("ℹ️  Des données existent déjà. Seed ignoré.")
            return

        mat = Matiere(id=1, niveau="Fondamental", nom="Mathématiques")
        db.add(mat)
        db.flush()

        chap = Chapitre(id=1, matiere_id=1, titre="Fractions")
        db.add(chap)
        db.flush()

        questions = [
            Question(
                chapitre_id=1,
                enonce="Combien vaut 1/2 + 1/4 ?",
                choix=["3/4", "1/2", "2/4", "1/6"],
                bonne_reponse="3/4",
                explication="1/2 = 2/4, donc 2/4 + 1/4 = 3/4.",
                niveau_complexite="facile",
            ),
            Question(
                chapitre_id=1,
                enonce="Quel est le résultat de 2/3 × 3/4 ?",
                choix=["1/2", "2/4", "6/7", "5/12"],
                bonne_reponse="1/2",
                explication="2×3 = 6 et 3×4 = 12, soit 6/12 = 1/2.",
                niveau_complexite="moyen",
            ),
            Question(
                chapitre_id=1,
                enonce="Simplifier 6/9.",
                choix=["2/3", "3/4", "1/2", "4/6"],
                bonne_reponse="2/3",
                explication="PGCD(6,9) = 3, donc 6/9 = 2/3.",
                niveau_complexite="facile",
            ),
        ]
        db.add_all(questions)

        realisation = Realisation(
            id="premier_quiz",
            nom="Premier pas",
            description="Terminer un premier quiz",
            categorie=0,
            rarete=0,
            objectif=1,
            recompense_pieces=10,
        )
        db.add(realisation)

        db.commit()
        print("✅ Données d'exemple insérées.")


if __name__ == "__main__":
    if len(sys.argv) > 1:
        seed_depuis_sqlite(sys.argv[1])
    else:
        seed_exemple()
