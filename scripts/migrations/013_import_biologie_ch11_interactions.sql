-- Import du chapitre Biologie « Les interactions écologiques » (NS1, NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('B11-01', NULL, 'Mode de recherche alimentaire qui consiste à capturer un animal vivant et à le manger.', '["La prédation", "Le parasitisme", "La compétition", "Le commensalisme"]', 'La prédation', 'Exemple : le faucon qui chasse un lézard.', 'Facile', 'NS1'),
('B11-02', NULL, 'Animal qui capture et mange d''autres animaux vivants.', '["Un prédateur", "Une proie", "Un parasite", "Un décomposeur"]', 'Un prédateur', 'Exemples : le lion, le requin, la mangouste.', 'Facile', 'NS1'),
('B11-03', NULL, 'Animal vivant qui sert de victime et de nourriture à un animal d''une autre espèce.', '["Une proie", "Un prédateur", "Un hôte", "Un parasite"]', 'Une proie', 'Exemple : la gazelle pour le lion.', 'Facile', 'NS1'),
('B11-04', NULL, 'Se dit d''une espèce qui se nourrit en partie d''animaux carnivores et qui n''est elle-même mangée par aucune autre espèce.', '["Un superprédateur", "Un herbivore", "Un décomposeur", "Un parasite"]', 'Un superprédateur', 'Exemples : les rapaces, le cachalot, l''être humain.', 'Difficile', 'NS1'),
('B11-05', NULL, 'Concurrence entre des organismes, des populations ou des espèces pour l''utilisation d''une ressource, la nourriture ou un habitat.', '["La compétition", "La symbiose", "Le mutualisme", "Le commensalisme"]', 'La compétition', 'Elle porte sur l''eau, la lumière, la nourriture, l''espace…', 'Moyen', 'NS1'),
('B11-21', NULL, 'Comment appelle-t-on la compétition entre individus d''une même espèce ?', '["La compétition intraspécifique", "La compétition interspécifique", "Le mutualisme", "La prédation"]', 'La compétition intraspécifique', 'Exemple : deux manguiers voisins qui se disputent la lumière.', 'Moyen', 'NS1'),
('B11-22', NULL, 'Comment appelle-t-on la compétition entre individus d''espèces différentes ?', '["La compétition interspécifique", "La compétition intraspécifique", "Le commensalisme", "La symbiose"]', 'La compétition interspécifique', 'Exemple : le lion et la hyène qui chassent les mêmes proies.', 'Moyen', 'NS1'),
('B11-18', NULL, 'Étendue dont un individu ou une famille d''animaux se réserve l''usage.', '["Un territoire", "Un habitat", "Un biotope", "Un écosystème"]', 'Un territoire', 'Beaucoup d''oiseaux défendent leur territoire en chantant.', 'Moyen', 'NS1'),
('Q1610', 'Que désigne la niche écologique d''une espèce ?', 'Place et rôle d''une espèce dans un écosystème : ce qu''elle mange, où elle vit et ses relations avec les autres espèces.', '["La niche écologique", "L''habitat", "Le biotope", "Le territoire"]', 'La niche écologique', 'L''habitat est seulement le lieu de vie ; la niche inclut aussi le rôle de l''espèce.', 'Difficile', 'NS1'),
('Q1716', 'Qu''est-ce que la niche écologique d''une espèce ?', 'Qu''est-ce qui distingue la niche écologique de l''habitat ?', '["Elle inclut le rôle de l''espèce", "Elle est toujours plus petite", "Rien, c''est la même chose", "Elle ne concerne que les plantes"]', 'Elle inclut le rôle de l''espèce', 'L''habitat est l''adresse de l''espèce ; la niche, son métier.', 'Moyen', 'NS1'),
('Q1717', 'Que dit le principe d''exclusion compétitive de Gause ?', 'Que dit le principe d''exclusion compétitive de Gause ?', '["Deux espèces, une niche : impossible", "Les espèces coexistent toujours", "Les ressources sont toujours partagées", "La compétition est rare"]', 'Deux espèces, une niche : impossible', 'Énoncé par Gause en 1934 : l''une des deux espèces finit par exclure l''autre.', 'Moyen', 'NS1'),
('Q1603', 'Qu''est-ce qui caractérise le mutualisme entre deux espèces ?', 'Relation durable entre deux espèces ou deux populations, avantageuse pour toutes les deux.', '["Le mutualisme", "Le parasitisme", "Le commensalisme", "La prédation"]', 'Le mutualisme', 'Exemple : l''abeille récolte le nectar et transporte le pollen de la fleur.', 'Moyen', 'NS1'),
('B11-06', NULL, 'Association étroite de deux organismes différents, mutuellement bénéfique, voire indispensable à leur survie.', '["La symbiose", "Le parasitisme", "La compétition", "La prédation"]', 'La symbiose', 'C''est un cas particulier, très étroit, de mutualisme.', 'Moyen', 'NS1'),
('B11-07', NULL, 'Organisme vivant en association étroite et bénéfique avec un autre d''une espèce différente.', '["Un symbiote", "Un parasite", "Un prédateur", "Un hôte"]', 'Un symbiote', 'Exemple : les bactéries de notre intestin.', 'Difficile', 'NS1'),
('Q1613', 'La symbiose entre les champignons et les algues forme :', 'Quel organisme résulte de l''association d''un champignon et d''une algue ?', '["Le lichen", "La mousse", "La fougère", "Le corail"]', 'Le lichen', 'Le champignon protège et retient l''eau ; l''algue fabrique la matière organique.', 'Moyen', 'NS1'),
('B11-14', NULL, 'Association symbiotique du mycélium d''un champignon et des racines d''une plante.', '["Une mycorhize", "Un lichen", "Une nodosité", "Un rhizome"]', 'Une mycorhize', 'Le champignon apporte eau et sels minéraux ; la plante lui fournit des sucres.', 'Difficile', 'NS1'),
('B11-15', NULL, 'Renflement formé sur les racines d''une plante, souvent une légumineuse, envahie par des bactéries fixatrices d''azote.', '["Une nodosité", "Une mycorhize", "Un tubercule", "Un bourgeon"]', 'Une nodosité', 'On en trouve sur les racines du pois congo et du haricot.', 'Difficile', 'NS1'),
('B11-25', NULL, 'Quel avantage les légumineuses tirent-elles des bactéries de leurs nodosités ?', '["Un apport d''azote", "Un apport de lumière", "Une protection contre le vent", "Un apport de sucre"]', 'Un apport d''azote', 'C''est pourquoi on les utilise pour enrichir les sols.', 'Moyen', 'NS1'),
('B11-16', NULL, 'Transport des grains mâles d''une fleur jusqu''au stigmate, assuré par le vent ou par des animaux.', '["La pollinisation", "La germination", "La fécondation", "La photosynthèse"]', 'La pollinisation', 'Abeilles, papillons et colibris sont des agents de ce transport.', 'Moyen', 'NS1'),
('Q1608', 'Entre qui la pollinisation est-elle une relation de mutualisme ?', 'Entre qui la pollinisation est-elle une relation de mutualisme ?', '["Les fleurs et leurs pollinisateurs", "Les arbres et les vers de terre", "Les algues et les champignons", "Les carnivores et leurs proies"]', 'Les fleurs et leurs pollinisateurs', 'Les pollinisateurs (abeilles, papillons, colibris) transportent le pollen et reçoivent du nectar.', 'Moyen', 'NS1'),
('B11-20', NULL, 'Dispersion des graines chez les plantes.', '["La dissémination", "La pollinisation", "La germination", "La transpiration"]', 'La dissémination', 'Beaucoup d''oiseaux et de chauves-souris dispersent les graines des fruits qu''ils mangent.', 'Difficile', 'NS1'),
('B11-28', NULL, 'Quelle relation unit le poisson-clown et l''anémone de mer ?', '["Le mutualisme", "Le parasitisme", "La prédation", "La compétition"]', 'Le mutualisme', 'L''anémone protège le poisson ; le poisson nettoie l''anémone et éloigne certains prédateurs.', 'Moyen', 'NS1'),
('B11-08', NULL, 'Mode d''alimentation d''un animal qui se nourrit des restes de repas d''un animal d''une autre espèce, sans lui faire de tort.', '["Le commensalisme", "Le parasitisme", "La prédation", "Le mutualisme"]', 'Le commensalisme', 'L''un en profite, l''autre n''y gagne ni n''y perd.', 'Difficile', 'NS1'),
('Q1604', 'Qu''est-ce qui caractérise le parasitisme ?', 'État d''un organisme qui vit aux dépens d''un organisme d''une autre espèce, appelé l''hôte.', '["Le parasitisme", "Le mutualisme", "Le commensalisme", "La symbiose"]', 'Le parasitisme', 'Le parasite profite ; l''hôte en souffre, sans être tué en général.', 'Moyen', 'NS1'),
('B11-09', NULL, 'Organisme qui se nourrit aux dépens d''un organisme hôte d''une espèce différente.', '["Un parasite", "Un symbiote", "Un prédateur", "Un décomposeur"]', 'Un parasite', 'Exemples : le ténia, la puce, le plasmodium du paludisme.', 'Moyen', 'NS1'),
('B11-10', NULL, 'Être vivant qui héberge un parasite.', '["L''hôte", "Le vecteur", "Le prédateur", "Le symbiote"]', 'L''hôte', 'Exemple : le chien est l''hôte de ses puces.', 'Moyen', 'NS1'),
('B11-11', NULL, 'Organisme qui vit sur la peau d''un hôte et se nourrit de son sang, comme la tique ou le pou.', '["Un ectoparasite", "Un endoparasite", "Un symbiote", "Un commensal"]', 'Un ectoparasite', 'Ecto- = dehors.', 'Difficile', 'NS1'),
('B11-12', NULL, 'Organisme qui effectue son développement à l''intérieur du corps de son hôte : tissus, sang ou cavités profondes.', '["Un endoparasite", "Un ectoparasite", "Un symbiote", "Un commensal"]', 'Un endoparasite', 'Exemples : le ténia, l''ascaris. Endo- = dedans.', 'Difficile', 'NS1'),
('B11-13', NULL, 'Être vivant capable de transmettre un agent infectieux comme une bactérie, un virus ou un parasite.', '["Un vecteur", "Un hôte", "Un symbiote", "Un décomposeur"]', 'Un vecteur', 'Exemple : le moustique qui transmet le paludisme ou la dengue.', 'Moyen', 'NS1'),
('B11-24', NULL, 'Quel insecte transmet le paludisme en Haïti ?', '["Le moustique anophèle", "La mouche tsé-tsé", "La puce", "La tique"]', 'Le moustique anophèle', 'La femelle anophèle transmet le parasite (plasmodium) en piquant.', 'Facile', 'NS1'),
('B11-19', NULL, 'Se dit d''une espèce animale qui vit en groupe, mais sans organisation sociale.', '["Grégaire", "Solitaire", "Parasite", "Sédentaire"]', 'Grégaire', 'Exemple : un banc de sardines.', 'Moyen', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Les interactions écologiques';
SELECT COUNT(*) AS chapitre_trouve FROM cible;

CREATE TEMP TABLE mat ON COMMIT DROP AS
SELECT q.v4_mat_canonical AS code FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = 11 AND q.v4_mat_canonical IS NOT NULL
GROUP BY q.v4_mat_canonical ORDER BY COUNT(*) DESC LIMIT 1;

WITH maj AS (
  UPDATE questions q
  SET chapitre_id = (SELECT id FROM cible), enonce = i.enonce, choix = i.choix, bonne_reponse = i.bonne,
      explication = i.explication, niveau_complexite = i.complexite, v4_niveau = i.niveau
  FROM imp i, chapitres c
  WHERE c.id = q.chapitre_id AND c.matiere_id = 11 AND i.ancien IS NOT NULL AND q.enonce = i.ancien
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

-- Questions de base rejetées : suppression (et lignes qui les référencent)
CREATE TEMP TABLE asup ON COMMIT DROP AS
SELECT q.id FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = 11 AND q.enonce IN ('Que se passe-t-il si l''on élimine le prédateur naturel d''une proie ?');
DO $$
DECLARE r RECORD;
BEGIN
  FOR r IN SELECT conrelid::regclass AS t, a.attname AS col
           FROM pg_constraint k JOIN pg_attribute a ON a.attrelid = k.conrelid AND a.attnum = ANY (k.conkey)
           WHERE k.contype = 'f' AND k.confrelid = 'questions'::regclass LOOP
    EXECUTE format('DELETE FROM %s WHERE %I IN (SELECT id FROM asup)', r.t, r.col);
  END LOOP;
END $$;
WITH sup AS (DELETE FROM questions WHERE id IN (SELECT id FROM asup) RETURNING id)
SELECT COUNT(*) AS questions_rejetees_supprimees FROM sup;

SELECT COUNT(*) AS total_chapitre FROM questions WHERE chapitre_id = (SELECT id FROM cible);
COMMIT;
