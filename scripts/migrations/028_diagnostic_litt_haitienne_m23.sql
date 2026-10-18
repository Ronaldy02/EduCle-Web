-- Diagnostic littérature haïtienne : chapitres de la matière 23, comptages seulement, ROLLBACK
BEGIN;
SELECT c.matiere_id, COUNT(DISTINCT c.id) AS nb_chapitres, COUNT(q.id) AS nb_questions
FROM chapitres c LEFT JOIN questions q ON q.chapitre_id = c.id
WHERE c.matiere_id = 23 GROUP BY c.matiere_id;

SELECT c.id, c.niveau_v4,
  (SELECT string_agg(cn.niveau_v4, ',' ORDER BY cn.niveau_v4) FROM chapitre_niveaux cn WHERE cn.chapitre_id = c.id) AS liaisons,
  c.titre, COUNT(q.id) AS nb_questions
FROM chapitres c LEFT JOIN questions q ON q.chapitre_id = c.id
WHERE c.matiere_id = 23
GROUP BY c.id ORDER BY c.niveau_v4, c.id;

ROLLBACK;
