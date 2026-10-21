-- Import du chapitre Physique « Big Bang, système solaire et exploration de l'espace » (NS1, NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('PN1_02-71', NULL, 'Quelle science étudie les astres et l''Univers ?', '["L''astronomie", "L''astrologie", "La géologie", "La météorologie"]', 'L''astronomie', 'L''astrologie, elle, prétend lire l''avenir dans le ciel : ce n''est pas une science.', 'Moyen', 'NS1'),
('PN1_02-72', NULL, 'Quelle théorie plaçait la Terre au centre de l''Univers ?', '["Le géocentrisme", "L''héliocentrisme", "Le Big Bang", "La nucléosynthèse"]', 'Le géocentrisme', 'Elle remonte à Ptolémée, au IIᵉ siècle, et a dominé jusqu''à la Renaissance.', 'Moyen', 'NS1'),
('PN1_02-73', NULL, 'Quel savant polonais a placé le Soleil au centre du système planétaire, en 1543 ?', '["Nicolas Copernic", "Galilée", "Johannes Kepler", "Ptolémée"]', 'Nicolas Copernic', 'Son modèle, l''héliocentrisme, fait tourner la Terre et les autres planètes autour du Soleil.', 'Moyen', 'NS1'),
('PN1_02-74', NULL, 'Qui a observé les quatre grands satellites de Jupiter avec une lunette, en 1610 ?', '["Galilée", "Copernic", "Isaac Newton", "Johannes Kepler"]', 'Galilée', 'Cette découverte a montré que tous les astres ne tournent pas autour de la Terre.', 'Moyen', 'NS1'),
('PN1_02-75', NULL, 'Quel instrument capte les ondes radio venues de l''espace ?', '["Un radiotélescope", "Un microscope", "Un sismographe", "Un baromètre"]', 'Un radiotélescope', 'Sa grande antenne parabolique collecte les ondes émises par les étoiles et les galaxies.', 'Moyen', 'NS1'),
('PN1_02-81', NULL, 'Comment appelle-t-on le plus ancien rayonnement observable de l''Univers, émis environ 380 000 ans après le Big Bang ?', '["Le fond diffus cosmologique", "Le rayonnement solaire", "Le vent stellaire", "Le fond sonore céleste"]', 'Le fond diffus cosmologique', 'Découvert en 1964, c''est une preuve majeure du Big Bang.', 'Difficile', 'NS1'),
('PN1_02-82', NULL, 'Quel gaz constitue l''essentiel de la matière du Soleil ?', '["L''hydrogène", "L''oxygène", "Le carbone", "L''azote"]', 'L''hydrogène', 'Le Soleil contient environ 73 % d''hydrogène et 25 % d''hélium.', 'Facile', 'NS1'),
('PN1_02-83', NULL, 'Quelle réaction produit l''énergie du Soleil ?', '["La fusion de l''hydrogène", "La fission de l''uranium", "La combustion de l''oxygène", "La décomposition de l''eau"]', 'La fusion de l''hydrogène', 'Au cœur, à 15 millions de degrés, les noyaux d''hydrogène fusionnent en noyaux d''hélium.', 'Moyen', 'NS1'),
('PN1_02-84', NULL, 'Quelle est la température approximative de la surface du Soleil ?', '["Environ 5 500 °C", "Environ 500 °C", "Environ 55 000 °C", "Environ 1 000 000 °C"]', 'Environ 5 500 °C', 'Le cœur du Soleil est bien plus chaud que sa surface.', 'Moyen', 'NS1'),
('PN1_02-85', NULL, 'Quelle est la couleur d''une étoile très chaude ?', '["Bleue", "Rouge", "Verte", "Jaune"]', 'Bleue', 'Le Soleil, d''une température moyenne, est jaune ; les étoiles les plus froides sont rouges.', 'Moyen', 'NS1'),
('PN1_02-86', NULL, 'Comment appelle-t-on un groupe d''étoiles qui dessine une figure dans le ciel ?', '["Une constellation", "Une galaxie", "Une nébuleuse", "Une orbite"]', 'Une constellation', 'La Grande Ourse et Orion sont des constellations connues ; les étoiles d''une constellation ne sont pas forcément proches.', 'Facile', 'NS1'),
('PN1_02-87', NULL, 'Quelle étoile indique à peu près le nord dans l''hémisphère nord ?', '["L''étoile Polaire", "Sirius", "Proxima du Centaure", "Bételgeuse"]', 'L''étoile Polaire', 'Elle est presque alignée avec l''axe de rotation de la Terre : elle ne bouge presque pas dans le ciel de la nuit.', 'Moyen', 'NS1'),
('PN1_02-88', NULL, 'Quelle est l''étoile la plus brillante du ciel nocturne ?', '["Sirius", "L''étoile Polaire", "Proxima du Centaure", "Antarès"]', 'Sirius', 'Elle se trouve à 8,6 années-lumière de la Terre.', 'Moyen', 'NS1'),
('PN1_02-89', NULL, 'Comment appelle-t-on un astre dont la gravité est si forte que la lumière ne peut pas s''en échapper ?', '["Un trou noir", "Une supernova", "Une nébuleuse", "Une naine blanche"]', 'Un trou noir', 'Il peut se former quand une étoile très massive s''effondre à la fin de sa vie.', 'Moyen', 'NS1'),
('PN1_02-90', NULL, 'Quelle forme a la Voie lactée vue de loin ?', '["Une spirale", "Une sphère", "Un cube", "Un cône"]', 'Une spirale', 'Notre système solaire se trouve sur l''un des bras de cette spirale, loin du centre.', 'Facile', 'NS1'),
('PN1_02-101', NULL, 'Quelle planète vient juste après la Terre, en s''éloignant du Soleil ?', '["Mars", "Vénus", "Jupiter", "Mercure"]', 'Mars', 'Mars est la planète la plus proche de la Terre au-delà de son orbite.', 'Facile', 'NS1'),
('PN1_02-102', NULL, 'Quelle est la planète la plus éloignée du Soleil ?', '["Neptune", "Uranus", "Saturne", "Pluton"]', 'Neptune', 'Pluton, aujourd''hui planète naine, orbite en moyenne plus loin que Neptune.', 'Facile', 'NS1'),
('PN1_02-103', NULL, 'Quelle est la planète la plus chaude du système solaire ?', '["Vénus", "Mercure", "Mars", "Jupiter"]', 'Vénus', 'Son atmosphère épaisse de gaz carbonique provoque un énorme effet de serre : plus de 450 °C à sa surface.', 'Moyen', 'NS1'),
('PN1_02-104', NULL, 'Quelle planète est surnommée l''étoile du Berger ?', '["Vénus", "Mars", "Jupiter", "Mercure"]', 'Vénus', 'Très brillante au lever ou au coucher du Soleil, elle est facilement prise pour une étoile.', 'Moyen', 'NS1'),
('PN1_02-105', NULL, 'Quelle planète est la plus connue pour ses anneaux ?', '["Saturne", "Mars", "Mercure", "Vénus"]', 'Saturne', 'Ses anneaux, faits de glace et de roches, sont visibles avec un petit télescope.', 'Facile', 'NS1'),
('PN1_02-106', NULL, 'Quelle planète porte la Grande Tache rouge, une immense tempête ?', '["Jupiter", "Saturne", "Mars", "Neptune"]', 'Jupiter', 'Cette tempête dure depuis plusieurs siècles et est plus large que la Terre.', 'Moyen', 'NS1'),
('PN1_02-107', NULL, 'Quelle planète tourne couchée sur le côté, son axe étant presque dans le plan de son orbite ?', '["Uranus", "Neptune", "Mars", "Vénus"]', 'Uranus', 'Son axe est incliné d''environ 98°, si bien qu''elle roule presque comme une bille autour du Soleil.', 'Difficile', 'NS1'),
('PN1_02-108', NULL, 'Quelle planète est surnommée la planète bleue ?', '["La Terre", "Mars", "Mercure", "Vénus"]', 'La Terre', 'Les océans, qui couvrent environ 70 % de sa surface, lui donnent cette couleur vue de l''espace.', 'Facile', 'NS1'),
('PN1_02-109', NULL, 'Quelle sorte de planètes sont Jupiter et Saturne ?', '["Des planètes géantes gazeuses", "Des planètes telluriques", "Des planètes naines", "Des exoplanètes"]', 'Des planètes géantes gazeuses', 'Uranus et Neptune sont aussi des planètes géantes, riches en glaces.', 'Moyen', 'NS1'),
('PN1_02-110', NULL, 'Comment s''appelle la région de petits corps glacés située au-delà de Neptune ?', '["La ceinture de Kuiper", "La ceinture d''astéroïdes", "La Voie lactée", "La zone habitable"]', 'La ceinture de Kuiper', 'Pluton en est le plus célèbre habitant.', 'Difficile', 'NS1'),
('PN1_02-121', NULL, 'Combien de satellites naturels la Terre possède-t-elle ?', '["Un", "Deux", "Aucun", "Trois"]', 'Un', 'Il s''agit de la Lune, située à environ 384 000 km de la Terre.', 'Facile', 'NS1'),
('PN1_02-122', NULL, 'À quelle distance moyenne la Lune se trouve-t-elle de la Terre ?', '["Environ 384 000 km", "Environ 38 400 km", "Environ 3 840 000 km", "Environ 150 millions de km"]', 'Environ 384 000 km', 'La distance Terre-Soleil, 150 millions de km, est environ 400 fois plus grande.', 'Moyen', 'NS1'),
('PN1_02-123', NULL, 'Quel est le plus grand satellite naturel du système solaire ?', '["Ganymède", "Titan", "La Lune", "Europe"]', 'Ganymède', 'Ganymède, satellite de Jupiter, est plus gros que la planète Mercure.', 'Difficile', 'NS1'),
('PN1_02-124', NULL, 'Quels sont les deux satellites naturels de Mars ?', '["Phobos et Déimos", "Titan et Encelade", "Io et Europe", "Triton et Charon"]', 'Phobos et Déimos', 'Ce sont deux petits corps de forme irrégulière.', 'Difficile', 'NS1'),
('PN1_02-125', NULL, 'Quel satellite naturel de Saturne possède une épaisse atmosphère ?', '["Titan", "Europe", "Io", "Triton"]', 'Titan', 'Il est plus gros que la planète Mercure et présente des lacs de méthane liquide.', 'Difficile', 'NS1'),
('PN1_02-131', NULL, 'Comment appelle-t-on un engin construit par l''homme et placé en orbite autour de la Terre ?', '["Un satellite artificiel", "Une sonde spatiale", "Un météore", "Une comète"]', 'Un satellite artificiel', 'Ils servent aux télécommunications, à la météorologie et à la navigation (GPS).', 'Moyen', 'NS1'),
('PN1_02-132', NULL, 'Quelle station spatiale est habitée en permanence en orbite autour de la Terre ?', '["La Station spatiale internationale", "Hubble", "Spoutnik", "Apollo"]', 'La Station spatiale internationale', 'Elle orbite à environ 400 km d''altitude et fait le tour de la Terre en 90 minutes environ.', 'Facile', 'NS1'),
('PN1_02-133', NULL, 'Quel télescope spatial, lancé en 2021, observe l''Univers dans l''infrarouge ?', '["James Webb", "Hubble", "Spoutnik", "Kepler"]', 'James Webb', 'Il observe les premières galaxies formées après le Big Bang.', 'Moyen', 'NS1'),
('PN1_02-134', NULL, 'Quel animal a été le premier être vivant en orbite autour de la Terre, en 1957 ?', '["La chienne Laïka", "Le singe Ham", "Un chimpanzé", "Une souris"]', 'La chienne Laïka', 'Elle a voyagé à bord de Spoutnik 2, un mois après Spoutnik 1.', 'Moyen', 'NS1'),
('PN1_02-135', NULL, 'Qui a été la première femme dans l''espace, en 1963 ?', '["Valentina Terechkova", "Sally Ride", "Mae Jemison", "Svetlana Savitskaïa"]', 'Valentina Terechkova', 'Elle a fait 48 tours de la Terre à bord de Vostok 6.', 'Difficile', 'NS1'),
('PN1_02-136', NULL, 'Quel robot mobile de la NASA s''est posé sur Mars en 2012 ?', '["Curiosity", "Voyager", "Hubble", "Spoutnik"]', 'Curiosity', 'Il étudie le sol de Mars pour savoir si la planète a pu abriter de la vie.', 'Difficile', 'NS1'),
('PN1_02-137', NULL, 'Quelle sonde a survolé Pluton en 2015 ?', '["New Horizons", "Voyager 2", "Cassini", "Curiosity"]', 'New Horizons', 'Lancée en 2006, elle a envoyé les premières images détaillées de Pluton.', 'Difficile', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 9 AND titre = 'Big Bang, système solaire et exploration de l''espace';
SELECT COUNT(*) AS chapitre_trouve FROM cible;

CREATE TEMP TABLE mat ON COMMIT DROP AS
SELECT q.v4_mat_canonical AS code FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = 9 AND q.v4_mat_canonical IS NOT NULL
GROUP BY q.v4_mat_canonical ORDER BY COUNT(*) DESC LIMIT 1;

WITH maj AS (
  UPDATE questions q
  SET chapitre_id = (SELECT id FROM cible), enonce = i.enonce, choix = i.choix, bonne_reponse = i.bonne,
      explication = i.explication, niveau_complexite = i.complexite, v4_niveau = i.niveau
  FROM imp i, chapitres c
  WHERE c.id = q.chapitre_id AND c.matiere_id = 9 AND i.ancien IS NOT NULL AND q.enonce = i.ancien
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
