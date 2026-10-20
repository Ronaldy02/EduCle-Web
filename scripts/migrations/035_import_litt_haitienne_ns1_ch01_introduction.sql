-- Import du chapitre Littérature haïtienne « Introduction à la littérature haïtienne » (NS1) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('LH1-01', NULL, 'Ensemble des œuvres écrites auxquelles on reconnaît une valeur esthétique ?', '["La littérature", "La rhétorique", "La grammaire", "La philologie"]', 'La littérature', 'Le mot désigne aussi ces œuvres vues par pays ou par époque : on parle ainsi de littérature haïtienne.', 'Facile', 'NS1'),
('LH1-02', NULL, 'Caractère d''un discours ou d''un fait littéraire transmis par la parole plutôt que par l''écrit ?', '["L''oralité", "La notoriété", "La modernité", "La spontanéité"]', 'L''oralité', 'En Haïti, contes, proverbes et chansons ont longtemps circulé par la voix avant d''être écrits.', 'Moyen', 'NS1'),
('LH1-03', NULL, 'Récit généralement court, de faits imaginaires ?', '["Un conte", "Une chronique", "Un traité", "Une épopée"]', 'Un conte', 'Les contes haïtiens s''ouvrent par le dialogue « Cric ? Crac ! » entre le conteur et son public.', 'Facile', 'NS1'),
('LH1-04', NULL, 'Attachement sentimental à son pays, qui pousse à le défendre et à le promouvoir ?', '["Le patriotisme", "Le cosmopolitisme", "L''individualisme", "Le pacifisme"]', 'Le patriotisme', 'Après l''indépendance, il inspire une grande partie de la littérature haïtienne du XIXe siècle.', 'Moyen', 'NS1'),
('LH1-05', NULL, 'Petit écrit en prose, au ton polémique, violent et agressif ?', '["Un pamphlet", "Un éloge", "Une préface", "Un sermon"]', 'Un pamphlet', 'Le Baron de Vastey a publié des pamphlets contre le système colonial.', 'Moyen', 'NS1'),
('LH1-06', NULL, 'Chant ou poème lyrique à la gloire d''un personnage ou d''une grande idée ?', '["Un hymne", "Une élégie", "Une épigramme", "Une complainte"]', 'Un hymne', 'L''hymne national d''Haïti, La Dessalinienne, célèbre l''indépendance et son fondateur.', 'Moyen', 'NS1'),
('LH1-07', NULL, 'Écrit ou œuvre par lesquels on raille vivement quelqu''un ou quelque chose ?', '["Une satire", "Une apologie", "Un panégyrique", "Une confession"]', 'Une satire', 'Plusieurs romanciers haïtiens de 1900 à 1910 ont pratiqué la satire des mœurs.', 'Moyen', 'NS1'),
('LH1-08', NULL, 'Ouvrage de réflexions diverses sur un sujet qu''il ne prétend pas épuiser ?', '["Un essai", "Un roman", "Un recueil", "Un manuel"]', 'Un essai', 'Genre très pratiqué en Haïti, de Firmin et Janvier à Jean Price-Mars.', 'Moyen', 'NS1'),
('LH1-09', NULL, 'Situation de quelqu''un qui est obligé de vivre hors de son pays ?', '["L''exil", "L''asile", "L''oubli", "L''évasion"]', 'L''exil', 'Sous la dictature des Duvalier, de nombreux écrivains haïtiens ont connu l''exil.', 'Moyen', 'NS1'),
('LH1-10', NULL, 'Dispersion d''un peuple à travers le monde ?', '["La diaspora", "La migration", "La colonie", "L''exode"]', 'La diaspora', 'On parle de littérature de la diaspora pour les écrivains haïtiens installés à l''étranger.', 'Moyen', 'NS1'),
('LH1-21', NULL, 'Comment appelle-t-on les écrivains haïtiens de 1804 à 1836 ?', '["Les pionniers", "Les romantiques", "Les indigénistes", "Les spiralistes"]', 'Les pionniers', 'On les dit aussi pseudo-classiques, car ils imitent les modèles français du XVIIIe siècle.', 'Facile', 'NS1'),
('LH1-22', NULL, 'Quel courant français imitent surtout les écrivains haïtiens de 1804 à 1836 ?', '["Le classicisme", "Le romantisme", "Le symbolisme", "Le surréalisme"]', 'Le classicisme', 'Le romantisme n''arrive en Haïti qu''avec l''École de 1836.', 'Moyen', 'NS1'),
('LH1-23', NULL, 'Quel mouvement naît en Haïti avec l''École de 1836 ?', '["Le romantisme", "Le réalisme", "Le naturalisme", "L''indigénisme"]', 'Le romantisme', 'Ce groupe se forme autour des journaux Le Républicain et L''Union.', 'Facile', 'NS1'),
('LH1-24', NULL, 'Comment nomme-t-on la période littéraire haïtienne de 1860 à 1898 ?', '["L''école patriotique", "La Ronde", "L''indigénisme", "Le spiralisme"]', 'L''école patriotique', 'On parle aussi de romantisme patriotique : les écrivains défendent la patrie et la race noire.', 'Moyen', 'NS1'),
('LH1-25', NULL, 'Quelle revue donne son nom à la génération littéraire de 1898 à 1915 ?', '["La Ronde", "La Ruche", "Les Griots", "La Revue indigène"]', 'La Ronde', 'Selon les sources, la revue est fondée en 1895 ou en 1898 ; la génération couvre 1898-1915.', 'Facile', 'NS1'),
('LH1-27', NULL, 'Quel événement de 1915 est à l''origine du mouvement indigéniste ?', '["L''occupation américaine", "La chute de Boyer", "L''abolition de l''esclavage", "Le coup d''État de Duvalier"]', 'L''occupation américaine', 'En réaction, les écrivains valorisent la culture populaire et les racines africaines d''Haïti.', 'Moyen', 'NS1'),
('LH1-28', NULL, 'Quel mouvement littéraire haïtien né après 1915 valorise les racines africaines et populaires ?', '["L''indigénisme", "Le parnasse", "Le naturalisme", "Le symbolisme"]', 'L''indigénisme', 'Il est lancé en particulier par Jean Price-Mars et la Revue indigène (1927).', 'Facile', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 23 AND titre = 'Introduction à la littérature haïtienne';
SELECT COUNT(*) AS chapitre_trouve FROM cible;

CREATE TEMP TABLE mat ON COMMIT DROP AS
SELECT q.v4_mat_canonical AS code FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = 23 AND q.v4_mat_canonical IS NOT NULL
GROUP BY q.v4_mat_canonical ORDER BY COUNT(*) DESC LIMIT 1;

WITH maj AS (
  UPDATE questions q
  SET chapitre_id = (SELECT id FROM cible), enonce = i.enonce, choix = i.choix, bonne_reponse = i.bonne,
      explication = i.explication, niveau_complexite = i.complexite, v4_niveau = i.niveau
  FROM imp i, chapitres c
  WHERE c.id = q.chapitre_id AND c.matiere_id = 23 AND i.ancien IS NOT NULL AND q.enonce = i.ancien
  RETURNING q.id
)
SELECT COUNT(*) AS questions_de_base_deplacees FROM maj;

WITH ins AS (
  INSERT INTO questions (chapitre_id, enonce, choix, bonne_reponse, explication, niveau_complexite, v4_niveau, v4_mat_canonical)
  SELECT (SELECT id FROM cible), i.enonce, i.choix, i.bonne, i.explication, i.complexite, i.niveau, (SELECT code FROM mat)
  FROM imp i
  WHERE NOT EXISTS (SELECT 1 FROM questions q WHERE q.chapitre_id = (SELECT id FROM cible) AND q.enonce = i.enonce)
  RETURNING id
)
SELECT COUNT(*) AS questions_inserees FROM ins;

SELECT COUNT(*) AS total_chapitre FROM questions WHERE chapitre_id = (SELECT id FROM cible);
COMMIT;
