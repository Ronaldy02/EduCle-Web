-- Import du chapitre Français « Notions de conjugaison : groupes, modes, temps, auxiliaires » (NS1, NS2, NS3, NS4) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('F05-01', NULL, 'Présenter successivement toutes les formes d''un verbe, selon la personne, le nombre, le mode et le temps ?', '["Conjuguer", "Accorder", "Décliner", "Analyser"]', 'Conjuguer', 'On conjugue « parler » : je parle, tu parles, il parle…', 'Facile', 'NS1'),
('F05-02', NULL, 'Partie du verbe qui porte le sens et qui reste en général stable d''une forme à l''autre ?', '["Le radical", "La terminaison", "Le préfixe", "L''auxiliaire"]', 'Le radical', 'Pour « parler », le radical est « parl- ».', 'Facile', 'NS1'),
('F05-03', NULL, 'Partie variable ajoutée au radical d''un verbe, qui indique la personne, le nombre, le temps et le mode ?', '["La terminaison", "Le radical", "L''auxiliaire", "Le participe"]', 'La terminaison', 'On dit aussi désinence. Pour « parler » au présent : -e, -es, -e, -ons, -ez, -ent.', 'Moyen', 'NS1'),
('F05-04', NULL, 'Dans « parlons », quel est le radical ?', '["« parl- »", "« parlon- »", "« par- »", "« -ons »"]', '« parl- »', 'Le radical « parl- » est suivi de la terminaison « -ons ».', 'Moyen', 'NS1'),
('F05-05', NULL, 'Dans « nous chantions », quelle est la terminaison ?', '["« -ions »", "« -ons »", "« -ais »", "« -ant »"]', '« -ions »', 'Le radical est « chant- » ; « -ions » marque l''imparfait à la première personne du pluriel.', 'Moyen', 'NS1'),
('F05-06', NULL, 'Manière dont le verbe présente l''action ou l''état : comme un fait certain, une possibilité, une condition, un ordre ?', '["Le mode", "Le temps", "La voix", "Le groupe"]', 'Le mode', 'Les modes sont l''indicatif, le subjonctif, le conditionnel, l''impératif, l''infinitif, le participe et le gérondif.', 'Facile', 'NS1'),
('F05-07', NULL, 'Forme verbale qui situe l''action dans le présent, le passé ou l''avenir ?', '["Le temps", "Le mode", "La voix", "Le groupe"]', 'Le temps', 'Un temps est simple (un seul mot : je parle) ou composé (auxiliaire + participe passé : j''ai parlé).', 'Moyen', 'NS1'),
('F05-08', NULL, 'Comment forme-t-on un temps composé ?', '["Auxiliaire + participe passé", "Radical + terminaison", "Infinitif + auxiliaire", "Participe présent + auxiliaire"]', 'Auxiliaire + participe passé', 'Exemples : « j''ai parlé », « nous étions partis », « elle sera arrivée ».', 'Facile', 'NS1'),
('F05-09', NULL, 'Lequel de ces temps est un temps composé ?', '["Le plus-que-parfait", "L''imparfait", "Le futur simple", "Le passé simple"]', 'Le plus-que-parfait', 'Le plus-que-parfait se forme avec l''auxiliaire à l''imparfait + le participe passé : « j''avais parlé ».', 'Moyen', 'NS1'),
('F05-11', NULL, 'Lequel de ces verbes appartient au premier groupe ?', '["« chanter »", "« aller »", "« finir »", "« prendre »"]', '« chanter »', 'Le premier groupe réunit les verbes en -er, sauf « aller ».', 'Moyen', 'NS1'),
('F05-12', NULL, 'Quelle caractéristique distingue les verbes du deuxième groupe ?', '["Infinitif en -ir, participe en -issant", "Infinitif en -er, participe en -ant", "Infinitif en -re, participe en -ant", "Infinitif en -oir, participe en -ant"]', 'Infinitif en -ir, participe en -issant', 'Exemple : finir → finissant ; choisir → choisissant.', 'Moyen', 'NS1'),
('F05-13', NULL, 'Lequel de ces verbes appartient au deuxième groupe ?', '["« grandir »", "« partir »", "« courir »", "« venir »"]', '« grandir »', '« Grandir » fait « grandissant ». « Partir », « courir » et « venir » (partant, courant, venant) sont du troisième groupe.', 'Difficile', 'NS1'),
('F05-14', NULL, 'À quel groupe appartient le verbe « aller » ?', '["Au troisième groupe", "Au premier groupe", "Au deuxième groupe", "À aucun groupe"]', 'Au troisième groupe', 'Malgré son infinitif en -er, « aller » est irrégulier : je vais, nous allons, j''irai.', 'Difficile', 'NS1'),
('F05-15', NULL, 'Groupe qui rassemble tous les autres verbes et qui est le plus irrégulier ?', '["Le troisième groupe", "Le premier groupe", "Le deuxième groupe", "Le groupe des auxiliaires"]', 'Le troisième groupe', 'Il comprend aller, venir, prendre, voir, pouvoir, vouloir, faire, dire…', 'Moyen', 'NS1'),
('F05-21', NULL, 'Quels sont les modes personnels ?', '["Indicatif, subjonctif, conditionnel, impératif", "Indicatif, subjonctif, infinitif, impératif", "Indicatif, conditionnel, participe, gérondif", "Subjonctif, impératif, infinitif, participe"]', 'Indicatif, subjonctif, conditionnel, impératif', 'Leurs formes varient selon la personne. Les autres modes sont impersonnels.', 'Moyen', 'NS1'),
('F05-22', NULL, 'Quels sont les modes impersonnels ?', '["Infinitif, participe, gérondif", "Infinitif, participe, conditionnel", "Participe, impératif, gérondif", "Infinitif, indicatif, gérondif"]', 'Infinitif, participe, gérondif', 'Leurs formes ne varient pas selon la personne grammaticale.', 'Moyen', 'NS1'),
('F05-23', NULL, 'Mode qui présente l''action ou l''état comme un fait réel, certain ou objectif ?', '["L''indicatif", "Le subjonctif", "Le conditionnel", "L''impératif"]', 'L''indicatif', 'C''est le mode le plus employé : il compte le plus grand nombre de temps.', 'Facile', 'NS1'),
('F05-24', NULL, 'Mode qui présente l''action comme une éventualité ou comme la conséquence d''un fait supposé ?', '["Le conditionnel", "Le subjonctif", "L''indicatif", "L''impératif"]', 'Le conditionnel', 'Exemple : « J''aimerais voyager si j''avais le temps ».', 'Moyen', 'NS1'),
('F05-25', NULL, 'Mode employé surtout dans les subordonnées pour exprimer la subjectivité ou l''affectivité ?', '["Le subjonctif", "Le conditionnel", "L''indicatif", "L''impératif"]', 'Le subjonctif', 'Exemple : « Il faut que tu viennes ».', 'Moyen', 'NS1'),
('F05-26', NULL, 'Mode caractérisé par l''absence de pronom sujet et qui exprime un ordre ou une défense ?', '["L''impératif", "Le subjonctif", "Le conditionnel", "L''infinitif"]', 'L''impératif', 'Exemples : « Viens ! », « Ne pars pas ! ».', 'Facile', 'NS1'),
('F05-27', NULL, 'Forme nominale du verbe, qui ne porte aucune marque de nombre ni de personne ?', '["L''infinitif", "Le participe", "Le gérondif", "L''impératif"]', 'L''infinitif', 'Exemples : parler, finir, prendre. C''est la forme sous laquelle le verbe figure au dictionnaire.', 'Moyen', 'NS1'),
('F05-28', NULL, 'Forme verbale impersonnelle qui tient à la fois du verbe et de l''adjectif ?', '["Le participe", "L''infinitif", "Le gérondif", "L''impératif"]', 'Le participe', 'Comme l''adjectif, il peut varier en genre et en nombre : « des fenêtres ouvertes ».', 'Moyen', 'NS1'),
('F05-29', NULL, 'Forme verbale en -ant précédée de la préposition « en » ?', '["Le gérondif", "Le participe présent", "L''infinitif", "L''adjectif verbal"]', 'Le gérondif', 'Exemple : « En sortant, j''ai vu qu''il pleuvait ». Il joue le rôle d''un complément circonstanciel.', 'Difficile', 'NS1'),
('F05-31', NULL, 'Verbe qui perd son sens plein et se combine avec un participe pour former un temps composé ?', '["Un auxiliaire", "Un verbe d''état", "Un verbe pronominal", "Un verbe défectif"]', 'Un auxiliaire', 'Il n''y a que deux auxiliaires pour former les temps composés : être et avoir.', 'Moyen', 'NS1'),
('F05-32', NULL, 'Quels sont les deux auxiliaires qui forment les temps composés ?', '["être et avoir", "être et faire", "avoir et aller", "pouvoir et devoir"]', 'être et avoir', '« Pouvoir » et « devoir » sont des verbes modaux, pas des auxiliaires de temps composés.', 'Facile', 'NS1'),
('F05-33', NULL, 'Dans « Il a mangé », quelle est la nature de « a » ?', '["Un auxiliaire", "Une préposition", "Un verbe d''état", "Un pronom"]', 'Un auxiliaire', '« A » forme le passé composé avec le participe « mangé ». Sans accent, il ne s''écrit pas « à ».', 'Moyen', 'NS1'),
('F05-34', NULL, 'Avec quel auxiliaire se conjuguent tous les verbes pronominaux aux temps composés ?', '["Être", "Avoir", "Aller", "Avoir ou être"]', 'Être', 'Exemples : « elle s''est levée », « ils se sont parlé ».', 'Moyen', 'NS1'),
('F05-35', NULL, 'Avec quel auxiliaire se conjugue « partir » aux temps composés ?', '["Être", "Avoir", "Aller", "Faire"]', 'Être', 'Les verbes de mouvement ou de changement d''état (aller, venir, arriver, naître, mourir, tomber) se conjuguent avec être : « il est parti ».', 'Moyen', 'NS1'),
('F05-36', NULL, 'Dans « Elle se lève », quel type de verbe est « se lever » ?', '["Un verbe pronominal", "Un verbe auxiliaire", "Un verbe défectif", "Un verbe impersonnel"]', 'Un verbe pronominal', 'Un verbe pronominal se conjugue avec un pronom réfléchi (me, te, se, nous, vous).', 'Moyen', 'NS1'),
('F05-37', NULL, 'Verbe qui ne possède pas certaines formes que les verbes du même type ont normalement ?', '["Un verbe défectif", "Un verbe irrégulier", "Un verbe auxiliaire", "Un verbe pronominal"]', 'Un verbe défectif', 'Exemple : « gésir » n''existe qu''au présent, à l''imparfait et au participe présent « gisant ».', 'Difficile', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 25 AND titre = 'Notions de conjugaison : groupes, modes, temps, auxiliaires';
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
