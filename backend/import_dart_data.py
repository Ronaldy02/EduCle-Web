"""
import_dart_data.py
===================
Lit la méthode _seedData de database_helper.dart (Flutter/Dart) et insère
toutes les matières, chapitres, cartes mentales et questions dans PostgreSQL.

Aucune conversion manuelle nécessaire : le script parse le Dart directement.

Usage :
    # Activer l'environnement virtuel, puis :
    python import_dart_data.py "chemin/vers/database_helper.dart"

    # Exemple Windows :
    python import_dart_data.py "C:\\...\\mobile\\lib\\services\\database_helper.dart"
"""
import sys
import json
import os

# ──────────────────────────────────────────────────────────────────────────────
# 1. TOKENISEUR
# Transforme le source Dart en liste de tokens simples.
# On ne supporte que le sous-ensemble utilisé dans _seedData.
# ──────────────────────────────────────────────────────────────────────────────

def tokenize(src: str) -> list[tuple[str, str]]:
    tokens = []
    i, n = 0, len(src)
    while i < n:
        c = src[i]
        # Espaces
        if c in ' \t\n\r':
            i += 1
            continue
        # Commentaire //
        if src[i:i+2] == '//':
            while i < n and src[i] != '\n':
                i += 1
            continue
        # Commentaire /* ... */
        if src[i:i+2] == '/*':
            i += 2
            while i < n - 1 and src[i:i+2] != '*/':
                i += 1
            i += 2
            continue
        # Chaîne de caractères (simple ou double guillemet)
        if c in ("'", '"'):
            quote, i = c, i + 1
            buf = []
            while i < n:
                if src[i] == '\\' and i + 1 < n:
                    nc = src[i + 1]
                    buf.append({'n': '\n', 't': '\t', 'r': '\r'}.get(nc, nc))
                    i += 2
                elif src[i] == quote:
                    i += 1
                    break
                else:
                    buf.append(src[i])
                    i += 1
            tokens.append(('STR', ''.join(buf)))
        elif c == '[':  tokens.append(('LB', c));  i += 1
        elif c == ']':  tokens.append(('RB', c));  i += 1
        elif c == '(':  tokens.append(('LP', c));  i += 1
        elif c == ')':  tokens.append(('RP', c));  i += 1
        elif c == ',':  tokens.append(('CM', c));  i += 1
        elif c == ':':  tokens.append(('CL', c));  i += 1
        elif c == ';':  tokens.append(('SC', c));  i += 1
        elif c.isalpha() or c == '_':
            j = i
            while j < n and (src[j].isalnum() or src[j] == '_'):
                j += 1
            tokens.append(('ID', src[i:j]))
            i = j
        else:
            i += 1
    return tokens


# ──────────────────────────────────────────────────────────────────────────────
# 2. PARSER
# Reconnaît la structure spécifique de _seedData :
#   await ajouterMatiere(niveau, nom, [_ChapitreSeed(...), ...])
#   _ChapitreSeed(titre: '...', cartes: [...], questions: [_QSeed(...), ...])
#   _QSeed(enonce, [choix], bonne_reponse, explication, niveau_complexite)
# ──────────────────────────────────────────────────────────────────────────────

