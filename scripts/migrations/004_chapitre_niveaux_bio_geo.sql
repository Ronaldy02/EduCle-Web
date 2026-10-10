-- Migration 004 : Table de liaison chapitre ↔ niveaux + structure Biologie (11) / Géologie (12) NS1–NS4
-- Référence : curriculum/biologie_geologie_ns.md (programme SVT MENFP, 24/07/2024)
-- Appliquer manuellement dans Supabase SQL Editor, en TRANSACTION.
--
-- Principes :
--   * chapitre_niveaux = source de vérité des niveaux d'un chapitre (un chapitre commun = plusieurs lignes).
--   * chapitres.niveau_v4 est conservé (compatibilité) et contient le niveau PRINCIPAL (le plus bas).
--   * Idempotent : peut être rejoué sans créer de doublons.
--
-- NON TRAITÉ ICI (étape suivante, question par question) :
--   * « Évolution et classification du vivant » (Bio NS3)      → à répartir dans « Classification du vivant » / « Évolution et sélection naturelle »
--   * « Écologie et dynamique des écosystèmes » (Bio NS4)       → à répartir dans « Les interactions écologiques » / « Biodiversité et équilibre écologique »
--   * « Séismes et volcans : risques naturels » (Géol NS3)      → à répartir dans les chapitres séismes / volcans NS1
--   Ces 3 chapitres restent visibles à leur niveau actuel jusqu'à la répartition, puis seront supprimés.

BEGIN;

-- ─────────────────────────────────────────────────────────────
-- 1. Table de liaison
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS chapitre_niveaux (
    chapitre_id INTEGER     NOT NULL REFERENCES chapitres(id) ON DELETE CASCADE,
    niveau_v4   VARCHAR(20) NOT NULL,
    ordre       SMALLINT,               -- position du chapitre dans ce niveau (NULL = non défini)
    PRIMARY KEY (chapitre_id, niveau_v4)
);

CREATE INDEX IF NOT EXISTS idx_chapitre_niveaux_niveau ON chapitre_niveaux (niveau_v4);

-- ─────────────────────────────────────────────────────────────
-- 2. Structure cible Biologie / Géologie
--    niveaux[1] = niveau principal ; ordres alignés sur niveaux
-- ─────────────────────────────────────────────────────────────
CREATE TEMP TABLE cible (matiere_id INT, titre TEXT, niveaux TEXT[], ordres INT[]) ON COMMIT DROP;

