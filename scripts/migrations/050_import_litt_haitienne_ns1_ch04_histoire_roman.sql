-- Import du chapitre Littérature haïtienne « L'École de 1836 : histoire et roman » (NS1) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('LH4-01', NULL, 'Expression d''une idée par une métaphore animée et continuée par un développement ?', '["Une allégorie", "Une paraphrase", "Une hyperbole", "Une antithèse"]', 'Une allégorie', 'Dans Stella, le personnage qui donne son titre au roman est une allégorie de la Liberté.', 'Moyen', 'NS1'),
('LH4-02', NULL, 'Long récit poétique d''aventures héroïques où intervient le merveilleux ?', '["Une épopée", "Une ballade", "Une élégie", "Une fable"]', 'Une épopée', 'Christiane Ndiaye lit Stella comme un roman épique qui réinvente les conventions de l''épopée.', 'Moyen', 'NS1'),
('LH4-03', NULL, 'Dont la divulgation a lieu après la mort de son auteur ?', '["Posthume", "Anonyme", "Apocryphe", "Clandestin"]', 'Posthume', 'Stella est publié à titre posthume, en 1859, par le cousin de Bergeaud.', 'Moyen', 'NS1'),
('LH4-04', NULL, 'Ensemble des documents concernant l''histoire d''une collectivité, d''une famille ou d''un individu ?', '["Les archives", "Les annales", "Les mémoires", "Les almanachs"]', 'Les archives', 'La destruction de la plupart des archives rendait difficile le travail des premiers historiens haïtiens.', 'Moyen', 'NS1'),
('LH4-05', NULL, 'Régime politique où l''autorité est entre les mains de quelques personnes ou familles puissantes ?', '["Une oligarchie", "Une démocratie", "Une théocratie", "Une anarchie"]', 'Une oligarchie', 'Hoffmann estime que le système défendu par les historiens mulâtres était en fait une oligarchie.', 'Moyen', 'NS1'),
('LH4-06', NULL, 'Opinion adoptée sans examen, souvent imposée par le milieu ou l''éducation ?', '["Un préjugé", "Un pronostic", "Un postulat", "Un paradoxe"]', 'Un préjugé', 'Le préjugé de couleur est un thème majeur de la littérature haïtienne, de Pierre Faubert à Bergeaud.', 'Moyen', 'NS1'),
('LH4-07', NULL, 'Quel écrivain est l''auteur du roman Stella ?', '["Émeric Bergeaud", "Thomas Madiou", "Demesvar Delorme", "Ignace Nau"]', 'Émeric Bergeaud', 'Né aux Cayes en 1818, il meurt à Saint-Thomas en 1858.', 'Facile', 'NS1'),
('LH4-08', NULL, 'Quel roman est considéré comme le premier roman haïtien ?', '["Stella", "Mimola", "Le Damné", "Gouverneurs de la rosée"]', 'Stella', 'Hoffmann le qualifie de premier roman composé par un Haïtien.', 'Facile', 'NS1'),
('LH4-09', NULL, 'En quelle année Stella est-il publié ?', '["1859", "1847", "1884", "1901"]', '1859', 'Il paraît après la mort de l''auteur, survenue en 1858.', 'Moyen', 'NS1'),
('LH4-10', NULL, 'Dans quelle ville Stella est-il publié, à titre posthume ?', '["Paris", "Port-au-Prince", "Les Cayes", "Saint-Thomas"]', 'Paris', 'Le livre est publié chez l''éditeur Édouard Dentu.', 'Moyen', 'NS1'),
('LH4-12', NULL, 'Qui fait publier Stella après la mort de Bergeaud ?', '["Beaubrun Ardouin", "Émile Nau", "Thomas Madiou", "Joseph Saint-Rémy"]', 'Beaubrun Ardouin', 'Bergeaud lui avait confié son manuscrit à Paris en 1857 ; ils étaient cousins.', 'Moyen', 'NS1'),
('LH4-13', NULL, 'Dans quelles circonstances Bergeaud écrit-il Stella ?', '["Pendant son exil à Saint-Thomas", "Pendant ses études à Paris", "Pendant la guerre d''Indépendance", "Pendant son service militaire"]', 'Pendant son exil à Saint-Thomas', 'Il s''exile en 1848, à cause de sa proximité avec un soulèvement contre Soulouque.', 'Moyen', 'NS1'),
('LH4-14', NULL, 'Contre quel dirigeant s''est élevé le soulèvement qui pousse Bergeaud à l''exil en 1848 ?', '["Faustin Soulouque", "Jean-Pierre Boyer", "Fabre Geffrard", "Alexandre Pétion"]', 'Faustin Soulouque', 'Soulouque voulait se faire proclamer empereur.', 'Moyen', 'NS1'),
('LH4-15', NULL, 'Dans quelle ville est né Émeric Bergeaud ?', '["Les Cayes", "Port-au-Prince", "Le Cap", "Jérémie"]', 'Les Cayes', 'Il fut le secrétaire de son oncle, le général Borgella.', 'Moyen', 'NS1'),
('LH4-17', NULL, 'Quel roman raconte les aventures de deux frères, Romulus et Rémus, jusqu''à l''indépendance de 1804 ?', '["Stella", "Mimola", "Deux amours", "Le Vieux Piquet"]', 'Stella', 'Ils sont les fils de Marie, une esclave africaine ; Romulus est noir et Rémus mulâtre.', 'Moyen', 'NS1'),
('LH4-18', NULL, 'Quels personnages historiques les héros Romulus et Rémus évoquent-ils ?', '["Toussaint Louverture et André Rigaud", "Dessalines et Christophe", "Pétion et Boyer", "Capois et Vernet"]', 'Toussaint Louverture et André Rigaud', 'Hoffmann souligne qu''ils sont calqués sur le Noir Toussaint et son ennemi mulâtre Rigaud.', 'Moyen', 'NS1'),
('LH4-19', NULL, 'Contre quel préjugé Bergeaud prêche-t-il à travers Romulus et Rémus ?', '["Le préjugé de couleur", "Le préjugé de classe", "Le préjugé religieux", "Le préjugé de sexe"]', 'Le préjugé de couleur', 'Le roman est une version à peine romancée des événements de la guerre d''Indépendance.', 'Moyen', 'NS1'),
('LH4-20', NULL, 'Qui est Stella, dans le roman de Bergeaud ?', '["L''allégorie de la Liberté", "La mère de Romulus", "Une esclave révoltée", "La fille de Toussaint"]', 'L''allégorie de la Liberté', 'Jeune guerrière qui guide les héros, elle révèle à la fin son identité : elle est la Liberté.', 'Moyen', 'NS1'),
('LH4-21', NULL, 'Quel événement clôt le récit de Stella ?', '["L''indépendance de 1804", "La mort de Dessalines", "Le couronnement de Christophe", "La chute de Boyer"]', 'L''indépendance de 1804', 'Les héros luttent pour la liberté et l''indépendance de Saint-Domingue, proclamée le 1er janvier 1804.', 'Moyen', 'NS1'),
('LH4-22', NULL, 'Quel genre Christiane Ndiaye reconnaît-elle dans Stella ?', '["Un roman épique", "Un roman policier", "Un roman d''apprentissage", "Un roman épistolaire"]', 'Un roman épique', 'Elle parle d''un texte « hybride », mêlant poétique épique et polyphonie.', 'Difficile', 'NS1'),
('LH4-23', NULL, 'Avec quels pays Bergeaud compare-t-il les paysages haïtiens dans Stella ?', '["La Suisse, l''Italie et l''Espagne", "La Norvège, la Russie et l''Écosse", "Le Canada, l''Alaska et le Groenland", "L''Égypte, l''Inde et la Chine"]', 'La Suisse, l''Italie et l''Espagne', 'Hoffmann y voit la note donnée dès 1859 : une nature de convention, qui pourrait être celle de l''Europe.', 'Difficile', 'NS1'),
('LH4-24', NULL, 'Qui est l''auteur de l''Histoire d''Haïti, publiée en 1847-1848 ?', '["Thomas Madiou", "Beaubrun Ardouin", "Joseph Saint-Rémy", "Émile Nau"]', 'Thomas Madiou', 'C''est le premier grand historien haïtien.', 'Facile', 'NS1'),
('LH4-25', NULL, 'Combien de tomes de l''Histoire d''Haïti Madiou publie-t-il en 1847 et 1848 ?', '["Trois", "Un", "Cinq", "Onze"]', 'Trois', 'Deux tomes paraissent en 1847 et un en 1848 ; un tome posthume sort en 1904.', 'Difficile', 'NS1'),
('LH4-26', NULL, 'En quelle année est né Thomas Madiou ?', '["1814", "1796", "1816", "1812"]', '1814', 'Il est né à Port-au-Prince et y meurt en 1884.', 'Difficile', 'NS1'),
('LH4-27', NULL, 'Quel journal officiel Madiou dirige-t-il en 1849 ?', '["Le Moniteur", "Le Télégraphe", "L''Union", "Le Républicain"]', 'Le Moniteur', 'Il a étudié en France, à Angers puis à Rennes, avant de rentrer en Haïti en 1835.', 'Difficile', 'NS1'),
('LH4-29', NULL, 'Qui a écrit les Études sur l''histoire d''Haïti ?', '["Beaubrun Ardouin", "Thomas Madiou", "Émile Nau", "Hannibal Price"]', 'Beaubrun Ardouin', 'Il y affirme que les Haïtiens doivent eux-mêmes découvrir la filiation des événements de leur patrie.', 'Facile', 'NS1'),
('LH4-31', NULL, 'En quelle année est né Beaubrun Ardouin ?', '["1796", "1814", "1816", "1808"]', '1796', 'Il est né à Petit-Trou-de-Nippes, comme son frère le poète Coriolan.', 'Difficile', 'NS1'),
('LH4-32', NULL, 'Quelle fonction Beaubrun Ardouin reçoit-il en 1832, sous Boyer ?', '["Sénateur", "Ministre de la Guerre", "Directeur du lycée", "Président de la Cour"]', 'Sénateur', 'Après la chute de Boyer en 1843, il est emprisonné.', 'Moyen', 'NS1'),
('LH4-34', NULL, 'Quel ouvrage Beaubrun Ardouin publie-t-il à Port-au-Prince en 1832 ?', '["Géographie de l''île d''Haïti", "Pétion et Haïti", "Histoire d''Haïti", "Stella"]', 'Géographie de l''île d''Haïti', 'Il fut d''abord typographe et avocat.', 'Difficile', 'NS1'),
('LH4-35', NULL, 'Quel ouvrage de son frère Céligny, Beaubrun Ardouin publie-t-il en 1865 ?', '["Essais sur l''histoire d''Haïti", "Études sur l''histoire d''Haïti", "Histoire des caciques d''Haïti", "Géographie de l''île d''Haïti"]', 'Essais sur l''histoire d''Haïti', 'Les frères avaient commencé à recueillir des récits oraux dès 1837.', 'Difficile', 'NS1'),
('LH4-37', NULL, 'Qui est l''auteur de Pétion et Haïti, en cinq volumes ?', '["Joseph Saint-Rémy", "Thomas Madiou", "Beaubrun Ardouin", "Hannibal Price"]', 'Joseph Saint-Rémy', 'Il meurt en 1858 sans avoir terminé l''ouvrage.', 'Moyen', 'NS1'),
('LH4-38', NULL, 'Dans quelle île est né Joseph Saint-Rémy ?', '["La Guadeloupe", "La Martinique", "Cuba", "La Jamaïque"]', 'La Guadeloupe', 'Ses parents, de descendance africaine, viennent s''établir en Haïti.', 'Moyen', 'NS1'),
('LH4-39', NULL, 'Quel ouvrage de Saint-Rémy (1851) publie les mémoires de Boisrond-Tonnerre ?', '["Mémoires pour servir à l''histoire d''Haïti", "Vie de Toussaint-L''Ouverture", "Essai sur Henri-Christophe", "Pétion et Haïti"]', 'Mémoires pour servir à l''histoire d''Haïti', 'Saint-Rémy y ajoute une préface et une étude critique.', 'Difficile', 'NS1'),
('LH4-40', NULL, 'Quel héros Saint-Rémy critique-t-il dans son premier livre, publié en 1839 ?', '["Henri Christophe", "Jean-Jacques Dessalines", "Alexandre Pétion", "Jean-Pierre Boyer"]', 'Henri Christophe', 'L''Essai sur Henri-Christophe, général haïtien, paraît à Paris.', 'Difficile', 'NS1'),
('LH4-41', NULL, 'Quel ouvrage de Saint-Rémy, publié en 1850, retrace la vie d''un héros de la Révolution ?', '["Vie de Toussaint-L''Ouverture", "Essai sur Henri-Christophe", "Pétion et Haïti", "Études sur l''histoire d''Haïti"]', 'Vie de Toussaint-L''Ouverture', 'Il publie aussi en 1853 les Mémoires du général Toussaint-Louverture.', 'Difficile', 'NS1'),
('LH4-42', NULL, 'De quelle origine sont les premiers historiens haïtiens, selon Hoffmann ?', '["Descendants de gens de couleur", "Anciens esclaves", "Colons français", "Immigrés africains"]', 'Descendants de gens de couleur', 'Ils expriment et influencent l''idéologie de la classe dirigeante mulâtre.', 'Moyen', 'NS1'),
('LH4-45', NULL, 'Quel historien noir juge sévèrement les idoles de Madiou, d''Ardouin et de Saint-Rémy dans Les Constitutions d''Haïti (1886) ?', '["Louis-Joseph Janvier", "Hannibal Price", "Frédéric Marcelin", "Duraciné Vaval"]', 'Louis-Joseph Janvier', 'Il défend Toussaint Louverture, Dessalines et Christophe.', 'Difficile', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 23 AND titre = 'L''École de 1836 : histoire et roman';
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
