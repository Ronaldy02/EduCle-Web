-- Import du chapitre Français « La phrase : types, formes et ponctuation » (NS1) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('F02-01', NULL, 'Unité grammaticale formée de mots ordonnés, qui exprime un énoncé complet ?', '["La phrase", "Le mot", "Le groupe nominal", "Le paragraphe"]', 'La phrase', 'À l''écrit, elle commence par une majuscule et se termine par un point (ou un signe équivalent).', 'Facile', 'NS1'),
('F02-02', NULL, 'Unité syntaxique élémentaire construite autour d''un verbe ?', '["Une proposition", "Un groupe nominal", "Une locution", "Un paragraphe"]', 'Une proposition', 'La réunion de propositions, par coordination ou subordination, forme la phrase.', 'Moyen', 'NS1'),
('F02-03', NULL, 'Combien de propositions contient une phrase simple ?', '["Une seule", "Deux", "Trois", "Aucune"]', 'Une seule', 'Une phrase simple se confond avec une proposition indépendante : « Le chien aboie ».', 'Facile', 'NS1'),
('F02-04', NULL, 'Quelles sont les deux parties essentielles d''une phrase simple ?', '["Groupe sujet et groupe verbal", "Nom et adjectif", "Article et nom", "Verbe et adverbe"]', 'Groupe sujet et groupe verbal', 'Dans « Le chien aboie », « Le chien » est le groupe sujet et « aboie » le groupe verbal.', 'Moyen', 'NS1'),
('Q0199', 'Dans « Marie lit un roman passionnant », quel est le groupe verbal ?', 'Dans « Marie lit un roman passionnant », quel est le groupe verbal ?', '["« lit un roman passionnant »", "« Marie lit »", "« un roman passionnant »", "« lit »"]', '« lit un roman passionnant »', 'Le groupe verbal comprend le verbe et ses compléments. « Marie » est le groupe sujet ; « lit un roman passionnant » est le groupe verbal.', 'Moyen', 'NS1'),
('F02-06', NULL, 'Quel est l''ordre habituel des éléments dans une phrase déclarative ?', '["Sujet, verbe, complément", "Verbe, sujet, complément", "Complément, sujet, verbe", "Sujet, complément, verbe"]', 'Sujet, verbe, complément', 'Exemple : « Les élèves (sujet) lisent (verbe) un roman (complément) ».', 'Moyen', 'NS1'),
('F02-11', NULL, 'Quels sont les quatre types de phrases ?', '["Déclaratif, interrogatif, impératif, exclamatif", "Déclaratif, descriptif, impératif, exclamatif", "Affirmatif, négatif, interrogatif, impératif", "Simple, complexe, nominal, verbal"]', 'Déclaratif, interrogatif, impératif, exclamatif', 'Le type dépend de l''intention de celui qui parle : informer, questionner, ordonner ou exprimer une émotion.', 'Facile', 'NS1'),
('F02-12', NULL, 'Type de phrase qui énonce un fait ou une vérité ?', '["La phrase déclarative", "La phrase interrogative", "La phrase exclamative", "La phrase impérative"]', 'La phrase déclarative', 'On l''appelle aussi phrase assertive. Elle se termine en général par un point.', 'Facile', 'NS1'),
('F02-13', NULL, 'Type de phrase qui pose une question ?', '["La phrase interrogative", "La phrase déclarative", "La phrase impérative", "La phrase exclamative"]', 'La phrase interrogative', 'Elle se termine par un point d''interrogation à l''écrit.', 'Facile', 'NS1'),
('F02-14', NULL, 'Type de phrase qui énonce un ordre ou une défense ?', '["La phrase impérative", "La phrase interrogative", "La phrase exclamative", "La phrase déclarative"]', 'La phrase impérative', 'Exemples : « Sors. », « Ne touchez pas ! ». On dit aussi phrase injonctive.', 'Facile', 'NS1'),
('F02-15', NULL, 'Type de phrase qui exprime une émotion vive ou un jugement affectif ?', '["La phrase exclamative", "La phrase déclarative", "La phrase impérative", "La phrase interrogative"]', 'La phrase exclamative', 'Elle se termine par un point d''exclamation : « Quel beau match ! ».', 'Facile', 'NS1'),
('Q0198', 'La phrase "Les enfants jouent dans la cour" est de type :', 'Quel est le type de la phrase « Les enfants jouent dans la cour » ?', '["Déclarative affirmative", "Interrogative", "Exclamative", "Impérative"]', 'Déclarative affirmative', 'La phrase « Les enfants jouent dans la cour » énonce un fait et ne contient pas de négation : elle est déclarative et affirmative.', 'Facile', 'NS1'),
('F02-17', NULL, 'Quel type de phrase est « Ferme la porte. » ?', '["Impérative", "Déclarative", "Interrogative", "Exclamative"]', 'Impérative', 'Le verbe est à l''impératif, sans pronom sujet, et exprime un ordre.', 'Facile', 'NS1'),
('F02-18', NULL, 'Quelle particularité présente le verbe d''une phrase impérative ?', '["Il s''emploie sans pronom sujet", "Il s''emploie toujours au pluriel", "Il se met à l''infinitif", "Il s''emploie sans complément"]', 'Il s''emploie sans pronom sujet', 'On dit « Viens ! » et non « Tu viens ! » : le sujet n''est pas exprimé.', 'Moyen', 'NS1'),
('F02-19', NULL, 'Par quels procédés peut-on marquer l''interrogation ?', '["L''intonation, l''inversion, « est-ce que »", "La majuscule, le tiret, les guillemets", "Le futur, le passé, le subjonctif", "L''adverbe, le nom, le pronom"]', 'L''intonation, l''inversion, « est-ce que »', 'Exemples : « Tu viens ? » ; « Viens-tu ? » ; « Est-ce que tu viens ? ».', 'Moyen', 'NS1'),
('F02-20', NULL, 'Lequel de ces mots est un mot interrogatif ?', '["« pourquoi »", "« parce que »", "« puisque »", "« pourtant »"]', '« pourquoi »', '« Pourquoi » introduit une question ; « parce que » introduit la réponse.', 'Moyen', 'NS1'),
('F02-21', NULL, 'Comment appelle-t-on la question à laquelle on répond par « oui » ou par « non » ?', '["L''interrogation totale", "L''interrogation partielle", "L''interrogation oratoire", "L''interrogation indirecte"]', 'L''interrogation totale', 'Exemple : « Viens-tu demain ? ». L''interrogation partielle porte sur un élément et commence par un mot interrogatif : « Quand viens-tu ? ».', 'Moyen', 'NS1'),
('F02-22', NULL, 'Comment appelle-t-on la question qui porte sur un seul élément et commence par un mot interrogatif ?', '["L''interrogation partielle", "L''interrogation totale", "L''interrogation oratoire", "L''interrogation indirecte"]', 'L''interrogation partielle', 'Exemples : « Où habites-tu ? », « Pourquoi pleures-tu ? ». On n''y répond pas par « oui » ou « non ».', 'Moyen', 'NS1'),
('F02-31', NULL, 'Forme de phrase qui présente un fait comme vrai ou possible ?', '["La forme affirmative", "La forme négative", "La forme emphatique", "La forme passive"]', 'La forme affirmative', 'Exemple : « Il mange ». Sa forme contraire est la forme négative.', 'Facile', 'NS1'),
('F02-32', NULL, 'Forme de phrase qui exprime qu''un fait n''est pas vrai ?', '["La forme négative", "La forme affirmative", "La forme emphatique", "La forme passive"]', 'La forme négative', 'Exemple : « Il ne mange pas ». Elle s''oppose à la forme affirmative.', 'Facile', 'NS1'),
('F02-33', NULL, 'Dans « Il ne mange pas », quels mots marquent la négation ?', '["ne et pas", "Il et mange", "ne et mange", "Il et pas"]', 'ne et pas', 'La négation encadre le verbe : « ne » devant, « pas » derrière. À l''oral, « ne » disparaît souvent.', 'Facile', 'NS1'),
('F02-34', NULL, 'Mise en relief d''un élément de la phrase par l''intonation ou l''ordre des mots ?', '["L''emphase", "L''ellipse", "L''inversion", "La négation"]', 'L''emphase', 'Elle donne plus de force à une idée : « C''est Marie qui a gagné ».', 'Moyen', 'NS1'),
('F02-35', NULL, 'Laquelle de ces phrases est à la forme emphatique ?', '["« C''est lui qui gagne. »", "« Il gagne. »", "« Gagne-t-il ? »", "« Il ne gagne pas. »"]', '« C''est lui qui gagne. »', 'La construction « c''est… qui » met « lui » en relief.', 'Moyen', 'NS1'),
('F02-41', NULL, 'Comment appelle-t-on une phrase organisée autour d''un verbe conjugué ?', '["Une phrase verbale", "Une phrase nominale", "Une phrase interrogative", "Une phrase impérative"]', 'Une phrase verbale', 'Exemple : « Le soleil brille ». La majorité des phrases sont verbales.', 'Moyen', 'NS1'),
('F02-42', NULL, 'Comment appelle-t-on une phrase sans verbe conjugué, comme « Quel beau temps ! » ?', '["Une phrase nominale", "Une phrase verbale", "Une phrase complexe", "Une phrase passive"]', 'Une phrase nominale', 'Elle est construite autour d''un nom : « Silence dans la salle ! », « Beau temps aujourd''hui ».', 'Moyen', 'NS1'),
('F02-43', NULL, 'Laquelle de ces phrases est une phrase nominale ?', '["« Quel beau paysage ! »", "« Il pleut ce matin. »", "« Le soleil brille. »", "« Elle chante bien. »"]', '« Quel beau paysage ! »', 'Les trois autres contiennent un verbe conjugué : pleut, brille, chante.', 'Moyen', 'NS1'),
('F02-51', NULL, 'Système de signes graphiques qui marque les pauses entre les phrases ou les éléments de phrase ?', '["La ponctuation", "La grammaire", "L''orthographe", "La conjugaison"]', 'La ponctuation', 'Elle traduit aussi certains rapports entre les idées et des nuances affectives.', 'Facile', 'NS1'),
('F02-52', NULL, 'Signe de ponctuation qui marque la fin d''une phrase déclarative ?', '["Le point", "La virgule", "Le point-virgule", "Les deux-points"]', 'Le point', 'À l''oral, il correspond à une pause assez forte.', 'Facile', 'NS1'),
('F02-53', NULL, 'Signe de ponctuation qui sépare, à l''intérieur de la phrase, des mots, des groupes de mots ou des propositions ?', '["La virgule", "Le point", "Les guillemets", "Le tiret"]', 'La virgule', 'Elle sépare aussi les éléments d''une énumération : « du riz, des haricots, du poisson ».', 'Facile', 'NS1'),
('F02-54', NULL, 'Signe qui sépare deux membres de phrase indépendants mais liés par le sens ?', '["Le point-virgule", "Les deux-points", "Le point", "La virgule"]', 'Le point-virgule', 'Il marque une pause plus forte que la virgule et plus faible que le point.', 'Moyen', 'NS1'),
('F02-55', NULL, 'Signe qui introduit une explication, une énumération ou une citation ?', '["Les deux-points", "Le point-virgule", "Les guillemets", "Le tiret"]', 'Les deux-points', 'Exemple : « Il y a trois couleurs : rouge, bleu, jaune ».', 'Moyen', 'NS1'),
('F02-56', NULL, 'Quel signe termine une phrase interrogative ?', '["Le point d''interrogation", "Le point d''exclamation", "Les points de suspension", "Le point-virgule"]', 'Le point d''interrogation', 'Exemple : « Où vas-tu ? ».', 'Facile', 'NS1'),
('F02-57', NULL, 'Quel signe termine souvent une phrase exclamative ou impérative marquée ?', '["Le point d''exclamation", "Le point d''interrogation", "Le point-virgule", "Les deux-points"]', 'Le point d''exclamation', 'Exemples : « Quel beau jour ! », « Sortez ! ».', 'Facile', 'NS1'),
('F02-58', NULL, 'Quels signes indiquent qu''une phrase reste en suspens ou inachevée ?', '["Les points de suspension", "Les deux-points", "Le point-virgule", "Les guillemets"]', 'Les points de suspension', 'Ils marquent aussi une hésitation ou une énumération qui continue.', 'Moyen', 'NS1'),
('F02-59', NULL, 'Signes doubles entre lesquels on place un élément inséré dans la phrase pour en préciser le sens ?', '["Les parenthèses", "Les guillemets", "Les deux-points", "Les points de suspension"]', 'Les parenthèses', 'L''élément placé entre parenthèses n''est pas indispensable à la phrase.', 'Moyen', 'NS1'),
('F02-60', NULL, 'Signes doubles qui isolent un mot ou un groupe de mots, ou encadrent des paroles rapportées ?', '["Les guillemets", "Les parenthèses", "Les virgules", "Les tirets"]', 'Les guillemets', 'Ils ouvrent (« ) et ferment (» ) une citation ou un dialogue.', 'Moyen', 'NS1'),
('F02-61', NULL, 'Trait qui, dans un dialogue, indique un changement d''interlocuteur ?', '["Le tiret", "Le trait d''union", "Les guillemets", "La virgule"]', 'Le tiret', 'Il commence aussi une réplique à la ligne. Ne pas le confondre avec le trait d''union, plus court.', 'Moyen', 'NS1'),
('F02-62', NULL, 'Lettre de plus grande taille placée au début d''une phrase ou d''un nom propre ?', '["La majuscule", "La minuscule", "L''italique", "Le gras"]', 'La majuscule', 'Exemples : « Haïti », « Port-au-Prince ». Elle commence aussi chaque phrase.', 'Facile', 'NS1'),
('Q0203', 'Où ne met-on jamais de virgule ?', 'Où ne place-t-on normalement pas de virgule ?', '["Entre le sujet et le verbe", "Entre les éléments d''une liste", "Avant « mais »", "Autour d''une apposition"]', 'Entre le sujet et le verbe', 'On ne sépare pas le sujet de son verbe : « Les élèves arrivent », sans virgule. On en met dans une liste, avant « mais » et autour d''une apposition.', 'Moyen', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 25 AND titre = 'La phrase : types, formes et ponctuation';
SELECT COUNT(*) AS chapitre_trouve FROM cible;

CREATE TEMP TABLE mat ON COMMIT DROP AS
SELECT q.v4_mat_canonical AS code FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = 25 AND q.v4_mat_canonical IS NOT NULL
GROUP BY q.v4_mat_canonical ORDER BY COUNT(*) DESC LIMIT 1;

WITH maj AS (
  UPDATE questions q
  SET chapitre_id = (SELECT id FROM cible), enonce = i.enonce, choix = i.choix, bonne_reponse = i.bonne,
      explication = i.explication, niveau_complexite = i.complexite, v4_niveau = i.niveau
  FROM imp i, chapitres c
  WHERE c.id = q.chapitre_id AND c.matiere_id = 25 AND i.ancien IS NOT NULL AND q.enonce = i.ancien
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
