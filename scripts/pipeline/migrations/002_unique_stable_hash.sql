-- Migration 002 : Contrainte UNIQUE sur questions.stable_hash
-- PRÉREQUIS OBLIGATOIRES avant d'appliquer :
--   1. Exécuter audit_duplicates.py et vérifier 0 doublon
--   2. Supprimer les IDs en double (voir delete_duplicates.sql)
--   3. Vérifier que COUNT(DISTINCT stable_hash) = COUNT(*) pour les lignes non-NULL

-- Vérification préalable (exécuter d'abord) :
-- SELECT COUNT(*) AS total,
--        COUNT(DISTINCT stable_hash) AS uniques,
--        SUM(CASE WHEN stable_hash IS NULL THEN 1 ELSE 0 END) AS nulls
-- FROM questions;

-- Appliquer seulement quand total = uniques + nulls :
ALTER TABLE questions
    ADD CONSTRAINT uq_questions_stable_hash UNIQUE (stable_hash);

-- Note : NULL est autorisé (questions sans stable_hash ne sont pas concernées
-- par la contrainte UNIQUE en PostgreSQL — chaque NULL est distinct).

-- Vérification post-migration :
SELECT COUNT(*) FROM questions WHERE stable_hash IS NOT NULL;
