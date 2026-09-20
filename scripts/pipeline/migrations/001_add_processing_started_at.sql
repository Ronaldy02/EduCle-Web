-- Migration 001 : Ajouter processing_started_at à questions_staging
-- Requis par publish_to_prod.py pour le mécanisme de récupération des lignes abandonnées.
-- Appliquer manuellement dans Supabase SQL Editor AVANT le prochain run du pipeline.

ALTER TABLE questions_staging
    ADD COLUMN IF NOT EXISTS processing_started_at TIMESTAMPTZ DEFAULT NULL;

-- Index pour accélérer la requête de récupération des lignes abandonnées
CREATE INDEX IF NOT EXISTS idx_staging_processing_started_at
    ON questions_staging (processing_started_at)
    WHERE statut = 'processing';

-- Vérification
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'questions_staging'
  AND column_name = 'processing_started_at';
