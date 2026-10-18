-- Import du chapitre Français « Nature des mots et classes grammaticales » (NS1) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('F01-41', NULL, 'Ensemble des règles qui président à la correction de la langue écrite ou parlée ?', '["La grammaire", "Le lexique", "La rhétorique", "La versification"]', 'La grammaire', 'Elle comprend la morphologie (forme des mots) et la syntaxe (combinaison des mots en phrases).', 'Facile', 'NS1'),
('F01-42', NULL, 'Partie de la grammaire qui étudie la formation des mots et les variations de leurs terminaisons ?', '["La morphologie", "La syntaxe", "L''orthographe", "La phonétique"]', 'La morphologie', 'Elle explique par exemple pourquoi « chanteur » devient « chanteuse » ou « chanter » devient « chantons ».', 'Moyen', 'NS1'),
('F01-43', NULL, 'Partie de la grammaire qui décrit les règles de combinaison des mots en phrases ?', '["La syntaxe", "La morphologie", "La conjugaison", "La ponctuation"]', 'La syntaxe', 'C''est elle qui étudie la fonction des mots : sujet, complément, attribut…', 'Moyen', 'NS1'),
('F01-44', NULL, 'Élément de la langue formé d''un ou de plusieurs sons, qui peut s''écrire isolément ?', '["Un mot", "Une phrase", "Une syllabe", "Une lettre"]', 'Un mot', 'Chaque mot appartient à une classe grammaticale (sa nature).', 'Facile', 'NS1'),
('F01-45', NULL, 'Groupe de mots figé qui a la valeur grammaticale d''un mot unique ?', '["Une locution", "Une proposition", "Un groupe nominal", "Une phrase"]', 'Une locution', 'On distingue les locutions verbales, nominales, adverbiales, prépositives et conjonctives.', 'Moyen', 'NS1'),
('F01-46', NULL, 'Quelle est la nature de la locution « tout de suite » ?', '["Locution adverbiale", "Locution prépositive", "Locution conjonctive", "Locution verbale"]', 'Locution adverbiale', '« Tout de suite » équivaut à l''adverbe « immédiatement ».', 'Moyen', 'NS1'),
('F01-47', NULL, 'Quelle est la nature de la locution « au-dessus de » ?', '["Locution prépositive", "Locution adverbiale", "Locution conjonctive", "Locution verbale"]', 'Locution prépositive', 'Elle joue le rôle d''une préposition : « au-dessus de la table ».', 'Moyen', 'NS1'),
('F01-48', NULL, 'Quelle est la nature de la locution « pour que » ?', '["Locution conjonctive", "Locution prépositive", "Locution adverbiale", "Locution verbale"]', 'Locution conjonctive', 'Elle joue le rôle d''une conjonction de subordination et introduit une subordonnée.', 'Moyen', 'NS1'),
('F01-49', NULL, 'Quelle est la nature de la locution « faire grâce » ?', '["Locution verbale", "Locution adverbiale", "Locution prépositive", "Locution conjonctive"]', 'Locution verbale', 'Elle équivaut à un seul verbe : « gracier ».', 'Moyen', 'NS1'),
('F01-50', NULL, 'Quelles classes de mots sont toutes variables ?', '["Nom, adjectif, verbe", "Nom, adverbe, verbe", "Nom, préposition, adjectif", "Verbe, conjonction, adjectif"]', 'Nom, adjectif, verbe', 'Sont variables le nom, le déterminant, l''adjectif, le pronom et le verbe.', 'Moyen', 'NS1'),
('F01-51', NULL, 'Quelles classes de mots sont toutes invariables ?', '["Adverbe, préposition, conjonction, interjection", "Adverbe, pronom, préposition, interjection", "Nom, préposition, conjonction, interjection", "Adverbe, préposition, déterminant, interjection"]', 'Adverbe, préposition, conjonction, interjection', 'Ces quatre classes ne varient ni en genre, ni en nombre, ni en personne.', 'Moyen', 'NS1'),
('F01-52', NULL, 'Emploi comme nom d''un mot qui n''est pas un nom à l''origine, comme « bleu » dans « le bleu du ciel » ?', '["La substantivation", "La dérivation", "La conjugaison", "L''élision"]', 'La substantivation', 'Un adjectif, un verbe ou un adverbe peut devenir nom quand un déterminant le précède.', 'Moyen', 'NS1'),
('F01-53', NULL, 'Dans « le bleu du ciel », quelle est la nature de « bleu » ?', '["Un nom", "Un adjectif", "Un adverbe", "Un verbe"]', 'Un nom', 'Précédé de l''article « le », « bleu » est substantivé : c''est un nom, alors qu''il est adjectif dans « un ciel bleu ».', 'Moyen', 'NS1'),
('F01-54', NULL, 'Dans « Il parle fort », quelle est la nature de « fort » ?', '["Un adverbe", "Un adjectif", "Un nom", "Un verbe"]', 'Un adverbe', '« Fort » modifie le verbe « parle » : c''est un adverbe invariable. Il est adjectif dans « un homme fort ».', 'Moyen', 'NS1'),
('F01-55', NULL, 'Dans « Elle livre le colis », quelle est la nature de « livre » ?', '["Un verbe", "Un nom", "Un adjectif", "Un pronom"]', 'Un verbe', '« Livre » est ici le verbe livrer. C''est un nom dans « un livre ».', 'Moyen', 'NS1'),
('F01-56', NULL, 'Dans « Je le vois », quelle est la nature de « le » ?', '["Un pronom", "Un article", "Une préposition", "Un adverbe"]', 'Un pronom', 'Placé devant le verbe, « le » remplace un nom : c''est un pronom. Devant un nom (« le livre »), c''est un article.', 'Moyen', 'NS1'),
('F01-57', NULL, 'Quel test permet de reconnaître un nom ?', '["Il peut être précédé d''un déterminant", "Il se conjugue", "Il reste toujours invariable", "Il introduit un complément"]', 'Il peut être précédé d''un déterminant', 'On peut dire « un livre », « la liberté », « mon ami » : un déterminant précède le nom.', 'Facile', 'NS1'),
('F01-58', NULL, 'Quel test permet de reconnaître un adjectif qualificatif ?', '["Il s''accorde avec le nom", "Il se conjugue", "Il reste toujours invariable", "Il introduit un complément"]', 'Il s''accorde avec le nom', 'On dit « une fille grande », « des filles grandes » : l''adjectif change avec le nom qu''il accompagne.', 'Moyen', 'NS1'),
('F01-59', NULL, 'Quel type d''adverbe indique le moment où se passe l''action ?', '["Adverbe de temps", "Adverbe de lieu", "Adverbe de manière", "Adverbe de quantité"]', 'Adverbe de temps', 'Exemples : « hier », « demain », « souvent », « aujourd''hui ».', 'Moyen', 'NS1'),
('F01-60', NULL, 'Quel type d''adverbe indique l''endroit où se passe l''action ?', '["Adverbe de lieu", "Adverbe de temps", "Adverbe de manière", "Adverbe de quantité"]', 'Adverbe de lieu', 'Exemples : « ici », « là », « partout », « dehors ».', 'Moyen', 'NS1'),
('F01-61', NULL, 'Quel type d''adverbe indique comment se fait l''action ?', '["Adverbe de manière", "Adverbe de lieu", "Adverbe de temps", "Adverbe de quantité"]', 'Adverbe de manière', 'Beaucoup se terminent en -ment : « lentement », « doucement ». Autres : « bien », « mal ».', 'Moyen', 'NS1'),
('F01-62', NULL, 'Quel type d''adverbe indique la quantité ou l''intensité ?', '["Adverbe de quantité", "Adverbe de manière", "Adverbe de temps", "Adverbe de lieu"]', 'Adverbe de quantité', 'Exemples : « très », « beaucoup », « trop », « peu », « assez ».', 'Moyen', 'NS1'),
('F01-63', NULL, 'Quel type d''adverbe sert à nier ce qu''exprime le verbe, comme « ne… pas » ?', '["Adverbe de négation", "Adverbe d''affirmation", "Adverbe de doute", "Adverbe de lieu"]', 'Adverbe de négation', 'Exemples : « ne… pas », « ne… jamais », « ne… plus ». L''adverbe d''affirmation, lui, dit oui : « oui », « certes ».', 'Moyen', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 25 AND titre = 'Nature des mots et classes grammaticales';
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
