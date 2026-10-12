-- Import du chapitre Biologie « Biodiversité et équilibre écologique » (NS1, NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('Q1709', 'De quoi un écosystème est-il composé ?', 'De quoi un écosystème est-il composé ?', '["Une biocénose et un biotope", "Uniquement d''êtres vivants", "D''espèces d''un même genre", "D''un habitat forestier"]', 'Une biocénose et un biotope', 'Il réunit des facteurs abiotiques (température, lumière, sol) et biotiques (prédation, compétition, symbiose).', 'Facile', 'NS1'),
('B9-02', NULL, 'Ensemble des êtres vivants qui occupent un milieu donné, en interaction les uns avec les autres et avec ce milieu.', '["La biocénose", "Le biotope", "La biomasse", "La population"]', 'La biocénose', 'Exemple : tous les animaux, plantes et micro-organismes d''une mare.', 'Moyen', 'NS1'),
('B9-03', NULL, 'Science ayant pour objet les relations des êtres vivants avec leur environnement, ainsi qu''avec les autres êtres vivants.', '["L''écologie", "La taxonomie", "La physiologie", "La géologie"]', 'L''écologie', 'Le mot vient du grec oikos (maison) et logos (étude).', 'Facile', 'NS1'),
('B9-04', NULL, 'Ensemble des individus d''une même espèce trouvés dans un lieu donné.', '["Une population", "Une biocénose", "Une famille", "Un genre"]', 'Une population', 'Exemple : tous les flamants roses de l''étang Saumâtre.', 'Moyen', 'NS1'),
('B9-05', NULL, 'Partie de l''environnement, définie par un ensemble de facteurs physiques, dans laquelle vit un individu, une population ou une espèce.', '["L''habitat", "La biomasse", "La niche alimentaire", "La biosphère"]', 'L''habitat', 'La destruction des habitats est la première cause de perte de biodiversité.', 'Moyen', 'NS1'),
('B9-06', NULL, 'Ensemble des facteurs extérieurs qui agissent de façon durable sur un animal, une plante ou une biocénose, et auxquels ils doivent être adaptés pour survivre.', '["Le milieu", "Le génotype", "Le métabolisme", "Le règne"]', 'Le milieu', 'Un être vivant doit être adapté à son milieu pour survivre et se reproduire.', 'Difficile', 'NS1'),
('B9-07', NULL, 'Masse totale de l''ensemble des êtres vivants occupant, à un moment donné, un biotope bien défini.', '["La biomasse", "La biocénose", "La biodiversité", "La population"]', 'La biomasse', 'Elle comprend les arbres comme la faune microscopique du sol.', 'Moyen', 'NS1'),
('B9-08', NULL, 'Quels sont les trois niveaux de la biodiversité ?', '["Génétique, spécifique, écosystémique", "Animal, végétal, minéral", "Terrestre, marin, aérien", "Cellulaire, tissulaire, organique"]', 'Génétique, spécifique, écosystémique', 'Diversité des gènes, des espèces et des écosystèmes.', 'Facile', 'NS1'),
('B9-12', NULL, 'Se dit des espèces vivantes propres à un territoire bien délimité.', '["Endémiques", "Invasives", "Migratrices", "Domestiques"]', 'Endémiques', 'Haïti compte de nombreuses espèces endémiques d''amphibiens et de reptiles.', 'Moyen', 'NS1'),
('B9-13', NULL, 'Quel oiseau endémique d''Hispaniola est l''oiseau national d''Haïti ?', '["Le trogon d''Hispaniola", "Le flamant rose", "Le pélican brun", "Le colibri à gorge rubis"]', 'Le trogon d''Hispaniola', 'En créole : le kanson fran.', 'Moyen', 'NS1'),
('B9-14', NULL, 'Formation forestière littorale tropicale, à base de palétuviers, qui colonise les dépôts vaseux d''estuaires ou de lagunes.', '["La mangrove", "La savane", "La forêt de pins", "Le récif"]', 'La mangrove', 'Les mangroves servent de nurserie à de nombreux poissons.', 'Difficile', 'NS1'),
('B9-15', NULL, 'Zone de transition et de contact entre deux écosystèmes voisins, comme la lisière d''une forêt.', '["Un écotone", "Un biotope", "Un habitat", "Un récif"]', 'Un écotone', 'Sa faune et sa flore sont souvent plus riches que celles des deux milieux voisins.', 'Difficile', 'NS1'),
('B9-16', NULL, 'Se dit des facteurs liés à l''activité des êtres vivants et agissant sur la répartition des espèces d''un milieu donné.', '["Biotiques", "Abiotiques", "Climatiques", "Géologiques"]', 'Biotiques', 'Exemples : prédation, compétition, parasitisme.', 'Difficile', 'NS1'),
('B9-17', NULL, 'Qui ne concerne pas, ne conditionne pas la vie.', '["Abiotique", "Biotique", "Organique", "Trophique"]', 'Abiotique', 'Facteurs abiotiques : température, lumière, eau, sol, vent.', 'Moyen', 'NS1'),
('B9-18', NULL, 'Lequel de ces facteurs est abiotique ?', '["La température", "La prédation", "Le parasitisme", "La compétition"]', 'La température', 'Les facteurs abiotiques sont physiques ou chimiques.', 'Facile', 'NS1'),
('B9-19', NULL, 'Lequel de ces facteurs est biotique ?', '["La prédation", "La lumière", "L''humidité", "Le pH du sol"]', 'La prédation', 'Les facteurs biotiques viennent des êtres vivants.', 'Facile', 'NS1'),
('B9-20', NULL, 'Quel facteur abiotique est indispensable aux producteurs pour fabriquer leur matière organique ?', '["La lumière", "Le vent", "Le bruit", "La pente"]', 'La lumière', 'Les végétaux chlorophylliens l''utilisent pour la photosynthèse.', 'Moyen', 'NS1'),
('Q1598', 'Qui sont les producteurs dans une chaîne alimentaire ?', 'Qui sont les producteurs dans une chaîne alimentaire ?', '["Les végétaux chlorophylliens", "Les animaux herbivores", "Les champignons", "Les bactéries décomposeurs"]', 'Les végétaux chlorophylliens', 'Plantes, algues et cyanobactéries fabriquent leur matière organique par photosynthèse.', 'Facile', 'NS1'),
('Q1599', 'De quel ordre de consommateur un herbivore fait-il partie ?', 'De quel ordre de consommateur un herbivore fait-il partie ?', '["Premier ordre", "Deuxième ordre", "Troisième ordre", "Aucun : c''est un producteur"]', 'Premier ordre', 'Les herbivores (vache, lapin, chenille) mangent directement les producteurs.', 'Facile', 'NS1'),
('Q1618', 'Dans la chaîne « herbe → lapin → renard », quel est le rôle du renard ?', 'Dans la chaîne « herbe → lapin → renard », quel est le rôle du renard ?', '["Consommateur secondaire", "Producteur", "Consommateur primaire", "Décomposeur"]', 'Consommateur secondaire', 'L''herbe est le producteur et le lapin le consommateur primaire.', 'Facile', 'NS1'),
('Q1600', 'Qui sont les décomposeurs dans un écosystème ?', 'Qui sont les décomposeurs dans un écosystème ?', '["Les bactéries et les champignons", "Les carnivores", "Les herbivores", "Les producteurs"]', 'Les bactéries et les champignons', 'Ils transforment la matière organique morte en sels minéraux réutilisables par les plantes.', 'Moyen', 'NS1'),
('B9-21', NULL, 'Organisme vivant se nourrissant d''autres organismes ou de matière organique préexistante.', '["Un consommateur", "Un producteur", "Un minéral", "Un autotrophe"]', 'Un consommateur', 'Herbivores et carnivores sont des consommateurs.', 'Moyen', 'NS1'),
('B9-22', NULL, 'Espèce vivante (bactérie, champignon…) qui se nourrit d''excréments, de cadavres ou de déchets, et contribue à leur minéralisation et à la formation de l''humus.', '["Un décomposeur", "Un prédateur", "Un producteur", "Un herbivore"]', 'Un décomposeur', 'Ils rendent la matière à nouveau utilisable par les plantes et bouclent les chaînes alimentaires.', 'Difficile', 'NS1'),
('B9-23', NULL, 'Se dit d''une espèce vivante qui se nourrit de débris animaux et végétaux.', '["Détritivore", "Herbivore", "Carnivore", "Frugivore"]', 'Détritivore', 'Exemples : le ver de terre, le cloporte.', 'Moyen', 'NS1'),
('B9-24', NULL, 'Se dit des végétaux, champignons et micro-organismes qui se nourrissent de matière organique morte.', '["Saprophyte", "Parasite", "Autotrophe", "Prédateur"]', 'Saprophyte', 'Contrairement au parasite, il ne vit pas aux dépens d''un être vivant.', 'Difficile', 'NS1'),
('Q1616', 'Quel cycle la photosynthèse et la respiration cellulaire forment-elles ensemble ?', 'Quel cycle la photosynthèse et la respiration cellulaire forment-elles ensemble ?', '["Le cycle du carbone", "Le cycle de l''eau", "Le cycle de l''azote", "Le cycle des minéraux"]', 'Le cycle du carbone', 'La photosynthèse fixe le CO₂ et libère l''O₂ ; la respiration fait l''inverse.', 'Moyen', 'NS1'),
('B9-27', NULL, 'Absence de descendants mettant fin à une variété, à une espèce animale ou végétale.', '["L''extinction", "La migration", "La mutation", "L''hybridation"]', 'L''extinction', 'Une espèce éteinte ne réapparaît pas.', 'Moyen', 'NS1'),
('Q1715', 'Quelles sont les principales causes actuelles de la perte de biodiversité ?', 'Quelles sont les principales causes actuelles de la perte de biodiversité ?', '["Habitats détruits, surexploitation, invasions", "Uniquement la pollution", "Uniquement le climat", "Les espèces sauvages"]', 'Habitats détruits, surexploitation, invasions', 'S''y ajoutent la pollution et le changement climatique ; le rythme actuel des extinctions dépasse largement le rythme naturel.', 'Moyen', 'NS1'),
('B9-28', NULL, 'Espèce animale ou végétale qui, introduite dans un milieu naturel, s''y implante et en affecte l''équilibre écologique.', '["Une espèce invasive", "Une espèce endémique", "Une espèce menacée", "Une espèce disparue"]', 'Une espèce invasive', 'Exemple : la mangouste, introduite aux Antilles au XIXe siècle.', 'Moyen', 'NS1'),
('B9-29', NULL, 'Dégradation de l''environnement par des substances, des déchets ou des nuisances diverses.', '["La pollution", "L''érosion", "La sécheresse", "La déforestation"]', 'La pollution', 'Elle est principalement liée aux activités humaines.', 'Facile', 'NS1'),
('B9-30', NULL, 'Enrichissement d''une eau en sels minéraux (nitrates, phosphates) entraînant la prolifération de la végétation aquatique et l''appauvrissement du milieu en oxygène.', '["L''eutrophisation", "L''érosion", "La salinisation", "La sédimentation"]', 'L''eutrophisation', 'Elle est souvent due aux engrais et aux eaux usées.', 'Difficile', 'NS1'),
('Q1612', 'Quelle est la cause de l''eutrophisation d''un lac ?', 'Quelle est la cause de l''eutrophisation d''un lac ?', '["Un excès de nutriments", "Un manque de nutriments", "Les métaux lourds", "Des poissons prédateurs"]', 'Un excès de nutriments', 'Nitrates et phosphates font proliférer les algues, ce qui appauvrit l''eau en oxygène.', 'Difficile', 'NS1'),
('B9-31', NULL, 'Quelle conséquence de la déforestation menace particulièrement les sols haïtiens ?', '["L''érosion", "Le gel", "La salinisation", "Le volcanisme"]', 'L''érosion', 'Sans racines pour les retenir, les sols sont emportés par les pluies.', 'Facile', 'NS1'),
('Q1605', 'Comment le réchauffement climatique affecte-t-il la biodiversité ?', 'Comment le réchauffement climatique affecte-t-il la biodiversité ?', '["Il cause des extinctions", "Il l''augmente partout", "Il n''a aucun effet prouvé", "Il favorise toutes les espèces"]', 'Il cause des extinctions', 'Les espèces qui ne s''adaptent pas assez vite à la hausse des températures ou au déplacement de leur habitat risquent de disparaître.', 'Moyen', 'NS1'),
('Q1611', 'Par quoi les coraux de la mer des Caraïbes sont-ils surtout menacés ?', 'Par quoi les coraux de la mer des Caraïbes sont-ils surtout menacés ?', '["Réchauffement, acidification, pollution", "La surpêche uniquement", "Les cyclones uniquement", "La pêche au filet uniquement"]', 'Réchauffement, acidification, pollution', 'Le stress thermique provoque le blanchissement des coraux ; l''acidification fragilise leur squelette calcaire.', 'Moyen', 'NS1'),
('Q1718', 'Quels effets le changement climatique a-t-il sur les écosystèmes haïtiens ?', 'Quels effets le changement climatique a-t-il sur les écosystèmes haïtiens ?', '["Cyclones plus intenses, sécheresses", "Aucun effet important", "Des effets limités aux pôles", "Un problème uniquement industriel"]', 'Cyclones plus intenses, sécheresses', 'Hausse des températures, cyclones plus intenses, sécheresses et blanchissement des coraux.', 'Moyen', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Biodiversité et équilibre écologique';
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

-- Questions de base rejetées : suppression (et lignes qui les référencent)
CREATE TEMP TABLE asup ON COMMIT DROP AS
SELECT q.id FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = 11 AND q.enonce IN ('Que dit la règle des 10 % sur le flux d''énergie dans un écosystème ?', 'Pourquoi le cycle du carbone est-il important pour le climat ?', 'Comment la déforestation en Haïti affecte-t-elle la biodiversité ?');
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
