-- Diagnostic EEA : liste des matières et chapitres de l'Éducation esthétique et artistique, comptages seulement, ROLLBACK
BEGIN;
SELECT m.id, m.niveau, m.nom, COUNT(DISTINCT c.id) AS nb_chapitres
FROM matieres m LEFT JOIN chapitres c ON c.matiere_id = m.id
GROUP BY m.id ORDER BY m.id;

SELECT c.matiere_id, c.id, c.niveau_v4,
  (SELECT string_agg(cn.niveau_v4, ',' ORDER BY cn.niveau_v4) FROM chapitre_niveaux cn WHERE cn.chapitre_id = c.id) AS liaisons,
  c.titre, COUNT(q.id) AS nb_questions
FROM chapitres c JOIN matieres m ON m.id = c.matiere_id LEFT JOIN questions q ON q.chapitre_id = c.id
WHERE m.nom ILIKE '%esth%' OR m.nom ILIKE '%artist%'
GROUP BY c.id ORDER BY c.matiere_id, c.niveau_v4, c.id;

SELECT q.v4_niveau, q.v4_mat_canonical, COUNT(*) AS nb_questions
FROM questions q JOIN chapitres c ON c.id = q.chapitre_id JOIN matieres m ON m.id = c.matiere_id
WHERE m.nom ILIKE '%esth%' OR m.nom ILIKE '%artist%'
GROUP BY 1, 2 ORDER BY 1, 2;
ROLLBACK;
