-- Import du chapitre Français « Le groupe nominal : déterminants, genre, nombre et accord de l'adjectif » (NS1) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('Q0193', 'De quoi un groupe nominal est-il composé au minimum ?', 'De quoi un groupe nominal est-il composé au minimum ?', '["Un déterminant et un nom", "Un verbe et un sujet", "Un adjectif et un nom", "Un sujet et un prédicat"]', 'Un déterminant et un nom', 'Exemples : « la maison », « un élève ». On peut y ajouter des expansions : « la grande maison blanche ».', 'Facile', 'NS1'),
('F03-02', NULL, 'Dans « la belle maison blanche », quel est le mot principal du groupe nominal ?', '["« maison »", "« belle »", "« blanche »", "« la »"]', '« maison »', 'Le nom est le noyau du groupe nominal ; le déterminant et les adjectifs l''accompagnent.', 'Moyen', 'NS1'),
('F03-11', NULL, 'Mot qui précède le nom et le détermine de façon plus ou moins précise, en indiquant son genre et son nombre ?', '["L''article", "Le pronom", "L''adjectif", "La préposition"]', 'L''article', 'On distingue l''article défini, l''article indéfini et l''article partitif.', 'Facile', 'NS1'),
('F03-12', NULL, 'Quelles sont les trois sortes d''articles ?', '["Défini, indéfini, partitif", "Défini, possessif, partitif", "Simple, double, contracté", "Défini, indéfini, démonstratif"]', 'Défini, indéfini, partitif', 'L''article contracté (au, aux, du, des) est un article défini réuni à une préposition.', 'Facile', 'NS1'),
('F03-13', NULL, 'Quel article désigne une chose précise, connue de celui qui parle ?', '["L''article défini", "L''article indéfini", "L''article partitif", "L''article contracté"]', 'L''article défini', 'Formes : le, la, l'', les. Exemple : « le livre que tu m''as prêté ».', 'Facile', 'NS1'),
('F03-14', NULL, 'Quel article désigne une chose non précisée, parmi d''autres de même espèce ?', '["L''article indéfini", "L''article défini", "L''article partitif", "L''article contracté"]', 'L''article indéfini', 'Formes : un, une, des. Exemple : « un livre ».', 'Facile', 'NS1'),
('F03-15', NULL, 'Quel article désigne une partie d''un tout que l''on ne peut pas compter ?', '["L''article partitif", "L''article défini", "L''article indéfini", "L''article contracté"]', 'L''article partitif', 'Formes : du, de la, de l''. Exemples : « du riz », « de la farine ».', 'Moyen', 'NS1'),
('F03-16', NULL, 'Lequel de ces mots est un article défini ?', '["« les »", "« un »", "« mon »", "« ce »"]', '« les »', '« Un » est indéfini, « mon » possessif et « ce » démonstratif.', 'Moyen', 'NS1'),
('F03-17', NULL, 'Lequel de ces groupes contient un article partitif ?', '["« de la farine »", "« à la maison »", "« sur la table »", "« dans la cour »"]', '« de la farine »', 'Dans les trois autres, « la » est un article défini précédé d''une préposition.', 'Moyen', 'NS1'),
('F03-18', NULL, 'Quel article contracté est formé de « à » et de « le » ?', '["« au »", "« du »", "« aux »", "« à la »"]', '« au »', 'Contractions : à + le = au ; à + les = aux ; de + le = du ; de + les = des.', 'Moyen', 'NS1'),
('F03-21', NULL, 'Se dit d''un déterminant qui exprime la possession ou l''appartenance ?', '["Possessif", "Démonstratif", "Indéfini", "Numéral"]', 'Possessif', 'Exemples : mon, ton, son, notre, votre, leur.', 'Facile', 'NS1'),
('F03-22', NULL, 'Se dit d''un déterminant qui présente un être ou un objet déterminé par la situation ou le contexte ?', '["Démonstratif", "Possessif", "Indéfini", "Numéral"]', 'Démonstratif', 'Exemples : ce, cet, cette, ces. « Cette fille » désigne une fille que l''on montre ou dont on vient de parler.', 'Facile', 'NS1'),
('F03-23', NULL, 'Se dit d''un déterminant qui exprime une idée vague de quantité, de qualité ou d''identité ?', '["Indéfini", "Démonstratif", "Possessif", "Numéral"]', 'Indéfini', 'Exemples : plusieurs, chaque, quelques, certains, aucun, tout.', 'Moyen', 'NS1'),
('F03-24', NULL, 'Se dit d''un terme qui exprime un nombre ou un rang ?', '["Numéral", "Indéfini", "Possessif", "Démonstratif"]', 'Numéral', 'Exemples : « trois élèves » (nombre), « le troisième élève » (rang).', 'Facile', 'NS1'),
('F03-25', NULL, 'Se dit d''un adjectif numéral qui exprime l''ordre ou le rang ?', '["Ordinal", "Cardinal", "Indéfini", "Possessif"]', 'Ordinal', 'Exemples : premier, deuxième, dernier. Les adjectifs cardinaux expriment le nombre : un, deux, trois.', 'Moyen', 'NS1'),
('F03-26', NULL, 'Lequel de ces mots est un déterminant démonstratif ?', '["« cette »", "« notre »", "« plusieurs »", "« trois »"]', '« cette »', '« Cette » désigne un être précis ; « notre » est possessif, « plusieurs » indéfini, « trois » numéral.', 'Moyen', 'NS1'),
('F03-27', NULL, 'Quelle forme du possessif emploie-t-on devant « amie » ?', '["« mon »", "« ma »", "« mes »", "« moi »"]', '« mon »', 'Devant un nom féminin commençant par une voyelle, on dit « mon amie » pour éviter le hiatus, comme « ton école », « son idée ».', 'Moyen', 'NS1'),
('F03-28', NULL, 'Quelle forme du démonstratif emploie-t-on devant « arbre » ?', '["« cet »", "« ce »", "« cette »", "« ces »"]', '« cet »', 'Devant un nom masculin commençant par une voyelle ou un h muet, « ce » devient « cet » : « cet arbre », « cet homme ».', 'Moyen', 'NS1'),
('F03-31', NULL, 'Catégorie grammaticale qui répartit les noms en masculin et en féminin ?', '["Le genre", "Le nombre", "Le temps", "Le mode"]', 'Le genre', 'Le genre grammatical ne correspond pas toujours au sexe : « une table » est féminin.', 'Facile', 'NS1'),
('F03-32', NULL, 'Combien de genres le français distingue-t-il ?', '["Deux", "Trois", "Quatre", "Un"]', 'Deux', 'Le masculin et le féminin. Le neutre existe dans d''autres langues, comme l''allemand ou le latin.', 'Facile', 'NS1'),
('F03-33', NULL, 'Quelle est la marque habituelle du féminin à l''écrit ?', '["Un « e » final", "Un « s » final", "Un « x » final", "Un « t » final"]', 'Un « e » final', 'On forme souvent le féminin en ajoutant un « e » : ami → amie, étudiant → étudiante.', 'Facile', 'NS1'),
('F03-34', NULL, 'Quel est le féminin de « acteur » ?', '["Actrice", "Acteuse", "Actrisse", "Actère"]', 'Actrice', 'Les noms en -teur forment souvent leur féminin en -trice : acteur → actrice, directeur → directrice.', 'Moyen', 'NS1'),
('F03-35', NULL, 'Quel est le féminin de « héros » ?', '["Héroïne", "Héroesse", "Héroe", "Héros"]', 'Héroïne', 'Le féminin de héros est héroïne ; le « h » de héros est aspiré mais pas celui de héroïne.', 'Moyen', 'NS1'),
('F03-36', NULL, 'Quel est le féminin de « compagnon » ?', '["Compagne", "Compagnonne", "Compagnone", "Compagnonie"]', 'Compagne', 'Ce féminin ne double pas le « n » comme « lion/lionne » : compagnon → compagne.', 'Difficile', 'NS1'),
('F03-37', NULL, 'Se dit d''un nom qui a la même forme au masculin et au féminin ?', '["Épicène", "Collectif", "Abstrait", "Invariable"]', 'Épicène', 'Exemples : un élève / une élève, un enfant / une enfant, un artiste / une artiste. Seul le déterminant change.', 'Moyen', 'NS1'),
('F03-38', NULL, 'Quel mot change de sens selon qu''il est masculin ou féminin ?', '["« tour »", "« table »", "« maison »", "« arbre »"]', '« tour »', '« Le tour du monde » ≠ « la tour Eiffel ». Autres exemples : le livre / la livre, le mode / la mode, le voile / la voile.', 'Difficile', 'NS1'),
('F03-39', NULL, 'Quel est le genre du nom « énigme » ?', '["Féminin", "Masculin", "Neutre", "Les deux"]', 'Féminin', 'On dit « une énigme ». Le genre de certains mots est source d''erreur : un emblème, un insigne, une atmosphère.', 'Moyen', 'NS1'),
('F03-41', NULL, 'Catégorie grammaticale qui oppose le singulier et le pluriel ?', '["Le nombre", "Le genre", "La personne", "Le mode"]', 'Le nombre', 'Elle concerne le nom, le déterminant, l''adjectif, le pronom et le verbe.', 'Facile', 'NS1'),
('Q0200', 'Comment s''accorde l''adjectif qualificatif ?', 'Comment s''accorde l''adjectif qualificatif ?', '["En genre et en nombre", "En genre seulement", "En nombre seulement", "Jamais"]', 'En genre et en nombre', 'L''adjectif prend le genre et le nombre du nom qu''il accompagne : « une grande maison », « des enfants joyeux ».', 'Moyen', 'NS1'),
('F03-68', NULL, 'Lequel de ces adjectifs de couleur reste toujours invariable ?', '["« marron »", "« rouge »", "« blanc »", "« vert »"]', '« marron »', 'Les adjectifs de couleur qui sont des noms (marron, orange, cerise, citron) ne s''accordent pas : des chaussures marron.', 'Moyen', 'NS1'),
('F03-69', NULL, 'Que devient un adjectif de couleur composé, comme « bleu clair » ?', '["Il reste invariable", "Il s''accorde en genre", "Il prend un « s »", "Les deux mots s''accordent"]', 'Il reste invariable', 'On écrit « des robes bleu clair », « des yeux vert foncé » : les deux mots restent au singulier.', 'Moyen', 'NS1'),
('F03-70', NULL, 'Comment s''accorde un adjectif qui qualifie un nom masculin et un nom féminin ?', '["Au masculin pluriel", "Au féminin pluriel", "Au masculin singulier", "Il reste invariable"]', 'Au masculin pluriel', 'Le masculin l''emporte : « un garçon et une fille sérieux ».', 'Moyen', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 25 AND titre = 'Le groupe nominal : déterminants, genre, nombre et accord de l''adjectif';
SELECT COUNT(*) AS chapitre_trouve FROM cible;

CREATE TEMP TABLE mat ON COMMIT DROP AS
SELECT q.v4_mat_canonical AS code FROM questions q JOIN chapitres c ON c.id = q.chapitre_id
WHERE c.matiere_id = 25 AND q.v4_mat_canonical IS NOT NULL
GROUP BY q.v4_mat_canonical ORDER BY COUNT(*) DESC LIMIT 1;

WITH maj AS (
  UPDATE questions q
  SET chapitre_id = (SELECT id FROM cible), enonce = i.enonce, choix = i.choix, bonne_reponse = i.bonne,
      explication = i.explication, niveau_complexite = i.complexite, v4_niveau = i.niveau
  FROM imp i, chapitres c
  WHERE c.id = q.chapitre_id AND c.matiere_id = 25 AND i.ancien IS NOT NULL AND q.enonce = i.ancien
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
