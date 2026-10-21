-- Import du chapitre Physique « Big Bang, système solaire et exploration de l'espace » (NS1, NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('PN1_02-01', NULL, 'Ensemble de tout ce qui existe : matière, énergie, espace et temps', '["L''Univers", "La galaxie", "Le système solaire", "L''atmosphère"]', 'L''Univers', 'Il contient des milliards de galaxies, elles-mêmes formées de milliards d''étoiles.', 'Facile', 'NS1'),
('PN1_02-02', NULL, 'Modèle selon lequel l''Univers est né d''un état extrêmement chaud et dense, puis s''est dilaté', '["Le Big Bang", "La nucléosynthèse", "L''effondrement gravitationnel", "La fission nucléaire"]', 'Le Big Bang', 'Ce n''est pas une explosion dans l''espace : c''est l''espace lui-même qui s''est mis à se dilater.', 'Moyen', 'NS1'),
('PN1_02-03', NULL, 'Il y a environ combien de temps l''Univers est-il né, selon le Big Bang ?', '["13,8 milliards d''années", "4,6 milliards d''années", "138 millions d''années", "13 800 ans"]', '13,8 milliards d''années', 'Le système solaire, lui, n''est apparu qu''il y a 4,6 milliards d''années.', 'Moyen', 'NS1'),
('PN1_02-04', NULL, 'Quel phénomène explique que les galaxies lointaines s''éloignent de nous ?', '["L''expansion de l''Univers", "La rotation de la Terre", "L''attraction du Soleil", "La chute des étoiles"]', 'L''expansion de l''Univers', 'Plus une galaxie est lointaine, plus elle s''éloigne vite : c''est l''observation faite par Edwin Hubble en 1929.', 'Moyen', 'NS1'),
('PN1_02-05', NULL, 'Ensemble des processus qui conduisent à l''apparition des éléments chimiques de l''Univers', '["La nucléosynthèse", "La photosynthèse", "La fission nucléaire", "La condensation"]', 'La nucléosynthèse', 'Elle a lieu dans les premières minutes de l''Univers, puis au cœur des étoiles et lors des supernovas.', 'Moyen', 'NS1'),
('PN1_02-06', NULL, 'Quels sont les deux premiers éléments formés après le Big Bang ?', '["Hydrogène et hélium", "Carbone et oxygène", "Fer et nickel", "Azote et soufre"]', 'Hydrogène et hélium', 'Ils forment encore presque toute la matière visible : environ trois quarts d''hydrogène et un quart d''hélium.', 'Moyen', 'NS1'),
('PN1_02-07', NULL, 'Où se forment les éléments plus lourds que l''hélium ?', '["Au cœur des étoiles", "Dans les planètes", "Dans les comètes", "Dans les satellites"]', 'Au cœur des étoiles', 'Les étoiles fusionnent les noyaux légers en noyaux plus lourds ; les supernovas fabriquent les plus lourds.', 'Moyen', 'NS1'),
('PN1_02-11', NULL, 'Astre qui brille de sa propre lumière grâce aux réactions nucléaires qui s''y produisent', '["Une étoile", "Une planète", "Une comète", "Un satellite"]', 'Une étoile', 'Le Soleil est l''étoile la plus proche de la Terre.', 'Facile', 'NS1'),
('PN1_02-12', NULL, 'Explosion d''une étoile massive en fin de vie, qui la rend très brillante pendant un temps', '["Une supernova", "Une nébuleuse", "Un trou noir", "Une comète"]', 'Une supernova', 'Elle disperse dans l''espace les éléments fabriqués par l''étoile, qui serviront à former de nouveaux astres.', 'Moyen', 'NS1'),
('PN1_02-13', NULL, 'Nuage de gaz et de poussières interstellaires', '["Une nébuleuse", "Une galaxie", "Une comète", "Une orbite"]', 'Une nébuleuse', 'Les étoiles et leurs planètes naissent de l''effondrement de nuages de ce type.', 'Facile', 'NS1'),
('PN1_02-14', NULL, 'Vaste ensemble d''étoiles et de matière dont la cohésion est assurée par la gravitation', '["Une galaxie", "Une nébuleuse", "Un système planétaire", "Un amas de météorites"]', 'Une galaxie', 'Une galaxie compte des centaines de milliards d''étoiles.', 'Moyen', 'NS1'),
('PN1_02-15', NULL, 'Comment s''appelle la galaxie qui contient le système solaire ?', '["La Voie lactée", "Andromède", "Le Grand Nuage", "Le Triangle"]', 'La Voie lactée', 'Vue de la Terre, elle forme une bande blanchâtre dans le ciel nocturne ; Andromède est la grande galaxie la plus proche.', 'Moyen', 'NS1'),
('PN1_02-21', NULL, 'Quel astre se trouve au centre du système solaire ?', '["Le Soleil", "La Terre", "Jupiter", "La Lune"]', 'Le Soleil', 'Il rassemble plus de 99 % de la masse du système solaire.', 'Facile', 'NS1'),
('PN1_02-22', NULL, 'Quel est l''âge approximatif du système solaire ?', '["4,6 milliards d''années", "13,8 milliards d''années", "460 millions d''années", "46 millions d''années"]', '4,6 milliards d''années', 'Il s''est formé à partir d''un nuage de gaz et de poussières, bien après le Big Bang.', 'Moyen', 'NS1'),
('PN1_02-23', NULL, 'Corps céleste non lumineux par lui-même, qui gravite autour du Soleil', '["Une planète", "Une étoile", "Un satellite", "Une comète"]', 'Une planète', 'La Terre est la troisième planète à partir du Soleil.', 'Facile', 'NS1'),
('PN1_02-24', NULL, 'Combien de planètes compte le système solaire ?', '["Huit", "Neuf", "Sept", "Dix"]', 'Huit', 'Mercure, Vénus, la Terre, Mars, Jupiter, Saturne, Uranus et Neptune.', 'Facile', 'NS1'),
('PN1_02-25', NULL, 'Quelle est la planète la plus proche du Soleil ?', '["Mercure", "Vénus", "Mars", "La Terre"]', 'Mercure', 'Elle est aussi la plus petite des huit planètes.', 'Facile', 'NS1'),
('PN1_02-26', NULL, 'Quelle planète est surnommée la planète rouge ?', '["Mars", "Vénus", "Mercure", "Jupiter"]', 'Mars', 'Sa couleur vient de l''oxyde de fer qui recouvre son sol.', 'Facile', 'NS1'),
('PN1_02-27', NULL, 'Quelle est la plus grande planète du système solaire ?', '["Jupiter", "Saturne", "Neptune", "Uranus"]', 'Jupiter', 'C''est une planète géante gazeuse, plus de mille fois plus volumineuse que la Terre.', 'Facile', 'NS1'),
('PN1_02-28', NULL, 'Quelles planètes sont dites telluriques ?', '["Mercure, Vénus, la Terre, Mars", "Jupiter, Saturne, Uranus, Neptune", "Mercure, Jupiter, la Terre, Saturne", "Vénus, Mars, Uranus, Neptune"]', 'Mercure, Vénus, la Terre, Mars', 'Elles sont petites, rocheuses et proches du Soleil ; les quatre autres sont des planètes géantes, gazeuses ou glacées.', 'Moyen', 'NS1'),
('PN1_02-29', NULL, 'Corps qui gravite autour d''un astre de masse prépondérante, en particulier autour d''une planète', '["Un satellite", "Une comète", "Un astéroïde", "Une étoile"]', 'Un satellite', 'La Lune est le satellite naturel de la Terre ; les engins lancés par l''homme sont des satellites artificiels.', 'Facile', 'NS1'),
('PN1_02-30', NULL, 'Courbe décrite par une planète autour du Soleil ou par un satellite autour de sa planète', '["Une orbite", "Une éclipse", "Une parallaxe", "Une trajectoire droite"]', 'Une orbite', 'L''orbite de la Terre est une ellipse presque circulaire, parcourue en une année.', 'Moyen', 'NS1'),
('PN1_02-31', NULL, 'Petit corps rocheux ou métallique, de forme irrégulière, qui gravite autour du Soleil', '["Un astéroïde", "Une comète", "Une planète", "Une étoile"]', 'Un astéroïde', 'La plupart se trouvent dans la ceinture située entre Mars et Jupiter.', 'Moyen', 'NS1'),
('PN1_02-32', NULL, 'Où se situe la ceinture d''astéroïdes ?', '["Entre Mars et Jupiter", "Entre la Terre et Mars", "Au-delà de Neptune", "Entre Mercure et Vénus"]', 'Entre Mars et Jupiter', 'Cérès, le plus gros objet de cette ceinture, est classé planète naine.', 'Moyen', 'NS1'),
('PN1_02-33', NULL, 'Petit astre de glace et de poussières qui développe une chevelure et une queue près du Soleil', '["Une comète", "Un astéroïde", "Une planète", "Un météore"]', 'Une comète', 'La comète de Halley repasse près de la Terre environ tous les 76 ans.', 'Moyen', 'NS1'),
('PN1_02-34', NULL, 'Dans quelle catégorie Pluton est-elle classée depuis 2006 ?', '["Planète naine", "Satellite", "Astéroïde", "Comète"]', 'Planète naine', 'L''Union astronomique internationale a précisé en 2006 les conditions pour être une planète ; Pluton n''en remplit pas toutes.', 'Moyen', 'NS1'),
('PN1_02-35', NULL, 'Planète qui tourne autour d''une autre étoile que le Soleil', '["Une exoplanète", "Un satellite", "Une planète naine", "Une comète"]', 'Une exoplanète', 'Plus de cinq mille exoplanètes ont été découvertes depuis 1995.', 'Difficile', 'NS1'),
('PN1_02-41', NULL, 'Petit corps solide qui circule dans l''espace interplanétaire', '["Un météoroïde", "Une météorite", "Un météore", "Un astéroïde"]', 'Un météoroïde', 'Il devient un météore s''il traverse l''atmosphère de la Terre.', 'Moyen', 'NS1'),
('PN1_02-42', NULL, 'Phénomène lumineux dû à la chute dans l''atmosphère d''un corps venu de l''espace', '["Un météore", "Une météorite", "Une comète", "Une aurore"]', 'Un météore', 'On l''appelle aussi étoile filante : un grain de matière brûle en traversant l''atmosphère.', 'Moyen', 'NS1'),
('PN1_02-43', NULL, 'Fragment de corps venu de l''espace, retrouvé à la surface d''un astre après sa chute', '["Une météorite", "Un météore", "Un météoroïde", "Un satellite"]', 'Une météorite', 'Les grosses météorites laissent des cratères d''impact, comme le Meteor Crater en Arizona.', 'Moyen', 'NS1'),
('Q1288', 'La vitesse de la lumière dans le vide est approximativement :', 'Quelle est la vitesse de la lumière dans le vide ?', '["Environ 300 000 km/s", "Environ 300 km/s", "Environ 150 000 km/s", "Environ 3 000 km/s"]', 'Environ 300 000 km/s', 'Elle vaut 3 × 10⁸ m/s ; aucune matière ne peut aller plus vite.', 'Facile', 'NS1'),
('PN1_02-52', NULL, 'Unité de longueur astronomique correspondant à environ 9 461 milliards de kilomètres', '["L''année-lumière", "L''unité astronomique", "Le parsec", "Le mille marin"]', 'L''année-lumière', 'Proxima du Centaure, l''étoile la plus proche du Soleil, est à 4,2 années-lumière.', 'Moyen', 'NS1'),
('PN1_02-53', NULL, 'Combien de temps la lumière du Soleil met-elle pour atteindre la Terre ?', '["Environ 8 minutes", "Environ 8 secondes", "Environ 8 heures", "Environ 8 jours"]', 'Environ 8 minutes', 'La Terre est à 150 millions de km du Soleil : 150 000 000 km ÷ 300 000 km/s = 500 s.', 'Moyen', 'NS1'),
('PN1_02-54', NULL, 'Quelle méthode permet de mesurer la distance des étoiles proches ?', '["La parallaxe", "La réflexion", "La réfraction", "La dilatation"]', 'La parallaxe', 'On observe l''étoile à six mois d''intervalle : l''angle de son décalage apparent sur le fond du ciel donne la distance.', 'Moyen', 'NS1'),
('PN1_02-55', NULL, 'Que représente l''unité astronomique ?', '["La distance Terre-Soleil", "La distance Terre-Lune", "Une année de lumière", "Le rayon du Soleil"]', 'La distance Terre-Soleil', 'Elle vaut environ 150 millions de kilomètres et sert à mesurer les distances dans le système solaire.', 'Moyen', 'NS1'),
('PN1_02-56', NULL, 'Quel est l''ordre de grandeur du rayon de la Terre ?', '["Environ 6 400 km", "Environ 640 km", "Environ 64 000 km", "Environ 640 000 km"]', 'Environ 6 400 km', 'Son rayon est de 6 371 km environ ; sa circonférence dépasse 40 000 km.', 'Moyen', 'NS1'),
('PN1_02-57', NULL, 'Quel ordre de grandeur correspond à la taille d''un atome ?', '["10⁻¹⁰ m", "10⁻⁶ m", "10⁻³ m", "10⁻¹⁵ m"]', '10⁻¹⁰ m', 'Un atome est environ un million de fois plus petit que l''épaisseur d''un cheveu.', 'Moyen', 'NS1'),
('PN1_02-58', NULL, 'Instrument d''observation astronomique dont l''objectif est un miroir', '["Un télescope", "Un microscope", "Un périscope", "Un baromètre"]', 'Un télescope', 'Le télescope spatial Hubble, lancé en 1990, observe sans être gêné par l''atmosphère.', 'Moyen', 'NS1'),
('PN1_02-59', NULL, 'Quel engin non habité est envoyé explorer les planètes ou les comètes ?', '["Une sonde spatiale", "Un ballon météo", "Une navette habitée", "Un satellite géostationnaire"]', 'Une sonde spatiale', 'Voyager 1, lancée en 1977, a quitté le système solaire ; d''autres sondes se sont posées sur Mars.', 'Moyen', 'NS1'),
('PN1_02-60', NULL, 'Quel est le premier satellite artificiel de la Terre, lancé en 1957 ?', '["Spoutnik 1", "Apollo 11", "Hubble", "Voyager 1"]', 'Spoutnik 1', 'Lancé par l''Union soviétique le 4 octobre 1957, il a ouvert l''ère spatiale.', 'Moyen', 'NS1'),
('PN1_02-61', NULL, 'Qui a été le premier homme dans l''espace, en 1961 ?', '["Youri Gagarine", "Neil Armstrong", "Alan Shepard", "Buzz Aldrin"]', 'Youri Gagarine', 'Il a fait un tour complet de la Terre à bord de Vostok 1, le 12 avril 1961.', 'Moyen', 'NS1'),
('PN1_02-62', NULL, 'En quelle année l''être humain a-t-il marché sur la Lune pour la première fois ?', '["1969", "1957", "1961", "1981"]', '1969', 'Neil Armstrong a posé le pied sur la Lune le 20 juillet 1969, lors de la mission Apollo 11.', 'Moyen', 'NS1');

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
