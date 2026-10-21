-- Import du chapitre Physique « Grandeurs, mesures et états de la matière » (NS1) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('PN1_01-01', NULL, 'Propriété d''un objet ou d''un phénomène que l''on peut exprimer par un nombre et une unité', '["Une grandeur physique", "Une loi physique", "Une constante universelle", "Un instrument de mesure"]', 'Une grandeur physique', 'La longueur, la masse, la durée et la température sont des grandeurs physiques ; la couleur ou la beauté n''en sont pas.', 'Facile', 'NS1'),
('PN1_01-02', NULL, 'Comparaison d''une grandeur à une référence de même nature, prise comme étalon', '["La mesure", "L''estimation", "L''hypothèse", "La conversion"]', 'La mesure', 'Mesurer une longueur, c''est compter combien de fois l''étalon, par exemple le mètre, y est contenu.', 'Moyen', 'NS1'),
('PN1_01-03', NULL, 'Grandeur de référence servant à exprimer le résultat d''une mesure', '["Une unité", "Un symbole", "Une formule", "Un repère"]', 'Une unité', 'Un résultat sans unité n''a pas de sens : « 5 » ne dit pas s''il s''agit de 5 mètres ou de 5 secondes.', 'Facile', 'NS1'),
('PN1_01-04', NULL, 'Ensemble cohérent d''unités adopté par la communauté scientifique mondiale', '["Le Système international", "Le système impérial", "Le système CGS", "Le système décimal"]', 'Le Système international', 'Adopté en 1960, il est utilisé dans le monde entier en science ; certains pays gardent d''autres unités pour l''usage courant.', 'Moyen', 'NS1'),
('Q1312', 'Combien d''unités de base compte le Système international (SI) ?', 'Combien d''unités de base compte le Système international (SI) ?', '["7", "5", "10", "12"]', '7', 'Mètre, kilogramme, seconde, ampère, kelvin, mole et candela ; toutes les autres unités s''en déduisent.', 'Facile', 'NS1'),
('PN1_01-06', NULL, 'Quelle est l''unité de longueur du Système international ?', '["Le mètre", "Le pied", "Le pouce", "Le mille"]', 'Le mètre', 'Le mètre (m) est défini à partir de la distance parcourue par la lumière dans le vide pendant un très court instant.', 'Facile', 'NS1'),
('PN1_01-07', NULL, 'Quelle est l''unité de masse du Système international ?', '["Le kilogramme", "Le gramme", "La tonne", "Le newton"]', 'Le kilogramme', 'Le gramme et la tonne sont des sous-multiples ou multiples usuels, mais l''unité de base est le kilogramme (kg) ; le newton mesure une force.', 'Moyen', 'NS1'),
('PN1_01-08', NULL, 'Quelle est l''unité de temps du Système international ?', '["La seconde", "La minute", "L''heure", "Le jour"]', 'La seconde', 'La minute et l''heure sont tolérées avec le SI, mais l''unité de base est la seconde (s).', 'Moyen', 'NS1'),
('PN1_01-09', NULL, 'Quelle est l''unité de température du Système international ?', '["Le kelvin", "Le degré Celsius", "Le degré Fahrenheit", "Le joule"]', 'Le kelvin', '0 K correspond à − 273,15 °C ; une variation de 1 K vaut une variation de 1 °C.', 'Moyen', 'NS1'),
('PN1_01-10', NULL, 'Quelle est l''unité de volume du Système international ?', '["Le mètre cube", "Le litre", "Le centimètre cube", "Le gramme"]', 'Le mètre cube', 'Le litre (1 dm³) est très employé mais n''est pas une unité du SI ; 1 m³ = 1 000 L.', 'Moyen', 'NS1'),
('PN1_01-11', NULL, 'Combien de kilogrammes représentent 3 000 grammes ?', '["3 kg", "30 kg", "0,3 kg", "300 kg"]', '3 kg', '1 kg = 1 000 g, donc 3 000 g = 3 kg.', 'Facile', 'NS1'),
('Q1318', 'Comment convertit-on 5 km en mètres ?', 'Comment convertit-on 5 km en mètres ?', '["5 000 m", "0,005 m", "500 m", "50 m"]', '5 000 m', '1 km = 1 000 m, donc 5 km = 5 × 1 000 m = 5 000 m.', 'Facile', 'NS1'),
('PN1_01-13', NULL, 'Un volume de 1 litre est égal à combien de centimètres cubes ?', '["1 000 cm³", "10 cm³", "100 cm³", "10 000 cm³"]', '1 000 cm³', '1 L = 1 dm³ = 1 000 cm³ ; en pratique, 1 mL = 1 cm³.', 'Moyen', 'NS1'),
('PN1_01-21', NULL, 'Quel instrument simple sert à mesurer une longueur ?', '["Une règle graduée", "Un chronomètre", "Une balance", "Une éprouvette"]', 'Une règle graduée', 'Pour de grandes longueurs, on utilise un mètre ruban ; pour de très petites, un pied à coulisse.', 'Facile', 'NS1'),
('PN1_01-22', NULL, 'Quel instrument de laboratoire sert à mesurer le volume d''un liquide ?', '["Une éprouvette graduée", "Un chronomètre", "Un thermomètre", "Une balance"]', 'Une éprouvette graduée', 'On lit le volume au bas de la surface incurvée du liquide, l''œil à son niveau.', 'Facile', 'NS1'),
('PN1_01-23', NULL, 'Appareil à plateaux ou à affichage numérique servant à peser', '["Une balance", "Un baromètre", "Un chronomètre", "Un voltmètre"]', 'Une balance', 'Elle compare ou mesure des masses ; en laboratoire, on utilise surtout la balance électronique.', 'Facile', 'NS1'),
('PN1_01-24', NULL, 'Appareil destiné à la mesure des températures', '["Un thermomètre", "Un baromètre", "Un hygromètre", "Un voltmètre"]', 'Un thermomètre', 'Le thermomètre à alcool repose sur la dilatation d''un liquide ; il en existe aussi à affichage électronique.', 'Facile', 'NS1'),
('PN1_01-25', NULL, 'Quel instrument sert à mesurer une durée ?', '["Un chronomètre", "Un baromètre", "Un dynamomètre", "Un ampèremètre"]', 'Un chronomètre', 'Il donne souvent le dixième ou le centième de seconde ; dans le SI, la durée s''exprime en secondes.', 'Facile', 'NS1'),
('Q1313', 'Comment exprime-t-on une incertitude de mesure ?', 'Marge d''erreur possible autour du résultat d''une mesure', '["L''incertitude", "L''étalon", "L''unité", "L''ordre de grandeur"]', 'L''incertitude', 'On l''écrit sous la forme valeur ± incertitude, par exemple 9,81 ± 0,02 m/s².', 'Moyen', 'NS1'),
('PN1_01-32', NULL, 'Qualité d''une mesure qui donne presque le même résultat quand on la répète', '["La précision", "L''exactitude", "L''incertitude", "La sensibilité"]', 'La précision', 'Un instrument précis donne des résultats très rapprochés d''une mesure à l''autre.', 'Moyen', 'NS1'),
('Q1320', 'Qu''est-ce que l''exactitude d''une mesure ?', 'Qualité d''une mesure proche de la valeur vraie de la grandeur', '["L''exactitude", "La précision", "L''incertitude", "La sensibilité"]', 'L''exactitude', 'Image de la cible : des tirs groupés mais loin du centre sont précis sans être exacts.', 'Moyen', 'NS1'),
('Q1316', 'Qu''a de plus une grandeur vectorielle qu''une grandeur scalaire ?', 'Grandeur définie par une valeur, une direction et un sens', '["Une grandeur vectorielle", "Une grandeur scalaire", "Une grandeur dérivée", "Une grandeur de base"]', 'Une grandeur vectorielle', 'Elle se représente par une flèche : la longueur indique la valeur, l''orientation donne la direction et le sens.', 'Facile', 'NS1'),
('PN1_01-35', NULL, 'Grandeur entièrement définie par un nombre et son unité', '["Une grandeur scalaire", "Une grandeur vectorielle", "Une grandeur nulle", "Une grandeur variable"]', 'Une grandeur scalaire', 'La masse, la température et le volume sont des grandeurs scalaires : aucune direction n''est nécessaire.', 'Moyen', 'NS1'),
('PN1_01-36', NULL, 'Laquelle de ces grandeurs est vectorielle ?', '["La force", "La masse", "La température", "Le volume"]', 'La force', 'Une force se décrit par son point d''application, sa direction, son sens et sa valeur.', 'Facile', 'NS1'),
('PN1_01-41', NULL, 'Substance qui constitue les corps et possède des propriétés physiques', '["La matière", "L''énergie", "La lumière", "L''espace"]', 'La matière', 'Tout ce qui a une masse et occupe un volume est de la matière : l''air, l''eau, le bois. La lumière n''en est pas.', 'Facile', 'NS1'),
('PN1_01-42', NULL, 'Corps qui garde sa forme propre et son volume propre', '["Un solide", "Un liquide", "Un gaz", "Un plasma"]', 'Un solide', 'Les particules d''un solide sont serrées et ne bougent presque pas ; exemples : le fer, le bois, la glace.', 'Facile', 'NS1'),
('PN1_01-43', NULL, 'Corps qui prend la forme du récipient qui le contient mais dont le volume est déterminé', '["Un liquide", "Un solide", "Un gaz", "Un plasma"]', 'Un liquide', 'Ses particules sont proches mais glissent les unes sur les autres : eau, huile, alcool.', 'Facile', 'NS1'),
('PN1_01-44', NULL, 'Corps qui occupe la totalité du volume du récipient dans lequel il est enfermé', '["Un gaz", "Un liquide", "Un solide", "Un plasma"]', 'Un gaz', 'Ses particules sont très espacées et très agitées ; l''air est un mélange de gaz.', 'Facile', 'NS1'),
('PN1_01-45', NULL, 'Fluide composé de molécules gazeuses neutres, d''ions positifs et d''électrons', '["Le plasma", "Le gaz", "La vapeur", "Le gel"]', 'Le plasma', 'On le trouve dans le Soleil et les étoiles ; c''est le quatrième état de la matière. À ne pas confondre avec le plasma du sang.', 'Moyen', 'NS1'),
('PN1_01-46', NULL, 'Parmi ces exemples, lequel est un état intermédiaire entre solide et liquide ?', '["Une pâte", "La glace", "La vapeur d''eau", "Un fil de fer"]', 'Une pâte', 'Les pâtes et les gels se comportent à la fois comme des solides et comme des liquides.', 'Difficile', 'NS1'),
('PN1_01-47', NULL, 'Dans quel état de la matière les particules sont-elles les plus éloignées les unes des autres ?', '["L''état gazeux", "L''état solide", "L''état liquide", "L''état pâteux"]', 'L''état gazeux', 'Les particules d''un gaz se déplacent librement dans tout le volume disponible, d''où sa grande facilité à être comprimé.', 'Facile', 'NS1'),
('PN1_01-48', NULL, 'Constituant fondamental de la matière, formé d''un noyau et d''électrons', '["L''atome", "La molécule", "La cellule", "L''ion"]', 'L''atome', 'Le diamètre d''un atome est de l''ordre de 10⁻¹⁰ m.', 'Facile', 'NS1'),
('PN1_01-49', NULL, 'Particule formée d''atomes, plus petite quantité d''un corps pur pouvant exister à l''état libre', '["Une molécule", "Un atome", "Un ion", "Un cristal"]', 'Une molécule', 'La molécule d''eau est formée de deux atomes d''hydrogène et d''un atome d''oxygène.', 'Moyen', 'NS1'),
('PN1_01-51', NULL, 'Grandeur qui exprime la quantité de matière que contient un corps', '["La masse", "Le volume", "Le poids", "La densité"]', 'La masse', 'Elle s''exprime en kilogrammes et ne change pas d''un lieu à un autre, contrairement au poids.', 'Facile', 'NS1'),
('PN1_01-52', NULL, 'Espace occupé par un corps', '["Le volume", "La masse", "La surface", "La longueur"]', 'Le volume', 'Pour un solide irrégulier, on le mesure par déplacement d''eau dans une éprouvette graduée.', 'Facile', 'NS1'),
('PN1_01-53', NULL, 'Rapport de la masse d''un corps à son volume', '["La masse volumique", "La densité", "La pression", "La concentration"]', 'La masse volumique', 'Elle dépend de la substance : environ 7 800 kg/m³ pour l''acier, 2 700 kg/m³ pour l''aluminium.', 'Moyen', 'NS1'),
('PN1_01-54', NULL, 'Quelle est l''unité de la masse volumique dans le Système international ?', '["Le kg/m³", "Le m³/kg", "Le N/m²", "Le kg·m"]', 'Le kg/m³', 'En pratique, on emploie aussi le g/cm³ : 1 g/cm³ = 1 000 kg/m³.', 'Moyen', 'NS1'),
('PN1_01-55', NULL, 'Quelle est la formule de la masse volumique ρ ?', '["ρ = m / V", "ρ = V / m", "ρ = m × V", "ρ = m + V"]', 'ρ = m / V', 'm est la masse du corps et V son volume ; on en déduit m = ρ × V.', 'Facile', 'NS1'),
('PN1_01-56', NULL, 'Rapport de la masse d''un corps à celle d''un même volume d''eau', '["La densité", "La masse volumique", "La concentration", "La viscosité"]', 'La densité', 'Elle n''a pas d''unité : un corps de densité 7,8 est 7,8 fois plus massif que l''eau pour le même volume. La densité de l''eau vaut 1.', 'Moyen', 'NS1'),
('PN1_01-57', NULL, 'Quelle est la masse volumique de l''eau pure ?', '["1 000 kg/m³", "100 kg/m³", "10 kg/m³", "1 kg/m³"]', '1 000 kg/m³', 'Cela revient à 1 g/cm³, soit 1 kg par litre.', 'Moyen', 'NS1'),
('PN1_01-58', NULL, 'Un objet de 200 g occupe un volume de 100 cm³. Quelle est sa masse volumique ?', '["2 g/cm³", "0,5 g/cm³", "20 g/cm³", "300 g/cm³"]', '2 g/cm³', 'ρ = m / V = 200 g / 100 cm³ = 2 g/cm³.', 'Moyen', 'NS1'),
('PN1_01-61', NULL, 'Quel métal est attiré par un aimant ?', '["Le fer", "L''aluminium", "Le cuivre", "L''or"]', 'Le fer', 'Le nickel et le cobalt le sont aussi ; l''aimant permet de distinguer le fer de l''aluminium.', 'Facile', 'NS1'),
('PN1_01-62', NULL, 'Quel métal est liquide à la température ambiante ?', '["Le mercure", "Le plomb", "Le zinc", "L''étain"]', 'Le mercure', 'Le mercure fond à − 39 °C, alors que l''étain fond à 232 °C et le plomb à 327 °C.', 'Facile', 'NS1'),
('PN1_01-63', NULL, 'Quel métal sert surtout à fabriquer les fils électriques ?', '["Le cuivre", "Le plomb", "Le fer", "Le mercure"]', 'Le cuivre', 'Excellent conducteur d''électricité, le cuivre se tire facilement en fils ; l''argent conduit mieux mais coûte plus cher.', 'Facile', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 9 AND titre = 'Grandeurs, mesures et états de la matière';
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

-- Questions de base rejetées : suppression (et lignes qui les référencent)
CREATE TEMP TABLE asup ON COMMIT DROP AS
SELECT q.id FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = 9 AND q.enonce IN ('Comment s''écrit un nombre en notation scientifique ?', 'Qu''est-ce que l''ordre de grandeur d''une valeur ?');
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
