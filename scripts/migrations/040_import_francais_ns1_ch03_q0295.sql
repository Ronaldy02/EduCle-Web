-- Import du chapitre Français « Le groupe nominal : déterminants, genre, nombre et accord de l'adjectif » (NS1) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('Q0295', 'Avec quoi l''adjectif qualificatif s''accorde-t-il ?', 'Avec quoi l''adjectif qualificatif s''accorde-t-il ?', '["Le nom ou pronom qu''il qualifie", "Le verbe qui le précède", "Le mot placé juste avant", "Le déterminant du nom"]', 'Le nom ou pronom qu''il qualifie', 'Exemple : « Elles sont heureuses » : l''adjectif s''accorde avec le pronom « elles », même s''il est séparé de lui par le verbe.', 'Facile', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 25 AND titre = 'Le groupe nominal : déterminants, genre, nombre et accord de l''adjectif';
SELECT COUNT(*) AS chapitre_trouve FROM cible;

CREATE TEMP TABLE mat ON COMMIT DROP AS
SELECT q.v4_mat_canonical AS code FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = 25 AND q.v4_mat_canonical IS NOT NULL
GROUP BY q.v4_mat_canonical ORDER BY COUNT(*) DESC LIMIT 1;

WITH maj AS (
  UPDATE questions q
  SET chapitre_id = (SELECT id FROM cible), enonce = i.enonce, choix = i.choix, bonne_reponse = i.bonne,
      explication = i.explication, niveau_complexite = i.complexite, v4_niveau = i.niveau
  FROM imp i, chapitres c
  WHERE c.id = q.chapitre_id AND c.matiere_id = 25 AND i.ancien IS NOT NULL AND q.enonce = i.ancien
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

SELECT COUNT(*) AS total_chapitre FROM questions WHERE chapitre_id = (SELECT id FROM cible);
COMMIT;
