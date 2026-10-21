-- Import du chapitre Littérature haïtienne « Les débuts de la littérature haïtienne (1804-1836) » (NS1) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('LH2-01', NULL, 'Personne qui, par son action, a préparé les voies à un mouvement ?', '["Un précurseur", "Un disciple", "Un mécène", "Un censeur"]', 'Un précurseur', 'Hoffmann intitule « Les précurseurs » le chapitre sur les écrivains de 1804 à 1830.', 'Moyen', 'NS1'),
('LH2-02', NULL, 'Débat vif, agressif, le plus souvent par écrit ?', '["Une polémique", "Une dédicace", "Une préface", "Une anthologie"]', 'Une polémique', 'Au lendemain de l''indépendance, les premiers écrits haïtiens sont surtout des textes politiques ou polémiques.', 'Moyen', 'NS1'),
('LH2-03', NULL, 'Critique amère et violente, qui prend la forme d''un pamphlet ?', '["Une diatribe", "Une apologie", "Une épître", "Une élégie"]', 'Une diatribe', 'On trouve dans les premiers périodiques haïtiens des diatribes contre Bonaparte, puis contre les anciens colons.', 'Moyen', 'NS1'),
('LH2-04', NULL, 'Très élogieux, d''un enthousiasme emphatique et outré ?', '["Dithyrambique", "Laconique", "Lugubre", "Pathétique"]', 'Dithyrambique', 'Hoffmann parle d''éloges dithyrambiques des héros tombés et des chefs d''État.', 'Moyen', 'NS1'),
('LH2-05', NULL, 'Poème lyrique en strophes semblables, destiné à célébrer de grands événements ou de hauts personnages ?', '["Une ode", "Une fable", "Une épigramme", "Une élégie"]', 'Une ode', 'Une Ode à l''Indépendance (1824), d''Eugène Séguy Villevaleix, célèbre aussi le président Boyer.', 'Moyen', 'NS1'),
('LH2-06', NULL, 'Composition à une ou plusieurs voix, avec accompagnement ?', '["Une cantate", "Une ballade", "Une sonate", "Une ode"]', 'Une cantate', 'Liautaud Ethéart cite une Cantate pour le jour de la Saint-Pierre parmi les vers de circonstance.', 'Moyen', 'NS1'),
('LH2-07', NULL, 'Petite pièce en vers exprimant une pensée fine, tendre ou galante ?', '["Un madrigal", "Un sonnet", "Un hymne", "Une épitaphe"]', 'Un madrigal', 'Milscent publie un Madrigal à Céleste dans L''Abeille haytienne en septembre 1817.', 'Moyen', 'NS1'),
('LH2-08', NULL, 'Petit poème chantant l''amour dans un décor pastoral ?', '["Une idylle", "Une épopée", "Une ode", "Une satire"]', 'Une idylle', 'François Romain Lhérisson écrit une Épître en 1819 où il évoque l''idylle des poètes français à la mode.', 'Moyen', 'NS1'),
('LH2-09', NULL, 'Récit allégorique d''où l''on tire une moralité ?', '["Une fable", "Une chronique", "Une épopée", "Une légende"]', 'Une fable', 'Milscent a publié dans L''Abeille haytienne des fables comme Le Rossignol et l''hirondelle.', 'Moyen', 'NS1'),
('LH2-10', NULL, 'Brève formule qui caractérise la valeur symbolique d''une chose ?', '["Une devise", "Une légende", "Une épigraphe", "Une citation"]', 'Une devise', 'La première revue littéraire du pays avait pour devise : « L''épée et les talents doivent n''avoir qu''un but ».', 'Moyen', 'NS1'),
('LH2-11', NULL, 'Pièce de théâtre destinée à faire rire par la peinture satirique des mœurs ?', '["Une comédie", "Une tragédie", "Un drame", "Une cantate"]', 'Une comédie', 'L''Haïtien expatrié (1804) est une comédie en trois actes.', 'Facile', 'NS1'),
('LH2-12', NULL, 'Quel type de textes domine les premiers écrits haïtiens après l''indépendance ?', '["Des textes politiques et polémiques", "Des romans d''amour", "Des traités de médecine", "Des recueils de contes"]', 'Des textes politiques et polémiques', 'Odes à la liberté, discours à la gloire des chefs, diatribes contre Bonaparte : la plume est l''auxiliaire de l''épée.', 'Moyen', 'NS1'),
('LH2-14', NULL, 'Qui est le rédacteur en chef de L''Abeille haytienne ?', '["Jules Solime Milscent", "Juste Chanlatte", "Hérard Dumesle", "Julien Prévost"]', 'Jules Solime Milscent', 'Il y publie aussi des fables, des madrigaux et des couplets patriotiques.', 'Moyen', 'NS1'),
('LH2-15', NULL, 'Quel secrétaire de Dessalines a rédigé la proclamation de 1804 sur les Français restés dans l''île ?', '["Boisrond-Tonnerre", "Baron de Vastey", "Juste Chanlatte", "Antoine Dupré"]', 'Boisrond-Tonnerre', 'On lui attribue aussi la rédaction de l''Acte de l''indépendance.', 'Moyen', 'NS1'),
('LH2-16', NULL, 'Qui a écrit en 1816 la Réfutation d''un écrit de Charrault, ex-colon ?', '["Philémon Charlemagne", "Baron de Vastey", "Julien Prévost", "Hérard Dumesle"]', 'Philémon Charlemagne', 'Sur le mode sarcastique, il décrit comment les Haïtiens anéantiraient une nouvelle expédition française.', 'Difficile', 'NS1'),
('LH2-17', NULL, 'Qui a écrit la Relation des glorieux événements qui ont porté leurs majestés royales sur le trône d''Hayti (1814) ?', '["Julien Prévost", "Juste Chanlatte", "Boisrond-Tonnerre", "Milscent"]', 'Julien Prévost', 'Ce texte louangeur célèbre le roi Henry Christophe, comme les classiques français encensaient le Roi Soleil.', 'Difficile', 'NS1'),
('LH2-18', NULL, 'Qui a écrit l''Ode sur la prise du Môle Saint-Nicolas ?', '["Julien Prévost", "Antoine Dupré", "Hérard Dumesle", "Isaac Louverture"]', 'Julien Prévost', 'L''ode célèbre une victoire des troupes du roi Henry sur un régiment révolté.', 'Difficile', 'NS1'),
('LH2-19', NULL, 'Quelle œuvre de Chanlatte (1810) répond aux esclavagistes qui voyaient la déportation comme un bienfait ?', '["Le Cri de la nature", "Le Système colonial dévoilé", "L''Haïtien expatrié", "Le Passager"]', 'Le Cri de la nature', 'On y sent l''influence de Jean-Jacques Rousseau.', 'Moyen', 'NS1'),
('LH2-20', NULL, 'Quel titre le roi Henry accorde-t-il à Juste Chanlatte ?', '["Comte de Rosiers", "Baron de Vastey", "Duc de Marmelade", "Comte de Limonade"]', 'Comte de Rosiers', 'Chanlatte servit Dessalines, le roi Henry puis Boyer, ce qui lui vaut une réputation de courtisan.', 'Difficile', 'NS1'),
('LH2-21', NULL, 'Quelle pièce de circonstance de Chanlatte, jouée en 1818, contient un dialogue en créole ?', '["L''Entrée du roi en sa capitale", "Le Prix de la vertu", "La Jeune Fille", "Le Philosophe physicien"]', 'L''Entrée du roi en sa capitale', 'C''est l''un des rares textes en créole de l''époque qui nous soient parvenus.', 'Difficile', 'NS1'),
('LH2-22', NULL, 'Quel poème Chanlatte compose-t-il en 1814 pour le couronnement du roi Henry ?', '["Chant inaugural", "Chant du départ", "Chant patriotique", "Chant royal"]', 'Chant inaugural', 'Il y affirme que les Haïtiens ont éclipsé la gloire des héros grecs et romains.', 'Difficile', 'NS1'),
('LH2-23', NULL, 'Qui est le plus prolixe et le plus intéressant des premiers écrivains politiques haïtiens ?', '["Baron de Vastey", "Boisrond-Tonnerre", "Antoine Dupré", "Hérard Dumesle"]', 'Baron de Vastey', 'Né au Cap-Français, il sert Dessalines puis Henry Christophe, et disparaît en 1820.', 'Facile', 'NS1'),
('LH2-24', NULL, 'Quel ouvrage de 1814 de Vastey dénonce le système colonial ?', '["Le Système colonial dévoilé", "Le Cri de la nature", "Notes à Malouet", "Ainsi parla l''Oncle"]', 'Le Système colonial dévoilé', 'Il est publié au Cap-Henry, à l''Imprimerie du roi.', 'Facile', 'NS1'),
('LH2-25', NULL, 'Quelle fonction Vastey occupe-t-il auprès des enfants d''Henry Christophe ?', '["Tuteur", "Médecin", "Imprimeur", "Précepteur militaire"]', 'Tuteur', 'Il est aussi secrétaire particulier du roi et fait baron lorsque son maître monte sur le trône.', 'Moyen', 'NS1'),
('LH2-26', NULL, 'Quel ouvrage de Vastey ridiculise les préjugés des Blancs et revendique la beauté noire ?', '["Réflexions sur une lettre de Mazères", "Le Système colonial dévoilé", "Le Cri de la nature", "Essai sur les causes"]', 'Réflexions sur une lettre de Mazères', 'Il y écrit que les Haïtiens peignent les anges en noir et les diables en blanc.', 'Moyen', 'NS1'),
('LH2-27', NULL, 'Qui a écrit en 1819 l''Essai sur les causes de la révolution et des guerres civiles d''Hayti ?', '["Baron de Vastey", "Hérard Dumesle", "Juste Chanlatte", "Thomas Madiou"]', 'Baron de Vastey', 'Il veut innocenter Christophe et en rejeter la responsabilité sur Pétion et Boyer.', 'Difficile', 'NS1'),
('LH2-28', NULL, 'Quelle comédie imprimée aux Cayes en 1804 raconte l''exil de deux Haïtiens à Saint-Thomas ?', '["L''Haïtien expatrié", "La Jeune Fille", "Le Philosophe physicien", "Le Prix de la vertu"]', 'L''Haïtien expatrié', 'Alix et Lindor, persécutés par les Blancs, rentrent au pays après la paix : seul leur pays les protège.', 'Moyen', 'NS1'),
('LH2-29', NULL, 'Qui est l''auteur de L''Haïtien expatrié (1804) ?', '["Pierre Flignaud", "Antoine Dupré", "Juste Chanlatte", "Hérard Dumesle"]', 'Pierre Flignaud', 'C''est l''une des rares pièces haïtiennes de l''époque à avoir été publiées. Larousse écrit « Fligneau ».', 'Difficile', 'NS1'),
('LH2-30', NULL, 'Quelle comédie de mœurs de Dupré satirise les mères haïtiennes qui cherchent des beaux-fils blancs ?', '["La Jeune Fille", "La Mort du général Lamarre", "L''Haïtien expatrié", "Le Prix de la vertu"]', 'La Jeune Fille', 'Aucune pièce de Dupré n''a été imprimée ; on les connaît par l''article de Saint-Rémy (1837).', 'Moyen', 'NS1'),
('LH2-31', NULL, 'Quel drame historique est attribué à Antoine Dupré ?', '["La Mort du général Lamarre", "La Jeune Fille", "Ogé ou le préjugé de couleur", "Le Philosophe physicien"]', 'La Mort du général Lamarre', 'Ogé ou le préjugé de couleur est de Pierre Faubert (représenté en 1844).', 'Moyen', 'NS1'),
('LH2-32', NULL, 'Où le théâtre haïtien des origines puise-t-il son inspiration pour le drame ?', '["Dans l''histoire nationale", "Dans la mythologie grecque", "Dans la Bible", "Dans les contes africains"]', 'Dans l''histoire nationale', 'Pour la comédie, il puise dans les mœurs locales.', 'Moyen', 'NS1'),
('LH2-33', NULL, 'Selon Edgar La Selve, à quelle école les premiers poètes haïtiens se rattachent-ils ?', '["L''école pseudo-classique", "L''école romantique", "L''école parnassienne", "L''école symboliste"]', 'L''école pseudo-classique', 'Ils imitent les modèles du Directoire et de l''Empire, jusqu''à la prosodie.', 'Moyen', 'NS1'),
('LH2-34', NULL, 'Selon Liautaud Ethéart (1855), quelle forme les Haïtiens jugent-ils seule digne de la pensée ?', '["Les vers", "La prose", "Le dialogue", "La chanson"]', 'Les vers', 'Il écrit : « tout n''est que vers » dans les Miscellanées.', 'Difficile', 'NS1'),
('LH2-35', NULL, 'Que dit Antoine Métral, en 1819, de l''éloquence des Haïtiens ?', '["Elle est mâle et originale", "Elle est pâle et lente", "Elle est froide et savante", "Elle est molle et vague"]', 'Elle est mâle et originale', 'Il juge au contraire leur poésie comme une pâle imitation de la poésie française.', 'Difficile', 'NS1'),
('LH2-36', NULL, 'Quel poète ose placer un gouyavier dans un poème de 1819 ?', '["Hérard Dumesle", "Milscent", "Juste Chanlatte", "Isaac Louverture"]', 'Hérard Dumesle', 'C''est peut-être la première apparition de la réalité tropicale dans la poésie haïtienne (« Fête champêtre »).', 'Difficile', 'NS1'),
('LH2-37', NULL, 'Qui a écrit Voyage dans le nord d''Hayti (1824) ?', '["Hérard Dumesle", "Thomas Madiou", "Juste Chanlatte", "Baron de Vastey"]', 'Hérard Dumesle', 'Récit de voyage entrecoupé d''alexandrins, publié aux Cayes ; il fonde aussi le journal L''Observateur.', 'Difficile', 'NS1'),
('LH2-38', NULL, 'Quel fils de Toussaint Louverture est l''auteur du poème Le Passager ?', '["Isaac Louverture", "Hérard Dumesle", "Julien Prévost", "Jules Solime Milscent"]', 'Isaac Louverture', 'Le poème chante la nostalgie du pays natal, dans une grande abstraction.', 'Difficile', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 23 AND titre = 'Les débuts de la littérature haïtienne (1804-1836)';
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
