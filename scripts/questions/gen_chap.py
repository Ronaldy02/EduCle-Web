"""Génère une migration d'import pour un chapitre validé (JSON curriculum/questions/...).
- Questions sans « statut » uniquement (les « à revalider » attendent).
- Questions déjà en base (ancien_enonce) : déplacées dans le chapitre et mises à jour, sinon insérées.
- base_rejetees_a_supprimer : supprimées (avec leurs lignes dépendantes : statistiques, réponses).
Usage : gen_chap.py <chapitre.json> <sortie.sql> [ids à inclure séparés par des virgules]"""
import json, sys
d = json.load(open(sys.argv[1], encoding="utf-8"))
only = set(sys.argv[3].split(",")) if len(sys.argv) > 3 else None
q = lambda s: "NULL" if s is None else "'" + s.replace("'", "''") + "'"
rows = []
for x in d["questions"]:
    if only is not None:
        if x["id"] not in only: continue
    elif x.get("statut"): continue
    assert len(x["choix"]) == 4 and x["bonne_reponse"] in x["choix"], x["id"]
    rows.append("(%s, %s, %s, %s, %s, %s, %s, %s)" % (q(x["id"]), q(x.get("ancien_enonce")), q(x["enonce"]),
        q(json.dumps(x["choix"], ensure_ascii=False)), q(x["bonne_reponse"]), q(x["explication"]),
        q(x["niveau_complexite"]), q(x.get("niveau") or d["niveaux"][0])))
dels = [q(r["enonce"]) for r in d.get("base_rejetees_a_supprimer", [])] if only is None else []
M, T = d["matiere_id"], q(d["chapitre"])
sql = f"""-- Import du chapitre {d['matiere']} « {d['chapitre']} » ({', '.join(d['niveaux'])}) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
""" + ",\n".join(rows) + f""";

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = {M} AND titre = {T};
SELECT COUNT(*) AS chapitre_trouve FROM cible;

CREATE TEMP TABLE mat ON COMMIT DROP AS
SELECT q.v4_mat_canonical AS code FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = {M} AND q.v4_mat_canonical IS NOT NULL
GROUP BY q.v4_mat_canonical ORDER BY COUNT(*) DESC LIMIT 1;

WITH maj AS (
  UPDATE questions q
  SET chapitre_id = (SELECT id FROM cible), enonce = i.enonce, choix = i.choix, bonne_reponse = i.bonne,
      explication = i.explication, niveau_complexite = i.complexite, v4_niveau = i.niveau
  FROM imp i, chapitres c
  WHERE c.id = q.chapitre_id AND c.matiere_id = {M} AND i.ancien IS NOT NULL AND q.enonce = i.ancien
  RETURNING q.id
)
SELECT COUNT(*) AS questions_de_base_deplacees FROM maj;

WITH ins AS (
  INSERT INTO questions (chapitre_id, enonce, choix, bonne_reponse, explication, niveau_complexite, v4_niveau, v4_mat_canonical)
  SELECT (SELECT id FROM cible), i.enonce, i.choix, i.bonne, i.explication, i.complexite, i.niveau, (SELECT code FROM mat)
  FROM imp i
  WHERE NOT EXISTS (SELECT 1 FROM questions q WHERE q.chapitre_id = (SELECT id FROM cible) AND q.enonce = i.enonce)
  RETURNING id
)
SELECT COUNT(*) AS questions_inserees FROM ins;
"""
if dels:
    sql += f"""
-- Questions de base rejetées : suppression (et lignes qui les référencent)
CREATE TEMP TABLE asup ON COMMIT DROP AS
SELECT q.id FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = {M} AND q.enonce IN ({', '.join(dels)});
DO $$
DECLARE r RECORD;
BEGIN
  FOR r IN SELECT conrelid::regclass AS t, a.attname AS col
           FROM pg_constraint k JOIN pg_attribute a ON a.attrelid = k.conrelid AND a.attnum = ANY (k.conkey)
           WHERE k.contype = 'f' AND k.confrelid = 'questions'::regclass LOOP
    EXECUTE format('DELETE FROM %s WHERE %I IN (SELECT id FROM asup)', r.t, r.col);
  END LOOP;
END $$;
WITH sup AS (DELETE FROM questions WHERE id IN (SELECT id FROM asup) RETURNING id)
SELECT COUNT(*) AS questions_rejetees_supprimees FROM sup;
"""
sql += f"""
SELECT COUNT(*) AS total_chapitre FROM questions WHERE chapitre_id = (SELECT id FROM cible);
COMMIT;
"""
open(sys.argv[2], "w", encoding="utf-8", newline="\n").write(sql)
print("lignes", len(rows), "suppressions", len(dels))
