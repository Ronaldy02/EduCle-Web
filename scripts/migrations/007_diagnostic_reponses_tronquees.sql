-- Diagnostic 007 : comptages seulement (aucune donnée exportée), toujours ROLLBACK
BEGIN;
SELECT m.nom AS matiere,
       COUNT(*) AS total,
       SUM((q.bonne_reponse ~* '\m(le|la|les|l''|de|des|du|d''|et|à|au|aux|un|une|en|par|sur|dans|qui|que|pour|avec|son|sa|ses|leur|ce|cette|entre)$')::int) AS reponse_coupee,
       SUM((rtrim(q.enonce) LIKE '%:')::int) AS enonce_a_completer,
       SUM((array_length(regexp_split_to_array(btrim(q.bonne_reponse), '\s+'), 1) > 6)::int) AS reponse_plus_6_mots
FROM questions q JOIN chapitres c ON c.id = q.chapitre_id JOIN matieres m ON m.id = c.matiere_id
GROUP BY m.nom ORDER BY reponse_coupee DESC;
ROLLBACK;
