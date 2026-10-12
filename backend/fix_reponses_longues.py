"""
Reformule les questions de quiz selon la règle pédagogique suivante :

  RÈGLE : Pour toute question utilisant une définition,
    - la QUESTION  = la définition (source : Larousse, Petit Robert ou source scientifique)
    - la RÉPONSE   = le concept / mot / thème défini  (1-3 mots max)
    - les LEURRES  = 3 autres concepts du même domaine (1-3 mots max, plausibles mais faux)

  Pour les questions qui ne sont pas de type définition (calcul, date, lieu…),
  raccourcir les réponses à 1-3 mots sans inverser la structure.

Usage :
    ANTHROPIC_API_KEY=sk-ant-... python fix_reponses_longues.py [--dry-run] [--mat "Biologie"]

Options :
    --dry-run      Affiche les corrections sans modifier la base
    --mat NOM      Traite uniquement la matière indiquée
    --batch N      Taille des lots (défaut : 12)
"""
import json, sys, time, argparse, psycopg2, os

DB_URL = (
    "postgresql://educle_user:5kyLmOySjdyN8gISNmRWop139fE2NNY6"
    "@dpg-d9tsi8qjobas73doq6cg-a.oregon-postgres.render.com/educle"
)
PROGRESS_FILE = "fix_progress.json"
MAX_CHARS = 25
MAX_WORDS = 3


def needs_fix(choix: list) -> bool:
    return any(len(c) > MAX_CHARS or len(c.split()) > MAX_WORDS for c in choix)


def load_progress() -> set:
    if os.path.exists(PROGRESS_FILE):
        with open(PROGRESS_FILE) as f:
            return set(json.load(f))
    return set()


def save_progress(done: set):
    with open(PROGRESS_FILE, "w") as f:
        json.dump(list(done), f)


SYSTEM_PROMPT = """Tu es un expert en pédagogie pour lycéens haïtiens. Tu reformules des questions de quiz.

═══ RÈGLE ABSOLUE ═══
Pour toute question qui porte sur une définition / un concept :
  • La QUESTION  = la définition exacte tirée du Larousse, Petit Robert ou d'une source scientifique reconnue.
    Elle ne doit PAS contenir le nom du concept à deviner.
  • La RÉPONSE CORRECTE = le concept / mot / thème défini → 1 à 3 mots MAX (25 caractères max).
  • Les 3 LEURRES = d'autres concepts du même domaine/chapitre, plausibles mais faux → 1 à 3 mots MAX chacun.

Pour les questions qui ne sont PAS de type définition (calcul, date, personnage, lieu…) :
  • Garder la structure question/réponses, mais raccourcir chaque réponse à 3 mots max.

Exemples de transformation correcte :

  AVANT → Q: "La mitochondrie est l'organite responsable de :"
           R correcte: "La production d'énergie (respiration cellulaire, ATP)"
  APRÈS → Q: "Organite cellulaire siège de la respiration cellulaire et de la synthèse d'ATP"
           R correcte: "Mitochondrie"
           Leurres: "Ribosome", "Vacuole", "Noyau"

  AVANT → Q: "Le coût d'opportunité est :"
           R correcte: "Ce à quoi on renonce en faisant un choix (valeur de la meilleure alternative non choisie)"
  APRÈS → Q: "Valeur de la meilleure option sacrifiée lors d'un choix économique (Larousse Économie)"
           R correcte: "Coût d'opportunité"
           Leurres: "Coût marginal", "Externalité", "Valeur ajoutée"

  AVANT → Q: "Quel est le résultat de 2/3 × 3/4 ?"
           R correcte: "1/2"          ← déjà court, structure conservée
  APRÈS → Q: "Quel est le résultat de 2/3 × 3/4 ?"
           R correcte: "1/2"
           Leurres: "6/7", "2/4", "5/12"

═══ FORMAT DE RÉPONSE ═══
Retourne UNIQUEMENT un tableau JSON valide, sans texte autour, avec exactement les mêmes clés :
[
  {
    "id": <int>,
    "enonce": "<nouvelle question>",
    "choix": ["<bonne réponse>", "<leurre1>", "<leurre2>", "<leurre3>"],
    "bonne_reponse": "<bonne réponse>"   ← doit être identique à choix[0]
  },
  ...
]
Contraintes strictes :
- 4 choix exactement, bonne_reponse doit figurer dans choix.
- Chaque choix : 1–3 mots, ≤ 25 caractères.
- La question ne contient PAS le mot/concept cherché.
- Langue : français (sauf termes créoles dans la matière Communication Créole).
"""

USER_TEMPLATE = """Reformule ces {n} questions selon la règle définie.

{questions_json}"""


def fix_batch(client, questions: list) -> list:
    payload = [
        {
            "id": q["id"],
            "enonce": q["enonce"],
            "choix": q["choix"],
            "bonne_reponse": q["bonne_reponse"],
        }
        for q in questions
    ]

    prompt = SYSTEM_PROMPT + "\n\n" + USER_TEMPLATE.format(
        n=len(questions),
        questions_json=json.dumps(payload, ensure_ascii=False, indent=2)
    )
    resp = client.models.generate_content(
        model="gemini-3.5-flash-lite",
        contents=prompt,
    )
    text = resp.text.strip()

    start = text.find("[")
    end   = text.rfind("]") + 1
    if start == -1 or end == 0:
        raise ValueError(f"Pas de JSON dans la réponse : {text[:300]}")
    return json.loads(text[start:end])


