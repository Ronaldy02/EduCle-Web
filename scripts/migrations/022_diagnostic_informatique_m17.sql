-- Diagnostic informatique : chapitres de la matière 17 (Informatique), comptages seulement, ROLLBACK
BEGIN;
SELECT c.matiere_id, COUNT(DISTINCT c.id) AS nb_chapitres, COUNT(q.id) AS nb_questions
FROM chapitres c LEFT JOIN questions q ON q.chapitre_id = c.id
WHERE c.matiere_id = 17 GROUP BY c.matiere_id;

SELECT c.id, c.niveau_v4,
  (SELECT string_agg(cn.niveau_v4, ',' ORDER BY cn.niveau_v4) FROM chapitre_niveaux cn WHERE cn.chapitre_id = c.id) AS liaisons,
  c.titre, COUNT(q.id) AS nb_questions
FROM chapitres c LEFT JOIN questions q ON q.chapitre_id = c.id
WHERE c.matiere_id = 17
GROUP BY c.id ORDER BY c.niveau_v4, c.id;

SELECT q.v4_niveau, COUNT(*) AS nb_questions
FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = 17 GROUP BY q.v4_niveau ORDER BY 1;
ROLLBACK;
