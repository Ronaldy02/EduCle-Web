-- Import du chapitre Biologie « Le système respiratoire » (NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('B12-01', NULL, 'Ensemble des phénomènes permettant l''absorption de l''oxygène et le rejet du gaz carbonique par les êtres vivants.', '["La respiration", "La digestion", "La circulation", "L''excrétion"]', 'La respiration', 'Chez l''humain, elle passe par les poumons.', 'Facile', 'NS2'),
('B12-02', NULL, 'Organe pair de la respiration, contenu dans la cavité thoracique.', '["Le poumon", "Le cœur", "Le foie", "Le rein"]', 'Le poumon', 'Le poumon gauche est un peu plus petit, pour laisser la place au cœur.', 'Facile', 'NS2'),
('Q1573', 'Quel est le rôle principal des poumons ?', 'Quel est le rôle principal des poumons ?', '["Les échanges gazeux", "Filtrer le sang", "Produire des hormones", "Digérer les aliments"]', 'Les échanges gazeux', 'Dans les alvéoles, le dioxygène passe dans le sang et le dioxyde de carbone en sort.', 'Facile', 'NS2'),
('B12-03', NULL, 'Cavité protégée par des parois osseuses, contenant les principaux organes de la circulation et de la respiration, située au-dessus de l''abdomen.', '["Le thorax", "L''abdomen", "Le crâne", "Le bassin"]', 'Le thorax', 'Il est protégé par les côtes, le sternum et la colonne vertébrale.', 'Moyen', 'NS2'),
('B12-12', NULL, 'Membrane qui recouvre presque complètement le poumon.', '["La plèvre", "Le péricarde", "Le diaphragme", "Le péritoine"]', 'La plèvre', 'Elle permet au poumon de glisser contre la paroi du thorax.', 'Moyen', 'NS2'),
('B12-20', NULL, 'Sécrétion visqueuse, riche en protéines, produite par les cellules qui tapissent les voies respiratoires, et qui joue un rôle de protection.', '["Le mucus", "La salive", "Le plasma", "La lymphe"]', 'Le mucus', 'Il piège les poussières et les microbes ; les cils les remontent vers la gorge.', 'Moyen', 'NS2'),
('B12-30', NULL, 'Dans quel ordre l''air inspiré traverse-t-il les voies respiratoires ?', '["Trachée, bronches, bronchioles, alvéoles", "Bronches, trachée, alvéoles, bronchioles", "Alvéoles, bronchioles, bronches, trachée", "Trachée, alvéoles, bronches, bronchioles"]', 'Trachée, bronches, bronchioles, alvéoles', 'Avant la trachée, l''air passe par les fosses nasales, le pharynx et le larynx.', 'Facile', 'NS2'),
('B12-43', NULL, 'Quel rôle jouent les poils et le mucus des fosses nasales ?', '["Filtrer l''air inspiré", "Produire l''oxygène", "Digérer les poussières", "Refroidir le sang"]', 'Filtrer l''air inspiré', 'Les fosses nasales réchauffent et humidifient aussi l''air.', 'Facile', 'NS2'),
('B12-05', NULL, 'Organe de la phonation, situé dans le cou, entre le pharynx et la trachée.', '["Le larynx", "Le pharynx", "La trachée", "L''œsophage"]', 'Le larynx', 'Il contient les cordes vocales.', 'Moyen', 'NS2'),
('B12-07', NULL, 'Partie moyenne de la cavité du larynx, bordée par les deux cordes vocales.', '["La glotte", "L''épiglotte", "La luette", "La trachée"]', 'La glotte', 'L''air qui la traverse fait vibrer les cordes vocales.', 'Difficile', 'NS2'),
('B12-06', NULL, 'Languette cartilagineuse qui ferme l''orifice supérieur du larynx au moment de la déglutition.', '["L''épiglotte", "La luette", "La glotte", "Le diaphragme"]', 'L''épiglotte', 'Elle empêche les aliments de passer dans la trachée (« avaler de travers »).', 'Moyen', 'NS2'),
('B12-08', NULL, 'Canal qui fait communiquer le larynx avec les bronches et qui sert au passage de l''air pendant la respiration.', '["La trachée", "L''œsophage", "Le pharynx", "La bronche"]', 'La trachée', 'Elle est renforcée par des anneaux de cartilage.', 'Facile', 'NS2'),
('B12-09', NULL, 'Conduit cylindrique qui transporte l''air entre la trachée et les alvéoles pulmonaires.', '["Une bronche", "La trachée", "Une alvéole", "Un capillaire"]', 'Une bronche', 'La trachée se divise en deux bronches, une par poumon.', 'Moyen', 'NS2'),
('B12-10', NULL, 'Plus fin conduit de l''arbre respiratoire, qui aboutit aux alvéoles pulmonaires.', '["Une bronchiole", "Une bronche", "La trachée", "Un capillaire"]', 'Une bronchiole', 'Les bronches se ramifient en milliers de bronchioles.', 'Moyen', 'NS2'),
('B12-11', NULL, 'Sac microscopique du tissu pulmonaire, situé au bout d''une bronchiole, où s''effectuent les échanges respiratoires.', '["Une alvéole", "Une bronchiole", "Un capillaire", "La plèvre"]', 'Une alvéole', 'Les poumons en contiennent des centaines de millions.', 'Moyen', 'NS2'),
('B12-17', NULL, 'Ensemble des échanges gazeux dans les poumons qui transforment le sang rouge sombre, riche en gaz carbonique, en sang rouge vif riche en oxygène.', '["L''hématose", "La respiration cellulaire", "La coagulation", "La digestion"]', 'L''hématose', 'Elle a lieu à travers la paroi des alvéoles et des capillaires.', 'Difficile', 'NS2'),
('B12-31', NULL, 'Quel gaz passe de l''air des alvéoles vers le sang ?', '["Le dioxygène", "Le dioxyde de carbone", "L''azote", "La vapeur d''eau"]', 'Le dioxygène', 'Il est ensuite transporté par les globules rouges.', 'Facile', 'NS2'),
('B12-32', NULL, 'Quel gaz passe du sang vers l''air des alvéoles ?', '["Le dioxyde de carbone", "Le dioxygène", "L''azote", "L''hydrogène"]', 'Le dioxyde de carbone', 'Il est rejeté lors de l''expiration.', 'Facile', 'NS2'),
('B12-15', NULL, 'Phase de la respiration pendant laquelle l''air atmosphérique, riche en oxygène, pénètre dans les poumons.', '["L''inspiration", "L''expiration", "L''hématose", "L''apnée"]', 'L''inspiration', 'C''est une phase active : des muscles se contractent.', 'Facile', 'NS2'),
('B12-16', NULL, 'Phase de la respiration pendant laquelle l''air est expulsé hors des poumons.', '["L''expiration", "L''inspiration", "La déglutition", "L''apnée"]', 'L''expiration', 'Au repos, c''est une phase passive : les muscles se relâchent.', 'Facile', 'NS2'),
('B12-13', NULL, 'Muscle très large et mince qui sépare le thorax de l''abdomen et dont la contraction provoque l''inspiration.', '["Le diaphragme", "Le muscle cardiaque", "Le grand dorsal", "L''abdominal"]', 'Le diaphragme', 'C''est le principal muscle de la respiration.', 'Moyen', 'NS2'),
('B12-18', NULL, 'Arrêt de la respiration, de durée variable, sans arrêt du cœur.', '["L''apnée", "L''asphyxie", "L''expiration", "La syncope"]', 'L''apnée', 'Exemple : la plongée sous-marine en apnée.', 'Moyen', 'NS2'),
('B12-19', NULL, 'Difficulté ou impossibilité de respirer.', '["L''asphyxie", "L''apnée", "La toux", "L''éternuement"]', 'L''asphyxie', 'Elle peut être causée par un étouffement, une noyade ou un gaz toxique.', 'Moyen', 'NS2'),
('B12-22', NULL, 'Appareil qui mesure la capacité vitale, c''est-à-dire le volume d''air expiré lors d''une expiration forcée après une inspiration forcée.', '["Le spiromètre", "Le stéthoscope", "Le tensiomètre", "Le thermomètre"]', 'Le spiromètre', 'Il sert à évaluer la santé des poumons.', 'Moyen', 'NS2'),
('B12-37', NULL, 'Comment appelle-t-on le volume d''air maximal expiré après une inspiration forcée ?', '["La capacité vitale", "Le volume courant", "Le volume résiduel", "Le débit cardiaque"]', 'La capacité vitale', 'Chez l''adulte, elle est d''environ 3 à 5 litres.', 'Moyen', 'NS2'),
('B12-38', NULL, 'Quel volume d''air un adulte échange-t-il environ à chaque respiration calme ?', '["Environ 0,5 litre", "Environ 5 litres", "Environ 0,05 litre", "Environ 2 litres"]', 'Environ 0,5 litre', 'C''est le volume courant.', 'Moyen', 'NS2'),
('B12-39', NULL, 'Quel est le rythme respiratoire normal d''un adulte au repos ?', '["12 à 20 par minute", "60 à 80 par minute", "2 à 5 par minute", "30 à 40 par minute"]', '12 à 20 par minute', 'Il augmente pendant l''effort.', 'Facile', 'NS2'),
('B12-40', NULL, 'Quelle partie de l''encéphale commande automatiquement la respiration ?', '["Le bulbe rachidien", "Le cervelet", "Le cortex frontal", "L''hypothalamus"]', 'Le bulbe rachidien', 'On peut aussi modifier volontairement sa respiration, pour un temps.', 'Difficile', 'NS2');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Le système respiratoire';
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
