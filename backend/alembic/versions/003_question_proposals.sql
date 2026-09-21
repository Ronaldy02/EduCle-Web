-- Migration 003 : Table question_proposals (propositions des utilisateurs)
-- Exécuter dans Supabase SQL Editor avant de déployer le backend.

CREATE TABLE IF NOT EXISTS question_proposals (
    id                SERIAL PRIMARY KEY,
    chapitre_id       INTEGER REFERENCES chapitres(id) ON DELETE SET NULL,
    matiere_id        INTEGER,
    nom_proposant     VARCHAR(100) NOT NULL DEFAULT 'Anonyme',
    enonce            TEXT NOT NULL,
    choix             JSONB NOT NULL,
    bonne_reponse     VARCHAR(500) NOT NULL,
    explication       TEXT NOT NULL DEFAULT '',
    niveau_complexite VARCHAR(20) NOT NULL DEFAULT 'Moyen',
    statut            VARCHAR(20) NOT NULL DEFAULT 'en_attente',
    created_at        VARCHAR(30) NOT NULL DEFAULT '',
    remarque_admin    TEXT
);

CREATE INDEX IF NOT EXISTS idx_proposals_statut ON question_proposals (statut);
CREATE INDEX IF NOT EXISTS idx_proposals_created_at ON question_proposals (created_at DESC);
