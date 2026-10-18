-- Migration 030 : chapitres de la Littérature haïtienne (matière 23), NS1–NS3
-- Référence : curriculum/litterature_haitienne_ns.md (plan validé par l'utilisateur le 2026-10-18, 24 chapitres)
-- Idempotent. La matière 23 n'avait aucun chapitre (diagnostic 028).
BEGIN;

CREATE TEMP TABLE cible (matiere_id INT, titre TEXT, niveaux TEXT[], ordres INT[]) ON COMMIT DROP;
INSERT INTO cible (matiere_id, titre, niveaux, ordres) VALUES
(23, 'Introduction à la littérature haïtienne', '{NS1}', '{1}'),
(23, 'Les débuts de la littérature haïtienne (1804-1836)', '{NS1}', '{2}'),
(23, 'L''École de 1836 : contexte et poètes', '{NS1}', '{3}'),
(23, 'L''École de 1836 : histoire et roman', '{NS1}', '{4}'),
(23, 'Le romantisme patriotique (1860-1898) : poésie', '{NS1}', '{5}'),
(23, 'Le romantisme patriotique (1860-1898) : roman et essais', '{NS1}', '{6}'),
(23, 'Le théâtre haïtien (1804-1915)', '{NS1,NS2}', '{7,6}'),
(23, 'La Ronde : contexte, revue et esprit de l''école', '{NS2}', '{1}'),
(23, 'Les poètes de La Ronde', '{NS2}', '{2}'),
(23, 'Etzer Vilaire', '{NS2}', '{3}'),
(23, 'Romanciers et humoristes de La Ronde', '{NS2}', '{4}'),
(23, 'La pensée et l''histoire au début du XXe siècle', '{NS2}', '{5}'),
(23, 'L''occupation américaine et la naissance de l''indigénisme', '{NS3}', '{1}'),
(23, 'Jean Price-Mars', '{NS3}', '{2}'),
(23, 'Les poètes de l''indigénisme', '{NS3}', '{3}'),
(23, 'Jacques Roumain', '{NS3}', '{4}'),
(23, 'Le roman paysan et le roman social', '{NS3}', '{5}'),
(23, 'Réalisme social et réalisme merveilleux (1945-1960)', '{NS3}', '{6}'),
(23, 'Littérature sous les Duvalier (1957-1986) et exil', '{NS3}', '{7}'),
(23, 'Le spiralisme et ses prolongements', '{NS3}', '{8}'),
(23, 'La diaspora : Canada, États-Unis, France', '{NS3}', '{9}'),
(23, 'La littérature haïtienne contemporaine', '{NS3}', '{10}'),
(23, 'Prix et distinctions des écrivains haïtiens', '{NS3}', '{11}'),
(23, 'Courants et notions de la littérature haïtienne du XXe siècle', '{NS3}', '{12}');

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
SELECT COUNT(*) AS chapitres_litt_haitienne FROM chapitres ch JOIN cible c ON c.matiere_id = ch.matiere_id AND c.titre = ch.titre;
SELECT cn.niveau_v4, COUNT(*) AS nb_liaisons FROM chapitre_niveaux cn JOIN chapitres ch ON ch.id = cn.chapitre_id JOIN cible c ON c.matiere_id = ch.matiere_id AND c.titre = ch.titre GROUP BY cn.niveau_v4 ORDER BY 1;
SELECT COUNT(*) AS chapitres_matiere_23_total FROM chapitres WHERE matiere_id = 23;
COMMIT;
