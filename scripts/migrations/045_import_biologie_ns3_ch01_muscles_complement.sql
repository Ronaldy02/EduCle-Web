-- Import du chapitre Biologie « Les muscles : types, structure et propriétés » (NS3) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('B20-71', NULL, 'Partie de l''anatomie qui traite des muscles.', '["La myologie", "L''ostéologie", "La cytologie", "La neurologie"]', 'La myologie', 'L''ostéologie étudie les os, la myologie étudie les muscles.', 'Moyen', 'NS3'),
('B20-72', NULL, 'Ensemble des muscles du corps humain.', '["La musculature", "L''ossature", "La carrure", "La charpente"]', 'La musculature', 'On dit d''un sportif qu''il a une musculature développée.', 'Moyen', 'NS3'),
('B20-73', NULL, 'Muscle pair des joues appartenant au groupe des muscles masticateurs, dont le rôle est d''élever la mâchoire inférieure.', '["Le masséter", "Le deltoïde", "Le pectoral", "Le triceps"]', 'Le masséter', 'C''est un muscle de la mastication, très puissant.', 'Moyen', 'NS3'),
('B20-74', NULL, 'Muscles constituant les parois antérieures et latérales de l''abdomen.', '["Les abdominaux", "Les pectoraux", "Les fessiers", "Les lombaires"]', 'Les abdominaux', 'On les renforce par des exercices de gainage.', 'Facile', 'NS3'),
('B20-75', NULL, 'Muscle pair situé dans le bassin, qui fléchit la cuisse sur le bassin.', '["Le psoas", "Le masséter", "Le deltoïde", "Le soléaire"]', 'Le psoas', 'Uni au muscle iliaque, il forme le psoas iliaque.', 'Difficile', 'NS3'),
('B20-76', NULL, 'Volumineuse masse musculaire située à la face postérieure de la jambe.', '["Le soléaire", "Le psoas", "Le masséter", "Le deltoïde"]', 'Le soléaire', 'Elle s''unit aux jumeaux pour former le triceps sural, qui se termine par le tendon d''Achille.', 'Difficile', 'NS3'),
('B20-77', NULL, 'Quel muscle large de la poitrine rapproche le bras du corps ?', '["Le grand pectoral", "Le grand dorsal", "Le deltoïde", "Le trapèze"]', 'Le grand pectoral', 'Il sert à pousser, par exemple dans les pompes.', 'Moyen', 'NS3'),
('B20-78', NULL, 'Quel muscle triangulaire du dos et de la nuque permet de hausser les épaules ?', '["Le trapèze", "Le deltoïde", "Le grand pectoral", "Le psoas"]', 'Le trapèze', 'Il tient son nom de sa forme de trapèze.', 'Moyen', 'NS3'),
('B20-79', NULL, 'Quel est le muscle le plus volumineux du corps humain ?', '["Le grand fessier", "Le quadriceps", "Le grand dorsal", "Le mollet"]', 'Le grand fessier', 'Il permet de se redresser, de monter les escaliers et de courir.', 'Moyen', 'NS3'),
('B20-80', NULL, 'Quel est le muscle le plus long du corps humain ?', '["Le sartorius", "Le quadriceps", "Le biceps", "Le soléaire"]', 'Le sartorius', 'Il traverse la cuisse en diagonale ; on l''appelle aussi muscle couturier.', 'Difficile', 'NS3'),
('B20-81', NULL, 'Quel muscle de la face avant de la cuisse étend la jambe ?', '["Le quadriceps", "Les ischio-jambiers", "Le soléaire", "Le psoas"]', 'Le quadriceps', 'Il compte quatre chefs, d''où son nom.', 'Moyen', 'NS3'),
('B20-82', NULL, 'Quel groupe de muscles de l''arrière de la cuisse est l''antagoniste du quadriceps ?', '["Les ischio-jambiers", "Les abdominaux", "Les fessiers", "Les deltoïdes"]', 'Les ischio-jambiers', 'Ils fléchissent la jambe sur la cuisse.', 'Difficile', 'NS3'),
('B20-83', NULL, 'Membrane plasmique qui entoure une cellule striée.', '["Le sarcolemme", "Le sarcomère", "Le cytoplasme", "L''aponévrose"]', 'Le sarcolemme', 'Elle transmet l''excitation nerveuse à l''intérieur de la cellule.', 'Difficile', 'NS3'),
('B20-84', NULL, 'Diminution acquise de poids et de volume d''une cellule, d''un tissu ou d''un organe.', '["L''atrophie", "L''hypertrophie", "La nécrose", "La dystrophie"]', 'L''atrophie', 'Elle survient après une longue immobilisation (plâtre) ou par manque d''activité.', 'Moyen', 'NS3'),
('B20-85', NULL, 'Augmentation de volume d''un tissu, d''un organe, due à une augmentation de volume de ses cellules.', '["L''hypertrophie", "L''atrophie", "L''œdème", "La prolifération"]', 'L''hypertrophie', 'Un entraînement de force provoque l''hypertrophie des fibres musculaires.', 'Moyen', 'NS3'),
('B20-86', NULL, 'Toute affection des fibres musculaires.', '["Une myopathie", "Une neuropathie", "Une arthrite", "Une tendinite"]', 'Une myopathie', 'La myopathie de Duchenne est une maladie génétique.', 'Moyen', 'NS3'),
('B20-87', NULL, 'Anomalie musculaire caractérisée par une décontraction anormalement lente.', '["La myotonie", "La myopathie", "L''hypotonie", "L''atrophie"]', 'La myotonie', 'La relaxation est retardée après chaque contraction.', 'Difficile', 'NS3'),
('B20-88', NULL, 'Contraction d''un muscle du squelette, spontanée, durable et douloureuse, survenant en l''absence de toute lésion anatomique.', '["La contracture", "La crampe", "Le claquage", "L''élongation"]', 'La contracture', 'Elle disparaît avec le repos, la chaleur et les étirements doux.', 'Moyen', 'NS3'),
('B20-89', NULL, 'Contraction pathologique des muscles et spécialement des muscles lisses.', '["Un spasme", "Une contracture", "Un claquage", "Une élongation"]', 'Un spasme', 'Les coliques sont des spasmes de l''intestin.', 'Moyen', 'NS3'),
('B20-90', NULL, 'Rupture partielle, accidentelle d''un muscle.', '["Un claquage", "Une entorse", "Une luxation", "Une tendinite"]', 'Un claquage', 'Il survient souvent lors d''un effort brusque sans échauffement.', 'Moyen', 'NS3'),
('B20-91', NULL, 'Allongement accidentel ou thérapeutique d''un muscle, d''un nerf, d''un tendon, etc.', '["Une élongation", "Un claquage", "Une entorse", "Une luxation"]', 'Une élongation', 'C''est la lésion musculaire la plus légère, sans rupture.', 'Moyen', 'NS3'),
('B20-92', NULL, 'Inflammation d''un tendon.', '["Une tendinite", "Une entorse", "Une arthrose", "Une fracture"]', 'Une tendinite', 'Elle est fréquente chez les sportifs, au tendon d''Achille ou à l''épaule.', 'Moyen', 'NS3'),
('B20-93', NULL, 'Lésion traumatique d''une articulation résultant de sa distorsion brutale, avec étirement ou rupture des ligaments.', '["Une entorse", "Une luxation", "Une fracture", "Une tendinite"]', 'Une entorse', 'La cheville est l''articulation la plus souvent touchée.', 'Moyen', 'NS3');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Les muscles : types, structure et propriétés';
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
