-- Inspection en lecture seule (aucune modification). Lancer en mode simulation.
BEGIN;

-- Matières
SELECT id, niveau, nom FROM matieres ORDER BY id;

-- Chapitres dont la matière ou le titre évoque la biologie / géologie / SVT
SELECT ch.id, ch.matiere_id, m.nom AS matiere, ch.niveau_v4, ch.titre,
       (SELECT COUNT(*) FROM questions q WHERE q.chapitre_id = ch.id) AS nb_q
FROM chapitres ch JOIN matieres m ON m.id = ch.matiere_id
WHERE m.nom ~* '(bio|g[ée]olog|svt|vie et de la terre|physiolog|sciences exp)'
ORDER BY ch.matiere_id, ch.niveau_v4, ch.titre;

-- Répartition des questions Bio/Géol par v4_mat_canonical / v4_niveau
SELECT q.v4_mat_canonical, q.v4_niveau, COUNT(*)
FROM questions q
WHERE q.v4_mat_canonical ~* '(bio|g[ée]olog|M17|M18)'
GROUP BY 1, 2 ORDER BY 1, 2;

-- Colonnes de questions et chapitres
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_name IN ('questions', 'chapitres')
ORDER BY table_name, ordinal_position;

COMMIT;
