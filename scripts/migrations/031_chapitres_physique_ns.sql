-- Migration 031 : chapitres de la Physique (matière 9), NS1–NS4
-- Référence : curriculum/physique_ns.md (découpage validé par l'utilisateur le 2026-10-18, 49 chapitres)
-- Idempotent. Les anciens chapitres de la matière 9 ne sont pas touchés (supprimés plus tard, une fois leurs questions replacées).
BEGIN;

CREATE TEMP TABLE cible (matiere_id INT, titre TEXT, niveaux TEXT[], ordres INT[]) ON COMMIT DROP;
INSERT INTO cible (matiere_id, titre, niveaux, ordres) VALUES
(9, 'Grandeurs, mesures et états de la matière', '{NS1}', '{1}'),
(9, 'Big Bang, système solaire et exploration de l''espace', '{NS1,NS2}', '{2,14}'),
(9, 'Gravitation universelle, poids et masse', '{NS1,NS2}', '{3,15}'),
(9, 'Mouvement, trajectoire, vitesse et accélération', '{NS1}', '{4}'),
(9, 'Force, interaction et effets d''une force', '{NS1,NS2}', '{5,16}'),
(9, 'La pression : solides, liquides et atmosphère', '{NS1,NS2}', '{6,17}'),
(9, 'La poussée d''Archimède et la flottaison', '{NS1}', '{7}'),
(9, 'Électrisation et charges électriques', '{NS1}', '{8}'),
(9, 'Conducteurs, isolants et circuit électrique', '{NS1,NS2}', '{9,18}'),
(9, 'Résistance électrique et loi d''Ohm', '{NS1,NS2}', '{10,19}'),
(9, 'Puissance électrique et sécurité des installations', '{NS1}', '{11}'),
(9, 'Propagation rectiligne de la lumière, ombres et éclipses', '{NS1}', '{12}'),
(9, 'Réflexion de la lumière et miroir plan', '{NS1,NS2}', '{13,20}'),
(9, 'Le son et la transmission de l''information', '{NS1,NS4}', '{14,12}'),
(9, 'Température, thermomètres et dilatation', '{NS2}', '{1}'),
(9, 'Les gaz : lois et gaz parfaits', '{NS2}', '{2}'),
(9, 'Chaleur : propagation, calorimétrie et changements d''état', '{NS2}', '{3}'),
(9, 'Équilibre d''un solide : deux ou trois forces, moment et couple', '{NS2}', '{4}'),
(9, 'Inertie, action-réaction, chute libre et quantité de mouvement', '{NS2,NS3}', '{5,13}'),
(9, 'Travail, puissance, rendement et formes d''énergie', '{NS2,NS3}', '{6,14}'),
(9, 'Courant électrique, tension, lois de Kirchhoff et électrolyse', '{NS2,NS3}', '{7,15}'),
(9, 'Associations de résistors, rhéostats et effet Joule', '{NS2,NS3}', '{8,16}'),
(9, 'Diodes, générateurs, récepteurs et loi de Pouillet', '{NS2,NS3}', '{9,17}'),
(9, 'Vitesse de la lumière, réfraction, dioptre plan, lames et prisme', '{NS2,NS3}', '{10,18}'),
(9, 'Les lentilles minces et l''œil', '{NS2}', '{11}'),
(9, 'Lumières colorées, filtres et synthèse des couleurs', '{NS2,NS3}', '{12,19}'),
(9, 'Aimants et champ magnétique', '{NS2,NS3,NS4}', '{13,20,13}'),
(9, 'Énergies cinétique, potentielle et mécanique', '{NS3}', '{1}'),
(9, 'Les machines simples', '{NS3}', '{2}'),
(9, 'Référentiels, repérage et vecteur vitesse', '{NS3}', '{3}'),
(9, 'Cinématique du point', '{NS3}', '{4}'),
(9, 'Les lois de Newton et leurs applications', '{NS3}', '{5}'),
(9, 'Piles et accumulateurs', '{NS3}', '{6}'),
(9, 'Les condensateurs', '{NS3}', '{7}'),
(9, 'Induction électromagnétique et courant alternatif', '{NS3}', '{8}'),
(9, 'Les ondes mécaniques', '{NS3,NS4}', '{9,11}'),
(9, 'Ondes électromagnétiques, spectres et lumière', '{NS3}', '{10}'),
(9, 'La dualité onde-corpuscule de la lumière', '{NS3}', '{11}'),
(9, 'Les instruments d''optique', '{NS3}', '{12}'),
(9, 'Radioactivité et demi-vie', '{NS4}', '{1}'),
(9, 'Fission et fusion nucléaires', '{NS4}', '{2}'),
(9, 'Sources d''énergie, climat et transition énergétique', '{NS4}', '{3}'),
(9, 'Oscillations et oscillateurs mécaniques', '{NS4}', '{4}'),
(9, 'Interactions fondamentales, gravitation et pesanteur', '{NS4}', '{5}'),
(9, 'Charges, loi de Coulomb et champ électrique', '{NS4}', '{6}'),
(9, 'Force de Laplace et force de Lorentz', '{NS4}', '{7}'),
(9, 'Courant alternatif, circuits LC et RLC', '{NS4}', '{8}'),
(9, 'Acoustique appliquée', '{NS4}', '{9}'),
(9, 'Histoire de l''électricité et de l''électronique', '{NS4}', '{10}');

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
SELECT COUNT(*) AS chapitres_physique_nouveaux FROM chapitres ch JOIN cible c ON c.matiere_id = ch.matiere_id AND c.titre = ch.titre;
SELECT cn.niveau_v4, COUNT(*) AS nb_liaisons FROM chapitre_niveaux cn JOIN chapitres ch ON ch.id = cn.chapitre_id JOIN cible c ON c.matiere_id = ch.matiere_id AND c.titre = ch.titre GROUP BY cn.niveau_v4 ORDER BY 1;
SELECT COUNT(*) AS chapitres_matiere_9_total FROM chapitres WHERE matiere_id = 9;
COMMIT;
