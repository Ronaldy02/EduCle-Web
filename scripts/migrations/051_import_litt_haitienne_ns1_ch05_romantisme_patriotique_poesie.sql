-- Import du chapitre Littérature haïtienne « Le romantisme patriotique (1860-1898) : poésie » (NS1) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('LH5-01', NULL, 'Genre littéraire caractérisé par l''expression exaltée des sentiments, des passions ?', '["Le lyrisme", "Le réalisme", "Le didactisme", "L''épopée"]', 'Le lyrisme', 'Hoffmann note que le lyrisme des poètes haïtiens est teinté de patriotisme.', 'Moyen', 'NS1'),
('LH5-02', NULL, 'Chanson populaire racontant les malheurs d''un personnage ?', '["Une complainte", "Une marche", "Une berceuse", "Une ritournelle"]', 'Une complainte', 'Choucoune, d''Oswald Durand, est la complainte d''un Haïtien abandonné par sa belle.', 'Moyen', 'NS1'),
('LH5-03', NULL, 'Disposition favorable à l''égard de la France et des Français ?', '["La francophilie", "La francophonie", "La xénophobie", "Le chauvinisme"]', 'La francophilie', 'Hoffmann la dit sincère chez les élites haïtiennes du XIXe siècle, mais aussi politique.', 'Moyen', 'NS1'),
('LH5-04', NULL, 'Danse d''Haïti et de Saint-Domingue à deux temps, et musique qui l''accompagne ?', '["La méringue", "Le compas", "Le kadans", "Le rara"]', 'La méringue', 'Le poème Choucoune a été mis en musique en méringue lente.', 'Moyen', 'NS1'),
('LH5-05', NULL, 'Quel thème est devenu presque obligatoire dans la poésie haïtienne de l''époque ?', '["L''épopée de la guerre d''Indépendance", "La vie des paysans", "Les voyages en Europe", "Les saisons du Nord"]', 'L''épopée de la guerre d''Indépendance', 'Les poètes glorifient aussi les Pères de la patrie.', 'Moyen', 'NS1'),
('LH5-06', NULL, 'Quel poète publie à Paris, en 1892, un recueil intitulé Poésies nationales ?', '["Massillon Coicou", "Oswald Durand", "Etzer Vilaire", "Georges Sylvain"]', 'Massillon Coicou', 'Le recueil est publié à Paris et lui vaut le surnom de « barde national ».', 'Moyen', 'NS1'),
('LH5-07', NULL, 'Quelle revue fondée en 1895 par Seymour Pradel et Justin Lhérisson précède La Ronde ?', '["Jeune Haïti", "L''Union", "La Ruche", "Le Petit Haïtien"]', 'Jeune Haïti', 'Elle paraît à Port-au-Prince de 1895 à 1898.', 'Moyen', 'NS1'),
('LH5-09', NULL, 'Quel oiseau tropical remplace le rossignol dans la poésie haïtienne qui s''enracine ?', '["Le pipirit", "Le colibri", "Le perroquet", "Le flamant"]', 'Le pipirit', 'On y parle aussi de mornes plutôt que de montagnes et de champs de canne plutôt que de blé.', 'Moyen', 'NS1'),
('LH5-10', NULL, 'Quel poète est considéré comme le poète national d''Haïti ?', '["Oswald Durand", "Massillon Coicou", "Etzer Vilaire", "Tertullien Guilbaud"]', 'Oswald Durand', 'Né au Cap-Haïtien en 1840, il meurt à Port-au-Prince en 1906.', 'Facile', 'NS1'),
('LH5-11', NULL, 'Quel poème créole d''Oswald Durand est le plus célèbre ?', '["Choucoune", "Ces Allemands", "Idalina", "Contraste"]', 'Choucoune', 'Il raconte l''abandon d''un Haïtien par sa belle marabout, partie avec un petit Blanc.', 'Facile', 'NS1'),
('LH5-12', NULL, 'Dans quel recueil figure le poème Choucoune ?', '["Rires et pleurs", "Quatre Nouveaux poèmes", "Poésies nationales", "Sous les bambous"]', 'Rires et pleurs', 'Rires et pleurs rassemble en deux volumes des poèmes publiés dans les journaux ; il paraît en 1896.', 'Moyen', 'NS1'),
('LH5-13', NULL, 'En quelle année Rires et pleurs est-il publié en deux volumes ?', '["1896", "1883", "1901", "1869"]', '1896', 'Il rassemble les poèmes donnés à la presse pendant une vingtaine d''années.', 'Moyen', 'NS1'),
('LH5-15', NULL, 'Sous quel titre anglais Choucoune est-elle devenue célèbre ?', '["Yellow Bird", "Blue Moon", "Black Bird", "Green Island"]', 'Yellow Bird', 'Elle reste au répertoire des orchestres de danse antillais.', 'Moyen', 'NS1'),
('LH5-17', NULL, 'Quelle est la ville natale d''Oswald Durand ?', '["Le Cap-Haïtien", "Port-au-Prince", "Les Cayes", "Jacmel"]', 'Le Cap-Haïtien', 'Il y naît le 17 septembre 1840.', 'Moyen', 'NS1'),
('LH5-18', NULL, 'Quel poème de Durand exhorte à oublier le préjugé de couleur pour suivre les Pères de la patrie ?', '["Chant national", "Les Forts", "L''Arbre de la vallée", "Ode à la France"]', 'Chant national', 'Il s''adresse aux « descendants de l''Afrique, jaunes et noirs ».', 'Moyen', 'NS1'),
('LH5-21', NULL, 'Quel poème de Durand décrit une femme comparée aux sapotes et aux raisins noirs ?', '["Idalina", "Choucoune", "Contraste", "Les Forts"]', 'Idalina', 'Les fruits du terroir servent souvent à évoquer la femme dans la poésie haïtienne.', 'Difficile', 'NS1'),
('LH5-22', NULL, 'Quel surnom Massillon Coicou reçoit-il après son premier recueil ?', '["Le barde national", "Le poète des pauvres", "Le chantre du Nord", "Le prince des poètes"]', 'Le barde national', 'Ses poèmes célèbrent les héros nationaux.', 'Moyen', 'NS1'),
('LH5-23', NULL, 'Quel recueil de Coicou, publié en 1903, contient « La Voix mauvaise » ?', '["Impressions", "Passions", "Poésies nationales", "Complaintes d''esclave"]', 'Impressions', 'Hoffmann cite ce poème grinçant comme exemple de découragement des poètes.', 'Difficile', 'NS1'),
('LH5-24', NULL, 'Quelle bataille Coicou chante-t-il dans ses Poésies nationales ?', '["Vertières", "Crête-à-Pierrot", "La Ravine-à-Couleuvres", "Savannah"]', 'Vertières', 'Il consacre aussi des poèmes à Dessalines, Toussaint Louverture, Pétion et Christophe.', 'Moyen', 'NS1'),
('LH5-26', NULL, 'Quel poème grinçant de Coicou, de 1903, exprime son découragement ?', '["La Voix mauvaise", "Une voix sur le Pont Rouge", "À un Français", "Vertières"]', 'La Voix mauvaise', 'Il se moque des tribuns et des poètes.', 'Difficile', 'NS1'),
('LH5-27', NULL, 'En quelle année est né Massillon Coicou ?', '["1867", "1840", "1872", "1856"]', '1867', 'Il naît à Port-au-Prince le 9 octobre.', 'Moyen', 'NS1'),
('LH5-30', NULL, 'Quel poète publie en 1885 le recueil Patrie, espérance et souvenirs ?', '["Tertullien Guilbaud", "Alcibiade Fleury-Battier", "Oswald Durand", "Massillon Coicou"]', 'Tertullien Guilbaud', 'Le poème « Le Premier Janvier » y célèbre la naissance de la République noire.', 'Moyen', 'NS1'),
('LH5-31', NULL, 'Quel poème de Guilbaud évoque la naissance de la République noire ?', '["Le Premier Janvier", "Le Drapeau national", "Au peuple", "À un Montagnard"]', 'Le Premier Janvier', 'Il rappelle les esclaves marqués d''un « R » pour s''être révoltés.', 'Difficile', 'NS1'),
('LH5-32', NULL, 'Quel refus Guilbaud exprime-t-il dans « Les Hommes de l''Indépendance » ?', '["Toute critique des fondateurs", "Toute alliance avec la France", "Tout poème en créole", "Tout vote populaire"]', 'Toute critique des fondateurs', 'Pour lui, blâmer ces grandes figures est une impiété.', 'Difficile', 'NS1'),
('LH5-34', NULL, 'Quel recueil d''Alcibiade Fleury-Battier contient « Mon Pays » (1881) ?', '["Sous les bambous", "Feuilles au vent", "Chants du soir", "Fleurs et pleurs"]', 'Sous les bambous', 'Il y chante ses guerriers, ses paysages et la diversité de ses femmes.', 'Moyen', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 23 AND titre = 'Le romantisme patriotique (1860-1898) : poésie';
SELECT COUNT(*) AS chapitre_trouve FROM cible;

CREATE TEMP TABLE mat ON COMMIT DROP AS
SELECT q.v4_mat_canonical AS code FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = 23 AND q.v4_mat_canonical IS NOT NULL
GROUP BY q.v4_mat_canonical ORDER BY COUNT(*) DESC LIMIT 1;

WITH maj AS (
  UPDATE questions q
  SET chapitre_id = (SELECT id FROM cible), enonce = i.enonce, choix = i.choix, bonne_reponse = i.bonne,
      explication = i.explication, niveau_complexite = i.complexite, v4_niveau = i.niveau
  FROM imp i, chapitres c
  WHERE c.id = q.chapitre_id AND c.matiere_id = 23 AND i.ancien IS NOT NULL AND q.enonce = i.ancien
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
