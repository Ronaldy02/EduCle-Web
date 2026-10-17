-- Import du chapitre Biologie « Métabolisme : photosynthèse et respiration cellulaire » (NS2, NS3) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('B18-01', NULL, 'Ensemble des transformations de matière et d''énergie réalisées en permanence par la cellule ou l''organisme.', '["Le métabolisme", "La digestion", "La nutrition", "La circulation"]', 'Le métabolisme', 'Il comprend les réactions de construction et celles de dégradation.', 'Moyen', 'NS2'),
('B18-02', NULL, 'Ensemble des réactions chimiques qui fabriquent les constituants de l''organisme à partir d''éléments simples.', '["L''anabolisme", "Le catabolisme", "La glycolyse", "La fermentation"]', 'L''anabolisme', 'Exemple : la fabrication des protéines à partir des acides aminés.', 'Difficile', 'NS2'),
('B18-03', NULL, 'Ensemble des réactions de dégradation des substances organiques, qui libèrent de l''énergie et produisent des déchets.', '["Le catabolisme", "L''anabolisme", "La photosynthèse", "L''assimilation"]', 'Le catabolisme', 'La respiration cellulaire en fait partie.', 'Difficile', 'NS2'),
('B18-04', NULL, 'Suite de réactions chimiques, chacune catalysée par une enzyme, qui transforme une molécule de départ en un produit final.', '["Une voie métabolique", "Une chaîne alimentaire", "Un cycle cellulaire", "Une liaison peptidique"]', 'Une voie métabolique', 'La glycolyse en est un exemple.', 'Moyen', 'NS2'),
('B18-05', NULL, 'Propriété des êtres vivants qui transforment des molécules venues de l''extérieur pour les rendre identiques à leurs propres constituants.', '["L''assimilation", "L''excrétion", "La digestion", "L''absorption"]', 'L''assimilation', 'Exemple : les acides aminés des aliments deviennent nos propres protéines.', 'Difficile', 'NS2'),
('B18-10', NULL, 'Dégradation complète du glucose, en présence de dioxygène, qui libère de l''énergie sous forme d''ATP.', '["La respiration cellulaire", "La fermentation", "La photosynthèse", "La digestion"]', 'La respiration cellulaire', 'Elle se déroule en grande partie dans les mitochondries.', 'Moyen', 'NS2'),
('Q1677', 'Quelles sont les trois étapes de la respiration cellulaire aérobie ?', 'Quelles sont les trois étapes de la respiration cellulaire aérobie ?', '["Glycolyse, Krebs, chaîne respiratoire", "Glycolyse uniquement", "Photosynthèse, glycolyse, fermentation", "Calvin, glycolyse, ATP-synthase"]', 'Glycolyse, Krebs, chaîne respiratoire', 'La glycolyse a lieu dans le cytoplasme ; le cycle de Krebs et la chaîne respiratoire, dans la mitochondrie.', 'Moyen', 'NS2'),
('B18-11', NULL, 'Première étape de la dégradation du sucre, qui se déroule dans le cytoplasme sans dioxygène.', '["La glycolyse", "Le cycle de Krebs", "La photolyse", "La chaîne respiratoire"]', 'La glycolyse', 'Elle découpe une molécule de glucose en deux molécules plus petites.', 'Difficile', 'NS2'),
('Q1680', 'Quel est le rôle de l''ATP synthase dans la mitochondrie ?', 'Enzyme de la membrane interne des mitochondries qui fabrique la « monnaie énergétique » de la cellule.', '["L''ATP synthase", "L''amylase", "L''ADN polymérase", "La RuBisCO"]', 'L''ATP synthase', 'Elle utilise un flux de protons à travers la membrane pour assembler l''ATP.', 'Moyen', 'NS2'),
('Q1678', 'Qu''est-ce que la fermentation ?', 'Transformation de matières organiques par les enzymes de micro-organismes, sans dioxygène, comme celle du sucre en alcool par les levures.', '["La fermentation", "La respiration", "La photosynthèse", "La digestion"]', 'La fermentation', 'Elle ne fournit que 2 ATP par glucose, contre 36 à 38 pour la respiration.', 'Moyen', 'NS2'),
('Q1544', 'La capacité d''une cellule à produire de l''énergie sans oxygène s''appelle :', 'Quel type de fermentation se produit dans les muscles privés de dioxygène ?', '["La fermentation lactique", "La fermentation alcoolique", "La fermentation acétique", "La fermentation butyrique"]', 'La fermentation lactique', 'Elle produit de l''acide lactique ; les levures, elles, réalisent la fermentation alcoolique.', 'Moyen', 'NS2'),
('B18-12', NULL, 'Quels produits la fermentation alcoolique des levures fournit-elle ?', '["De l''alcool et du CO₂", "Du glucose et du dioxygène", "De l''acide lactique seul", "De l''amidon et de l''eau"]', 'De l''alcool et du CO₂', 'C''est elle qui fait lever la pâte à pain.', 'Moyen', 'NS2'),
('Q1679', 'Qu''est-ce que le coefficient respiratoire (CR) ?', 'Rapport entre le volume de dioxyde de carbone rejeté et le volume de dioxygène absorbé par un organisme.', '["Le coefficient respiratoire", "La capacité vitale", "Le débit cardiaque", "Le point de compensation"]', 'Le coefficient respiratoire', 'Il vaut 1 quand l''organisme utilise des glucides, environ 0,7 pour des lipides.', 'Moyen', 'NS2'),
('B18-13', NULL, 'Quel gaz une euglène placée à la lumière rejette-t-elle ?', '["Le dioxygène", "Le dioxyde de carbone", "Le diazote", "La vapeur d''eau"]', 'Le dioxygène', 'À la lumière, elle réalise la photosynthèse ; à l''obscurité, elle ne fait que respirer.', 'Moyen', 'NS2'),
('B18-20', NULL, 'Fabrication de matière organique par les végétaux, à partir de dioxyde de carbone et d''eau, en présence de lumière.', '["La photosynthèse", "La respiration", "La fermentation", "La chimiosynthèse"]', 'La photosynthèse', 'Elle libère du dioxygène.', 'Facile', 'NS3'),
('Q1673', 'Quelle est l''équation globale de la photosynthèse ?', 'Quels sont les produits de la photosynthèse ?', '["Le glucose et le dioxygène", "Le CO₂ et l''eau", "L''ATP et l''urée", "L''amidon et l''azote"]', 'Le glucose et le dioxygène', 'Bilan : 6 CO₂ + 6 H₂O + lumière → C₆H₁₂O₆ + 6 O₂.', 'Facile', 'NS3'),
('Q1674', 'Où se déroulent les réactions de la phase claire de la photosynthèse ?', 'Réseau de membranes du chloroplaste, qui renferme la chlorophylle et où se déroule la phase claire de la photosynthèse.', '["Le thylakoïde", "Le stroma", "La mitochondrie", "Le noyau"]', 'Le thylakoïde', 'On y trouve les photosystèmes ; c''est là que l''eau est décomposée.', 'Moyen', 'NS3'),
('B18-21', NULL, 'Empilement de 50 à 100 disques chargés de chlorophylle, à l''intérieur du chloroplaste.', '["Un granum", "Un stroma", "Un ribosome", "Un nucléole"]', 'Un granum', 'Au pluriel, on dit des grana.', 'Difficile', 'NS3'),
('B18-22', NULL, 'Liquide qui remplit le chloroplaste, où le dioxyde de carbone est transformé en glucides.', '["Le stroma", "Le cytoplasme", "Le thylakoïde", "La vacuole"]', 'Le stroma', 'C''est le lieu du cycle de Calvin.', 'Difficile', 'NS3'),
('Q1675', 'Qu''est-ce que le cycle de Calvin (phase sombre) de la photosynthèse ?', 'Ensemble de réactions du stroma qui fixent le dioxyde de carbone pour fabriquer des glucides.', '["Le cycle de Calvin", "Le cycle de Krebs", "La glycolyse", "La photolyse"]', 'Le cycle de Calvin', 'Il utilise l''ATP et les composés réduits produits pendant la phase claire.', 'Moyen', 'NS3'),
('B18-23', NULL, 'Décomposition de la molécule d''eau par l''énergie de la lumière, dans la cellule végétale.', '["La photolyse", "L''hydrolyse", "La glycolyse", "L''osmose"]', 'La photolyse', 'Elle libère du dioxygène, des protons et des électrons.', 'Difficile', 'NS3'),
('B18-24', NULL, 'D''où provient le dioxygène libéré par la photosynthèse ?', '["De l''eau", "Du dioxyde de carbone", "Du glucose", "De la chlorophylle"]', 'De l''eau', 'Démontré en 1941 grâce à de l''eau marquée à l''oxygène 18.', 'Difficile', 'NS3'),
('B18-25', NULL, 'Substance qui donne leur couleur aux animaux ou aux plantes.', '["Un pigment", "Un sucre", "Une hormone", "Une vitamine"]', 'Un pigment', 'La chlorophylle est le pigment vert des plantes.', 'Facile', 'NS3'),
('B18-26', NULL, 'Pigment jaune ou orangé des chloroplastes, qui aide la chlorophylle à capter la lumière.', '["Un caroténoïde", "Une anthocyane", "Un tanin", "La lignine"]', 'Un caroténoïde', 'On les voit à l''automne, quand la chlorophylle disparaît des feuilles.', 'Difficile', 'NS3'),
('Q1682', 'Comment la concentration en CO₂ agit-elle sur la photosynthèse ?', 'Facteur dont la quantité insuffisante freine la photosynthèse, comme la lumière ou le dioxyde de carbone.', '["Un facteur limitant", "Un catalyseur", "Un pigment", "Un substrat"]', 'Un facteur limitant', 'La photosynthèse est réglée par le facteur le plus déficitaire.', 'Moyen', 'NS3'),
('Q1683', 'Qu''est-ce que le point de compensation photosynthétique ?', 'Intensité lumineuse pour laquelle la photosynthèse et la respiration d''une plante s''équilibrent exactement.', '["Le point de compensation", "Le point de saturation", "L''optimum", "Le facteur limitant"]', 'Le point de compensation', 'À ce niveau, la plante n''absorbe ni ne rejette de dioxyde de carbone.', 'Moyen', 'NS3'),
('B18-30', NULL, 'Liquide nourricier qui circule dans les diverses parties des végétaux.', '["La sève", "La lymphe", "Le latex", "Le nectar"]', 'La sève', 'La sève élaborée transporte les sucres fabriqués dans les feuilles.', 'Facile', 'NS3'),
('B18-31', NULL, 'Sous quelle forme les sucres fabriqués dans les feuilles sont-ils transportés dans la plante ?', '["Le saccharose", "L''amidon", "La cellulose", "Le glycogène"]', 'Le saccharose', 'Ils voyagent dans la sève élaborée jusqu''aux organes de réserve.', 'Moyen', 'NS3'),
('B18-32', NULL, 'Organite des organes de réserve, comme le tubercule de pomme de terre, qui accumule des grains de réserve glucidique.', '["Un amyloplaste", "Un chloroplaste", "Une mitochondrie", "Une vacuole"]', 'Un amyloplaste', 'Les grains qu''il forme sont des grains d''amidon.', 'Difficile', 'NS3'),
('B18-33', NULL, 'Constituant fondamental du bois, qui imprègne les parois de cellulose de certaines cellules végétales.', '["La lignine", "La cellulose", "L''amidon", "La kératine"]', 'La lignine', 'Elle rend les parois rigides et imperméables.', 'Moyen', 'NS3'),
('B18-34', NULL, 'Pigment végétal rouge, violet ou bleu des pétales, des feuilles et des fruits, situé dans les vacuoles.', '["Une anthocyane", "La chlorophylle", "Un caroténoïde", "Un tanin"]', 'Une anthocyane', 'Il colore par exemple les pétales d''hibiscus.', 'Difficile', 'NS3'),
('B18-35', NULL, 'Substance du bois, de l''écorce et des feuilles de nombreux végétaux, capable de transformer la peau en cuir.', '["Le tanin", "La lignine", "La résine", "Le latex"]', 'Le tanin', 'Il protège la plante contre les animaux qui la mangent.', 'Difficile', 'NS3');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Métabolisme : photosynthèse et respiration cellulaire';
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

-- Questions de base rejetées : suppression (et lignes qui les référencent)
CREATE TEMP TABLE asup ON COMMIT DROP AS
SELECT q.id FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = 11 AND q.enonce IN ('Quelle est l''équation globale de la respiration cellulaire aérobie ?', 'Que produit la respiration cellulaire aérobie ?');
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

SELECT COUNT(*) AS total_chapitre FROM questions WHERE chapitre_id = (SELECT id FROM cible);
COMMIT;