class Parser:
    def __init__(self, tokens: list):
        self.tokens = tokens
        self.pos = 0

    def peek(self) -> tuple:
        return self.tokens[self.pos] if self.pos < len(self.tokens) else ('EOF', '')

    def consume(self, *types) -> tuple:
        tok = self.peek()
        if types and tok[0] not in types:
            raise SyntaxError(f"Attendu {types}, reçu {tok} (pos {self.pos})")
        self.pos += 1
        return tok

    def skip_optional(self, *types):
        if self.peek()[0] in types:
            self.consume()

    # ── Briques élémentaires ─────────────────────────────────────────────────

    def parse_string(self) -> str:
        return self.consume('STR')[1]

    def parse_list_of_strings(self) -> list[str]:
        self.consume('LB')
        items = []
        while self.peek()[0] != 'RB':
            if self.peek()[0] == 'STR':
                items.append(self.parse_string())
            self.skip_optional('CM')
        self.consume('RB')
        return items

    # ── _QSeed ───────────────────────────────────────────────────────────────

    def parse_q_seed(self) -> dict:
        """_QSeed(enonce, [choix...], bonne_reponse, explication, niveau)"""
        self.consume('LP')
        enonce      = self.parse_string(); self.skip_optional('CM')
        choix       = self.parse_list_of_strings(); self.skip_optional('CM')
        bonne_rep   = self.parse_string(); self.skip_optional('CM')
        explication = self.parse_string(); self.skip_optional('CM')
        niveau      = self.parse_string(); self.skip_optional('CM')
        self.consume('RP')
        return {
            'enonce': enonce,
            'choix': choix,
            'bonne_reponse': bonne_rep,
            'explication': explication,
            'niveau_complexite': niveau,
        }

    def parse_list_of_q_seeds(self) -> list[dict]:
        self.consume('LB')
        questions = []
        while self.peek()[0] != 'RB':
            t = self.peek()
            if t == ('ID', '_QSeed'):
                self.consume('ID')
                try:
                    questions.append(self.parse_q_seed())
                except Exception as e:
                    print(f"  ⚠ _QSeed ignorée : {e}")
            else:
                self.skip_optional('CM')
                if self.peek()[0] not in ('RB', 'CM', 'EOF') and self.peek() != ('ID', '_QSeed'):
                    self.pos += 1
        self.consume('RB')
        return questions

    # ── _ChapitreSeed ────────────────────────────────────────────────────────

    def parse_chapitre_seed(self) -> dict:
        """_ChapitreSeed(titre: '...', cartes: [...], questions: [...])"""
        self.consume('LP')
        titre, cartes, questions = '', [], []
        while self.peek()[0] != 'RP':
            t = self.peek()
            if t[0] == 'ID':
                name = self.consume('ID')[1]
                self.consume('CL')   # :
                if name == 'titre':
                    titre = self.parse_string()
                elif name == 'cartes':
                    cartes = self.parse_list_of_strings()
                elif name == 'questions':
                    questions = self.parse_list_of_q_seeds()
                else:
                    self.pos += 1  # champ inconnu
            self.skip_optional('CM')
        self.consume('RP')
        return {'titre': titre, 'cartes': cartes, 'questions': questions}

    def parse_list_of_chapitres(self) -> list[dict]:
        self.consume('LB')
        chapitres = []
        while self.peek()[0] != 'RB':
            if self.peek() == ('ID', '_ChapitreSeed'):
                self.consume('ID')
                try:
                    chapitres.append(self.parse_chapitre_seed())
                except Exception as e:
                    print(f"  ⚠ _ChapitreSeed ignorée : {e}")
            else:
                self.skip_optional('CM')
                if self.peek()[0] not in ('RB', 'CM', 'EOF') and self.peek() != ('ID', '_ChapitreSeed'):
                    self.pos += 1
        self.consume('RB')
        return chapitres

    # ── ajouterMatiere ───────────────────────────────────────────────────────

    def parse_ajouter_matiere(self) -> dict:
        """ajouterMatiere(niveau, nom, [...chapitres])"""
        self.consume('LP')
        niveau    = self.parse_string(); self.skip_optional('CM')
        nom       = self.parse_string(); self.skip_optional('CM')
        chapitres = self.parse_list_of_chapitres()
        self.skip_optional('CM')
        self.consume('RP')
        return {'niveau': niveau, 'nom': nom, 'chapitres': chapitres}

    # ── Point d'entrée ───────────────────────────────────────────────────────

    def parse_all(self) -> list[dict]:
        """Parcourt tout le flux de tokens et collecte les appels await ajouterMatiere(...)."""
        matieres = []
        while self.peek()[0] != 'EOF':
            # Chercher la séquence : await  ajouterMatiere  (
            if self.peek() == ('ID', 'await'):
                if self.pos + 1 < len(self.tokens) and self.tokens[self.pos + 1] == ('ID', 'ajouterMatiere'):
                    self.consume('ID')  # await
                    self.consume('ID')  # ajouterMatiere
                    try:
                        mat = self.parse_ajouter_matiere()
                        nb_q = sum(len(c['questions']) for c in mat['chapitres'])
                        print(f"  ✓ {mat['nom']} ({mat['niveau']}) — "
                              f"{len(mat['chapitres'])} chapitre(s), {nb_q} question(s)")
                        matieres.append(mat)
                    except Exception as e:
                        print(f"  ⚠ ajouterMatiere ignorée : {e}")
                    continue
            self.pos += 1
        return matieres


