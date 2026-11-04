-- Import du chapitre Physique « Gravitation universelle, poids et masse » (NS1, NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('PN1_03-01', NULL, 'Force attractive qui s''exerce entre tous les corps qui ont une masse', '["La gravitation", "La pesanteur", "La flottaison", "Le magnétisme"]', 'La gravitation', 'Elle maintient la Lune autour de la Terre et les planètes autour du Soleil.', 'Moyen', 'NS1'),
('PN1_03-02', NULL, 'Qui a énoncé la loi de la gravitation universelle ?', '["Isaac Newton", "Galilée", "Albert Einstein", "Johannes Kepler"]', 'Isaac Newton', 'Il l''a publiée en 1687 dans son ouvrage Principia.', 'Facile', 'NS1'),
('PN1_03-03', NULL, 'De quoi dépend la force de gravitation entre deux corps ?', '["Leurs masses et leur distance", "Leur volume seulement", "Leur couleur et leur forme", "Leur température et leur vitesse"]', 'Leurs masses et leur distance', 'Elle augmente avec les masses et diminue quand la distance augmente.', 'Moyen', 'NS1'),
('PN1_03-05', NULL, 'Quelle est l''expression de la loi de la gravitation universelle ?', '["F = G·m·m′/d²", "F = G·m·m′·d²", "F = G·(m+m′)/d", "F = m·g"]', 'F = G·m·m′/d²', 'G est la constante de gravitation, égale à 6,67 × 10⁻¹¹ N·m²/kg².', 'Moyen', 'NS1'),
('PN1_03-06', NULL, 'La force de gravitation entre deux corps est-elle attractive ou répulsive ?', '["Toujours attractive", "Toujours répulsive", "Parfois répulsive", "Nulle dans le vide"]', 'Toujours attractive', 'Deux corps s''attirent mutuellement avec des forces de même valeur, même si l''un est bien plus massif que l''autre.', 'Facile', 'NS1'),
('PN1_03-11', NULL, 'Force d''attraction exercée par la Terre, ou un autre astre, sur un corps proche de sa surface', '["Le poids", "La masse", "La pression", "La densité"]', 'Le poids', 'Il se mesure avec un dynamomètre et s''exprime en newtons.', 'Facile', 'NS1'),
('PN1_03-12', NULL, 'Appareil destiné à la mesure d''une force', '["Un dynamomètre", "Un baromètre", "Un ampèremètre", "Un thermomètre"]', 'Un dynamomètre', 'À l''intérieur, un ressort s''allonge proportionnellement à la force appliquée.', 'Facile', 'NS1'),
('PN1_03-13', NULL, 'Quelle est la nature du poids d''un corps ?', '["Une force", "Une quantité de matière", "Une énergie", "Une vitesse"]', 'Une force', 'C''est pourquoi le poids s''exprime en newtons et se représente par une flèche, un vecteur.', 'Facile', 'NS1'),
('PN1_03-14', NULL, 'Dans quelle unité exprime-t-on le poids d''un corps ?', '["Le newton", "Le kilogramme", "Le gramme", "Le joule"]', 'Le newton', 'Le newton (N) est l''unité SI de force : 1 N est le poids d''une masse d''environ 100 g sur Terre.', 'Facile', 'NS1'),
('PN1_03-15', NULL, 'Quelle est la direction du poids d''un corps ?', '["La verticale, vers le bas", "L''horizontale, vers l''avant", "La verticale, vers le haut", "La direction du Soleil"]', 'La verticale, vers le bas', 'Il s''applique au centre de gravité du corps et pointe vers le centre de la Terre.', 'Moyen', 'NS1'),
('PN1_03-16', NULL, 'Quelle est la formule du poids d''un corps ?', '["P = m × g", "P = m / g", "P = m + g", "P = g / m"]', 'P = m × g', 'P est en newtons, m en kilogrammes et g en newtons par kilogramme.', 'Facile', 'NS1'),
('Q1214', 'Un objet de masse 5 kg a un poids sur Terre de (g = 10 m/s²) :', 'Quel est le poids d''un objet de masse 5 kg sur Terre (g = 10 N/kg) ?', '["50 N", "5 N", "500 N", "0,5 N"]', '50 N', 'P = m × g = 5 × 10 = 50 N.', 'Facile', 'NS1'),
('Q1235', 'Combien vaut g approximativement sur Terre ?', 'Quelle est la valeur de g à la surface de la Terre ?', '["Environ 9,8 N/kg", "Environ 1,6 N/kg", "Environ 98 N/kg", "Environ 0,98 N/kg"]', 'Environ 9,8 N/kg', 'En calcul scolaire, on prend souvent g = 10 N/kg.', 'Facile', 'NS1'),
('PN1_03-19', NULL, 'État dans lequel les effets de la pesanteur sont annulés, comme à bord d''une station spatiale en orbite', '["L''apesanteur", "L''inertie", "La gravitation", "La flottaison"]', 'L''apesanteur', 'Les astronautes flottent parce qu''ils tombent en permanence avec la station, pas parce que la gravité y est nulle.', 'Moyen', 'NS1'),
('Q1218', 'Quelle est la différence entre la masse et le poids ?', 'Laquelle de ces propriétés distingue la masse du poids ?', '["Masse fixe, poids variable", "Masse variable, poids fixe", "Les deux varient avec le lieu", "Les deux restent fixes"]', 'Masse fixe, poids variable', 'La masse, en kilogrammes, ne change pas ; le poids, en newtons, dépend de la gravité du lieu : un objet est plus léger sur la Lune.', 'Moyen', 'NS1'),
('Q1226', 'Un astronaute sur la Lune (g = 1,6 m/s²) pesant 80 N sur Terre aura un poids lunaire de :', 'Un astronaute pèse 80 N sur Terre. Quel est son poids sur la Lune (g = 1,6 N/kg) ?', '["Environ 13 N", "80 N", "0 N", "160 N"]', 'Environ 13 N', 'Sa masse est m = 80 / 10 = 8 kg ; sur la Lune, P = 8 × 1,6 ≈ 13 N.', 'Difficile', 'NS1'),
('PN1_03-31', NULL, 'Quelle force fait tomber une pomme et retient la Lune en orbite ?', '["La gravitation terrestre", "La force magnétique", "La poussée d''Archimède", "La force de frottement"]', 'La gravitation terrestre', 'C''est la même force : la Lune « tombe » sans cesse vers la Terre sans jamais l''atteindre, car elle avance aussi sur le côté.', 'Moyen', 'NS1'),
('PN1_03-32', NULL, 'Quelle est la forme de l''orbite d''une planète autour du Soleil ?', '["Une ellipse", "Une parabole", "Une droite", "Un carré"]', 'Une ellipse', 'C''est la première loi de Kepler ; l''orbite de la Terre est presque un cercle.', 'Moyen', 'NS1'),
('PN1_03-33', NULL, 'En combien de temps la Terre fait-elle un tour complet autour du Soleil ?', '["365 jours environ", "24 heures", "30 jours", "12 ans"]', '365 jours environ', 'C''est sa période de révolution : une année.', 'Facile', 'NS1'),
('PN1_03-34', NULL, 'Quel mouvement de la Terre produit l''alternance du jour et de la nuit ?', '["Sa rotation sur elle-même", "Sa révolution autour du Soleil", "Sa translation vers la Lune", "L''inclinaison de la Lune"]', 'Sa rotation sur elle-même', 'Un tour complet sur elle-même dure environ 24 heures.', 'Facile', 'NS1'),
('PN1_03-35', NULL, 'Combien de temps la Lune met-elle pour faire le tour de la Terre ?', '["Environ 27 jours", "Environ 7 jours", "Environ 365 jours", "Environ 24 heures"]', 'Environ 27 jours', 'Les phases de la Lune reviennent tous les 29,5 jours, car la Terre a elle aussi avancé autour du Soleil.', 'Moyen', 'NS1'),
('PN1_03-41', NULL, 'Quel fruit, selon la légende, a fait réfléchir Newton à la gravitation ?', '["La pomme", "La mangue", "La banane", "L''orange"]', 'La pomme', 'Voir tomber un fruit l''aurait conduit à relier la chute des corps sur Terre au mouvement de la Lune.', 'Facile', 'NS1'),
('PN1_03-44', NULL, 'Quel phénomène sur Terre est provoqué surtout par l''attraction de la Lune ?', '["Les marées", "Les séismes", "Les cyclones", "Les éclipses"]', 'Les marées', 'L''attraction de la Lune, et dans une moindre mesure du Soleil, soulève les océans deux fois par jour.', 'Moyen', 'NS1'),
('PN1_03-45', NULL, 'Quel savant du XVIIᵉ siècle a établi les lois du mouvement des planètes autour du Soleil ?', '["Johannes Kepler", "Nicolas Copernic", "Galilée", "Isaac Newton"]', 'Johannes Kepler', 'Ses trois lois décrivent des orbites en ellipse ; Newton les a expliquées ensuite par la gravitation.', 'Moyen', 'NS1'),
('PN1_03-51', NULL, 'Comment appelle-t-on la grandeur g, exprimée en N/kg ?', '["L''intensité de la pesanteur", "La constante de gravitation", "La masse volumique", "L''accélération électrique"]', 'L''intensité de la pesanteur', 'Elle indique le poids d''un kilogramme : 9,8 N/kg sur Terre.', 'Moyen', 'NS1'),
('PN1_03-52', NULL, 'Comment appelle-t-on le point d''application du poids d''un corps ?', '["Son centre de gravité", "Son sommet", "Sa base", "Sa surface"]', 'Son centre de gravité', 'Pour un objet homogène et symétrique, il se confond avec son centre géométrique.', 'Moyen', 'NS1'),
('Q1238', 'Le centre de gravité d''un objet symétrique et uniforme se trouve :', 'Où se trouve le centre de gravité d''une sphère homogène ?', '["En son centre", "À sa surface", "À sa base", "Au sommet"]', 'En son centre', 'Pour un objet homogène et symétrique (sphère, cube), le centre de gravité coïncide avec le centre géométrique.', 'Moyen', 'NS1'),
('PN1_03-54', NULL, 'Quel est à peu près le poids d''une masse de 100 g sur Terre ?', '["Environ 1 N", "Environ 10 N", "Environ 0,1 N", "Environ 100 N"]', 'Environ 1 N', 'P = 0,1 kg × 10 N/kg = 1 N ; c''est pourquoi 1 N correspond à peu près au poids d''une tablette de chocolat.', 'Facile', 'NS1'),
('PN1_03-55', NULL, 'Quelle est la masse d''un objet dont le poids est de 300 N (g = 10 N/kg) ?', '["30 kg", "3 kg", "300 kg", "3 000 kg"]', '30 kg', 'm = P / g = 300 / 10 = 30 kg.', 'Moyen', 'NS1'),
('PN1_03-56', NULL, 'Sur lequel de ces astres un même objet pèse-t-il le plus ?', '["Jupiter", "La Terre", "La Lune", "Mars"]', 'Jupiter', 'La pesanteur à la surface de Jupiter vaut environ 25 N/kg, contre 9,8 sur Terre, 3,7 sur Mars et 1,6 sur la Lune.', 'Moyen', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 9 AND titre = 'Gravitation universelle, poids et masse';
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
