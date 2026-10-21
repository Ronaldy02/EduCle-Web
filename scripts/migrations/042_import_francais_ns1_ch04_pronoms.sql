-- Import du chapitre Français « Les pronoms » (NS1, NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('F04-01', NULL, 'Élément qui précède un pronom relatif et auquel ce pronom se rapporte ?', '["L''antécédent", "Le complément", "L''attribut", "Le sujet"]', 'L''antécédent', 'Dans « l''homme dont je parle », l''antécédent du pronom « dont » est « homme ».', 'Moyen', 'NS1'),
('F04-02', NULL, 'Dans « l''homme dont je parle », quel est l''antécédent de « dont » ?', '["« homme »", "« je »", "« parle »", "« l'' »"]', '« homme »', 'L''antécédent est le mot que le pronom relatif reprend : ici « homme ».', 'Moyen', 'NS1'),
('F04-03', NULL, 'Catégorie grammaticale qui distingue celui qui parle, celui à qui l''on parle et celui dont on parle ?', '["La personne", "Le nombre", "Le genre", "Le mode"]', 'La personne', 'Elle se marque par les pronoms personnels (je, tu, il…) et par les terminaisons du verbe.', 'Moyen', 'NS1'),
('F04-04', NULL, 'Quelle personne grammaticale désigne celui à qui l''on parle ?', '["La deuxième personne", "La première personne", "La troisième personne", "La quatrième personne"]', 'La deuxième personne', 'Pronoms : « tu » au singulier, « vous » au pluriel.', 'Facile', 'NS1'),
('F04-05', NULL, 'Quelle personne grammaticale désigne celui ou ce dont on parle ?', '["La troisième personne", "La première personne", "La deuxième personne", "La quatrième personne"]', 'La troisième personne', 'Pronoms : « il », « elle », « on », « ils », « elles ».', 'Facile', 'NS1'),
('F04-12', NULL, 'Lequel de ces pronoms est une forme tonique ?', '["« moi »", "« me »", "« te »", "« se »"]', '« moi »', 'Les formes atones (me, te, se, le) s''opposent aux formes toniques (moi, toi, soi, lui).', 'Moyen', 'NS1'),
('F04-14', NULL, 'Quel pronom remplace un complément de personne au pluriel introduit par « à » ?', '["« leur »", "« les »", "« eux »", "« lui »"]', '« leur »', '« Je parle à mes amis » → « Je leur parle ». Placé devant le verbe, le pronom « leur » ne prend jamais de « s ».', 'Difficile', 'NS1'),
('F04-15', NULL, 'Dans « Nous nous lavons », quelle est la nature du second « nous » ?', '["Un pronom réfléchi", "Un pronom sujet", "Un pronom relatif", "Un déterminant"]', 'Un pronom réfléchi', 'Le pronom réfléchi renvoie au même être que le sujet : l''action porte sur ceux qui la font.', 'Moyen', 'NS1'),
('F04-16', NULL, 'Quel pronom convient dans « Je compte sur ___ » si l''on parle de Paul ?', '["« lui »", "« le »", "« il »", "« se »"]', '« lui »', 'Après une préposition, on emploie la forme tonique : « sur lui », « avec elle », « chez moi ».', 'Moyen', 'NS1'),
('F04-17', NULL, 'Dans « J''y vais », que remplace le pronom « y » ?', '["Un lieu", "Une personne", "Un sujet", "Une quantité"]', 'Un lieu', '« Y » reprend un lieu (« à Jacmel ») ou un complément introduit par « à ».', 'Moyen', 'NS1'),
('F04-18', NULL, 'Dans « Il en parle », que remplace le pronom « en » ?', '["Un complément en « de »", "Un complément en « à »", "Un sujet", "Un attribut"]', 'Un complément en « de »', '« Il parle de son voyage » → « Il en parle ».', 'Moyen', 'NS1'),
('F04-21', NULL, 'Pronom qui indique à qui appartient une chose et qui remplace un nom précédé d''un déterminant ?', '["Un pronom possessif", "Un pronom démonstratif", "Un pronom personnel", "Un pronom indéfini"]', 'Un pronom possessif', 'Formes : le mien, la tienne, les siens, le nôtre, les vôtres, les leurs.', 'Moyen', 'NS1'),
('F04-22', NULL, 'Lequel de ces mots est un pronom possessif ?', '["« le mien »", "« mon »", "« mes »", "« moi »"]', '« le mien »', '« Mon » et « mes » sont des déterminants possessifs, « moi » est un pronom personnel.', 'Moyen', 'NS1'),
('F04-23', NULL, 'Lequel de ces mots est un pronom démonstratif ?', '["« celui-ci »", "« cet »", "« cette »", "« ces »"]', '« celui-ci »', 'Les trois autres sont des déterminants démonstratifs. « Celui-ci » remplace un nom : « Prends celui-ci ».', 'Moyen', 'NS1'),
('F04-24', NULL, 'Lequel de ces mots est un pronom indéfini ?', '["« quelqu''un »", "« celui-ci »", "« le mien »", "« lequel »"]', '« quelqu''un »', 'Les pronoms indéfinis expriment une idée vague : quelqu''un, personne, rien, chacun, plusieurs.', 'Moyen', 'NS1'),
('F04-25', NULL, 'Quel pronom interrogatif sert à demander qui a fait l''action ?', '["« qui »", "« que »", "« quoi »", "« où »"]', '« qui »', '« Qui » interroge sur une personne sujet ; « que » interroge sur une chose objet : « Que veux-tu ? ».', 'Difficile', 'NS1'),
('F04-31', NULL, 'Mot qui rattache un nom ou un pronom à une proposition qui le précise ?', '["Le pronom relatif", "Le pronom personnel", "Le pronom démonstratif", "Le pronom interrogatif"]', 'Le pronom relatif', 'Dans « l''élève qui chante », « qui » rattache « élève » à la proposition « qui chante ».', 'Moyen', 'NS1'),
('F04-32', NULL, 'Lequel de ces mots est un pronom relatif ?', '["« dont »", "« donc »", "« dans »", "« dès »"]', '« dont »', 'Les pronoms relatifs sont qui, que, quoi, dont, où, lequel (et ses formes).', 'Moyen', 'NS1'),
('F04-33', NULL, 'Quel pronom relatif remplace un complément introduit par « de » ?', '["« dont »", "« que »", "« qui »", "« où »"]', '« dont »', '« Le livre dont je parle » : « je parle de ce livre ».', 'Moyen', 'NS1'),
('F04-34', NULL, 'Quel pronom relatif exprime le lieu ou le temps ?', '["« où »", "« dont »", "« que »", "« qui »"]', '« où »', '« La ville où j''habite », « le jour où il est venu ».', 'Moyen', 'NS1'),
('F04-35', NULL, 'Dans « Je pense que tu viens », quelle est la nature de « que » ?', '["Une conjonction", "Un pronom relatif", "Un pronom personnel", "Un adverbe"]', 'Une conjonction', '« Que » introduit une proposition complétive et ne reprend aucun antécédent : c''est une conjonction de subordination.', 'Difficile', 'NS1'),
('F04-36', NULL, 'Dans « le livre que tu lis », quelle est la nature de « que » ?', '["Un pronom relatif", "Une conjonction", "Un pronom personnel", "Un adverbe"]', 'Un pronom relatif', '« Que » reprend l''antécédent « livre » : c''est un pronom relatif.', 'Difficile', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 25 AND titre = 'Les pronoms';
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