# ──────────────────────────────────────────────────────────────────────────────
# 3. INSERTION POSTGRESQL  (bulk, keepalive, un commit par matière)
# ──────────────────────────────────────────────────────────────────────────────

def inserer(matieres: list[dict]) -> None:
    import os
    from sqlalchemy import create_engine, text
    from sqlalchemy.orm import sessionmaker

    from config import settings
    from models import matiere as mat_mod, question as q_mod
    from models.matiere import Matiere, Chapitre, CarteMentale
    from models.question import Question

    # Connexion avec keepalive TCP pour éviter les coupures Render (plan gratuit)
    db_url = settings.database_url
    engine = create_engine(
        db_url,
        pool_pre_ping=True,
        connect_args={
            'keepalives': 1,
            'keepalives_idle': 20,
            'keepalives_interval': 10,
            'keepalives_count': 5,
            'connect_timeout': 30,
        },
    )

    # Créer les tables si elles n'existent pas encore
    from database import Base
    Base.metadata.create_all(bind=engine)

    Session = sessionmaker(bind=engine)

    # Vider les tables pour repartir d'une base propre
    print("🗑  Nettoyage des tables existantes …")
    with Session() as db:
        db.execute(text(
            "TRUNCATE questions, cartes_mentales, chapitres, matieres RESTART IDENTITY CASCADE"
        ))
        db.commit()

    total_q = 0

    for mat_data in matieres:
        with Session() as db:
            mat = Matiere(nom=mat_data['nom'], niveau=mat_data['niveau'])
            db.add(mat)
            db.flush()

            for chap_data in mat_data['chapitres']:
                chap = Chapitre(matiere_id=mat.id, titre=chap_data['titre'])
                db.add(chap)
                db.flush()

                cartes = [
                    CarteMentale(chapitre_id=chap.id, contenu=c)
                    for c in chap_data.get('cartes', [])
                ]
                if cartes:
                    db.add_all(cartes)

                questions = [
                    Question(
                        chapitre_id=chap.id,
                        enonce=q['enonce'],
                        choix=q['choix'],
                        bonne_reponse=q['bonne_reponse'],
                        explication=q['explication'],
                        niveau_complexite=q['niveau_complexite'],
                    )
                    for q in chap_data.get('questions', [])
                ]
                if questions:
                    db.add_all(questions)
                    total_q += len(questions)

            db.commit()
            print(f"  ✓ {mat_data['nom']} ({mat_data['niveau']}) insérée.")

    print(f"\n✅ {total_q} question(s) insérée(s) dans PostgreSQL.")


# ──────────────────────────────────────────────────────────────────────────────
# 4. MAIN
# ──────────────────────────────────────────────────────────────────────────────

def main():
    if len(sys.argv) < 2:
        print("Usage : python import_dart_data.py chemin/vers/database_helper.dart")
        sys.exit(1)

    dart_path = sys.argv[1]
    if not os.path.exists(dart_path):
        print(f"Fichier introuvable : {dart_path}")
        sys.exit(1)

    print(f"📖 Lecture de {dart_path} …")
    src = open(dart_path, encoding='utf-8').read()

    # Extraire uniquement la méthode _seedData pour limiter le travail du parser
    start = src.find('Future<void> _seedData(')
    if start == -1:
        print("❌ Méthode _seedData introuvable dans le fichier.")
        sys.exit(1)
    # Trouver la fin de _seedData (la classe _ChapitreSeed qui suit)
    end = src.find('\nclass _ChapitreSeed', start)
    seed_src = src[start:end] if end != -1 else src[start:]

    print("🔍 Tokenisation …")
    tokens = tokenize(seed_src)

    print("🧩 Parsing …")
    parser = Parser(tokens)
    matieres = parser.parse_all()

    if not matieres:
        print("❌ Aucune matière trouvée. Vérifie le chemin du fichier.")
        sys.exit(1)

    print(f"\n📦 {len(matieres)} matière(s) trouvée(s). Insertion en cours …\n")
    inserer(matieres)


if __name__ == '__main__':
    main()
