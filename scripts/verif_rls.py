"""Refuse toute migration SQL qui crée une table sans activer Row Level Security.

Sans RLS, une table du schéma public est lisible ET modifiable par n'importe qui
avec la clé anon Supabase (publique). Lancé par .github/workflows/verif-rls.yml.

    python scripts/verif_rls.py            # vérifie tous les .sql du dépôt
    python scripts/verif_rls.py a.sql b.sql
"""
import re
import sys
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
DOSSIERS = ["scripts", "backend/alembic/versions"]

# Antérieures à la règle : leurs tables ont reçu le RLS par la migration 038
HISTORIQUE = {
    "scripts/migrations/004_chapitre_niveaux_bio_geo.sql",
    "backend/alembic/versions/003_question_proposals.sql",
}

CREATE = re.compile(
    r"\bcreate\s+(?:unlogged\s+)?table\s+(?:if\s+not\s+exists\s+)?(?:public\.)?\"?(\w+)\"?",
    re.IGNORECASE,
)
TEMP = re.compile(r"\bcreate\s+(?:local\s+|global\s+)?temp(?:orary)?\s+table\b", re.IGNORECASE)


def sans_texte(sql: str) -> str:
    """Retire commentaires et chaînes ('…', $$…$$) : seules les instructions comptent."""
    sql = re.sub(r"\$(\w*)\$.*?\$\1\$", " ", sql, flags=re.DOTALL)
    sql = re.sub(r"'(?:[^']|'')*'", "''", sql)
    sql = re.sub(r"--[^\n]*", " ", sql)
    return re.sub(r"/\*.*?\*/", " ", sql, flags=re.DOTALL)


def tables_sans_rls(chemin: Path) -> list[str]:
    sql = sans_texte(chemin.read_text(encoding="utf-8", errors="replace"))
    manquantes = []
    for m in CREATE.finditer(sql):
        # « CREATE TEMP TABLE » est éphémère et hors du schéma public
        debut = sql.rfind("create", 0, m.end())
        if TEMP.match(sql, debut):
            continue
        table = m.group(1)
        rls = re.compile(
            rf"\balter\s+table\s+(?:if\s+exists\s+)?(?:only\s+)?(?:public\.)?\"?{table}\"?\s+enable\s+row\s+level\s+security",
            re.IGNORECASE,
        )
        if not rls.search(sql):
            manquantes.append(table)
    return manquantes


def main(args: list[str]) -> int:
    fichiers = [Path(a).resolve() for a in args] or [
        p for d in DOSSIERS for p in sorted((RACINE / d).rglob("*.sql"))
    ]
    erreurs = 0
    for f in fichiers:
        rel = f.relative_to(RACINE).as_posix()
        if rel in HISTORIQUE:
            continue
        for table in tables_sans_rls(f):
            erreurs += 1
            print(f"::error file={rel}::La table « {table} » est créée sans "
                  f"« ALTER TABLE {table} ENABLE ROW LEVEL SECURITY; » dans la même migration.")
    if erreurs:
        print(f"\n{erreurs} table(s) sans RLS : la clé anon Supabase pourrait les lire et les modifier.")
        return 1
    print(f"OK : {len(fichiers)} fichier(s) SQL vérifié(s), toutes les tables créées ont le RLS.")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
