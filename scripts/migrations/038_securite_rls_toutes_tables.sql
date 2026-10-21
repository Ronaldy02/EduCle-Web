-- Sécurité (alerte Supabase rls_disabled_in_public, 2026-10-17) :
-- active Row Level Security sur TOUTES les tables du schéma public qui ne l'ont pas.
-- Sans politique, la clé anon / authenticated ne peut plus rien lire ni écrire.
-- Le backend (rôle postgres, propriétaire, BYPASSRLS) n'est pas affecté.
-- Idempotent : peut être relancé sans effet de bord.
BEGIN;

-- Avant : tables sans RLS et droits accordés à anon / authenticated
SELECT c.relname AS table_sans_rls,
       has_table_privilege('anon', c.oid, 'SELECT') AS anon_select,
       has_table_privilege('anon', c.oid, 'INSERT') AS anon_insert,
       (SELECT COUNT(*) FROM pg_policies p WHERE p.schemaname = 'public' AND p.tablename = c.relname) AS nb_politiques
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'public' AND c.relkind IN ('r', 'p') AND NOT c.relrowsecurity
ORDER BY c.relname;

DO $$
DECLARE t record;
BEGIN
  FOR t IN
    SELECT c.relname
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = 'public' AND c.relkind IN ('r', 'p') AND NOT c.relrowsecurity
  LOOP
    EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY', t.relname);
    RAISE NOTICE 'RLS activé sur %', t.relname;
  END LOOP;
END $$;

-- Politiques existantes (aucune n'est attendue : l'API publique n'est pas utilisée)
SELECT tablename, policyname, roles, cmd FROM pg_policies WHERE schemaname = 'public' ORDER BY tablename;

-- Après : doit être vide
SELECT c.relname AS encore_sans_rls
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'public' AND c.relkind IN ('r', 'p') AND NOT c.relrowsecurity;

COMMIT;
