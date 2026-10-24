-- Migration 055 : abonnements Web Push et préférences de rappels
-- Additive, idempotente. Ne pas appliquer en production sans accord de Ronaldy.

CREATE TABLE IF NOT EXISTS abonnements_push (
    id              BIGSERIAL PRIMARY KEY,
    user_id         INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    endpoint        TEXT NOT NULL UNIQUE,
    cle_p256dh      TEXT NOT NULL,
    cle_auth        TEXT NOT NULL,
    rappel_debut    BOOLEAN NOT NULL DEFAULT TRUE,
    rappel_fin      BOOLEAN NOT NULL DEFAULT TRUE,
    derniere_erreur TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_abonnements_push_user
    ON abonnements_push (user_id);
