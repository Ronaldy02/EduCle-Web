-- Import du chapitre Littérature haïtienne « L'École de 1836 : contexte et poètes » (NS1) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('LH3-34', NULL, 'Comment nomme-t-on le groupe romantique formé en 1836 autour des frères Nau ?', '["Le Cénacle", "La Ronde", "Les Griots", "L''école patriotique"]', 'Le Cénacle', 'On l''appelle aussi l''École de 1836 ; il se forme autour du journal Le Républicain, puis de L''Union.', 'Moyen', 'NS1'),
('LH3-35', NULL, 'Entre quelles dates se situe l''École de 1836 ?', '["De 1836 à 1860", "De 1804 à 1836", "De 1860 à 1898", "De 1898 à 1915"]', 'De 1836 à 1860', 'C''est la deuxième période de la littérature haïtienne, de type romantique.', 'Moyen', 'NS1'),
('LH3-36', NULL, 'Quel président fait fermer le journal Le Républicain ?', '["Jean-Pierre Boyer", "Alexandre Pétion", "Faustin Soulouque", "Fabre Geffrard"]', 'Jean-Pierre Boyer', 'Le journal, fondé en août 1836, est d''abord censuré puis fermé.', 'Moyen', 'NS1'),
('LH3-37', NULL, 'Pour quelle raison Le Républicain est-il interdit ?', '["Un article hostile au gouvernement", "Un poème jugé obscène", "Une attaque contre l''Église", "Un litige avec l''imprimeur"]', 'Un article hostile au gouvernement', 'L''Union paraît la même année, avec les mêmes collaborateurs, pour contourner la censure.', 'Moyen', 'NS1'),
('LH3-38', NULL, 'Quel autre frère Nau appartient au Cénacle, avec Ignace et Émile ?', '["Eugène Nau", "Dumaï Lespinasse", "Céligny Ardouin", "Thomas Madiou"]', 'Eugène Nau', 'Eugène Nau écrit dans L''Union, en 1837 : « ce n''est pas la poésie qui manque, ce sont les poètes ».', 'Moyen', 'NS1'),
('LH3-39', NULL, 'Quels frères de Coriolan Ardouin, historiens et hommes politiques, appartiennent au Cénacle ?', '["Beaubrun et Céligny", "Émile et Ignace", "Dumaï et Beauvais", "Thomas et Hérard"]', 'Beaubrun et Céligny', 'Beaubrun Ardouin est l''auteur des Études sur l''histoire d''Haïti.', 'Moyen', 'NS1'),
('LH3-40', NULL, 'Quels frères Lespinasse sont membres du Cénacle ?', '["Beauvais et Dumaï", "Beaubrun et Céligny", "Ignace et Émile", "Eugène et Charles"]', 'Beauvais et Dumaï', 'La plupart des membres du Cénacle étaient proches parents et issus de la haute bourgeoisie.', 'Difficile', 'NS1'),
('LH3-41', NULL, 'Quel historien rejoint plus tard le Cénacle, avec Ogé Longuefosse et Alibée Fleury ?', '["Thomas Madiou", "Baron de Vastey", "Julien Prévost", "Hérard Dumesle"]', 'Thomas Madiou', 'Madiou est l''auteur de l''Histoire d''Haïti.', 'Difficile', 'NS1'),
('LH3-42', NULL, 'Contre quoi le Cénacle s''élève-t-il en littérature ?', '["La mythologie et les imitations", "Le romantisme français", "La poésie lyrique", "Le roman historique"]', 'La mythologie et les imitations', 'Le groupe veut une littérature originale, qui se distingue de celle des pionniers.', 'Moyen', 'NS1'),
('LH3-43', NULL, 'Que reprochent les membres de l''École de 1836 aux pionniers ?', '["Leur imitation des pseudo-classiques français", "Leur écriture en créole", "Leur goût du romantisme", "Leur refus de publier"]', 'Leur imitation des pseudo-classiques français', 'Ils les trouvent trop attachés aux modèles pseudo-classiques de la France.', 'Moyen', 'NS1'),
('LH3-44', NULL, 'Quels poètes illustrent le romantisme haïtien à partir de 1836, selon Larousse ?', '["Ignace Nau et Coriolan Ardouin", "Oswald Durand et Massillon Coicou", "Etzer Vilaire et Georges Sylvain", "Jacques Roumain et Carl Brouard"]', 'Ignace Nau et Coriolan Ardouin', 'Larousse ajoute le romancier Émeric Bergeaud et les historiens Madiou, Beaubrun Ardouin et Saint-Rémy.', 'Moyen', 'NS1'),
('LH3-45', NULL, 'Quels thèmes accompagnent le sentiment religieux dans le romantisme du Cénacle ?', '["L''exil et l''amour du terroir", "La guerre et l''héroïsme", "Le commerce et l''argent", "La science et le progrès"]', 'L''exil et l''amour du terroir', 'Universalis parle d''un romantisme « qui s''enfante dans la douleur ».', 'Difficile', 'NS1'),
('LH3-46', NULL, 'Quel est l''unique recueil de Coriolan Ardouin ?', '["Reliques d''un poète haïtien", "Poésies fugitives", "Poèmes mélancoliques", "Rires et pleurs"]', 'Reliques d''un poète haïtien', 'Il est publié après sa mort, en 1837.', 'Moyen', 'NS1'),
('LH3-47', NULL, 'Qui publie à titre posthume Reliques d''un poète haïtien ?', '["Émile Nau", "Ignace Nau", "Beaubrun Ardouin", "Thomas Madiou"]', 'Émile Nau', 'Coriolan Ardouin est mort très jeune ; il avait onze frères et sœurs.', 'Difficile', 'NS1'),
('LH3-48', NULL, 'Quels poètes français influencent surtout Coriolan Ardouin ?', '["Lamartine et Casimir Delavigne", "Hugo et Rimbaud", "Villon et Ronsard", "Verlaine et Mallarmé"]', 'Lamartine et Casimir Delavigne', 'Sa poésie est marquée par la mélancolie, la sincérité et de nombreuses exclamations.', 'Moyen', 'NS1'),
('LH3-49', NULL, 'En quelle année est né Coriolan Ardouin ?', '["1812", "1808", "1806", "1815"]', '1812', 'Les sources divergent sur la date de sa mort, entre 1835 et 1838.', 'Difficile', 'NS1'),
('LH3-50', NULL, 'Dans quelle localité est né Coriolan Ardouin ?', '["Petit-Trou-de-Nippes", "Jacmel", "Les Cayes", "Port-de-Paix"]', 'Petit-Trou-de-Nippes', 'Ses frères Beaubrun et Céligny sont devenus historiens et hommes politiques.', 'Difficile', 'NS1'),
('LH3-51', NULL, 'En quelle année est né Ignace Nau ?', '["1808", "1812", "1806", "1815"]', '1808', 'Né à Port-au-Prince, il est l''initiateur du Cénacle.', 'Moyen', 'NS1'),
('LH3-52', NULL, 'Quelle fonction Ignace Nau occupe-t-il auprès du président Boyer ?', '["Secrétaire particulier", "Ministre de la Guerre", "Ambassadeur à Paris", "Directeur du lycée"]', 'Secrétaire particulier', 'Son père, Jean-Pierre Nau, fut trésorier général sous Pétion et Boyer.', 'Difficile', 'NS1'),
('LH3-53', NULL, 'Quel poème d''Ignace Nau est un hommage à l''empereur fondateur de la nation haïtienne ?', '["Dessalines", "Le Lac", "À ma patrie", "Isalina"]', 'Dessalines', 'Ignace Nau a aussi laissé des Poésies, rééditées au XXIe siècle.', 'Difficile', 'NS1'),
('LH3-54', NULL, 'En quelle année est né Émile Nau ?', '["1812", "1808", "1806", "1818"]', '1812', 'Il est né à Port-au-Prince et meurt en 1860.', 'Moyen', 'NS1'),
('LH3-55', NULL, 'Quelle fonction politique Émile Nau exerce-t-il à partir de 1842 ?', '["Député", "Sénateur", "Ministre des Finances", "Président du Sénat"]', 'Député', 'Il est aussi délégué (préfet) de Port-au-Prince sous Boyer.', 'Difficile', 'NS1'),
('LH3-56', NULL, 'Dans quelle ville est né Pierre Faubert ?', '["Les Cayes", "Jacmel", "Le Cap", "Jérémie"]', 'Les Cayes', 'Poète, dramaturge, diplomate et homme politique, il est né en 1806.', 'Moyen', 'NS1'),
('LH3-57', NULL, 'Quel lycée Pierre Faubert dirige-t-il ?', '["Le lycée Pétion", "Le lycée Toussaint-Louverture", "Le lycée Dessalines", "Le lycée Boyer"]', 'Le lycée Pétion', 'Il a aussi été conseiller du président Boyer.', 'Moyen', 'NS1'),
('LH3-58', NULL, 'Quel drame historique de Pierre Faubert met en scène le chef de la révolte de 1790 ?', '["Ogé ou le préjugé de couleur", "La Mort du général Lamarre", "L''Haïtien expatrié", "L''Entrée du roi en sa capitale"]', 'Ogé ou le préjugé de couleur', 'La pièce, écrite en 1841, dénonce les préjugés liés à la couleur de la peau.', 'Moyen', 'NS1'),
('LH3-59', NULL, 'Quel recueil poétique de Pierre Faubert est cité par Wikipédia ?', '["Poésies fugitives", "Poésies nationales", "Rires et pleurs", "Primevères"]', 'Poésies fugitives', 'Hoffmann cite aussi son poème « Le Souvenir » (1856).', 'Difficile', 'NS1'),
('LH3-60', NULL, 'Dans quel pays Pierre Faubert s''exile-t-il après la chute de Boyer ?', '["La Jamaïque", "Cuba", "Le Canada", "Le Venezuela"]', 'La Jamaïque', 'Il s''installe ensuite à Paris et meurt à Issy-les-Moulineaux en 1868.', 'Difficile', 'NS1'),
('LH3-61', NULL, 'Quel poète haïtien négocie un concordat avec le Vatican sous la présidence de Geffrard ?', '["Pierre Faubert", "Émile Nau", "Coriolan Ardouin", "Ignace Nau"]', 'Pierre Faubert', 'Il est alors désigné émissaire d''Haïti auprès de la papauté.', 'Difficile', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 23 AND titre = 'L''École de 1836 : contexte et poètes';
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
