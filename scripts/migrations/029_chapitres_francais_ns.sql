-- Migration 029 : chapitres du Français / Communication française (matière 25), NS1–NS4
-- Référence : curriculum/francais_ns.md (découpage validé par l'utilisateur le 2026-10-18, 38 chapitres)
-- Idempotent. Les anciens chapitres de la matière 25 ne sont pas touchés (supprimés plus tard, une fois leurs questions replacées).
BEGIN;

CREATE TEMP TABLE cible (matiere_id INT, titre TEXT, niveaux TEXT[], ordres INT[]) ON COMMIT DROP;
INSERT INTO cible (matiere_id, titre, niveaux, ordres) VALUES
(25, 'Nature des mots et classes grammaticales', '{NS1}', '{1}'),
(25, 'La phrase : types, formes et ponctuation', '{NS1}', '{2}'),
(25, 'Le groupe nominal : déterminants, genre, nombre et accord de l''adjectif', '{NS1}', '{3}'),
(25, 'Les pronoms', '{NS1,NS2}', '{4,10}'),
(25, 'Notions de conjugaison : groupes, modes, temps, auxiliaires', '{NS1,NS2,NS3,NS4}', '{5,11,6,3}'),
(25, 'L''indicatif : temps simples', '{NS1,NS2,NS3,NS4}', '{6,12,7,4}'),
(25, 'L''indicatif : temps composés', '{NS1,NS2,NS3,NS4}', '{7,13,8,5}'),
(25, 'Le subjonctif', '{NS1,NS2,NS3,NS4}', '{8,14,9,6}'),
(25, 'Voix active et voix passive', '{NS1,NS3}', '{9,10}'),
(25, 'Le lexique : relations de sens', '{NS1,NS2,NS3}', '{10,15,11}'),
(25, 'Formation des mots, famille et étymologie', '{NS1,NS2}', '{11,16}'),
(25, 'Les niveaux de langue', '{NS1,NS2,NS3}', '{12,17,12}'),
(25, 'Orthographe : accents, élision, liaison et homophones', '{NS1}', '{13}'),
(25, 'La situation de communication et l''énonciation', '{NS1,NS2}', '{14,18}'),
(25, 'Connecteurs logiques, reprises et cohérence du texte', '{NS1,NS2,NS3}', '{15,19,13}'),
(25, 'Exprimer la cause, la conséquence et le but', '{NS1,NS2}', '{16,20}'),
(25, 'Exprimer l''opposition, la concession et l''hypothèse', '{NS1,NS2,NS3}', '{17,21,14}'),
(25, 'Le discours rapporté', '{NS1,NS3}', '{18,15}'),
(25, 'Figures d''analogie et de substitution', '{NS1,NS2,NS3}', '{19,22,16}'),
(25, 'Figures d''opposition, d''insistance et d''atténuation', '{NS1,NS2,NS3}', '{20,23,17}'),
(25, 'Types de textes et séquences', '{NS1}', '{21}'),
(25, 'La presse et les médias', '{NS1,NS2}', '{22,24}'),
(25, 'La phrase complexe et les propositions', '{NS2}', '{1}'),
(25, 'Le conditionnel', '{NS2,NS3,NS4}', '{2,18,7}'),
(25, 'L''impératif', '{NS2,NS3,NS4}', '{3,19,8}'),
(25, 'Les modes impersonnels : infinitif, participe, gérondif', '{NS2,NS3,NS4}', '{4,20,9}'),
(25, 'Les accords : sujet-verbe et participe passé', '{NS2,NS3,NS4}', '{5,21,10}'),
(25, 'La lettre', '{NS2}', '{6}'),
(25, 'Le discours explicatif et scientifique', '{NS2}', '{7}'),
(25, 'Le discours argumentatif : débat, plaidoyer, polémique', '{NS2,NS3}', '{8,22}'),
(25, 'Résumer, prendre des notes et reformuler', '{NS2}', '{9}'),
(25, 'Les fonctions essentielles dans la phrase', '{NS3,NS4}', '{1,11}'),
(25, 'Les compléments circonstanciels', '{NS3,NS4}', '{2,12}'),
(25, 'Les fonctions liées au groupe nominal et à l''adjectif', '{NS3,NS4}', '{3,13}'),
(25, 'Les fonctions du pronom, de l''infinitif et de la subordonnée', '{NS3,NS4}', '{4,14}'),
(25, 'La lecture d''un texte d''idées', '{NS3}', '{5}'),
(25, 'La dissertation', '{NS4}', '{1}'),
(25, 'Le commentaire et l''explication de texte', '{NS4}', '{2}');

INSERT INTO chapitres (matiere_id, titre, niveau_v4)
SELECT c.matiere_id, c.titre, c.niveaux[1]
FROM cible c
WHERE NOT EXISTS (SELECT 1 FROM chapitres ch WHERE ch.matiere_id = c.matiere_id AND ch.titre = c.titre);

DELETE FROM chapitre_niveaux cn
USING chapitres ch, cible c
WHERE cn.chapitre_id = ch.id AND c.matiere_id = ch.matiere_id AND c.titre = ch.titre;

INSERT INTO chapitre_niveaux (chapitre_id, niveau_v4, ordre)
SELECT ch.id, u.niveau, u.ordre
FROM cible c
JOIN chapitres ch ON ch.matiere_id = c.matiere_id AND ch.titre = c.titre
CROSS JOIN LATERAL unnest(c.niveaux, c.ordres) AS u(niveau, ordre);

-- Contrôles (comptages)
SELECT COUNT(*) AS chapitres_francais_nouveaux FROM chapitres ch JOIN cible c ON c.matiere_id = ch.matiere_id AND c.titre = ch.titre;
SELECT cn.niveau_v4, COUNT(*) AS nb_liaisons FROM chapitre_niveaux cn JOIN chapitres ch ON ch.id = cn.chapitre_id JOIN cible c ON c.matiere_id = ch.matiere_id AND c.titre = ch.titre GROUP BY cn.niveau_v4 ORDER BY 1;
SELECT COUNT(*) AS chapitres_matiere_25_total FROM chapitres WHERE matiere_id = 25;
COMMIT;
