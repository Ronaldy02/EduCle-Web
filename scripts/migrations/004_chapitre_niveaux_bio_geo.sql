-- Migration 004 : Table de liaison chapitre ↔ niveaux + structure Biologie (11) / Géologie (12) NS1–NS4
-- Référence : curriculum/biologie_geologie_ns.md (programme SVT MENFP, 24/07/2024)
-- Appliquer manuellement dans Supabase SQL Editor, en TRANSACTION.
--
-- Principes :
--   * chapitre_niveaux = source de vérité des niveaux d'un chapitre (un chapitre commun = plusieurs lignes).
--   * chapitres.niveau_v4 est conservé (compatibilité) et contient le niveau PRINCIPAL (le plus bas).
--   * Idempotent : peut être rejoué sans créer de doublons.
--
-- Répartition (section 6b) : les questions des anciens chapitres Bio/Géol de production
--   (« Génétique et hérédité », « Minéraux, roches et ressources minières »,
--    « Risques géologiques et protection », « Géologie d'Haïti et ressources naturelles »,
--    et « Structure interne de la Terre » pour les questions hors sujet)
--   sont déplacées question par question (correspondance exacte sur l'énoncé, source :
--   seed Dart Mobile/lib/services/database_helper.dart). Les anciens chapitres vidés sont supprimés.

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
-- 6b. Répartition des questions des anciens chapitres (par énoncé exact)
-- ─────────────────────────────────────────────────────────────
CREATE TEMP TABLE repartition (matiere_id INT, enonce TEXT, titre TEXT, niveau TEXT) ON COMMIT DROP;

