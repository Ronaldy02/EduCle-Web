-- Import du chapitre Biologie « Structure et fonction des molécules biologiques » (NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('B17-01', NULL, 'Très grande particule chimique pouvant contenir des milliers, voire des centaines de milliers d''atomes.', '["Une macromolécule", "Un ion", "Un atome", "Un cristal"]', 'Une macromolécule', 'Protéines, polysaccharides et acides nucléiques en sont des exemples.', 'Moyen', 'NS2'),
('B17-02', NULL, 'Substance formée par la répétition, un grand nombre de fois, d''un même groupe d''atomes.', '["Un polymère", "Un monomère", "Un isomère", "Un élément"]', 'Un polymère', 'L''amidon est formé de milliers de glucoses enchaînés.', 'Difficile', 'NS2'),
('B17-03', NULL, 'Petite molécule qui, en s''enchaînant à d''autres, forme une macromolécule.', '["Un monomère", "Un polymère", "Un isomère", "Un ion"]', 'Un monomère', 'Exemples : le glucose pour l''amidon, l''acide aminé pour la protéine.', 'Difficile', 'NS2'),
('B17-04', NULL, 'Quelles sont les quatre grandes familles de molécules du vivant ?', '["Glucides, lipides, protéines, acides nucléiques", "Eau, sels, vitamines, fibres", "Glucose, amidon, cellulose, glycogène", "Fer, calcium, sodium, potassium"]', 'Glucides, lipides, protéines, acides nucléiques', 'Toutes sont des molécules organiques, construites autour du carbone.', 'Moyen', 'NS2'),
('B17-10', NULL, 'Composé formé par l''union de deux sucres simples, comme le saccharose.', '["Un diholoside", "Un polysaccharide", "Un acide aminé", "Un nucléotide"]', 'Un diholoside', 'On l''appelle aussi disaccharide.', 'Moyen', 'NS2'),
('Q1667', 'Qu''est-ce qui distingue un polysaccharide d''un monosaccharide ?', 'Glucide formé de l''union de nombreux oses, comme l''amidon, le glycogène ou la cellulose.', '["Un polysaccharide", "Un diholoside", "Un ose", "Un acide gras"]', 'Un polysaccharide', 'On l''appelle aussi polyoside. Son hydrolyse libère des oses.', 'Facile', 'NS2'),
('B17-11', NULL, 'Sucre simple très présent dans les fruits et le miel.', '["Le fructose", "Le lactose", "L''amidon", "Le maltose"]', 'Le fructose', 'Avec le glucose, il forme le saccharose.', 'Facile', 'NS2'),
('B17-12', NULL, 'Alcool de l''organisme, qui entre dans la composition des lipides et sert de source d''énergie.', '["Le glycérol", "L''éthanol", "Le cholestérol", "Le glucose"]', 'Le glycérol', 'Un triglycéride est formé d''un glycérol et de trois acides gras.', 'Moyen', 'NS2'),
('Q1665', 'Qu''est-ce qui distingue un acide gras insaturé d''un acide gras saturé ?', 'Comment appelle-t-on un acide gras dont la chaîne possède au moins une double liaison ?', '["Un acide gras insaturé", "Un acide gras saturé", "Un triglycéride", "Un phospholipide"]', 'Un acide gras insaturé', 'On en trouve surtout dans les huiles végétales et le poisson ; ils sont liquides à température ambiante.', 'Moyen', 'NS2'),
('B17-13', NULL, 'Qui évite l''eau.', '["Hydrophobe", "Hydrophile", "Soluble", "Aqueux"]', 'Hydrophobe', 'Les lipides sont hydrophobes : ils ne se mélangent pas à l''eau.', 'Moyen', 'NS2'),
('B17-20', NULL, 'Macromolécule constituée d''acides aminés unis entre eux par des liaisons peptidiques.', '["Une protéine", "Un glucide", "Un lipide", "Un acide nucléique"]', 'Une protéine', 'Enzymes, anticorps, hémoglobine et kératine en sont des exemples.', 'Facile', 'NS2'),
('Q1661', 'Quelle est la structure de base d''un acide aminé ?', 'Quels groupes chimiques caractérisent un acide aminé ?', '["Les groupes NH₂ et COOH", "Un groupe phosphate seulement", "Une base azotée et un sucre", "Trois acides gras"]', 'Les groupes NH₂ et COOH', 'Ils sont portés par un même carbone, avec un radical R qui varie d''un acide aminé à l''autre.', 'Moyen', 'NS2'),
('Q1662', 'Qu''est-ce qu''une liaison peptidique ?', 'Liaison chimique qui unit deux acides aminés dans une protéine.', '["La liaison peptidique", "La liaison hydrogène", "La liaison ionique", "La liaison phosphodiester"]', 'La liaison peptidique', 'Elle se forme entre le COOH d''un acide aminé et le NH₂ du suivant, avec libération d''eau.', 'Moyen', 'NS2'),
('B17-21', NULL, 'Combien d''acides aminés différents entrent dans la composition des protéines ?', '["20", "4", "100", "1 000"]', '20', 'Leur ordre dans la chaîne détermine la protéine.', 'Facile', 'NS2'),
('B17-22', NULL, 'Ordre dans lequel les acides aminés s''enchaînent dans une protéine.', '["La structure primaire", "La structure secondaire", "La structure tertiaire", "La structure quaternaire"]', 'La structure primaire', 'Il est fixé par l''information génétique.', 'Moyen', 'NS2'),
('Q1663', 'Qu''est-ce que la structure secondaire d''une protéine ?', 'Repliement local de la chaîne d''acides aminés en hélice α ou en feuillet β.', '["La structure secondaire", "La structure primaire", "La structure tertiaire", "La structure quaternaire"]', 'La structure secondaire', 'La structure tertiaire est le repliement de toute la chaîne dans l''espace.', 'Moyen', 'NS2'),
('Q1664', 'Qu''est-ce que la dénaturation d''une protéine ?', 'Perte de la forme dans l''espace d''une protéine, sous l''effet de la chaleur ou d''un pH extrême, qui lui fait perdre sa fonction.', '["La dénaturation", "L''hydrolyse", "La mutation", "La digestion"]', 'La dénaturation', 'Exemple : le blanc d''œuf qui blanchit à la cuisson.', 'Moyen', 'NS2'),
('B17-30', NULL, 'Macromolécule qui porte ou transmet l''information génétique, comme l''ADN ou l''ARN.', '["Un acide nucléique", "Une protéine", "Un polysaccharide", "Un lipide"]', 'Un acide nucléique', 'Elle est formée d''un enchaînement de nucléotides.', 'Moyen', 'NS2'),
('Q1668', 'De quoi un nucléotide est-il composé ?', 'Molécule formée d''un sucre, d''un groupe phosphate et d''une base azotée, unité de base de l''ADN et de l''ARN.', '["Un nucléotide", "Un acide aminé", "Un ose", "Un acide gras"]', 'Un nucléotide', 'L''ADN en contient quatre sortes : A, T, G et C.', 'Moyen', 'NS2'),
('Q1669', 'Quelle est la différence de structure entre l''ADN et l''ARN ?', 'Quelle est la différence de structure entre l''ADN et l''ARN ?', '["ADN double brin, ARN simple brin", "Ils sont identiques", "L''ARN est double brin", "L''ADN contient de l''uracile"]', 'ADN double brin, ARN simple brin', 'L''ADN contient le désoxyribose et la thymine ; l''ARN, le ribose et l''uracile.', 'Facile', 'NS2'),
('Q1666', 'Pourquoi l''ATP est-elle appelée la « monnaie énergétique » de la cellule ?', 'Quelle molécule fournit directement l''énergie nécessaire aux activités de la cellule ?', '["L''ATP", "L''ADN", "Le glycogène", "Le glycérol"]', 'L''ATP', 'Son hydrolyse libère de l''énergie : on l''appelle la « monnaie énergétique » de la cellule.', 'Facile', 'NS2'),
('B17-40', NULL, 'Substance qui augmente la vitesse d''une réaction chimique sans être consommée par celle-ci.', '["Un catalyseur", "Un substrat", "Un produit", "Un solvant"]', 'Un catalyseur', 'Les enzymes sont des catalyseurs biologiques.', 'Moyen', 'NS2'),
('B17-41', NULL, 'De quelle nature chimique sont la plupart des enzymes ?', '["Des protéines", "Des lipides", "Des glucides", "Des vitamines"]', 'Des protéines', 'Leur forme dans l''espace est essentielle à leur action.', 'Facile', 'NS2'),
('B17-42', NULL, 'Molécule sur laquelle agit une enzyme et qu''elle transforme.', '["Le substrat", "Le produit", "Le catalyseur", "Le coenzyme"]', 'Le substrat', 'Exemple : l''amidon est celui de l''amylase.', 'Moyen', 'NS2'),
('Q1671', 'Comment s''explique la spécificité d''une enzyme ?', 'Région d''une enzyme où se fixe le substrat et où a lieu la réaction.', '["Le site actif", "Le substrat", "Le coenzyme", "Le noyau"]', 'Le site actif', 'Sa forme ne convient qu''à un substrat précis : c''est la spécificité de l''enzyme.', 'Moyen', 'NS2'),
('Q1670', 'Comment une enzyme catalyse-t-elle une réaction ?', 'Comment une enzyme catalyse-t-elle une réaction ?', '["Elle abaisse l''énergie d''activation", "Elle est consommée par la réaction", "Elle fournit de l''énergie", "Elle change le produit final"]', 'Elle abaisse l''énergie d''activation', 'Elle accélère la réaction sans être consommée, grâce à son site actif.', 'Facile', 'NS2'),
('Q1672', 'Comment le pH et la température agissent-ils sur une enzyme ?', 'Comment appelle-t-on la température ou le pH pour lesquels une enzyme est la plus active ?', '["L''optimum", "Le seuil", "Le minimum", "La saturation"]', 'L''optimum', 'Pour la plupart des enzymes humaines : environ 37 °C.', 'Moyen', 'NS2'),
('B17-43', NULL, 'Petite molécule non protéique dont certains catalyseurs biologiques ont besoin pour agir.', '["Un coenzyme", "Un substrat", "Un acide aminé", "Un anticorps"]', 'Un coenzyme', 'Plusieurs vitamines du groupe B servent à en fabriquer.', 'Difficile', 'NS2');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Structure et fonction des molécules biologiques';
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
