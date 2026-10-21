-- Migration 051 : regroupement des chapitres Français NS1 (22 -> 16), demande de l'utilisateur du 2026-10-21
-- Les chapitres 1 à 5 (déjà importés) ne changent pas. Les chapitres fusionnés n'ont pas encore de questions :
-- le chapitre survivant est renommé, les anciens sont supprimés seulement s'ils sont vides (aucune question supprimée).
-- Idempotent.
BEGIN;

UPDATE chapitres SET titre = 'L''indicatif : temps simples et composés' WHERE matiere_id = 25 AND titre = 'L''indicatif : temps simples' AND NOT EXISTS (SELECT 1 FROM chapitres x WHERE x.matiere_id = 25 AND x.titre = 'L''indicatif : temps simples et composés');
DELETE FROM chapitres c WHERE c.matiere_id = 25 AND c.titre = 'L''indicatif : temps composés' AND NOT EXISTS (SELECT 1 FROM questions qq WHERE qq.chapitre_id = c.id);
UPDATE chapitres SET titre = 'Le lexique : sens, formation des mots, niveaux de langue' WHERE matiere_id = 25 AND titre = 'Le lexique : relations de sens' AND NOT EXISTS (SELECT 1 FROM chapitres x WHERE x.matiere_id = 25 AND x.titre = 'Le lexique : sens, formation des mots, niveaux de langue');
DELETE FROM chapitres c WHERE c.matiere_id = 25 AND c.titre = 'Formation des mots, famille et étymologie' AND NOT EXISTS (SELECT 1 FROM questions qq WHERE qq.chapitre_id = c.id);
DELETE FROM chapitres c WHERE c.matiere_id = 25 AND c.titre = 'Les niveaux de langue' AND NOT EXISTS (SELECT 1 FROM questions qq WHERE qq.chapitre_id = c.id);
UPDATE chapitres SET titre = 'Les rapports logiques : cause, conséquence, but, opposition, concession, hypothèse' WHERE matiere_id = 25 AND titre = 'Exprimer la cause, la conséquence et le but' AND NOT EXISTS (SELECT 1 FROM chapitres x WHERE x.matiere_id = 25 AND x.titre = 'Les rapports logiques : cause, conséquence, but, opposition, concession, hypothèse');
DELETE FROM chapitres c WHERE c.matiere_id = 25 AND c.titre = 'Exprimer l''opposition, la concession et l''hypothèse' AND NOT EXISTS (SELECT 1 FROM questions qq WHERE qq.chapitre_id = c.id);
UPDATE chapitres SET titre = 'Les figures de style' WHERE matiere_id = 25 AND titre = 'Figures d''analogie et de substitution' AND NOT EXISTS (SELECT 1 FROM chapitres x WHERE x.matiere_id = 25 AND x.titre = 'Les figures de style');
DELETE FROM chapitres c WHERE c.matiere_id = 25 AND c.titre = 'Figures d''opposition, d''insistance et d''atténuation' AND NOT EXISTS (SELECT 1 FROM questions qq WHERE qq.chapitre_id = c.id);
UPDATE chapitres SET titre = 'Types de textes, séquences et presse' WHERE matiere_id = 25 AND titre = 'Types de textes et séquences' AND NOT EXISTS (SELECT 1 FROM chapitres x WHERE x.matiere_id = 25 AND x.titre = 'Types de textes, séquences et presse');
DELETE FROM chapitres c WHERE c.matiere_id = 25 AND c.titre = 'La presse et les médias' AND NOT EXISTS (SELECT 1 FROM questions qq WHERE qq.chapitre_id = c.id);

