-- Import du chapitre Biologie « Évolution et sélection naturelle » (NS1, NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('B10-01', NULL, 'Ensemble des changements subis au cours des temps géologiques par les lignées animales et végétales, ayant eu pour résultat l''apparition de formes nouvelles.', '["L''évolution", "La mutation", "La sélection", "L''adaptation"]', 'L''évolution', 'Toutes les espèces actuelles descendent d''espèces plus anciennes.', 'Moyen', 'NS1'),
('B10-09', NULL, 'Débris ou empreinte de plante ou d''animal, ensevelis dans des couches rocheuses anciennes, et qui s''y sont conservés.', '["Un fossile", "Un minéral", "Un sédiment", "Un cristal"]', 'Un fossile', 'Coquilles, os, empreintes de feuilles ou de pas…', 'Facile', 'NS1'),
('B10-10', NULL, 'Science qui étudie les êtres vivants ayant peuplé la Terre au cours des temps géologiques, principalement à partir des fossiles.', '["La paléontologie", "L''archéologie", "La géologie", "L''écologie"]', 'La paléontologie', 'L''archéologie, elle, étudie les traces laissées par les sociétés humaines.', 'Moyen', 'NS1'),
('Q1701', 'Quelles sont les preuves moléculaires d''une origine commune des espèces ?', 'Quelles sont les preuves moléculaires d''une origine commune des espèces ?', '["Des séquences d''ADN partagées", "L''absence de ressemblances", "Les différences de taille", "L''absence de fossiles"]', 'Des séquences d''ADN partagées', 'Plus deux espèces sont apparentées, plus leurs séquences d''ADN et de protéines se ressemblent.', 'Moyen', 'NS1'),
('Q1704', 'Qu''est-ce qui caractérise des organes homologues ?', 'Se dit d''organes qui ont la même structure fondamentale, la même origine embryonnaire et les mêmes connexions, mais dont la fonction peut être différente.', '["Homologues", "Analogues", "Vestigiaux", "Convergents"]', 'Homologues', 'Exemple : le bras humain, l''aile de la chauve-souris et la nageoire du phoque. Ils révèlent un ancêtre commun.', 'Moyen', 'NS1'),
('B10-13', NULL, 'Se dit d''organes très différents par leur origine, mais qui se ressemblent par leur forme et leur fonction, comme l''aile de l''oiseau et celle de l''insecte.', '["Analogues", "Homologues", "Vestigiaux", "Héréditaires"]', 'Analogues', 'Leur ressemblance ne vient pas d''un ancêtre commun mais d''une convergence.', 'Difficile', 'NS1'),
('B10-14', NULL, 'Ressemblance acquise entre des êtres vivants de même milieu ou de même mode de vie, alors que leurs ancêtres étaient très différents.', '["La convergence", "La coévolution", "La divergence", "L''homologie"]', 'La convergence', 'Exemple : la forme fuselée du requin (poisson) et du dauphin (mammifère).', 'Difficile', 'NS1'),
('B10-32', NULL, 'Quel est le plus proche parent vivant de l''espèce humaine ?', '["Le chimpanzé", "Le gorille", "L''orang-outan", "Le babouin"]', 'Le chimpanzé', 'Avec le bonobo, il partage environ 98 % de notre ADN et un ancêtre commun récent.', 'Moyen', 'NS1'),
('B10-16', NULL, 'Doctrine selon laquelle les espèces vivantes ne se transforment pas au cours des temps.', '["Le fixisme", "Le transformisme", "Le lamarckisme", "Le néodarwinisme"]', 'Le fixisme', 'Elle s''oppose à l''évolutionnisme et a été abandonnée.', 'Moyen', 'NS1'),
('B10-20', NULL, 'Théorie selon laquelle chaque espèce serait apparue brusquement, sans ancêtres, par la volonté divine.', '["Le créationnisme", "Le transformisme", "Le darwinisme", "Le néodarwinisme"]', 'Le créationnisme', 'Cette doctrine religieuse est abandonnée par la communauté scientifique.', 'Moyen', 'NS1'),
('B10-17', NULL, 'Doctrine suivant laquelle les espèces animales et végétales se modifient et dérivent les unes des autres par filiation.', '["Le transformisme", "Le fixisme", "Le créationnisme", "Le vitalisme"]', 'Le transformisme', 'Elle s''oppose au fixisme.', 'Difficile', 'NS1'),
('B10-18', NULL, 'Théorie de 1809 qui explique l''évolution des espèces par l''hérédité des caractères acquis.', '["Le lamarckisme", "Le darwinisme", "Le fixisme", "Le créationnisme"]', 'Le lamarckisme', 'Exposée par Lamarck dans sa Philosophie zoologique.', 'Moyen', 'NS1'),
('Q1698', 'Qu''est-ce qui distingue la théorie de Lamarck de celle de Darwin ?', 'Qu''est-ce qui distingue la théorie de Lamarck de celle de Darwin ?', '["L''hérédité des caractères acquis", "Rien, elles sont identiques", "Lamarck vient après Darwin", "Lamarck n''a pas parlé d''évolution"]', 'L''hérédité des caractères acquis', 'Lamarck : la girafe allonge son cou à force de l''étirer et transmet ce caractère. Cette idée a été réfutée.', 'Facile', 'NS1'),
('B10-19', NULL, 'Doctrine scientifique exposée en 1858, qui démontre le fait de l''évolution et explique le renouvellement des faunes et des flores au cours des ères géologiques.', '["Le darwinisme", "Le lamarckisme", "Le fixisme", "Le créationnisme"]', 'Le darwinisme', 'Elle repose sur la variation, l''hérédité et la sélection naturelle.', 'Moyen', 'NS1'),
('Q1601', 'La théorie de l''évolution par sélection naturelle a été proposée par :', 'Quel naturaliste a proposé la théorie de l''évolution par sélection naturelle ?', '["Charles Darwin", "Jean-Baptiste Lamarck", "Gregor Mendel", "Louis Pasteur"]', 'Charles Darwin', 'Il l''a exposée dans L''Origine des espèces (1859).', 'Facile', 'NS1'),
('B10-23', NULL, 'Quel livre Charles Darwin a-t-il publié en 1859 ?', '["L''Origine des espèces", "Philosophie zoologique", "Systema Naturae", "Le Capital"]', 'L''Origine des espèces', 'Il y expose la théorie de l''évolution par sélection naturelle.', 'Facile', 'NS1'),
('B10-35', NULL, 'Quels oiseaux des îles Galápagos ont inspiré Darwin ?', '["Les pinsons", "Les flamants", "Les pélicans", "Les colibris"]', 'Les pinsons', 'Leurs becs, différents d''une île à l''autre, sont adaptés à leur nourriture.', 'Moyen', 'NS1'),
('Q1697', 'Que dit la théorie de l''évolution par sélection naturelle de Darwin ?', 'Que dit la théorie de l''évolution par sélection naturelle de Darwin ?', '["Les mieux adaptés se reproduisent plus", "Les espèces sont immuables", "L''évolution va vers la complexité", "Les caractères acquis se transmettent"]', 'Les mieux adaptés se reproduisent plus', 'Variation, hérédité et sélection naturelle expliquent l''évolution (1859).', 'Facile', 'NS1'),
('Q1703', 'Qu''est-ce que la théorie synthétique de l''évolution (néo-darwinisme) ?', 'Théorie explicative de l''évolution, dite « théorie synthétique », qui retient les mutations génétiques et la sélection naturelle comme facteurs d''apparition de nouvelles espèces.', '["Le néodarwinisme", "Le lamarckisme", "Le fixisme", "Le créationnisme"]', 'Le néodarwinisme', 'Elle unit, dans les années 1930-1940, les idées de Darwin et la génétique de Mendel.', 'Moyen', 'NS1'),
('B10-06', NULL, 'Différence qu''un individu animal ou végétal présente avec ses parents et ses autres ascendants, au même stade de développement.', '["Une variation", "Une lignée", "Une adaptation", "Une espèce"]', 'Une variation', 'Lorsqu''elle se transmet par l''hérédité, on parle de mutation.', 'Moyen', 'NS1'),
('B10-05', NULL, 'Apparition brusque, dans les cellules d''un être vivant, d''un changement dans la structure de certains gènes, transmis aux générations suivantes si les gamètes sont touchés.', '["Une mutation", "Une adaptation", "Une hybridation", "Une sélection"]', 'Une mutation', 'C''est la source de nouveaux caractères.', 'Moyen', 'NS1'),
('B10-07', NULL, 'Variante d''un gène, résultant d''une mutation, qui assure la même fonction que le gène initial mais selon ses modalités propres.', '["Un allèle", "Un chromosome", "Un génotype", "Un caryotype"]', 'Un allèle', 'Exemple : les allèles A, B et O du groupe sanguin.', 'Difficile', 'NS1'),
('B10-21', NULL, 'Transmission des caractères génétiques des parents à leurs descendants.', '["L''hérédité", "La mutation", "L''adaptation", "La sélection"]', 'L''hérédité', 'Sans hérédité, les caractères avantageux ne se transmettraient pas.', 'Facile', 'NS1'),
('B10-30', NULL, 'Pourquoi les mutations sont-elles importantes pour l''évolution ?', '["Elles créent de nouveaux caractères", "Elles sont toujours favorables", "Le milieu les dirige", "Elles n''ont aucun effet"]', 'Elles créent de nouveaux caractères', 'La plupart sont neutres ou défavorables ; quelques-unes sont avantageuses.', 'Moyen', 'NS1'),
('B10-31', NULL, 'Les mutations apparaissent-elles pour répondre aux besoins de l''organisme ?', '["Non, elles surviennent au hasard", "Oui, toujours", "Oui, chez les animaux seulement", "Oui, en cas de danger"]', 'Non, elles surviennent au hasard', 'C''est ensuite la sélection naturelle qui trie les mutations utiles.', 'Moyen', 'NS1'),
('Q1699', 'Qu''est-ce que la dérive génétique ?', 'Variation au hasard des fréquences des allèles d''une génération à l''autre, plus forte dans les petites populations.', '["La dérive génétique", "La sélection naturelle", "La mutation", "La migration"]', 'La dérive génétique', 'Elle peut faire disparaître ou fixer un allèle sans rapport avec son utilité.', 'Moyen', 'NS1'),
('B10-02', NULL, 'Tri opéré par le milieu, au sein d''une espèce, des individus qui assureront sa reproduction de façon préférentielle.', '["La sélection naturelle", "La sélection artificielle", "La dérive génétique", "La mutation"]', 'La sélection naturelle', 'Les mieux adaptés au milieu laissent plus de descendants.', 'Moyen', 'NS1'),
('B10-03', NULL, 'Choix, opéré par l''homme au sein d''une espèce animale ou végétale, des individus qui se reproduiront.', '["La sélection artificielle", "La sélection naturelle", "La dérive génétique", "La spéciation"]', 'La sélection artificielle', 'Exemples : les races de chiens, les variétés de maïs.', 'Moyen', 'NS1'),
('Q1602', 'Que favorise la sélection naturelle ?', 'Que favorise la sélection naturelle ?', '["Les caractères utiles à la survie", "Les mutations aléatoires seulement", "Les individus les plus grands", "Les individus les plus forts"]', 'Les caractères utiles à la survie', 'Ce sont les mieux adaptés au milieu, pas forcément les plus forts, qui survivent et se reproduisent davantage.', 'Moyen', 'NS1'),
('B10-25', NULL, 'Comment appelle-t-on l''action du milieu qui favorise les individus les mieux adaptés ?', '["Une pression de sélection", "Une dérive génétique", "Une mutation dirigée", "Une hybridation"]', 'Une pression de sélection', 'Prédateurs, climat, maladies ou manque de nourriture exercent des pressions de sélection.', 'Moyen', 'NS1'),
('B10-04', NULL, 'Changement survenu chez un individu, une lignée ou une espèce, qui augmente ses chances de survie et de reproduction dans le milieu où il vit.', '["L''adaptation", "La mutation", "L''extinction", "La migration"]', 'L''adaptation', 'Exemple : les épines des cactus qui limitent la perte d''eau.', 'Moyen', 'NS1'),
('Q1620', 'De quoi l''adaptation d''une espèce à son milieu est-elle le résultat ?', 'De quoi l''adaptation d''une espèce à son milieu est-elle le résultat ?', '["De la sélection naturelle", "D''une décision de l''espèce", "D''un accident unique", "De l''action directe du milieu"]', 'De la sélection naturelle', 'Les individus porteurs de caractères avantageux survivent et se reproduisent davantage, génération après génération.', 'Moyen', 'NS1'),
('B10-15', NULL, 'Particularité des espèces qui, par leur forme ou leur couleur, peuvent se confondre avec leur environnement ou avec une autre espèce.', '["Le mimétisme", "Le parasitisme", "La convergence", "L''hibernation"]', 'Le mimétisme', 'Exemple : le phasme qui ressemble à une brindille.', 'Moyen', 'NS1'),
('B10-27', NULL, 'Pourquoi les papillons sombres (phalènes) se sont-ils multipliés dans l''Angleterre industrielle ?', '["Ils étaient moins visibles des oiseaux", "Ils mangeaient la suie", "Ils fuyaient la pollution", "Ils changeaient de couleur à volonté"]', 'Ils étaient moins visibles des oiseaux', 'Sur les troncs noircis par la suie, les papillons clairs étaient plus facilement mangés.', 'Moyen', 'NS1'),
('Q1708', 'Que favorise la sélection sexuelle ?', 'Que favorise la sélection sexuelle ?', '["Le succès reproducteur", "La survie uniquement", "Le hasard", "Les insectes uniquement"]', 'Le succès reproducteur', 'Exemple : la queue du paon gêne sa survie mais attire les femelles.', 'Moyen', 'NS1'),
('Q1706', 'Qu''est-ce que la coévolution ?', 'Transformation parallèle, au fil des générations, de deux espèces en étroite interaction.', '["La coévolution", "La convergence", "La symbiose", "La spéciation"]', 'La coévolution', 'Exemple : une fleur et l''insecte qui la pollinise.', 'Moyen', 'NS1'),
('B10-08', NULL, 'Formation de nouvelles sortes d''êtres vivants, incapables de se reproduire avec les formes anciennes.', '["La spéciation", "L''extinction", "La mutation", "L''hybridation"]', 'La spéciation', 'Elle suit souvent l''isolement d''une population.', 'Moyen', 'NS1'),
('Q1700', 'Qu''est-ce que la spéciation allopatrique ?', 'Formation de nouvelles sortes d''êtres vivants à partir de populations séparées par une barrière géographique (montagne, bras de mer).', '["La spéciation allopatrique", "La dérive génétique", "La sélection sexuelle", "La coévolution"]', 'La spéciation allopatrique', 'Les populations isolées n''échangent plus de gènes et finissent par diverger.', 'Moyen', 'NS1'),
('B10-11', NULL, 'Succession des espèces animales ou végétales que l''on suppose descendre les unes des autres.', '["La phylogenèse", "La spéciation", "L''embryogenèse", "La classification"]', 'La phylogenèse', 'On la représente par un arbre phylogénétique.', 'Difficile', 'NS1'),
('B10-29', NULL, 'Dans un arbre phylogénétique, que représente un nœud (embranchement) ?', '["Un ancêtre commun", "Une espèce actuelle", "Une extinction", "Un fossile précis"]', 'Un ancêtre commun', 'Les espèces actuelles sont placées au bout des branches.', 'Moyen', 'NS1'),
('B10-12', NULL, 'Très grand groupe d''animaux ou de plantes descendant d''ancêtres communs.', '["Un clade", "Un genre", "Une population", "Une variété"]', 'Un clade', 'Exemple : les vertébrés forment un clade.', 'Difficile', 'NS1'),
('Q1702', 'Qu''est-ce que la classification phylogénétique (cladistique) ?', 'Méthode de recherche des parentés entre espèces vivantes, fondée sur l''analyse génétique plus que sur les ressemblances visibles.', '["La cladistique", "La systématique", "La paléontologie", "La morphologie"]', 'La cladistique', 'Elle regroupe les espèces selon leurs caractères hérités d''un ancêtre commun.', 'Moyen', 'NS1'),
('Q1707', 'Comment la théorie de l''endosymbiose explique-t-elle l''origine des mitochondries ?', 'Comment la théorie de l''endosymbiose explique-t-elle l''origine des mitochondries ?', '["Des bactéries englouties", "Une forme de parasitisme", "Une division cellulaire", "Une théorie réfutée"]', 'Des bactéries englouties', 'Mitochondries et chloroplastes ont leur propre ADN circulaire, comme les bactéries (Lynn Margulis).', 'Moyen', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Évolution et sélection naturelle';
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
WHERE c.matiere_id = 11 AND q.enonce IN ('Pourquoi les fossiles sont-ils des preuves de l''évolution ?');
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
