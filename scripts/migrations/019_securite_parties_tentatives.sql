-- Sécurité (audit 2026-10-14) : parties côté serveur, limitation des tentatives, révocation des JWT.
-- Idempotent : uniquement des ajouts, peut être relancé sans effet de bord.
BEGIN;

-- Révocation des tokens : un JWT dont "tv" ne correspond plus est refusé
ALTER TABLE users ADD COLUMN IF NOT EXISTS token_version INTEGER NOT NULL DEFAULT 0;
-- Passe à TRUE quand Google a confirmé l'adresse e-mail du compte
ALTER TABLE users ADD COLUMN IF NOT EXISTS email_verifie BOOLEAN NOT NULL DEFAULT FALSE;

-- Partie de quiz : questions servies et réponses données sont tenues par le serveur
CREATE TABLE IF NOT EXISTS parties (
    id           BIGSERIAL PRIMARY KEY,
    user_id      INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    mode_nom     VARCHAR(30) NOT NULL,
    chapitre_id  INTEGER NOT NULL,
    matiere_id   INTEGER,
    question_ids JSONB NOT NULL,
    reponses     JSONB NOT NULL DEFAULT '[]'::jsonb,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
    terminee     BOOLEAN NOT NULL DEFAULT FALSE
);
CREATE INDEX IF NOT EXISTS ix_parties_user_created ON parties (user_id, created_at);

-- Tentatives (connexion, inscription, propositions…) pour limiter le débit par IP / e-mail
CREATE TABLE IF NOT EXISTS tentatives (
    id         BIGSERIAL PRIMARY KEY,
    cle        VARCHAR(300) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS ix_tentatives_cle_created ON tentatives (cle, created_at);

-- Tables réservées au backend : aucun accès via la clé anon Supabase
ALTER TABLE parties    ENABLE ROW LEVEL SECURITY;
ALTER TABLE tentatives ENABLE ROW LEVEL SECURITY;

SELECT
  (SELECT COUNT(*) FROM information_schema.columns
     WHERE table_name = 'users' AND column_name IN ('token_version', 'email_verifie')) AS colonnes_users,
  to_regclass('public.parties')    AS table_parties,
  to_regclass('public.tentatives') AS table_tentatives;
COMMIT;