INSERT INTO cible (matiere_id, titre, niveaux, ordres) VALUES
-- BIOLOGIE NS1
(11, 'Aliments, nutriments et ration alimentaire',                 '{NS1}',         '{1}'),
(11, 'Le tube digestif et la digestion',                           '{NS1}',         '{2}'),
(11, 'Maladies liées à l''alimentation',                           '{NS1}',         '{3}'),
(11, 'Le rein et l''excrétion',                                    '{NS1}',         '{4}'),
(11, 'La cellule : unité du vivant',                               '{NS1}',         '{5}'),
(11, 'Cellules eucaryotes et procaryotes',                         '{NS1}',         '{6}'),
(11, 'La division cellulaire : mitose et méiose',                  '{NS1,NS2}',     '{7,8}'),
(11, 'Classification du vivant',                                   '{NS1}',         '{8}'),
(11, 'Biodiversité et équilibre écologique',                       '{NS1,NS2}',     '{9,9}'),
(11, 'Évolution et sélection naturelle',                           '{NS1,NS2}',     '{10,10}'),
(11, 'Les interactions écologiques',                               '{NS1,NS2}',     '{11,11}'),
-- BIOLOGIE NS2
(11, 'Le système respiratoire',                                    '{NS2}',         '{1}'),
(11, 'Tabac et maladies respiratoires',                            '{NS2}',         '{2}'),
(11, 'Le cœur et la circulation sanguine',                         '{NS2}',         '{3}'),
(11, 'Adaptation cardiaque et respiratoire à l''effort',           '{NS2}',         '{4}'),
(11, 'Les maladies cardiovasculaires',                             '{NS2}',         '{5}'),
(11, 'Structure et fonction des molécules biologiques',            '{NS2}',         '{6}'),
(11, 'Métabolisme : photosynthèse et respiration cellulaire',      '{NS2,NS3}',     '{7,15}'),
(11, 'Conservation de la biodiversité',                            '{NS2}',         '{12}'),
-- BIOLOGIE NS3
(11, 'Les muscles : types, structure et propriétés',               '{NS3}',         '{1}'),
(11, 'Le sang et l''approvisionnement des muscles',                '{NS3}',         '{2}'),
(11, 'Énergie musculaire, sport et santé',                         '{NS3}',         '{3}'),
(11, 'Appareils reproducteurs et identité sexuée',                 '{NS3}',         '{4}'),
(11, 'Régulation hormonale de la reproduction',                    '{NS3}',         '{5}'),
(11, 'Contraception et maîtrise de la procréation',                '{NS3}',         '{6}'),
(11, 'Sexualité, cerveau et identité',                             '{NS3}',         '{7}'),
(11, 'IST et santé reproductive',                                  '{NS3}',         '{8}'),
(11, 'ADN, réplication et expression génétique',                   '{NS3}',         '{9}'),
(11, 'Traduction et code génétique',                               '{NS3}',         '{10}'),
(11, 'Régulation de l''expression des gènes',                      '{NS3}',         '{11}'),
(11, 'Mutations et maladies génétiques',                           '{NS3}',         '{12}'),
(11, 'Organisation de la plante et échanges avec le milieu',       '{NS3}',         '{13}'),
(11, 'Croissance et développement des plantes',                    '{NS3}',         '{14}'),
-- BIOLOGIE NS4
(11, 'Organisation du système nerveux',                            '{NS4}',         '{1}'),
(11, 'Le message nerveux',                                         '{NS4}',         '{2}'),
(11, 'Troubles neurologiques et maladies neurodégénératives',      '{NS4}',         '{3}'),
(11, 'Drogues, alcool et addictions',                              '{NS4}',         '{4}'),
(11, 'L''œil et la vision',                                        '{NS4}',         '{5}'),
(11, 'Les micro-organismes et leur découverte',                    '{NS4}',         '{6}'),
(11, 'Immunité innée',                                             '{NS4}',         '{7}'),
(11, 'Immunité acquise',                                           '{NS4}',         '{8}'),
(11, 'Grandes maladies infectieuses',                              '{NS4}',         '{9}'),
(11, 'Antibiotiques, vaccins et médicaments',                      '{NS4}',         '{10}'),
(11, 'Génétique : hérédité et lois de Mendel',                     '{NS4}',         '{11}'),  -- déplacé de NS1
(11, 'Caryotype et maladies héréditaires',                         '{NS4}',         '{12}'),
(11, 'Biotechnologies et applications de la biologie',             '{NS4}',         '{13}'),
(11, 'Agriculture et systèmes de culture',                         '{NS4}',         '{14}'),
(11, 'Symbioses entre plantes et micro-organismes',                '{NS4}',         '{15}'),
(11, 'Lutte biologique contre les ravageurs',                      '{NS4}',         '{16}'),
-- GÉOLOGIE NS1
(12, 'Structure interne de la Terre',                              '{NS1,NS4}',     '{1,2}'),
(12, 'Tectonique des plaques',                                     '{NS1,NS4}',     '{2,3}'),
(12, 'Les séismes : définitions et mesure',                        '{NS1}',         '{3}'),
(12, 'Failles, plis et causes des séismes',                        '{NS1}',         '{4}'),
(12, 'Les séismes en Haïti et la prévention',                      '{NS1}',         '{5}'),
(12, 'Les volcans : structure, produits et types',                 '{NS1}',         '{6}'),
(12, 'Le volcanisme en Haïti et la prévention',                    '{NS1}',         '{7}'),
(12, 'Les roches et le cycle des roches',                          '{NS1}',         '{8}'),   -- déplacé de NS2
(12, 'Les glissements de terrain',                                 '{NS1}',         '{9}'),
(12, 'Érosion, sédimentation et dépôts',                           '{NS1}',         '{10}'),
-- GÉOLOGIE NS2
(12, 'Les perturbations atmosphériques',                           '{NS2}',         '{1}'),
(12, 'Les cyclones en Haïti : impacts et prévention',              '{NS2}',         '{2}'),
(12, 'L''eau : répartition, cycle et ressource',                   '{NS2,NS3}',     '{3,9}'),
(12, 'Pollution de l''eau et potabilité',                          '{NS2}',         '{4}'),
(12, 'Les sols : nature et types',                                 '{NS2}',         '{5}'),
(12, 'Pollution des sols',                                         '{NS2}',         '{6}'),
-- GÉOLOGIE NS3
(12, 'L''atmosphère : composition et phénomènes',                  '{NS3}',         '{1}'),
(12, 'Le système climatique',                                      '{NS3}',         '{2}'),
(12, 'Variabilité et changements climatiques naturels',            '{NS3}',         '{3}'),
(12, 'Effet de serre et changement climatique',                    '{NS3}',         '{4}'),
(12, 'Impacts, atténuation et adaptation',                         '{NS3}',         '{5}'),
(12, 'Ressources naturelles et géologie économique',               '{NS3}',         '{6}'),   -- déplacé de NS4
(12, 'Prospection et exploitation minière',                        '{NS3}',         '{7}'),
(12, 'Loi minière, durabilité et enjeux',                          '{NS3}',         '{8}'),
(12, 'La Terre, une planète singulière',                           '{NS3}',         '{10}'),
-- GÉOLOGIE NS4
(12, 'Histoire de l''Univers et du système solaire',               '{NS4}',         '{1}'),
(12, 'Divergence, subduction et collision',                        '{NS4}',         '{4}'),
(12, 'Origine de la vie et premiers êtres vivants',                '{NS4}',         '{5}'),
(12, 'Ères géologiques, explosion cambrienne et crises biologiques','{NS4}',        '{6}'),
(12, 'Chronologie relative',                                       '{NS4}',         '{7}'),
(12, 'Chronologie absolue et datation',                            '{NS4}',         '{8}'),
(12, 'La lignée humaine',                                          '{NS4}',         '{9}'),
(12, 'Phylogénie et génomes des hominidés',                        '{NS4}',         '{10}');

