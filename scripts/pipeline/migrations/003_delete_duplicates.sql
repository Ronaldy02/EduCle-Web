-- Migration 003 : Suppression des doublons stable_hash dans questions (production)
-- PRÉREQUIS : Exécuter audit_duplicates.py et vérifier la liste ci-dessous.
-- On conserve MIN(id) (première insertion) et supprime MAX(id) (doublon du run concurrent).
-- Exécuter en TRANSACTION pour pouvoir ROLLBACK si besoin.

BEGIN;

-- Vérification avant suppression
SELECT stable_hash, MIN(id) AS id_keep, MAX(id) AS id_dupe, COUNT(*) AS cnt
FROM questions
WHERE stable_hash IS NOT NULL
GROUP BY stable_hash
HAVING COUNT(*) > 1
ORDER BY MIN(id);

-- Suppression des doublons (MAX id pour chaque stable_hash dupliqué)
DELETE FROM questions
WHERE id IN (
    SELECT MAX(id)
    FROM questions
    WHERE stable_hash IS NOT NULL
    GROUP BY stable_hash
    HAVING COUNT(*) > 1
);

-- Vérification post-suppression : doit retourner 0 lignes
SELECT stable_hash, COUNT(*)
FROM questions
WHERE stable_hash IS NOT NULL
GROUP BY stable_hash
HAVING COUNT(*) > 1;

-- Si la vérification retourne 0 lignes : COMMIT
-- Sinon : ROLLBACK
COMMIT;
-- ROLLBACK;