def validate(original: dict, result: dict) -> str | None:
    """Retourne un message d'erreur ou None si valide."""
    choix = result.get("choix", [])
    if len(choix) != 4:
        return f"4 choix attendus, {len(choix)} reçus"
    if result.get("bonne_reponse") not in choix:
        return "bonne_reponse absente des choix"
    for c in choix:
        if len(c) > 30:
            return f"choix trop long : « {c} »"
    if not result.get("enonce", "").strip():
        return "énoncé vide"
    return None


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--mat", default=None)
    parser.add_argument("--batch", type=int, default=12)
    args = parser.parse_args()

    api_key = os.environ.get("GEMINI_API_KEY")
    if not api_key:
        print("❌  Définir GEMINI_API_KEY avant de lancer le script.")
        sys.exit(1)

    from google import genai as google_genai
    client = google_genai.Client(api_key=api_key)

    def get_conn():
        return psycopg2.connect(
            DB_URL,
            sslmode="require",
            connect_timeout=30,
            keepalives=1,
            keepalives_idle=10,
            keepalives_interval=5,
            keepalives_count=3,
        )

    for attempt in range(5):
        try:
            conn = get_conn()
            cur  = conn.cursor()
            cur.execute("""
                SELECT q.id, q.enonce, q.choix, q.bonne_reponse,
                       q.explication, q.niveau_complexite, q.chapitre_id,
                       c.titre, m.nom
                FROM questions q
                JOIN chapitres c ON c.id = q.chapitre_id
                JOIN matieres  m ON m.id = c.matiere_id
                ORDER BY m.nom, c.titre, q.id
            """)
            rows = cur.fetchall()
            conn.close()
            break
        except Exception as e:
            print(f"DB connexion tentative {attempt+1}/5 : {e}")
            if attempt == 4:
                raise
            time.sleep(5 * (attempt + 1))

    to_fix = [
        {
            "id": r[0], "enonce": r[1], "choix": r[2],
            "bonne_reponse": r[3], "explication": r[4],
            "niveau_complexite": r[5], "chapitre_id": r[6],
            "chap": r[7], "mat": r[8],
        }
        for r in rows
        if needs_fix(r[2]) and (args.mat is None or r[8] == args.mat)
    ]

    print(f"📋  {len(to_fix)} questions à corriger"
          + (f" dans « {args.mat} »" if args.mat else ""))
    if args.dry_run:
        print("ℹ️   Mode dry-run — aucune modification en base.\n")

    done = load_progress()
    to_fix = [q for q in to_fix if q["id"] not in done]
    print(f"⏩  {len(done)} déjà traitées, {len(to_fix)} restantes.\n")

    fixed_count  = 0
    error_count  = 0
    BATCH        = args.batch

    for i in range(0, len(to_fix), BATCH):
        batch = to_fix[i : i + BATCH]
        mat   = batch[0]["mat"]
        print(f"[{i+1:4d}/{len(to_fix)}]  {mat} — {len(batch)} questions …", end=" ", flush=True)

        try:
            results = fix_batch(client, batch)
        except Exception as e:
            print(f"⚠️  erreur API : {e}")
            error_count += len(batch)
            time.sleep(3)
            continue

        result_map = {r["id"]: r for r in results}
        updates = []

        for q in batch:
            r = result_map.get(q["id"])
            if not r:
                print(f"\n  ⚠️  id {q['id']} absent de la réponse")
                error_count += 1
                continue

            err = validate(q, r)
            if err:
                print(f"\n  ⚠️  id {q['id']} : {err}")
                error_count += 1
                continue

            updates.append((r["choix"], r["bonne_reponse"], r["enonce"], q["id"]))
            done.add(q["id"])
            fixed_count += 1

        if not args.dry_run and updates:
            for attempt in range(3):
                try:
                    wconn = get_conn()
                    upd   = wconn.cursor()
                    upd.executemany(
                        "UPDATE questions SET choix=%s, bonne_reponse=%s, enonce=%s WHERE id=%s",
                        [(json.dumps(u[0], ensure_ascii=False), u[1], u[2], u[3]) for u in updates],
                    )
                    wconn.commit()
                    wconn.close()
                    save_progress(done)
                    break
                except Exception as db_err:
                    print(f"\n  ⚠️  DB erreur (tentative {attempt+1}/3) : {db_err}")
                    time.sleep(2 ** attempt)

        elif args.dry_run and updates:
            print()
            for u in updates[:2]:   # Afficher 2 exemples par lot
                print(f"  📝 Q{u[3]}  « {u[2][:80]} »")
                print(f"     ✅ {u[1]}")
                print()

        print(f"✅  {len(updates)}/{len(batch)}")
        time.sleep(0.6)

    print(f"\n{'🔍 Dry-run' if args.dry_run else '✅ Terminé'} : "
          f"{fixed_count} corrections, {error_count} erreurs.")
    if not args.dry_run and os.path.exists(PROGRESS_FILE):
        os.remove(PROGRESS_FILE)


if __name__ == "__main__":
    main()
