-- Migration 054 : table codes_reinitialisation pour le flux « mot de passe oublié »
-- Additive, idempotente. Ne pas appliquer en production sans accord de Ronaldy.

CREATE TABLE IF NOT EXISTS codes_reinitialisation (
    id          BIGSERIAL PRIMARY KEY,
    user_id     INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    code_hash   VARCHAR(128) NOT NULL,
    expire_le   TIMESTAMPTZ NOT NULL,
    tentatives  INTEGER NOT NULL DEFAULT 0,
    utilise     BOOLEAN NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_codes_reinit_user
    ON codes_reinitialisation (user_id);

-- Table réservée au backend : sans RLS, la clé anon Supabase pourrait remettre
-- le compteur de tentatives à zéro et deviner le code par force brute.
ALTER TABLE codes_reinitialisation ENABLE ROW LEVEL SECURITY;
