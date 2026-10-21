-- Import du chapitre Littérature haïtienne « L'École de 1836 : contexte et poètes » (NS1) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('LH3-01', NULL, 'Ensemble des mouvements nés à la fin du XVIIIe siècle, qui font prévaloir le sentiment sur la raison et l''imagination sur l''analyse critique ?', '["Le romantisme", "Le classicisme", "Le réalisme", "Le symbolisme"]', 'Le romantisme', 'Hoffmann distingue en Haïti un romantisme sentimental (Lamartine) et un romantisme frénétique (Edmond Laforest).', 'Moyen', 'NS1'),
('LH3-02', NULL, 'Successeur d''un écrivain, disciple sans originalité ?', '["Un épigone", "Un précurseur", "Un mécène", "Un exégète"]', 'Un épigone', 'Hoffmann juge que les poèmes d''Ignace Nau ne se distinguent guère de ceux des autres épigones de Lamartine.', 'Moyen', 'NS1'),
('LH3-03', NULL, 'Attitude qui impose à la langue une norme idéale, interdisant toute évolution et tout emprunt ?', '["Le purisme", "Le réalisme", "Le lyrisme", "L''humanisme"]', 'Le purisme', 'Le purisme des écrivains haïtiens du XIXe siècle les poussait à écarter toute trace de créole et de régionalisme.', 'Moyen', 'NS1'),
('LH3-04', NULL, 'Mot ou tournure propres à une région ?', '["Un régionalisme", "Un néologisme", "Un archaïsme", "Un barbarisme"]', 'Un régionalisme', 'Émile Nau recommande d''adapter le français aux besoins et aux localités haïtiennes.', 'Moyen', 'NS1'),
('LH3-05', NULL, 'Petit poème lyrique sur un sujet tendre et triste ?', '["Une élégie", "Une épopée", "Une ode", "Une satire"]', 'Une élégie', 'Le Lac, d''Ignace Nau, imite l''élégie de Lamartine qui porte le même titre.', 'Moyen', 'NS1'),
('LH3-06', NULL, 'Pièce de poésie de quatorze vers, composée de deux quatrains et de deux tercets ?', '["Un sonnet", "Un madrigal", "Un rondeau", "Un distique"]', 'Un sonnet', 'Charles Séguy Villevaleix ouvre ses Primevères (1866) par un « Sonnet-Préface » où il se compare à Hugo et à Lamartine.', 'Moyen', 'NS1'),
('LH3-07', NULL, 'Être malfaisant qui, selon certaines croyances, se métamorphosait en loup la nuit ?', '["Un loup-garou", "Un houngan", "Un zombi", "Un revenant"]', 'Un loup-garou', 'Un loup-garou menace l''enfant de l''héroïne dans Un épisode de la Révolution, nouvelle d''Ignace Nau.', 'Moyen', 'NS1'),
('LH3-08', NULL, 'Qui est capable d''anticipation, qui a l''intuition de l''avenir ?', '["Visionnaire", "Utopique", "Éclectique", "Subversif"]', 'Visionnaire', 'Hoffmann juge qu''Ignace Nau était un visionnaire : il a appliqué des principes proclamés près d''un siècle plus tard.', 'Moyen', 'NS1'),
('LH3-09', NULL, 'Quel journal dirigé par Ignace Nau est devenu plus tard L''Union ?', '["Le Républicain", "L''Abeille haytienne", "La Ronde", "Le Télégraphe"]', 'Le Républicain', 'Émile Nau y publie en 1836-1837 une série d''articles sur la littérature.', 'Facile', 'NS1'),
('LH3-10', NULL, 'Quel frère d''Ignace Nau, journaliste et historien, appelle à une révolution dans les lettres haïtiennes ?', '["Émile Nau", "Beaubrun Ardouin", "Thomas Madiou", "Hérard Dumesle"]', 'Émile Nau', 'Il est le premier à mettre en question le désir d''assimilation des hommes de lettres haïtiens à ceux de France.', 'Moyen', 'NS1'),
('LH3-11', NULL, 'Quelle ambition Émile Nau assigne-t-il à la littérature haïtienne en 1836 ?', '["Devenir une littérature nationale", "Imiter les classiques français", "Se limiter à la poésie", "Écrire uniquement en latin"]', 'Devenir une littérature nationale', 'Il veut que les poèmes expriment les croyances et les sentiments de l''époque et du pays des poètes.', 'Moyen', 'NS1'),
('LH3-12', NULL, 'Quel ouvrage d''Émile Nau (1855) a inspiré toute une littérature à la gloire des premiers habitants de l''île ?', '["Histoire des caciques d''Haïti", "Histoire d''Haïti", "Études sur l''histoire d''Haïti", "Haïti et ses problèmes"]', 'Histoire des caciques d''Haïti', 'Les premiers habitants de Saint-Domingue sont les Taïnos, dirigés par des caciques.', 'Difficile', 'NS1'),
('LH3-13', NULL, 'Quel titre l''empereur Faustin Ier accorde-t-il à Émile Nau ?', '["Baron", "Comte", "Duc", "Marquis"]', 'Baron', 'Émile Nau (1812-1860) fonde aussi, deux ans avant sa mort, le journal La République.', 'Moyen', 'NS1'),
('LH3-14', NULL, 'Quelle revue française des anti-esclavagistes publie des poèmes d''Ignace Nau ?', '["La Revue des colonies", "La Revue indigène", "La Revue de Paris", "La Revue des Deux Mondes"]', 'La Revue des colonies', 'Ignace Nau s''y rend après la mort de sa femme ; il y publie « À ma patrie » et « Le Lac ».', 'Difficile', 'NS1'),
('LH3-15', NULL, 'Selon Hoffmann, quel écrivain est le premier Haïtien à avoir publié des œuvres d''imagination en prose ?', '["Ignace Nau", "Émeric Bergeaud", "Demesvar Delorme", "Coriolan Ardouin"]', 'Ignace Nau', 'Ses trois nouvelles datent de 1836 ; elles ne seront jamais publiées en volume.', 'Moyen', 'NS1'),
('LH3-16', NULL, 'Quelle nouvelle d''Ignace Nau met en scène le sorcier africain Halaou ?', '["Le Lambi", "Isalina", "Un épisode de la Révolution", "Le Lac"]', 'Le Lambi', 'Halaou fut un redoutable chef de bande pendant la lutte pour l''Indépendance.', 'Moyen', 'NS1'),
('LH3-17', NULL, 'Quelle nouvelle d''Ignace Nau raconte comment deux hommes font appel à des houngans pour gagner un amour ?', '["Isalina, ou une scène créole", "Le Lambi", "Un épisode de la Révolution", "À ma patrie"]', 'Isalina, ou une scène créole', 'Le préféré de la jeune fille, aidé par un bon houngan, triomphe du prétendant envieux.', 'Moyen', 'NS1'),
('LH3-18', NULL, 'Quelle nouvelle d''Ignace Nau est à la fois un court roman historique et un conte fantastique ?', '["Un épisode de la Révolution", "Isalina", "Le Lambi", "Le Lac"]', 'Un épisode de la Révolution', 'Un loup-garou y menace l''enfant d''une femme de lieutenant de l''armée indigène.', 'Moyen', 'NS1'),
('LH3-19', NULL, 'Quel poème d''Ignace Nau, daté des Basses-Pyrénées en 1836, chante la nostalgie du pays natal ?', '["À ma patrie", "À un ami", "Moi-même", "Le Passager"]', 'À ma patrie', 'Le poème ne mentionne jamais le nom de la patrie ; seule la dernière strophe laisse deviner les tropiques.', 'Difficile', 'NS1'),
('LH3-20', NULL, 'Quel poème d''Ignace Nau imite une célèbre méditation de Lamartine ?', '["Le Lac", "Isalina", "À ma patrie", "Moi-même"]', 'Le Lac', 'La bien-aimée y apparaît, comme Elvire, accoudée à un rocher.', 'Moyen', 'NS1'),
('LH3-21', NULL, 'Quel recueil de Lamartine (1820) compte parmi les premiers livres français arrivés dans l''Haïti indépendante ?', '["Les Méditations", "Les Contemplations", "Les Orientales", "Les Châtiments"]', 'Les Méditations', 'Il obtient en Haïti autant sinon plus de succès qu''en France lors de sa parution.', 'Moyen', 'NS1'),
('LH3-22', NULL, 'Quel critique haïtien souligne dès 1855 l''originalité d''Ignace Nau dans ses Miscellanées ?', '["Liautaud Ethéart", "Edgar La Selve", "Duraciné Vaval", "Ghislain Gouraige"]', 'Liautaud Ethéart', 'Il note que, pour comprendre ses contes, le lecteur français doit recourir à un « dictionnaire d''Ignace Nau ».', 'Difficile', 'NS1'),
('LH3-23', NULL, 'Quels mots du terroir Ignace Nau emploie-t-il pour désigner un magicien et une misérable petite maison ?', '["Caplata et counouque", "Houngan et ajoupa", "Bòkò et kay", "Zombi et lakou"]', 'Caplata et counouque', 'Liautaud Ethéart relève qu''il « appelle chaque chose par son nom ».', 'Moyen', 'NS1'),
('LH3-24', NULL, 'Quel principe Ignace Nau applique-t-il en situant l''action de ses nouvelles ?', '["La campagne et ses paysans", "Les salons de Paris", "La cour du roi", "Les ports de commerce"]', 'La campagne et ses paysans', 'Il puise aussi dans l''histoire d''Haïti et se penche sur le vaudou, présenté comme croyance populaire.', 'Moyen', 'NS1'),
('LH3-25', NULL, 'Quel poète haïtien est l''auteur du poème « Moi-même », publié par la Revue des colonies en juillet 1836 ?', '["Coriolan Ardouin", "Ignace Nau", "Pierre Faubert", "Charles Séguy Villevaleix"]', 'Coriolan Ardouin', 'Il se dit « déjà trop vieux » à vingt et un ans à peine.', 'Moyen', 'NS1'),
('LH3-26', NULL, 'Quel poème posthume de Coriolan Ardouin montre l''influence de Lamartine ?', '["À un ami", "Moi-même", "Le Lac", "À ma patrie"]', 'À un ami', 'Hoffmann note que cette influence se manifeste pratiquement jusqu''à nos jours.', 'Moyen', 'NS1'),
('LH3-27', NULL, 'Quels thèmes universels dominent le poème « Moi-même » de Coriolan Ardouin ?', '["La mort et l''existence humaine", "La guerre d''Indépendance", "Les paysages haïtiens", "Le vaudou"]', 'La mort et l''existence humaine', 'Hoffmann cite Ardouin parmi les poètes qui évitent toute référence à Haïti.', 'Moyen', 'NS1'),
('LH3-28', NULL, 'Quel poète français est le modèle de nombreux poètes haïtiens avec Hugo, Musset et Béranger ?', '["Lamartine", "Rimbaud", "Apollinaire", "Ronsard"]', 'Lamartine', 'Lamartine, Hugo, Musset et Béranger sont les poètes contemporains français les plus admirés en Haïti.', 'Facile', 'NS1'),
('LH3-29', NULL, 'Quel poète haïtien déclare en 1846 que Lamartine et Hugo sont des « dieux immortels » ?', '["Jean-Baptiste Chenêt", "Pierre Faubert", "Liautaud Ethéart", "Charles Séguy Villevaleix"]', 'Jean-Baptiste Chenêt', 'Il publie ses Études poétiques ; il affirme aussi que Dieu parlerait français.', 'Moyen', 'NS1'),
('LH3-30', NULL, 'Quel recueil de Charles Séguy Villevaleix (1866) s''ouvre par un « Sonnet-Préface » ?', '["Primevères", "Feuilles au vent", "Fleurs et pleurs", "Les Bluettes"]', 'Primevères', 'Il s''y compare modestement à Hugo, « sombre torrent », et à Lamartine, « doux lac ».', 'Difficile', 'NS1'),
('LH3-31', NULL, 'Quel poète haïtien chante en 1856 le teint de neige de Céline dans « Le Souvenir » ?', '["Pierre Faubert", "Ignace Nau", "Coriolan Ardouin", "Tertullien Guilbaud"]', 'Pierre Faubert', 'Hoffmann y voit l''exemple de la « muse nordique » : la femme aimée est déguisée en beauté blanche.', 'Difficile', 'NS1'),
('LH3-32', NULL, 'Que représente la « muse nordique » chez certains poètes haïtiens ?', '["Une femme aimée déguisée en blanche", "Une paysanne du Nord", "La muse du roi Henry", "Une déesse africaine"]', 'Une femme aimée déguisée en blanche', 'Mulâtresse ou noire, la femme ne correspondait pas au canon esthétique européen.', 'Moyen', 'NS1'),
('LH3-33', NULL, 'Que visent surtout les poètes haïtiens du XIXe siècle quant à la langue française ?', '["La pureté de la langue", "Le mélange avec le créole", "L''invention de mots", "La simplicité populaire"]', 'La pureté de la langue', 'Leur attitude envers la langue officielle frôle parfois le fétichisme.', 'Moyen', 'NS1');

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
