-- Import du chapitre Biologie « Biodiversité et équilibre écologique » (NS1, NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('Q1597', 'Qu''est-ce qu''un écosystème ?', 'Système formé par un environnement (biotope) et par l''ensemble des espèces (biocénose) qui y vivent, s''y nourrissent et s''y reproduisent.', '["Un écosystème", "Une biocénose", "Un biotope", "Une population"]', 'Un écosystème', 'Exemples : une forêt, une mare, une mangrove, un récif corallien.', 'Moyen', 'NS1'),
('B9-01', NULL, 'Aire géographique offrant des conditions constantes ou cycliques aux espèces de la biocénose.', '["Le biotope", "L''habitat", "La biosphère", "Le climat"]', 'Le biotope', 'Le biotope et sa biocénose forment un écosystème.', 'Moyen', 'NS1'),
('Q1714', 'Qu''est-ce que la biodiversité ?', 'Variété des espèces vivantes et de leurs caractères génétiques.', '["La biodiversité", "La biomasse", "La biosphère", "La biocénose"]', 'La biodiversité', 'Elle s''étudie à trois niveaux : les gènes, les espèces et les écosystèmes.', 'Moyen', 'NS1'),
('B9-09', NULL, 'Variété des caractères héréditaires entre les individus d''une même espèce.', '["La diversité génétique", "La diversité spécifique", "La diversité écosystémique", "La biomasse"]', 'La diversité génétique', 'Exemple : les nombreuses variétés de mangues en Haïti.', 'Moyen', 'NS1'),
('B9-10', NULL, 'Variété des sortes d''êtres vivants présentes dans un milieu, mesurée notamment par leur nombre.', '["La diversité spécifique", "La diversité génétique", "La diversité écosystémique", "La biomasse"]', 'La diversité spécifique', 'Plus un milieu compte d''espèces différentes, plus elle est grande.', 'Moyen', 'NS1'),
('B9-11', NULL, 'Variété des milieux de vie d''une région : forêts, mangroves, récifs, lacs, savanes…', '["La diversité écosystémique", "La diversité génétique", "La diversité spécifique", "La biomasse"]', 'La diversité écosystémique', 'Haïti possède des milieux très variés, du littoral aux sommets du Pic Macaya.', 'Moyen', 'NS1'),
('Q1619', 'Que désigne la biosphère ?', 'Ensemble des écosystèmes de la Terre : mince couche de l''air, des eaux et des roches où la vie est présente.', '["La biosphère", "L''atmosphère", "La lithosphère", "La biocénose"]', 'La biosphère', 'Elle va des profondeurs océaniques jusqu''à quelques kilomètres d''altitude.', 'Moyen', 'NS1'),
('Q1710', 'Qu''est-ce qui distingue un réseau trophique d''une chaîne alimentaire ?', 'Ensemble des chaînes alimentaires reliées entre elles dans un écosystème.', '["Le réseau trophique", "La chaîne alimentaire", "La biocénose", "Le cycle du carbone"]', 'Le réseau trophique', 'La chaîne est une suite linéaire ; le réseau représente toutes les relations alimentaires d''un milieu.', 'Moyen', 'NS1'),
('Q1713', 'Qu''est-ce que la succession écologique ?', 'Remplacement progressif, dans un milieu, de communautés d''êtres vivants par d''autres, jusqu''à un état stable.', '["La succession écologique", "La sélection naturelle", "La migration", "L''extinction"]', 'La succession écologique', 'Exemple : un sol nu colonisé par des herbes, puis des arbustes, puis la forêt.', 'Moyen', 'NS1'),
('Q1607', 'Qu''est-ce que l''extinction d''une espèce ?', 'Disparition définitive d''une espèce, quand son dernier individu meurt.', '["L''extinction", "La migration", "La mutation", "L''hybridation"]', 'L''extinction', 'C''est irréversible : l''espèce ne réapparaît pas.', 'Facile', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Biodiversité et équilibre écologique';
SELECT COUNT(*) AS chapitre_trouve FROM cible;

CREATE TEMP TABLE mat ON COMMIT DROP AS
SELECT q.v4_mat_canonical AS code FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = 11 AND q.v4_mat_canonical IS NOT NULL
GROUP BY q.v4_mat_canonical ORDER BY COUNT(*) DESC LIMIT 1;

WITH maj AS (
  UPDATE questions q
  SET chapitre_id = (SELECT id FROM cible), enonce = i.enonce, choix = i.choix, bonne_reponse = i.bonne,
      explication = i.explication, niveau_complexite = i.complexite, v4_niveau = i.niveau
  FROM imp i, chapitres c
  WHERE c.id = q.chapitre_id AND c.matiere_id = 11 AND i.ancien IS NOT NULL AND q.enonce = i.ancien
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
