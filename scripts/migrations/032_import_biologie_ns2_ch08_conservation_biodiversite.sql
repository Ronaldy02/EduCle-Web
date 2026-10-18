-- Import du chapitre Biologie « Conservation de la biodiversité » (NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('B19-01', NULL, 'Action de maintenir quelque chose intact, dans le même état, à l''abri de la destruction.', '["La conservation", "La restauration", "L''exploitation", "L''adaptation"]', 'La conservation', 'En biologie, on parle de conservation de la biodiversité : protéger les espèces et leurs milieux.', 'Facile', 'NS2'),
('Q1720', 'Quel est le but de la biologie de la conservation ?', 'Science qui étudie la biodiversité et cherche à la protéger de la disparition.', '["La biologie de la conservation", "La biologie moléculaire", "La biologie marine", "La génétique des populations"]', 'La biologie de la conservation', 'Elle combine écologie, génétique, sociologie et politique. Ses outils : aires protégées, corridors écologiques, élevages ex situ, banques de gènes.', 'Moyen', 'NS2'),
('B19-03', NULL, 'Espèce dont les effectifs diminuent au point qu''elle risque de disparaître.', '["Une espèce menacée", "Une espèce endémique", "Une espèce invasive", "Une espèce domestique"]', 'Une espèce menacée', 'On dit aussi espèce en danger. Une espèce peut être à la fois endémique et menacée.', 'Facile', 'NS2'),
('B19-04', NULL, 'Inventaire mondial qui classe les espèces selon leur risque de disparition.', '["La Liste rouge", "La Liste blanche", "La Liste noire", "La Liste grise"]', 'La Liste rouge', 'C''est la Liste rouge des espèces menacées, mise à jour régulièrement.', 'Moyen', 'NS2'),
('B19-05', NULL, 'Quelle organisation internationale publie la Liste rouge des espèces menacées ?', '["L''UICN", "L''OMS", "La FAO", "L''UNESCO"]', 'L''UICN', 'L''Union internationale pour la conservation de la nature a été fondée en 1948. Son siège est à Gland, en Suisse.', 'Moyen', 'NS2'),
('B19-06', NULL, 'Parmi les espèces menacées de la Liste rouge, quelle catégorie est la plus proche de l''extinction ?', '["En danger critique", "Vulnérable", "En danger", "Quasi menacée"]', 'En danger critique', 'Les trois catégories « menacées » sont, par ordre croissant de gravité : vulnérable, en danger, en danger critique.', 'Difficile', 'NS2'),
('B19-08', NULL, 'Quel mammifère insectivore nocturne à long museau, rare et menacé, ne vit qu''en Hispaniola ?', '["Le solénodon", "Le lamantin", "La mangouste", "Le hutia"]', 'Le solénodon', 'Sa salive est venimeuse. Les chiens, les chats et les mangoustes introduits le menacent, avec la perte de ses forêts.', 'Moyen', 'NS2'),
('B19-09', NULL, 'Mammifère aquatique strictement herbivore des rivages de l''Atlantique tropical, chassé pour sa chair.', '["Le lamantin", "Le dauphin", "Le phoque", "Le morse"]', 'Le lamantin', 'Le lamantin est menacé par la chasse, les filets de pêche et les collisions avec les bateaux.', 'Moyen', 'NS2'),
('B19-11', NULL, 'Action de supprimer les arbres d''un terrain (défrichement, exploitation abusive, incendie).', '["Le déboisement", "Le reboisement", "Le drainage", "Le labour"]', 'Le déboisement', 'Synonyme : déforestation. Il prive de nombreuses espèces de leur habitat.', 'Facile', 'NS2'),
('B19-12', NULL, 'Quelle source d''énergie domestique accélère le déboisement en Haïti ?', '["Le charbon de bois", "Le gaz propane", "L''énergie solaire", "Le kérosène"]', 'Le charbon de bois', 'La majorité des ménages cuisinent au charbon de bois, produit en coupant des arbres.', 'Facile', 'NS2'),
('B19-13', NULL, 'Creusement de profondes rigoles par les eaux de pluie sur des pentes dénudées.', '["Le ravinement", "La sédimentation", "La salinisation", "Le tassement"]', 'Le ravinement', 'Sur les pentes déboisées, il emporte la terre fertile et accélère l''érosion.', 'Moyen', 'NS2'),
('B19-14', NULL, 'Évolution d''une zone semi-aride vers l''aridité complète d''un désert.', '["La désertification", "La salinisation", "L''acidification", "La sédimentation"]', 'La désertification', 'Elle résulte du climat sec, du surpâturage et du déboisement.', 'Moyen', 'NS2'),
('B19-15', NULL, 'Prélèvement de ressources naturelles plus rapide que leur renouvellement.', '["La surexploitation", "La surproduction", "La surpopulation", "La suradaptation"]', 'La surexploitation', 'La pêche excessive de poissons ou de lambis en est un exemple.', 'Moyen', 'NS2'),
('B19-16', NULL, 'Consommation excessive de la végétation d''un terrain par le bétail.', '["Le surpâturage", "Le défrichement", "Le brûlis", "L''assolement"]', 'Le surpâturage', 'Il dégrade les sols et favorise l''érosion et la désertification.', 'Moyen', 'NS2'),
('B19-17', NULL, 'Fait de chasser ou de pêcher en violation des lois et règlements.', '["Le braconnage", "Le pillage", "Le piégeage", "La cueillette"]', 'Le braconnage', 'Il touche surtout les espèces rares et protégées.', 'Facile', 'NS2'),
('B19-18', NULL, 'Matière rejetée parce qu''elle n''a plus de valeur immédiate.', '["Un déchet", "Un intrant", "Un polluant", "Un nutriment"]', 'Un déchet', 'Les déchets mal gérés polluent les sols, les rivières et la mer.', 'Facile', 'NS2'),
('B19-21', NULL, 'Protection des espèces directement dans leur milieu naturel.', '["La conservation in situ", "La conservation ex situ", "La reproduction assistée", "La domestication"]', 'La conservation in situ', 'Les parcs nationaux et les réserves en sont des exemples.', 'Moyen', 'NS2'),
('B19-22', NULL, 'Protection des espèces en dehors de leur milieu naturel.', '["La conservation ex situ", "La conservation in situ", "La réintroduction", "La mise en jachère"]', 'La conservation ex situ', 'Elle passe par les zoos, les jardins botaniques et les banques de graines.', 'Moyen', 'NS2'),
('B19-23', NULL, 'Zone délimitée, reconnue et gérée par la loi pour protéger la nature.', '["Une aire protégée", "Une zone franche", "Une zone portuaire", "Un périmètre irrigué"]', 'Une aire protégée', 'Parcs nationaux et réserves naturelles sont des aires protégées.', 'Moyen', 'NS2'),
('B19-24', NULL, 'Vaste espace naturel protégé par l''État, dont l''accès du public est contrôlé.', '["Un parc national", "Un jardin public", "Un champ de culture", "Un verger"]', 'Un parc national', 'En Haïti, La Visite et Macaya sont deux parcs nationaux de montagne.', 'Moyen', 'NS2'),
('B19-25', NULL, 'Dans quel massif haïtien se trouve le parc national Macaya ?', '["Le massif de la Hotte", "Le massif de la Selle", "Le massif du Nord", "Les Montagnes Noires"]', 'Le massif de la Hotte', 'Sa forêt humide abrite de nombreuses espèces qu''on ne trouve nulle part ailleurs.', 'Moyen', 'NS2'),
('B19-26', NULL, 'Quel parc naturel protège les mangroves et les récifs côtiers du nord-est, près de Fort-Liberté ?', '["Le parc des Trois Baies", "Le parc La Visite", "Le parc Macaya", "Le parc Forêt-des-Pins"]', 'Le parc des Trois Baies', 'C''est une aire protégée côtière et marine, à la différence des parcs de forêt de montagne.', 'Moyen', 'NS2'),
('B19-27', NULL, 'Passage naturel qui relie des habitats isolés et permet aux animaux de se déplacer entre eux.', '["Un corridor écologique", "Une zone tampon", "Un couloir aérien", "Un réseau trophique"]', 'Un corridor écologique', 'Les corridors évitent l''isolement des populations et limitent la perte de diversité génétique.', 'Moyen', 'NS2'),
('B19-28', NULL, 'Établissement qui stocke des graines pour préserver les variétés de plantes.', '["Une banque de graines", "Un jardin potager", "Une serre", "Un herbier"]', 'Une banque de graines', 'C''est une forme de conservation ex situ, utile en cas de disparition des plantes dans la nature.', 'Moyen', 'NS2'),
('B19-29', NULL, 'Établissement qui cultive et étudie des plantes variées, souvent rares ou menacées.', '["Un jardin botanique", "Un verger", "Un parc public", "Une pépinière"]', 'Un jardin botanique', 'Il joue un rôle dans la conservation ex situ, l''éducation et la recherche.', 'Moyen', 'NS2'),
('B19-30', NULL, 'Établissement où des animaux sauvages sont élevés et présentés au public.', '["Un jardin zoologique", "Une réserve naturelle", "Une ferme d''élevage", "Un aquarium"]', 'Un jardin zoologique', 'Certains jardins zoologiques élèvent des espèces menacées pour les relâcher ensuite dans la nature.', 'Facile', 'NS2'),
('B19-31', NULL, 'Fait de relâcher dans une zone où elle a disparu une espèce élevée en captivité.', '["La réintroduction", "La domestication", "La migration", "La pollinisation"]', 'La réintroduction', 'Elle ne réussit que si les causes de la disparition ont été supprimées.', 'Moyen', 'NS2'),
('B19-32', NULL, 'Ensemble des actions qui aident un écosystème dégradé à retrouver son état d''origine.', '["La restauration écologique", "La colonisation", "La domestication", "La fragmentation"]', 'La restauration écologique', 'Exemples : replanter des arbres, rétablir des mangroves, nettoyer des rivières.', 'Moyen', 'NS2'),
('Q1719', 'Qu''est-ce que la biorestauration ?', 'Technique qui utilise des êtres vivants (plantes, bactéries, champignons) pour dépolluer un milieu abîmé.', '["La biorestauration", "L''incinération des déchets", "La stérilisation", "La désalinisation"]', 'La biorestauration', 'Elle comprend la phytoremédiation (plantes) et la remédiation bactérienne. C''est une alternative économique aux méthodes physico-chimiques.', 'Moyen', 'NS2'),
('B19-34', NULL, 'Plantation d''arbres sur un terrain nu ou sur un sol anciennement boisé.', '["Le reboisement", "Le défrichement", "Le labour", "Le drainage"]', 'Le reboisement', 'Synonyme : reforestation. Il protège les sols de l''érosion et rétablit des habitats.', 'Facile', 'NS2'),
('B19-35', NULL, 'Terrain où l''on élève de jeunes arbres destinés à être replantés.', '["Une pépinière", "Un verger", "Un herbier", "Une jachère"]', 'Une pépinière', 'Les projets de reboisement s''appuient sur des pépinières d''arbres forestiers et fruitiers.', 'Moyen', 'NS2'),
('B19-41', NULL, 'Façon de vivre et de produire qui répond aux besoins du présent sans compromettre ceux des générations futures.', '["Le développement durable", "Le progrès économique", "Le progrès technique", "L''économie circulaire"]', 'Le développement durable', 'Cette définition vient du rapport Brundtland (1987).', 'Moyen', 'NS2'),
('B19-42', NULL, 'Énergie issue du soleil, du vent, des marées ou de la biomasse.', '["Une énergie renouvelable", "Une énergie fossile", "Une énergie nucléaire", "Une énergie chimique"]', 'Une énergie renouvelable', 'Elle ne s''épuise pas à l''échelle humaine et pollue peu.', 'Moyen', 'NS2'),
('B19-43', NULL, 'Ensemble des techniques qui permettent de créer et d''exploiter rationnellement les forêts en assurant leur renouvellement.', '["La sylviculture", "L''horticulture", "L''arboriculture fruitière", "La viticulture"]', 'La sylviculture', 'Elle repose sur des coupes limitées et des replantations.', 'Moyen', 'NS2'),
('B19-44', NULL, 'Production d''organismes aquatiques (poissons, crustacés, algues) dans des conditions contrôlées par l''homme.', '["L''aquaculture", "La pêche artisanale", "La chasse sous-marine", "Le dragage"]', 'L''aquaculture', 'Elle réduit la pression de la pêche sur les populations sauvages.', 'Moyen', 'NS2'),
('B19-45', NULL, 'Élevage de poissons.', '["La pisciculture", "L''apiculture", "L''aviculture", "L''ostréiculture"]', 'La pisciculture', 'En Haïti, on élève par exemple le tilapia dans des bassins.', 'Facile', 'NS2'),
('B19-46', NULL, 'Nombre maximal de prises autorisé pour une espèce pêchée ou chassée.', '["Un quota", "Une cotisation", "Un permis", "Un moratoire"]', 'Un quota', 'Fixer des quotas évite la surexploitation d''une espèce.', 'Moyen', 'NS2'),
('B19-47', NULL, 'Forme de voyage axée sur la découverte de la nature, dans le respect du milieu et des habitants.', '["L''écotourisme", "Le tourisme balnéaire", "Le tourisme d''affaires", "Le tourisme de masse"]', 'L''écotourisme', 'Synonyme : tourisme vert. Il finance parfois la protection des aires naturelles.', 'Moyen', 'NS2'),
('B19-48', NULL, 'Ensemble des opérations qui permettent de réutiliser des déchets en les réintroduisant dans le cycle de production.', '["Le recyclage", "L''incinération", "L''enfouissement", "Le compostage"]', 'Le recyclage', 'Il économise des matières premières et réduit les déchets.', 'Moyen', 'NS2'),
('B19-49', NULL, 'Se dit d''un produit que des bactéries décomposent rapidement et font disparaître de l''environnement.', '["Biodégradable", "Recyclable", "Renouvelable", "Réutilisable"]', 'Biodégradable', 'Les épluchures sont biodégradables ; la plupart des plastiques ne le sont pas.', 'Moyen', 'NS2'),
('B19-50', NULL, 'Matière riche en humus obtenue par fermentation de déchets organiques, utilisée pour enrichir le sol.', '["Le compost", "Le lisier", "Le goudron", "Le sable"]', 'Le compost', 'Faire du compost avec les déchets de cuisine et de jardin réduit les ordures et fertilise le sol.', 'Moyen', 'NS2'),
('B19-51', NULL, 'Quels sont les trois gestes de la gestion durable des déchets (règle des 3 R) ?', '["Réduire, réutiliser, recycler", "Récolter, recycler, rejeter", "Réduire, récupérer, rejeter", "Recycler, réparer, remplacer"]', 'Réduire, réutiliser, recycler', 'L''ordre compte : on réduit d''abord les déchets, puis on réutilise, enfin on recycle.', 'Facile', 'NS2'),
('B19-61', NULL, 'Quel sommet mondial de 1992 a ouvert à la signature la Convention sur la diversité biologique ?', '["Le Sommet de Rio", "Le Sommet de Kyoto", "La conférence de Paris", "Le Sommet de Stockholm"]', 'Le Sommet de Rio', 'Aussi appelé Sommet de la Terre, il s''est tenu à Rio de Janeiro, au Brésil.', 'Moyen', 'NS2'),
('B19-62', NULL, 'Quel accord international encadre le commerce des espèces sauvages menacées ?', '["La CITES", "Le protocole de Kyoto", "La convention de Ramsar", "L''accord de Paris"]', 'La CITES', 'Signée à Washington en 1973, elle limite le commerce d''animaux et de plantes rares.', 'Moyen', 'NS2'),
('B19-63', NULL, 'Quelle convention internationale, signée en 1971, protège les zones humides ?', '["La convention de Ramsar", "La CITES", "Le protocole de Montréal", "L''accord de Paris"]', 'La convention de Ramsar', 'Elle porte le nom de la ville iranienne où elle a été adoptée.', 'Moyen', 'NS2');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Conservation de la biodiversité';
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

SELECT COUNT(*) AS total_chapitre FROM questions WHERE chapitre_id = (SELECT id FROM cible);
COMMIT;