-- Garde-fou : un titre en double dans la cible ferait échouer silencieusement la logique
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM cible GROUP BY matiere_id, titre HAVING COUNT(*) > 1) THEN
    RAISE EXCEPTION 'Titre en double dans la structure cible';
  END IF;
  IF EXISTS (SELECT 1 FROM chapitres WHERE matiere_id IN (11,12) GROUP BY matiere_id, titre HAVING COUNT(*) > 1) THEN
    RAISE EXCEPTION 'Chapitres Bio/Géol en double en base : dédoublonner avant migration';
  END IF;
END $$;

-- ─────────────────────────────────────────────────────────────
-- 3. Chapitres existants déplacés : mettre aussi à jour le niveau des questions
-- ─────────────────────────────────────────────────────────────
UPDATE questions q
SET v4_niveau = c.niveaux[1]
FROM chapitres ch
JOIN cible c ON c.matiere_id = ch.matiere_id AND c.titre = ch.titre
WHERE q.chapitre_id = ch.id
  AND cardinality(c.niveaux) = 1                       -- chapitres mono-niveau uniquement
  AND ch.niveau_v4 IS DISTINCT FROM c.niveaux[1];       -- Mendel NS1→NS4, Roches NS2→NS1, Ressources NS4→NS3

-- ─────────────────────────────────────────────────────────────
-- 4. Mettre à jour le niveau principal des chapitres existants
-- ─────────────────────────────────────────────────────────────
UPDATE chapitres ch
SET niveau_v4 = c.niveaux[1]
FROM cible c
WHERE c.matiere_id = ch.matiere_id AND c.titre = ch.titre
  AND ch.niveau_v4 IS DISTINCT FROM c.niveaux[1];