INSERT INTO repartition (matiere_id, enonce, titre, niveau) VALUES
(11, 'Un gène est :', 'ADN, réplication et expression génétique', 'NS3'),
(11, 'Dans les lois de Mendel, l''allèle dominant est celui qui :', 'Génétique : hérédité et lois de Mendel', 'NS4'),
(11, 'Un individu homozygote pour un gène possède :', 'Génétique : hérédité et lois de Mendel', 'NS4'),
(11, 'Chez l''humain, le sexe est déterminé par les chromosomes sexuels :', 'Appareils reproducteurs et identité sexuée', 'NS3'),
(11, 'La drépanocytose (anémie falciforme) est une maladie génétique :', 'Caryotype et maladies héréditaires', 'NS4'),
(11, 'Le carré de Punnett est utilisé pour :', 'Génétique : hérédité et lois de Mendel', 'NS4'),
(11, 'Si les deux parents sont porteurs sains (Aa × Aa), la probabilité d''un enfant malade (aa) est :', 'Génétique : hérédité et lois de Mendel', 'NS4'),
(11, 'Le génotype désigne :', 'Génétique : hérédité et lois de Mendel', 'NS4'),
(11, 'Le phénotype est influencé par :', 'Génétique : hérédité et lois de Mendel', 'NS4'),
(11, 'Une mutation est :', 'Mutations et maladies génétiques', 'NS3'),
(11, 'La méiose produit des cellules avec :', 'La division cellulaire : mitose et méiose', 'NS2'),
(11, 'Les groupes sanguins ABO chez l''humain sont déterminés par :', 'Génétique : hérédité et lois de Mendel', 'NS4'),
(11, 'La daltonisme (déficience de la vision des couleurs) est surtout chez les hommes car c''est :', 'Génétique : hérédité et lois de Mendel', 'NS4'),
(11, 'La recombinaison génétique lors de la méiose contribue à :', 'La division cellulaire : mitose et méiose', 'NS2'),
(11, 'Le test ADN de paternité est possible car :', 'Biotechnologies et applications de la biologie', 'NS4'),
(11, 'Les jumeaux monozygotes (vrais jumeaux) sont génétiquement :', 'Génétique : hérédité et lois de Mendel', 'NS4'),
(11, 'Le génie génétique permet de :', 'Biotechnologies et applications de la biologie', 'NS4'),
(11, 'L''épigénétique étudie :', 'Régulation de l''expression des gènes', 'NS3'),
(11, 'Le séquençage du génome humain (Human Genome Project) a été achevé en :', 'Biotechnologies et applications de la biologie', 'NS4'),
(11, 'Les maladies génétiques sont causées par :', 'Mutations et maladies génétiques', 'NS3'),
(11, 'La trisomie 21 (syndrome de Down) est causée par :', 'Caryotype et maladies héréditaires', 'NS4'),
(11, 'Qu''est-ce qu''un porteur sain pour une maladie génétique récessive ?', 'Génétique : hérédité et lois de Mendel', 'NS4'),
(11, 'La polydactylie (doigts supplémentaires) est un caractère :', 'Génétique : hérédité et lois de Mendel', 'NS4'),
(11, 'Gregor Mendel est connu pour :', 'Génétique : hérédité et lois de Mendel', 'NS4'),
(11, 'Watson et Crick ont découvert en 1953 :', 'ADN, réplication et expression génétique', 'NS3'),
(12, 'Quelles sont les couches internes de la Terre de la surface vers le centre ?', 'Structure interne de la Terre', 'NS1'),
(12, 'Quelle est la composition principale du noyau terrestre ?', 'Structure interne de la Terre', 'NS1'),
(12, 'La théorie de la tectonique des plaques explique :', 'Tectonique des plaques', 'NS1'),
(12, 'La dérive des continents a été proposée par :', 'Tectonique des plaques', 'NS1'),
(12, 'À une frontière divergente de plaques, on observe :', 'Divergence, subduction et collision', 'NS4'),
(12, 'La subduction est le processus par lequel :', 'Divergence, subduction et collision', 'NS4'),
(12, 'La lithosphère comprend :', 'Structure interne de la Terre', 'NS1'),
(12, 'La dorsale médio-atlantique est un exemple de :', 'Divergence, subduction et collision', 'NS4'),
(12, 'La faille de San Andreas en Californie est une :', 'Tectonique des plaques', 'NS1'),
(12, 'Comment les scientifiques étudient-ils l''intérieur de la Terre ?', 'Structure interne de la Terre', 'NS1'),
(12, 'La croûte océanique est plus ________ que la croûte continentale.', 'Structure interne de la Terre', 'NS1'),
(12, 'Combien de grandes plaques tectoniques majeures existent-il approximativement ?', 'Tectonique des plaques', 'NS1'),
(12, 'Le noyau externe de la Terre est à l''état :', 'Structure interne de la Terre', 'NS1'),
(12, 'La température au centre de la Terre est estimée à environ :', 'Structure interne de la Terre', 'NS1'),
(12, 'Le supercontinent originel est appelé :', 'Tectonique des plaques', 'NS1'),
(12, 'Les ondes sismiques de type S (ondes secondaires) :', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'Le champ magnétique terrestre est généré par :', 'Structure interne de la Terre', 'NS1'),
(12, 'Les chaînes de montagnes comme les Andes se forment aux :', 'Divergence, subduction et collision', 'NS4'),
(12, 'Les points chauds (hot spots) comme celui d''Hawaï sont :', 'Tectonique des plaques', 'NS1'),
(12, 'L''âge de la Terre est estimé à environ :', 'Chronologie absolue et datation', 'NS4'),
(12, 'La pression dans le manteau terrestre est si élevée qu''elle :', 'Structure interne de la Terre', 'NS1'),
(12, 'Les tsunamis sont généralement causés par :', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'La convection dans le manteau terrestre est le moteur :', 'Tectonique des plaques', 'NS1'),
(12, 'La croûte continentale est principalement composée de roches :', 'Structure interne de la Terre', 'NS1'),
(12, 'Les Himalayas se sont formés par :', 'Divergence, subduction et collision', 'NS4'),
(12, 'Un minéral est :', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Le granite est une roche :', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Le basalte est une roche :', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Le calcaire est une roche :', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Le marbre est du calcaire :', 'Les roches et le cycle des roches', 'NS1'),
(12, 'L''échelle de dureté de Mohs classe les minéraux de :', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Le pétrole et le charbon sont des roches :', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'La bauxite est le minerai principal de :', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Haïti possède des ressources minières importantes notamment :', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'L''érosion est le processus par lequel :', 'Érosion, sédimentation et dépôts', 'NS1'),
(12, 'Les roches sédimentaires se forment par :', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Le quartz (SiO₂) est l''un des minéraux les plus abondants dans la croûte terrestre. Sa dureté dans l''échelle de Mohs est :', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Un fossile est :', 'Chronologie relative', 'NS4'),
(12, 'La datation radiométrique utilise :', 'Chronologie absolue et datation', 'NS4'),
(12, 'Le schiste ardoisier est une roche :', 'Les roches et le cycle des roches', 'NS1'),
(12, 'La couleur d''un minéral est-elle toujours fiable pour l''identifier ?', 'Les roches et le cycle des roches', 'NS1'),
(12, 'L''obsidienne est un verre volcanique formé par :', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Les ressources minières d''Haïti (or, cuivre) se trouvent principalement dans :', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'La roche mère d''un sol est :', 'Les sols : nature et types', 'NS2'),
(12, 'L''exploitation minière peut causer :', 'Loi minière, durabilité et enjeux', 'NS3'),
(12, 'La stalactite se forme dans une grotte calcaire par :', 'Érosion, sédimentation et dépôts', 'NS1'),
(12, 'Un gisement de minerai est exploitable quand :', 'Prospection et exploitation minière', 'NS3'),
(12, 'Le calcaire, roche sédimentaire abondante en Haïti, est utilisé pour :', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Le sel gemme (NaCl) est une roche :', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Un geyser est :', 'Les volcans : structure, produits et types', 'NS1'),
(12, 'Un séisme est provoqué par :', 'Failles, plis et causes des séismes', 'NS1'),
(12, 'L''épicentre d''un séisme est :', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'L''échelle de Richter mesure :', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'Le séisme qui a frappé Haïti le 12 janvier 2010 avait une magnitude de :', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'La faille Enriquillo-Plantain Garden est importante car :', 'Tectonique des plaques', 'NS1'),
(12, 'Un volcan en éruption peut causer :', 'Les volcans : structure, produits et types', 'NS1'),
(12, 'Le risque sismique en Haïti est élevé principalement parce que :', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'Un tsunami est :', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'La prévention du risque sismique en zones urbaines passe principalement par :', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'Un glissement de terrain est particulièrement dangereux en Haïti car :', 'Les glissements de terrain', 'NS1'),
(12, 'L''échelle de Mercalli mesure :', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'Un lahar est :', 'Les volcans : structure, produits et types', 'NS1'),
(12, 'Les gaz émis par les volcans comprennent principalement :', 'Les volcans : structure, produits et types', 'NS1'),
(12, 'Comment se préparer à un séisme ?', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'La zone de subduction de Porto Rico est une menace pour Haïti car :', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'Le sismographe est un instrument qui :', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'Après un fort séisme, les répliques sont :', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'L''aléa sismique désigne :', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'Le séisme du 14 août 2021 en Haïti (magnitude 7,2) a particulièrement touché :', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'La réduction de la vulnérabilité face aux séismes en Haïti passe par :', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'Un raz-de-marée (terme courant pour tsunami) peut atteindre une hauteur de vague de :', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'Quel pays ou territoire voisin d''Haïti possède des volcans actifs ?', 'Le volcanisme en Haïti et la prévention', 'NS1'),
(12, 'Un séisme de magnitude 5 est :', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'L''île d''Hispaniola est située entre les plaques tectoniques :', 'Tectonique des plaques', 'NS1'),
(12, 'La bauxite haïtienne était exploitée principalement dans la région de :', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Les principales roches de surface en Haïti sont :', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Les eaux souterraines en Haïti sont importantes mais menacées par :', 'Pollution de l''eau et potabilité', 'NS2'),
(12, 'La principale faille sismique dans le sud d''Haïti s''appelle :', 'Tectonique des plaques', 'NS1'),
(12, 'Le calcaire karstique d''Haïti se caractérise par :', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Quel minerai est le plus exploité aujourd''hui en Haïti ?', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Les tremblements de terre en Haïti sont particulièrement destructeurs car :', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'La plaine de Port-au-Prince repose sur :', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Le golfe de la Gonâve est une dépression géologique formée par :', 'Tectonique des plaques', 'NS1'),
(12, 'Les coraux des côtes haïtiennes sont menacés par :', 'Pollution de l''eau et potabilité', 'NS2'),
(12, 'Les sources thermales (eaux chaudes) en Haïti, comme celles de Lavallee, indiquent :', 'Le volcanisme en Haïti et la prévention', 'NS1'),
(12, 'Le séisme de 2010 a été si dévastateur en partie parce que le foyer était :', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'La topographie accidentée d''Haïti (montagnes, vallées) résulte de :', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Quel est l''impact potentiel de l''exploitation minière sur les rivières haïtiennes ?', 'Loi minière, durabilité et enjeux', 'NS3'),
(12, 'La formation géologique des Antilles est liée à :', 'Divergence, subduction et collision', 'NS4'),
(12, 'La nappe phréatique est :', 'L''eau : répartition, cycle et ressource', 'NS2'),
(12, 'Quel département haïtien est le plus exposé aux séismes selon la faille du Nord ?', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'La grotte Marie-Jeanne, la plus grande grotte d''Haïti et de la Caraïbe, se trouve dans :', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Pourquoi est-il urgent de réduire la déforestation en Haïti du point de vue géologique ?', 'Les glissements de terrain', 'NS1'),
(12, 'Le Pic la Selle, point culminant d''Haïti, fait partie du :', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Quelles sont les trois couches principales de la structure interne de la Terre, de l''extérieur vers l''intérieur ?', 'Structure interne de la Terre', 'NS1'),
(12, 'Comment les scientifiques étudient-ils l''intérieur de la Terre qu''ils ne peuvent pas observer directement ?', 'Structure interne de la Terre', 'NS1'),
(12, 'Quelle est la différence entre la croûte océanique et la croûte continentale ?', 'Structure interne de la Terre', 'NS1'),
(12, 'Qu''est-ce que le manteau terrestre et quel est son état ?', 'Structure interne de la Terre', 'NS1'),
(12, 'Quelle est la composition probable du noyau terrestre et son état ?', 'Structure interne de la Terre', 'NS1'),
(12, 'Qu''est-ce que l''isostasie terrestre ?', 'Structure interne de la Terre', 'NS1'),
(12, 'Qu''est-ce que le gradient géothermique et quelle est sa valeur approximative ?', 'Structure interne de la Terre', 'NS1'),
(12, 'Qu''est-ce que la lithosphère et l''asthénosphère ?', 'Structure interne de la Terre', 'NS1'),
(12, 'Qu''est-ce que le champ magnétique terrestre et comment se forme-t-il ?', 'Structure interne de la Terre', 'NS1'),
(12, 'Qu''est-ce que le forage scientifique de Kola (Russie) a révélé sur l''intérieur de la Terre ?', 'Structure interne de la Terre', 'NS1'),
(12, 'Comment les météorites nous informent-elles sur la composition du noyau terrestre ?', 'Structure interne de la Terre', 'NS1'),
(12, 'Quel est l''âge estimé de la Terre et comment le détermine-t-on ?', 'Chronologie absolue et datation', 'NS4'),
(12, 'Qui a proposé la théorie de la dérive des continents et sur quelles preuves ?', 'Tectonique des plaques', 'NS1'),
(12, 'Qu''est-ce que la dorsale océanique et quel est son rôle dans la tectonique des plaques ?', 'Divergence, subduction et collision', 'NS4'),
(12, 'Qu''est-ce que la subduction et dans quel contexte se produit-elle ?', 'Divergence, subduction et collision', 'NS4'),
(12, 'Quel est le mécanisme moteur du déplacement des plaques tectoniques ?', 'Tectonique des plaques', 'NS1'),
(12, 'Comment se forment les chaînes de montagnes selon la tectonique des plaques ?', 'Divergence, subduction et collision', 'NS4'),
(12, 'Qu''est-ce qu''une faille transformante et quel en est un exemple célèbre ?', 'Tectonique des plaques', 'NS1'),
(12, 'Quelle est la vitesse typique de déplacement des plaques tectoniques ?', 'Tectonique des plaques', 'NS1'),
(12, 'Qu''est-ce que le volcanisme de point chaud et comment diffère-t-il du volcanisme de zone de subduction ?', 'Tectonique des plaques', 'NS1'),
(12, 'Comment la tectonique des plaques influence-t-elle la géologie des Caraïbes et d''Haïti ?', 'Tectonique des plaques', 'NS1'),
(12, 'Qu''est-ce que la paléomagnétisme et comment a-t-il confirmé l''expansion océanique ?', 'Tectonique des plaques', 'NS1'),
(12, 'Qu''est-ce que le supercontinent Pangée et quand a-t-il existé ?', 'Tectonique des plaques', 'NS1'),
(12, 'Quels sont les trois grands types de roches et comment se forment-ils ?', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Comment différencie-t-on les roches magmatiques plutoniques des roches volcaniques ?', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Qu''est-ce que le métamorphisme et quels facteurs le contrôlent ?', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Comment se forment les roches sédimentaires et quel est leur intérêt pour la géologie ?', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Qu''est-ce que le cycle des roches et quels processus y participent ?', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Qu''est-ce que la diagenèse dans la formation des roches sédimentaires ?', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Qu''est-ce que la minéralogie et quel est le minéral le plus abondant de la croûte terrestre ?', 'Les roches et le cycle des roches', 'NS1'),
(12, 'Comment la datation radiométrique permet-elle de dater les roches ?', 'Chronologie absolue et datation', 'NS4'),
(12, 'Qu''est-ce que le principe de superposition en stratigraphie et qui l''a établi ?', 'Chronologie relative', 'NS4'),
(12, 'Qu''est-ce que la géologie haïtienne et quels types de roches y trouve-t-on ?', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Quelle est la différence entre le foyer (hypocentre) et l''épicentre d''un séisme ?', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'Quelle est la différence entre l''échelle de Richter et l''échelle de Mercalli ?', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'Quels sont les deux types principaux d''ondes sismiques et leurs caractéristiques ?', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'Comment se forme un tsunami et quelles sont les conditions nécessaires ?', 'Les séismes : définitions et mesure', 'NS1'),
(12, 'Qu''est-ce que la liquéfaction des sols lors d''un séisme et pourquoi est-elle dangereuse ?', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'Quels sont les deux grands types de volcans selon leur structure et leur mode d''éruption ?', 'Les volcans : structure, produits et types', 'NS1'),
(12, 'Qu''est-ce qu''une nuée ardente et quel est son exemple historique le plus célèbre ?', 'Les volcans : structure, produits et types', 'NS1'),
(12, 'Comment se définit le risque sismique et quels sont ses facteurs ?', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'Qu''est-ce que le parc de prévention et les systèmes d''alerte sismique précoce ?', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'Qu''est-ce que la sismicité induite et comment les activités humaines peuvent-elles causer des séismes ?', 'Failles, plis et causes des séismes', 'NS1'),
(12, 'Qu''est-ce que le géorisque en Haïti et comment y faire face ?', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'Qu''est-ce que la construction parasismique et ses principes fondamentaux ?', 'Les séismes en Haïti et la prévention', 'NS1'),
(12, 'Comment se forment les gisements de pétrole et de gaz naturel ?', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Comment se forment les gisements de minerais métalliques ?', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Quels sont les potentiels miniers d''Haïti selon les études géologiques récentes ?', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Qu''est-ce que l''énergie géothermique et comment peut-elle être exploitée ?', 'Ressources naturelles et géologie économique', 'NS3'),
(12, 'Qu''est-ce que la géologie environnementale et ses applications ?', 'Loi minière, durabilité et enjeux', 'NS3'),
(12, 'Comment la déforestation en Haïti amplifie-t-elle les risques géologiques ?', 'Les glissements de terrain', 'NS1'),
(12, 'Qu''est-ce que la gestion durable des ressources minières ?', 'Loi minière, durabilité et enjeux', 'NS3'),
(12, 'Qu''est-ce que les aquifères et leur importance en Haïti ?', 'L''eau : répartition, cycle et ressource', 'NS2'),
(12, 'Comment les changements climatiques affectent-ils les ressources en eau souterraine ?', 'L''eau : répartition, cycle et ressource', 'NS2'),
(12, 'Qu''est-ce que la télédétection et les SIG (Systèmes d''Information Géographique) en géologie ?', 'Prospection et exploitation minière', 'NS3'),
(12, 'Qu''est-ce que la géologie isotopique et ses applications à la géochimie ?', 'Chronologie absolue et datation', 'NS4'),
(12, 'Comment la géologie contribue-t-elle à la compréhension du changement climatique passé et futur ?', 'Variabilité et changements climatiques naturels', 'NS3');

CREATE TEMP TABLE anciens ON COMMIT DROP AS
SELECT ch.id, ch.matiere_id, ch.titre
FROM chapitres ch
WHERE ch.matiere_id IN (11,12)
  AND NOT EXISTS (SELECT 1 FROM cible c WHERE c.matiere_id = ch.matiere_id AND c.titre = ch.titre);

UPDATE questions q
SET chapitre_id = dest.id,
    v4_niveau   = r.niveau
FROM repartition r
JOIN chapitres dest ON dest.matiere_id = r.matiere_id AND dest.titre = r.titre
JOIN chapitres src  ON src.matiere_id = r.matiere_id
WHERE q.chapitre_id = src.id
  AND q.enonce = r.enonce
  AND q.chapitre_id <> dest.id;

-- Cartes mentales des anciens chapitres → chapitre cible le plus proche
DO $$
BEGIN
  IF to_regclass('public.cartes_mentales') IS NOT NULL THEN
    UPDATE cartes_mentales cm
    SET chapitre_id = dest.id
    FROM anciens a
    JOIN (VALUES
      (11, 'Génétique et hérédité',                     'Génétique : hérédité et lois de Mendel'),
      (12, 'Minéraux, roches et ressources minières',   'Les roches et le cycle des roches'),
      (12, 'Risques géologiques et protection',         'Les séismes en Haïti et la prévention'),
      (12, 'Géologie d''Haïti et ressources naturelles', 'Ressources naturelles et géologie économique')
    ) AS m(matiere_id, ancien, nouveau) ON m.matiere_id = a.matiere_id AND m.ancien = a.titre
    JOIN chapitres dest ON dest.matiere_id = m.matiere_id AND dest.titre = m.nouveau
    WHERE cm.chapitre_id = a.id;
  END IF;
END $$;

-- Supprimer les anciens chapitres vidés (conservés s'ils sont encore référencés)
DO $$
DECLARE a RECORD;
BEGIN
  FOR a IN SELECT * FROM anciens LOOP
    IF NOT EXISTS (SELECT 1 FROM questions WHERE chapitre_id = a.id) THEN
      BEGIN
        DELETE FROM chapitres WHERE id = a.id;
        RAISE NOTICE 'Chapitre supprimé : % (%)', a.titre, a.id;
      EXCEPTION WHEN foreign_key_violation THEN
        RAISE NOTICE 'Chapitre conservé (encore référencé) : % (%)', a.titre, a.id;
      END;
    ELSE
      RAISE NOTICE 'Chapitre conservé (questions non réparties) : % (%)', a.titre, a.id;
    END IF;
  END LOOP;
END $$;

-- ─────────────────────────────────────────────────────────────
-- 7. Backfill : tous les autres chapitres (autres matières + anciens chapitres Bio/Géol non vidés)
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
-- 8a. Structure Bio/Géol par niveau : attendu Bio NS1=11, NS2=12, NS3=15, NS4=16
--                                     Géol NS1=10, NS2=6, NS3=10, NS4=10
SELECT ch.matiere_id, cn.niveau_v4, COUNT(*) AS nb_chapitres
FROM chapitre_niveaux cn JOIN chapitres ch ON ch.id = cn.chapitre_id
WHERE ch.matiere_id IN (11,12)
GROUP BY ch.matiere_id, cn.niveau_v4
ORDER BY ch.matiere_id, cn.niveau_v4;

-- 8b. Chapitres Bio/Géol hors structure cible (attendu : aucun)
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

-- 8e. Questions par chapitre Bio/Géol après répartition
SELECT ch.matiere_id, ch.niveau_v4, ch.titre, COUNT(q.id) AS nb_questions
FROM chapitres ch LEFT JOIN questions q ON q.chapitre_id = ch.id
WHERE ch.matiere_id IN (11,12)
GROUP BY ch.id ORDER BY ch.matiere_id, ch.niveau_v4, ch.titre;

-- 8f. Énoncés de la répartition introuvables en base (écarts entre seed Dart et production)
SELECT COUNT(*) AS enonces_introuvables
FROM repartition r
WHERE NOT EXISTS (
  SELECT 1 FROM questions q JOIN chapitres ch ON ch.id = q.chapitre_id
  WHERE ch.matiere_id = r.matiere_id AND q.enonce = r.enonce
);

-- Si les vérifications sont correctes : COMMIT ; sinon : ROLLBACK
COMMIT;
-- ROLLBACK;