CREATE TEMP TABLE cible (matiere_id INT, titre TEXT, niveaux TEXT[], ordres INT[]) ON COMMIT DROP;
INSERT INTO cible (matiere_id, titre, niveaux, ordres) VALUES
(25, 'Nature des mots et classes grammaticales', '{NS1}', '{1}'),
(25, 'La phrase : types, formes et ponctuation', '{NS1}', '{2}'),
(25, 'Le groupe nominal : déterminants, genre, nombre et accord de l''adjectif', '{NS1}', '{3}'),
(25, 'Les pronoms', '{NS1,NS2}', '{4,10}'),
(25, 'Notions de conjugaison : groupes, modes, temps, auxiliaires', '{NS1,NS2,NS3,NS4}', '{5,11,6,3}'),
(25, 'L''indicatif : temps simples et composés', '{NS1,NS2,NS3,NS4}', '{6,12,7,4}'),
(25, 'Le subjonctif', '{NS1,NS2,NS3,NS4}', '{7,13,8,5}'),
(25, 'Voix active et voix passive', '{NS1,NS3}', '{8,9}'),
(25, 'Le lexique : sens, formation des mots, niveaux de langue', '{NS1,NS2,NS3}', '{9,14,10}'),
(25, 'Orthographe : accents, élision, liaison et homophones', '{NS1}', '{10}'),
(25, 'La situation de communication et l''énonciation', '{NS1,NS2}', '{11,15}'),
(25, 'Connecteurs logiques, reprises et cohérence du texte', '{NS1,NS2,NS3}', '{12,16,11}'),
(25, 'Les rapports logiques : cause, conséquence, but, opposition, concession, hypothèse', '{NS1,NS2,NS3}', '{13,17,12}'),
(25, 'Le discours rapporté', '{NS1,NS3}', '{14,13}'),
(25, 'Les figures de style', '{NS1,NS2,NS3}', '{15,18,14}'),
(25, 'Types de textes, séquences et presse', '{NS1,NS2}', '{16,19}'),
(25, 'La phrase complexe et les propositions', '{NS2}', '{1}'),
(25, 'Le conditionnel', '{NS2,NS3,NS4}', '{2,15,6}'),
(25, 'L''impératif', '{NS2,NS3,NS4}', '{3,16,7}'),
(25, 'Les modes impersonnels : infinitif, participe, gérondif', '{NS2,NS3,NS4}', '{4,17,8}'),
(25, 'Les accords : sujet-verbe et participe passé', '{NS2,NS3,NS4}', '{5,18,9}'),
(25, 'La lettre', '{NS2}', '{6}'),
(25, 'Le discours explicatif et scientifique', '{NS2}', '{7}'),
(25, 'Le discours argumentatif : débat, plaidoyer, polémique', '{NS2,NS3}', '{8,19}'),
(25, 'Résumer, prendre des notes et reformuler', '{NS2}', '{9}'),
(25, 'Les fonctions essentielles dans la phrase', '{NS3,NS4}', '{1,10}'),
(25, 'Les compléments circonstanciels', '{NS3,NS4}', '{2,11}'),
(25, 'Les fonctions liées au groupe nominal et à l''adjectif', '{NS3,NS4}', '{3,12}'),
(25, 'Les fonctions du pronom, de l''infinitif et de la subordonnée', '{NS3,NS4}', '{4,13}'),
(25, 'La lecture d''un texte d''idées', '{NS3}', '{5}'),
(25, 'La dissertation', '{NS4}', '{1}'),
(25, 'Le commentaire et l''explication de texte', '{NS4}', '{2}');

INSERT INTO chapitres (matiere_id, titre, niveau_v4)
SELECT c.matiere_id, c.titre, c.niveaux[1]
FROM cible c
WHERE NOT EXISTS (SELECT 1 FROM chapitres ch WHERE ch.matiere_id = c.matiere_id AND ch.titre = c.titre);

UPDATE chapitres ch SET niveau_v4 = c.niveaux[1]
FROM cible c WHERE c.matiere_id = ch.matiere_id AND c.titre = ch.titre AND ch.niveau_v4 IS DISTINCT FROM c.niveaux[1];

DELETE FROM chapitre_niveaux cn
USING chapitres ch, cible c
WHERE cn.chapitre_id = ch.id AND c.matiere_id = ch.matiere_id AND c.titre = ch.titre;

INSERT INTO chapitre_niveaux (chapitre_id, niveau_v4, ordre)
SELECT ch.id, u.niveau, u.ordre
FROM cible c
JOIN chapitres ch ON ch.matiere_id = c.matiere_id AND ch.titre = c.titre
CROSS JOIN LATERAL unnest(c.niveaux, c.ordres) AS u(niveau, ordre);

-- Contrôles (comptages)
SELECT COUNT(*) AS chapitres_matiere_25 FROM chapitres WHERE matiere_id = 25;
SELECT COUNT(*) AS chapitres_hors_cible FROM chapitres ch WHERE ch.matiere_id = 25 AND NOT EXISTS (SELECT 1 FROM cible c WHERE c.titre = ch.titre);
SELECT COUNT(*) AS questions_matiere_25 FROM questions q JOIN chapitres ch ON ch.id = q.chapitre_id WHERE ch.matiere_id = 25;
SELECT cn.niveau_v4, COUNT(*) AS nb_liaisons FROM chapitre_niveaux cn JOIN chapitres ch ON ch.id = cn.chapitre_id WHERE ch.matiere_id = 25 GROUP BY cn.niveau_v4 ORDER BY 1;
COMMIT;