-- ─────────────────────────────────────────────────────────────
-- 5. Créer les nouveaux chapitres
-- ─────────────────────────────────────────────────────────────
INSERT INTO chapitres (matiere_id, titre, niveau_v4)
SELECT c.matiere_id, c.titre, c.niveaux[1]
FROM cible c
WHERE NOT EXISTS (
  SELECT 1 FROM chapitres ch WHERE ch.matiere_id = c.matiere_id AND ch.titre = c.titre
);

-- ─────────────────────────────────────────────────────────────
-- 6. Liaisons Bio/Géol (tous niveaux, y compris secondaires)
-- ─────────────────────────────────────────────────────────────
DELETE FROM chapitre_niveaux cn
USING chapitres ch, cible c
WHERE cn.chapitre_id = ch.id
  AND c.matiere_id = ch.matiere_id AND c.titre = ch.titre;

INSERT INTO chapitre_niveaux (chapitre_id, niveau_v4, ordre)
SELECT ch.id, u.niveau, u.ordre
FROM cible c
JOIN chapitres ch ON ch.matiere_id = c.matiere_id AND ch.titre = c.titre
CROSS JOIN LATERAL unnest(c.niveaux, c.ordres) AS u(niveau, ordre);

-- ─────────────────────────────────────────────────────────────
-- 7. Backfill : tous les autres chapitres (autres matières + 3 chapitres Bio/Géol à répartir)
--    reçoivent leur niveau actuel
-- ─────────────────────────────────────────────────────────────
INSERT INTO chapitre_niveaux (chapitre_id, niveau_v4)
SELECT ch.id, ch.niveau_v4
FROM chapitres ch
WHERE ch.niveau_v4 IS NOT NULL
ON CONFLICT (chapitre_id, niveau_v4) DO NOTHING;

-- ─────────────────────────────────────────────────────────────
-- 8. Vérifications (lire les résultats AVANT de valider)
-- ─────────────────────────────────────────────────────────────
-- 8a. Structure Bio/Géol par niveau : attendu Bio NS1=11, NS2=12, NS3=15, NS4=16 (+ chapitres à répartir)
--                                     Géol NS1=10, NS2=6, NS3=10, NS4=10 (+ chapitre à répartir)
SELECT ch.matiere_id, cn.niveau_v4, COUNT(*) AS nb_chapitres
FROM chapitre_niveaux cn JOIN chapitres ch ON ch.id = cn.chapitre_id
WHERE ch.matiere_id IN (11,12)
GROUP BY ch.matiere_id, cn.niveau_v4
ORDER BY ch.matiere_id, cn.niveau_v4;

-- 8b. Chapitres Bio/Géol hors structure cible (attendu : les 3 chapitres à répartir)
SELECT ch.id, ch.matiere_id, ch.titre, ch.niveau_v4,
       (SELECT COUNT(*) FROM questions q WHERE q.chapitre_id = ch.id) AS nb_questions
FROM chapitres ch
WHERE ch.matiere_id IN (11,12)
  AND NOT EXISTS (SELECT 1 FROM cible c WHERE c.matiere_id = ch.matiere_id AND c.titre = ch.titre);

-- 8c. Valeurs de niveau présentes (repérer d'éventuelles graphies non canoniques)
SELECT niveau_v4, COUNT(*) FROM chapitre_niveaux GROUP BY niveau_v4 ORDER BY niveau_v4;

-- 8d. Chapitres sans aucun niveau
SELECT COUNT(*) AS chapitres_sans_niveau
FROM chapitres ch WHERE NOT EXISTS (SELECT 1 FROM chapitre_niveaux cn WHERE cn.chapitre_id = ch.id);

-- Si les vérifications sont correctes : COMMIT ; sinon : ROLLBACK
COMMIT;
-- ROLLBACK;
