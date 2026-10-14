-- Import du chapitre Biologie « Tabac et maladies respiratoires » (NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('B13-01', NULL, 'Plante herbacée dont les feuilles, riches en nicotine, sont séchées et préparées pour être fumées.', '["Le tabac", "Le chanvre", "Le thé", "La menthe"]', 'Le tabac', 'On l''utilise pour fabriquer cigarettes, cigares et tabac à pipe.', 'Facile', 'NS2'),
('B13-02', NULL, 'Principale substance du tabac, qui excite le système nerveux et rend le fumeur dépendant.', '["La nicotine", "Le goudron", "La caféine", "Le monoxyde de carbone"]', 'La nicotine', 'Elle agit sur le cerveau en quelques secondes.', 'Moyen', 'NS2'),
('B13-03', NULL, 'Ensemble des particules noires de la fumée de cigarette, qui se déposent dans les poumons.', '["Les goudrons", "La nicotine", "Les cendres", "La vapeur d''eau"]', 'Les goudrons', 'Ils contiennent de nombreuses substances qui provoquent des cancers.', 'Moyen', 'NS2'),
('B13-04', NULL, 'Quel gaz toxique de la fumée de cigarette prend la place du dioxygène dans les globules rouges ?', '["Le monoxyde de carbone", "Le dioxyde de carbone", "Le diazote", "La vapeur d''eau"]', 'Le monoxyde de carbone', 'Il se fixe sur l''hémoglobine : le sang transporte alors moins de dioxygène.', 'Moyen', 'NS2'),
('B13-05', NULL, 'Intoxication chronique due à la consommation régulière de cigarettes, cigares ou pipe.', '["Le tabagisme", "L''alcoolisme", "L''asthme", "L''anémie"]', 'Le tabagisme', 'Synonyme : nicotinisme.', 'Moyen', 'NS2'),
('B13-06', NULL, 'Se dit d''une substance capable de provoquer une tumeur maligne.', '["Cancérogène", "Contagieuse", "Allergène", "Antibiotique"]', 'Cancérogène', 'Synonyme : carcinogène. La fumée de tabac en contient plusieurs dizaines.', 'Difficile', 'NS2'),
('B13-07', NULL, 'Besoin d''une drogue tel que son arrêt provoque des troubles physiques ou psychiques.', '["La dépendance", "L''allergie", "L''intoxication", "La tolérance"]', 'La dépendance', 'Synonyme : addiction. La nicotine en est la cause principale chez le fumeur.', 'Moyen', 'NS2'),
('B13-08', NULL, 'Ensemble des troubles ressentis par une personne privée de la drogue dont elle est dépendante.', '["Le sevrage", "L''overdose", "L''allergie", "La rechute"]', 'Le sevrage', 'Chez le fumeur qui arrête : nervosité, envie de fumer, troubles du sommeil.', 'Difficile', 'NS2'),
('B13-21', NULL, 'Quelle est la principale cause du cancer du poumon ?', '["Le tabagisme", "La pollution sonore", "Le manque de sport", "Une alimentation salée"]', 'Le tabagisme', 'Environ 8 cancers du poumon sur 10 sont dus au tabac.', 'Facile', 'NS2'),
('B13-22', NULL, 'Comment appelle-t-on le fait de respirer la fumée des autres fumeurs ?', '["Le tabagisme passif", "Le tabagisme actif", "La pollution sonore", "L''apnée"]', 'Le tabagisme passif', 'Il augmente lui aussi les risques de maladies respiratoires, surtout chez l''enfant.', 'Facile', 'NS2'),
('B13-25', NULL, 'Quel est le meilleur moyen de protéger ses poumons du tabac ?', '["Ne pas fumer", "Fumer des cigarettes légères", "Fumer seulement le soir", "Fumer avec un filtre"]', 'Ne pas fumer', 'Arrêter de fumer améliore la respiration dès les premières semaines.', 'Facile', 'NS2'),
('B13-30', NULL, 'Maladie de cause souvent allergique, caractérisée par des crises de gêne à l''expiration, dues à un spasme des bronches.', '["L''asthme", "La tuberculose", "La pneumonie", "L''emphysème"]', 'L''asthme', 'On la soigne avec des médicaments inhalés qui dilatent les bronches.', 'Moyen', 'NS2'),
('B13-31', NULL, 'Inflammation des conduits qui relient la trachée aux poumons, avec une toux grasse et des crachats.', '["La bronchite", "L''asthme", "La pneumonie", "La tuberculose"]', 'La bronchite', 'Chez le fumeur, elle devient souvent chronique.', 'Moyen', 'NS2'),
('B13-32', NULL, 'Maladie infectieuse et contagieuse, due au bacille de Koch et touchant principalement les poumons.', '["La tuberculose", "La pneumonie", "L''asthme", "La bronchite"]', 'La tuberculose', 'Elle reste fréquente en Haïti ; le vaccin BCG protège les enfants.', 'Moyen', 'NS2'),
('Q1583', 'Quelle est la cause de la tuberculose ?', 'Quel type de microbe provoque la tuberculose ?', '["Une bactérie", "Un virus", "Un champignon", "Un parasite sanguin"]', 'Une bactérie', 'C''est le bacille de Koch (Mycobacterium tuberculosis). Elle se transmet par les gouttelettes expirées par un malade.', 'Moyen', 'NS2'),
('B13-33', NULL, 'Inflammation microbienne aiguë d''un lobe entier du poumon.', '["La pneumonie", "La bronchite", "L''asthme", "L''emphysème"]', 'La pneumonie', 'Sa forme la plus typique est due au pneumocoque.', 'Moyen', 'NS2'),
('B13-34', NULL, 'Maladie dans laquelle les parois des alvéoles sont détruites, ce qui réduit la surface des échanges gazeux.', '["L''emphysème", "L''asthme", "La bronchite", "La pneumonie"]', 'L''emphysème', 'Le tabagisme en est la cause principale ; le malade est vite essoufflé.', 'Difficile', 'NS2'),
('B13-35', NULL, 'Expiration brusque et sonore de l''air des poumons, provoquée par une irritation des voies respiratoires.', '["La toux", "Le hoquet", "L''éternuement", "Le bâillement"]', 'La toux', 'C''est un réflexe qui nettoie les voies respiratoires.', 'Facile', 'NS2'),
('B13-36', NULL, 'Expulsion par la toux de sécrétions provenant de la trachée, des bronches ou des alvéoles.', '["L''expectoration", "La déglutition", "L''inspiration", "La digestion"]', 'L''expectoration', 'Le produit de cette expulsion s''appelle le crachat.', 'Moyen', 'NS2'),
('B13-37', NULL, 'Réaction inhabituelle et excessive du système immunitaire à une substance étrangère déjà rencontrée.', '["L''allergie", "L''infection", "La vaccination", "L''inflammation"]', 'L''allergie', 'Pollens, poussières et poils d''animaux peuvent déclencher des crises d''asthme.', 'Moyen', 'NS2'),
('B13-38', NULL, 'Substance qui provoque une réaction excessive du système immunitaire chez certaines personnes.', '["Un allergène", "Un antibiotique", "Un anticorps", "Un vaccin"]', 'Un allergène', 'Exemples : pollen, acariens, poils de chat.', 'Difficile', 'NS2'),
('B13-39', NULL, 'Transmission d''une maladie d''une personne malade à une personne saine.', '["La contagion", "La vaccination", "L''immunité", "La mutation"]', 'La contagion', 'Elle peut être directe ou passer par un objet contaminé.', 'Moyen', 'NS2'),
('B13-40', NULL, 'Comment la tuberculose se transmet-elle le plus souvent ?', '["Par les gouttelettes dans l''air", "Par la nourriture", "Par les piqûres de moustique", "Par le contact avec l''eau"]', 'Par les gouttelettes dans l''air', 'Un malade qui tousse projette des microbes que d''autres respirent.', 'Facile', 'NS2'),
('B13-41', NULL, 'Quel vaccin protège les enfants contre la tuberculose ?', '["Le BCG", "Le ROR", "Le vaccin antitétanique", "Le vaccin antipoliomyélitique"]', 'Le BCG', 'Il est donné dès la naissance en Haïti.', 'Facile', 'NS2');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Tabac et maladies respiratoires';
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
