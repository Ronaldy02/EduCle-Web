-- Import du chapitre Français « Nature des mots et classes grammaticales » (NS1) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('F01-01', NULL, 'Catégorie grammaticale à laquelle appartient un mot, quel que soit son emploi dans la phrase ?', '["La nature", "La fonction", "Le registre", "Le sens"]', 'La nature', 'On l''appelle aussi classe grammaticale. Elle ne change pas : « difficile » reste un adjectif dans toutes les phrases.', 'Facile', 'NS1'),
('F01-02', NULL, 'Rôle joué par un mot ou un groupe de mots par rapport aux autres éléments de la phrase ?', '["La fonction", "La nature", "La conjugaison", "L''accord"]', 'La fonction', 'Un même mot garde sa nature mais change de fonction : « travail » est sujet dans « Le travail avance » et COD dans « J''aime le travail ».', 'Facile', 'NS1'),
('F01-03', NULL, 'Entre « un travail difficile » et « ce travail est difficile », qu''est-ce qui change pour le mot « difficile » ?', '["Sa fonction", "Sa nature", "Son genre", "Son sens"]', 'Sa fonction', 'Dans les deux phrases, « difficile » est un adjectif ; il est épithète dans la première et attribut du sujet dans la seconde.', 'Moyen', 'NS1'),
('F01-11', NULL, 'Catégorie de mots qui désignent soit une espèce d''êtres ou de choses, soit un individu particulier, et qui peuvent être sujets ou compléments ?', '["Le nom", "Le verbe", "L''adjectif", "L''adverbe"]', 'Le nom', 'En grammaire, le nom se subdivise en noms communs et en noms propres.', 'Facile', 'NS1'),
('F01-12', NULL, 'Quel autre terme grammatical désigne le nom ?', '["Le substantif", "Le déterminant", "L''attribut", "Le complément"]', 'Le substantif', '« Substantif » est le synonyme savant de « nom » dans les grammaires.', 'Facile', 'NS1'),
('F01-13', NULL, 'Mot qui désigne une espèce, une catégorie d''êtres ou de choses, sans en distinguer un en particulier ?', '["Un nom commun", "Un nom propre", "Un nom collectif", "Un nom abstrait"]', 'Un nom commun', 'Exemples : « école », « élève », « montagne ». Il s''écrit sans majuscule, sauf en début de phrase.', 'Facile', 'NS1'),
('F01-14', NULL, 'Mot qui désigne un individu particulier (personne, lieu, pays…) et prend une majuscule ?', '["Un nom propre", "Un nom commun", "Un nom collectif", "Un nom concret"]', 'Un nom propre', 'Exemples : « Dessalines », « Jacmel », « Haïti ».', 'Facile', 'NS1'),
('F01-15', NULL, 'Se dit d''un nom qui désigne ce que l''on peut percevoir par les sens ?', '["Concret", "Abstrait", "Collectif", "Propre"]', 'Concret', 'Exemples : « table », « arbre », « mangue ». Son contraire est « abstrait ».', 'Facile', 'NS1'),
('F01-16', NULL, 'Se dit d''un nom qui désigne une notion que l''on ne peut ni voir ni toucher, comme la liberté ou la joie ?', '["Abstrait", "Concret", "Commun", "Propre"]', 'Abstrait', 'Exemples : « courage », « amitié », « justice ».', 'Facile', 'NS1'),
('F01-17', NULL, 'Nom qui, au singulier, désigne un ensemble d''êtres ou de choses de même espèce, comme « foule » ou « troupeau » ?', '["Un nom collectif", "Un nom concret", "Un nom propre", "Un nom abstrait"]', 'Un nom collectif', 'Il est singulier par la forme, mais il évoque plusieurs êtres : « une foule ».', 'Moyen', 'NS1'),
('F01-21', NULL, 'Mot qui se place devant le nom pour l''introduire dans le discours et le préciser ?', '["Le déterminant", "Le pronom", "L''adjectif qualificatif", "La préposition"]', 'Le déterminant', 'Les déterminants sont les articles et les adjectifs possessifs, démonstratifs, indéfinis et numéraux.', 'Facile', 'NS1'),
('F01-22', NULL, 'Dans « la maison », quelle est la nature de « la » ?', '["Un article", "Un pronom", "Une préposition", "Un adverbe"]', 'Un article', '« La » introduit le nom « maison » : c''est un article défini, donc un déterminant.', 'Facile', 'NS1'),
('F01-23', NULL, 'Dans « mes livres », quelle est la nature de « mes » ?', '["Un déterminant", "Un pronom", "Un adverbe", "Un nom"]', 'Un déterminant', '« Mes » est un déterminant possessif : il accompagne le nom « livres » et en indique le possesseur.', 'Moyen', 'NS1'),
('F01-24', NULL, 'Mot qui accompagne un nom et précise comment est l''être ou l''objet désigné ?', '["L''adjectif qualificatif", "Le déterminant", "L''adverbe", "Le pronom"]', 'L''adjectif qualificatif', 'Dans « une mangue mûre », « mûre » précise la mangue : c''est un adjectif qualificatif.', 'Facile', 'NS1'),
('Q0287', 'Quelle classe grammaticale désigne les mots qui remplacent un nom ou un groupe nominal ?', 'Mot qui remplace un terme déjà exprimé et occupe les mêmes fonctions que lui dans la phrase ?', '["Le pronom", "Le déterminant", "L''adverbe", "L''adjectif"]', 'Le pronom', 'Dans « Marie dort, elle est fatiguée », « elle » remplace « Marie » et évite de la répéter.', 'Facile', 'NS1'),
('F01-26', NULL, 'Mot qui exprime une action, un état ou un changement, et qui se conjugue ?', '["Le verbe", "Le nom", "L''adverbe", "L''adjectif"]', 'Le verbe', 'Le verbe varie en personne, en nombre, en temps et en mode : « je chante », « nous chanterons ».', 'Facile', 'NS1'),
('F01-31', NULL, 'Se dit d''un mot qui ne change ni de genre, ni de nombre, ni de personne ?', '["Invariable", "Variable", "Composé", "Dérivé"]', 'Invariable', 'Sont invariables les adverbes, les prépositions, les conjonctions et les interjections.', 'Facile', 'NS1'),
('F01-32', NULL, 'Mot invariable qui précise le sens d''un verbe ou d''un adjectif, par exemple pour dire comment, quand ou où ?', '["L''adverbe", "L''adjectif", "La préposition", "La conjonction"]', 'L''adverbe', 'Dans « Il parle doucement », « doucement » dit comment il parle.', 'Facile', 'NS1'),
('Q0288', 'Dans la phrase "Il travaille sérieusement", à quelle classe grammaticale appartient "sérieusement" ?', 'Dans la phrase "Il travaille sérieusement", à quelle classe grammaticale appartient "sérieusement" ?', '["Adverbe", "Adjectif qualificatif", "Nom commun", "Préposition"]', 'Adverbe', '« Sérieusement » est un adverbe de manière : il précise comment il travaille et ne varie jamais.', 'Facile', 'NS1'),
('F01-33', NULL, 'Mot invariable qui introduit un complément et le relie à un autre mot de la phrase ?', '["La préposition", "La conjonction", "L''adverbe", "L''interjection"]', 'La préposition', 'Exemples : « à », « de », « dans », « sur », « avec », « pour ».', 'Facile', 'NS1'),
('F01-34', NULL, 'Lequel de ces mots est une préposition ?', '["« dans »", "« mais »", "« très »", "« hélas »"]', '« dans »', '« Dans » relie un complément à un autre mot : « dans la cour ». « Mais » est une conjonction, « très » un adverbe, « hélas » une interjection.', 'Facile', 'NS1'),
('F01-35', NULL, 'Mot invariable qui relie deux mots ou deux propositions ?', '["La conjonction", "La préposition", "L''adverbe", "L''interjection"]', 'La conjonction', 'On distingue la conjonction de coordination et la conjonction de subordination.', 'Facile', 'NS1'),
('F01-36', NULL, 'Mot invariable qui relie des éléments de même fonction ou de même niveau ?', '["Une conjonction de coordination", "Une conjonction de subordination", "Une préposition", "Une interjection"]', 'Une conjonction de coordination', 'Exemples : « mais », « ou », « et », « donc », « or », « ni », « car ».', 'Moyen', 'NS1'),
('F01-37', NULL, 'Mot invariable qui rattache une proposition subordonnée à la proposition dont elle dépend ?', '["Une conjonction de subordination", "Une conjonction de coordination", "Une préposition", "Une interjection"]', 'Une conjonction de subordination', 'Exemples : « que », « quand », « parce que », « si », « lorsque ».', 'Moyen', 'NS1'),
('F01-38', NULL, 'Laquelle de ces conjonctions est une conjonction de coordination ?', '["« donc »", "« parce que »", "« quand »", "« lorsque »"]', '« donc »', 'Les conjonctions de coordination sont « mais, ou, et, donc, or, ni, car ». Les trois autres introduisent une subordonnée.', 'Moyen', 'NS1'),
('F01-39', NULL, 'Mot invariable, isolé, qui forme une phrase à lui seul et exprime le plus souvent une réaction affective vive ?', '["L''interjection", "L''adverbe", "La conjonction", "La préposition"]', 'L''interjection', 'Exemples : « Aïe ! », « Bravo ! », « Hélas ! », « Zut ! ».', 'Facile', 'NS1'),
('F01-40', NULL, 'Lequel de ces mots est une interjection ?', '["« Bravo ! »", "« Parfois »", "« Depuis »", "« Quand »"]', '« Bravo ! »', '« Bravo ! » exprime un sentiment à lui seul. « Parfois » est un adverbe, « depuis » une préposition, « quand » une conjonction.', 'Facile', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 25 AND titre = 'Nature des mots et classes grammaticales';
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
