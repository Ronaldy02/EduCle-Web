-- Import du chapitre Biologie « Adaptation cardiaque et respiratoire à l'effort » (NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('B15-01', NULL, 'Nombre de battements du cœur par minute.', '["La fréquence cardiaque", "Le débit cardiaque", "La tension artérielle", "Le volume courant"]', 'La fréquence cardiaque', 'On la mesure en prenant le pouls.', 'Facile', 'NS2'),
('B15-02', NULL, 'Appareil que l''on porte au poignet pour compter les battements du cœur pendant un effort.', '["Le cardiofréquencemètre", "Le spiromètre", "Le tensiomètre", "Le thermomètre"]', 'Le cardiofréquencemètre', 'Il permet de rester dans une zone d''effort adaptée.', 'Moyen', 'NS2'),
('B15-03', NULL, 'Volume de sang éjecté par le cœur en une minute.', '["Le débit cardiaque", "La fréquence cardiaque", "La capacité vitale", "Le volume courant"]', 'Le débit cardiaque', 'Il est égal à la fréquence cardiaque multipliée par le volume éjecté à chaque battement.', 'Difficile', 'NS2'),
('B15-04', NULL, 'Quelle est la fréquence cardiaque normale d''un adulte au repos ?', '["60 à 80 battements par minute", "20 à 30 battements par minute", "120 à 140 battements par minute", "200 battements par minute"]', '60 à 80 battements par minute', 'Elle est plus élevée chez l''enfant.', 'Facile', 'NS2'),
('B15-05', NULL, 'Accélération normale ou pathologique du rythme des battements du cœur.', '["La tachycardie", "La bradycardie", "L''arythmie", "L''hypertension"]', 'La tachycardie', 'Elle est normale pendant l''effort.', 'Moyen', 'NS2'),
('B15-06', NULL, 'Ralentissement des battements du cœur en dessous de 60 par minute.', '["La bradycardie", "La tachycardie", "L''apnée", "L''hypotension"]', 'La bradycardie', 'Elle est fréquente et normale chez les sportifs très entraînés.', 'Moyen', 'NS2'),
('B15-13', NULL, 'Quel gaz les muscles en activité rejettent-ils en plus grande quantité ?', '["Le dioxyde de carbone", "Le dioxygène", "Le diazote", "Le monoxyde de carbone"]', 'Le dioxyde de carbone', 'Il est évacué par les poumons, d''où une respiration plus rapide.', 'Moyen', 'NS2'),
('B15-16', NULL, 'Augmentation de la respiration pulmonaire due à l''anxiété, à l''activité physique ou à une maladie.', '["L''hyperventilation", "L''apnée", "L''hématose", "La bradycardie"]', 'L''hyperventilation', 'Pendant l''effort, elle permet d''absorber plus de dioxygène.', 'Moyen', 'NS2'),
('B15-17', NULL, 'Respiration courte et gênée de quelqu''un qui est hors d''haleine.', '["L''essoufflement", "L''apnée", "La toux", "Le hoquet"]', 'L''essoufflement', 'Il apparaît quand l''effort dépasse les capacités du moment.', 'Facile', 'NS2'),
('B15-18', NULL, 'Se dit des réactions chimiques d''un organisme qui se produisent en présence d''oxygène.', '["Aérobie", "Anaérobie", "Autotrophe", "Hétérotrophe"]', 'Aérobie', 'Un effort long et modéré, comme la course lente, est surtout de ce type.', 'Difficile', 'NS2'),
('B15-19', NULL, 'Se dit des réactions chimiques d''un organisme qui se produisent en l''absence d''oxygène.', '["Anaérobie", "Aérobie", "Autotrophe", "Hétérotrophe"]', 'Anaérobie', 'Un sprint très court et intense utilise surtout ce type de réactions.', 'Difficile', 'NS2'),
('B15-20', NULL, 'Quel déchet s''accumule dans les muscles lors d''un effort intense, quand le dioxygène manque ?', '["L''acide lactique", "L''urée", "Le glucose", "L''amidon"]', 'L''acide lactique', 'Il est produit par la fermentation dans les cellules musculaires.', 'Moyen', 'NS2'),
('B15-21', NULL, 'Douleur et fatigue des muscles après un effort inhabituel.', '["La courbature", "La crampe", "L''entorse", "La fracture"]', 'La courbature', 'Elle disparaît en quelques jours de repos.', 'Facile', 'NS2'),
('B15-30', NULL, 'Ensemble d''exercices légers qui préparent les muscles et le cœur avant un effort.', '["L''échauffement", "La récupération", "La relaxation", "La musculation"]', 'L''échauffement', 'Il réduit les risques de blessure.', 'Moyen', 'NS2'),
('B15-31', NULL, 'Aptitude à résister aux fatigues physiques ou aux épreuves morales.', '["L''endurance", "La vitesse", "La souplesse", "L''adresse"]', 'L''endurance', 'Exemple : l''endurance d''un coureur de fond.', 'Moyen', 'NS2'),
('B15-34', NULL, 'Mode de vie d''une personne qui bouge peu et reste longtemps assise.', '["La sédentarité", "L''endurance", "La récupération", "L''obésité"]', 'La sédentarité', 'Elle augmente les risques de maladies du cœur.', 'Moyen', 'NS2'),
('B15-35', NULL, 'Combien de minutes d''activité physique modérée par semaine l''OMS recommande-t-elle à un adulte ?', '["Au moins 150 minutes", "Au moins 15 minutes", "Au moins 1 000 minutes", "Aucune recommandation"]', 'Au moins 150 minutes', 'Pour les jeunes de 5 à 17 ans : 60 minutes par jour.', 'Moyen', 'NS2');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Adaptation cardiaque et respiratoire à l''effort';
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
