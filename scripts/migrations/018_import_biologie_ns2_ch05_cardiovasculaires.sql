-- Import du chapitre Biologie « Les maladies cardiovasculaires » (NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('B16-01', NULL, 'Relatif à la fois au cœur et aux vaisseaux.', '["Cardiovasculaire", "Respiratoire", "Digestif", "Lymphatique"]', 'Cardiovasculaire', 'Les maladies de ce type touchent le cœur, les artères ou les veines.', 'Moyen', 'NS2'),
('B16-02', NULL, 'Toute maladie du cœur, quelle qu''en soit l''origine.', '["Une cardiopathie", "Une néphropathie", "Une pneumonie", "Une hépatite"]', 'Une cardiopathie', 'L''infarctus et l''insuffisance cardiaque en sont des exemples.', 'Moyen', 'NS2'),
('B16-03', NULL, 'Médecin spécialiste des maladies du cœur.', '["Le cardiologue", "Le pneumologue", "Le néphrologue", "Le dermatologue"]', 'Le cardiologue', 'Il utilise notamment l''électrocardiogramme.', 'Facile', 'NS2'),
('B16-04', NULL, 'Battements du cœur plus rapides qu''à l''état normal, ou irréguliers, ressentis par la personne.', '["Des palpitations", "Des courbatures", "Des crampes", "Des vertiges"]', 'Des palpitations', 'Elles sont souvent sans gravité, mais doivent être signalées si elles se répètent.', 'Difficile', 'NS2'),
('B16-10', NULL, 'Dépôt de plaques riches en cholestérol sur la paroi interne des artères.', '["L''athérome", "L''anévrisme", "La varice", "L''embolie"]', 'L''athérome', 'Ces plaques rétrécissent peu à peu le passage du sang.', 'Difficile', 'NS2'),
('B16-11', NULL, 'Maladie des artères dont la paroi s''épaissit et durcit à cause de dépôts de cholestérol, ce qui gêne la circulation.', '["L''athérosclérose", "L''hypertension", "La phlébite", "L''anémie"]', 'L''athérosclérose', 'Elle est favorisée par le tabac, le diabète, l''excès de cholestérol et la sédentarité.', 'Difficile', 'NS2'),
('B16-12', NULL, 'Pression artérielle anormalement basse.', '["L''hypotension", "L''hypertension", "L''hypoglycémie", "La bradycardie"]', 'L''hypotension', 'Elle peut provoquer des vertiges, surtout en se levant brusquement.', 'Facile', 'NS2'),
('Q1592', 'La pression artérielle normale chez un adulte est approximativement :', 'Quelle est la pression artérielle normale d''un adulte au repos ?', '["120/80 mmHg", "200/100 mmHg", "80/40 mmHg", "140/90 mmHg"]', '120/80 mmHg', '120 mmHg pendant la contraction du cœur (systole), 80 mmHg pendant son relâchement (diastole). Au-delà de 140/90, on parle d''hypertension.', 'Moyen', 'NS2'),
('Q1580', 'Pourquoi l''hypertension artérielle est-elle dangereuse ?', 'Quelles complications graves l''hypertension artérielle peut-elle provoquer ?', '["AVC et infarctus", "Asthme et bronchite", "Anémie et diabète", "Caries et gingivite"]', 'AVC et infarctus', 'Elle fatigue le cœur et abîme les artères ; elle peut aussi atteindre les reins.', 'Moyen', 'NS2'),
('B16-13', NULL, 'Appareil qui mesure la pression du sang dans les artères.', '["Le tensiomètre", "Le spiromètre", "Le thermomètre", "Le stéthoscope"]', 'Le tensiomètre', 'Son nom savant est sphygmomanomètre.', 'Moyen', 'NS2'),
('B16-14', NULL, 'Poche formée par la dilatation de la paroi d''une artère ou du cœur.', '["Un anévrisme", "Une varice", "Un athérome", "Un caillot"]', 'Un anévrisme', 'Sa rupture provoque une hémorragie grave.', 'Difficile', 'NS2'),
('B16-20', NULL, 'Masse de sang coagulé.', '["Un caillot", "Un athérome", "Un anévrisme", "Un ganglion"]', 'Un caillot', 'Il arrête un saignement, mais devient dangereux s''il bouche un vaisseau.', 'Facile', 'NS2'),
('B16-21', NULL, 'Formation d''un caillot de sang dans une artère ou une veine.', '["La thrombose", "L''embolie", "L''hémorragie", "L''anévrisme"]', 'La thrombose', 'Le caillot formé s''appelle un thrombus.', 'Difficile', 'NS2'),
('B16-22', NULL, 'Obstruction brutale d''un vaisseau par un corps étranger transporté par le sang.', '["L''embolie", "La thrombose", "La varice", "L''anévrisme"]', 'L''embolie', 'Ce corps étranger, souvent un caillot, s''appelle un embole.', 'Difficile', 'NS2'),
('B16-23', NULL, 'Diminution ou arrêt de la circulation artérielle dans une partie d''un organe.', '["L''ischémie", "L''hémorragie", "La varice", "L''anémie"]', 'L''ischémie', 'Privées de dioxygène, les cellules peuvent mourir.', 'Difficile', 'NS2'),
('B16-24', NULL, 'Mort d''une partie d''un organe causée par l''arrêt brutal de sa circulation artérielle.', '["Un infarctus", "Une embolie", "Un anévrisme", "Une ischémie"]', 'Un infarctus', 'Il peut toucher le cœur, le cerveau, le poumon ou l''intestin.', 'Moyen', 'NS2'),
('B16-25', NULL, 'Formation d''un caillot dans une veine, parfois avec une inflammation de sa paroi.', '["La phlébite", "La varice", "L''athérome", "L''anévrisme"]', 'La phlébite', 'Elle touche surtout les jambes, après une longue immobilité.', 'Moyen', 'NS2'),
('B16-26', NULL, 'Dilatation permanente d''une veine.', '["Une varice", "Un anévrisme", "Une phlébite", "Un hématome"]', 'Une varice', 'Elle se voit surtout sur les jambes.', 'Moyen', 'NS2'),
('B16-30', NULL, 'Mort d''une partie du muscle du cœur, privée de sang par l''obstruction d''une artère coronaire.', '["L''infarctus du myocarde", "L''insuffisance cardiaque", "L''angine de poitrine", "L''accident vasculaire cérébral"]', 'L''infarctus du myocarde', 'Familièrement : la crise cardiaque. Il faut appeler les secours immédiatement.', 'Moyen', 'NS2'),
('B16-31', NULL, 'Douleur qui serre la poitrine, due à un manque passager de sang dans le muscle du cœur.', '["L''angine de poitrine", "L''infarctus du myocarde", "La pneumonie", "L''asthme"]', 'L''angine de poitrine', 'Synonyme : angor. Elle survient souvent à l''effort et cède au repos.', 'Moyen', 'NS2'),
('B16-32', NULL, 'Incapacité du cœur à pomper assez de sang pour les besoins du corps.', '["L''insuffisance cardiaque", "L''infarctus du myocarde", "La tachycardie", "L''hypertension"]', 'L''insuffisance cardiaque', 'Le malade s''essouffle et ses jambes gonflent.', 'Moyen', 'NS2'),
('B16-33', NULL, 'Arrêt brutal de la circulation sanguine dans une partie du cerveau, par obstruction ou rupture d''une artère.', '["L''accident vasculaire cérébral", "L''infarctus du myocarde", "L''épilepsie", "La migraine"]', 'L''accident vasculaire cérébral', 'On l''abrège en AVC ; chaque minute compte pour le soigner.', 'Moyen', 'NS2'),
('B16-34', NULL, 'Paralysie de la moitié droite ou gauche du corps.', '["L''hémiplégie", "La paraplégie", "La tétraplégie", "L''amnésie"]', 'L''hémiplégie', 'C''est une séquelle fréquente d''un AVC.', 'Difficile', 'NS2'),
('B16-40', NULL, 'Appareil qui rétablit un rythme normal du cœur au moyen d''un choc électrique.', '["Le défibrillateur", "Le tensiomètre", "Le spiromètre", "Le stéthoscope"]', 'Le défibrillateur', 'Des modèles automatiques peuvent être utilisés par tout le monde.', 'Moyen', 'NS2'),
('B16-41', NULL, 'Opération qui relie deux vaisseaux sanguins pour contourner une artère rétrécie ou bouchée.', '["Le pontage", "La dialyse", "La transfusion", "La vaccination"]', 'Le pontage', 'On utilise un morceau de veine ou d''artère du patient, ou un tube plastique.', 'Difficile', 'NS2'),
('B16-42', NULL, 'Quel aliment faut-il limiter pour prévenir l''hypertension ?', '["Le sel", "Le poisson", "Les légumes", "L''eau"]', 'Le sel', 'L''OMS recommande moins de 5 g de sel par jour.', 'Facile', 'NS2'),
('B16-43', NULL, 'Lequel de ces comportements protège le cœur et les vaisseaux ?', '["Une activité physique régulière", "Une alimentation très salée", "Le tabagisme", "La sédentarité"]', 'Une activité physique régulière', 'Il faut aussi limiter le sucre, les graisses et ne pas fumer.', 'Facile', 'NS2'),
('B16-44', NULL, 'Quelle est la première cause de décès dans le monde ?', '["Les maladies cardiovasculaires", "Le cancer du poumon", "La tuberculose", "Le paludisme"]', 'Les maladies cardiovasculaires', 'Selon l''OMS, elles causent environ 18 millions de morts par an.', 'Moyen', 'NS2');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Les maladies cardiovasculaires';
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
