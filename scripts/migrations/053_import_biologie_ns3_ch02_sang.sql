-- Import du chapitre Biologie « Le sang et l'approvisionnement des muscles » (NS3) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('B21-01', NULL, 'Quel constituant forme l''essentiel du plasma ?', '["L''eau", "Les protéines", "Le glucose", "Les sels minéraux"]', 'L''eau', 'Le plasma contient environ 90 % d''eau, où sont dissous protéines, sels minéraux, nutriments et déchets.', 'Facile', 'NS3'),
('B21-02', NULL, 'Substance organique protéique, soluble dans l''eau, coagulable par la chaleur, contenue dans le blanc d''œuf, le plasma sanguin, le lait, etc.', '["L''albumine", "L''urée", "Le glucose", "L''amidon"]', 'L''albumine', 'Dans le plasma, c''est la protéine la plus abondante : elle transporte de nombreuses substances.', 'Moyen', 'NS3'),
('B21-03', NULL, 'Protéine de poids moléculaire élevé, telle que les anticorps.', '["Une globuline", "Une albumine", "Une hormone", "Une vitamine"]', 'Une globuline', 'Les globulines du plasma comprennent les anticorps, qui défendent l''organisme.', 'Moyen', 'NS3'),
('B21-04', NULL, 'Protéine du plasma sanguin, qui se transforme en fibrine lors de la coagulation.', '["Le fibrinogène", "L''albumine", "L''hémoglobine", "La myoglobine"]', 'Le fibrinogène', 'La fibrine forme le réseau du caillot qui arrête le saignement.', 'Moyen', 'NS3'),
('B21-05', NULL, 'Liquide qui exsude d''un caillot de sang total coagulé ou liquide qui se sépare des globules d''un sang défibriné centrifugé.', '["Le sérum", "Le plasma", "La lymphe", "L''urine"]', 'Le sérum', 'Le sérum est du plasma privé de fibrinogène.', 'Difficile', 'NS3'),
('B21-11', NULL, 'Quelle forme ont les hématies ?', '["Un disque biconcave", "Une sphère pleine", "Un cube aplati", "Un bâtonnet"]', 'Un disque biconcave', 'Cette forme leur donne une grande surface d''échange avec l''oxygène et les rend souples dans les capillaires.', 'Moyen', 'NS3'),
('B21-12', NULL, 'Que perdent les hématies humaines en arrivant à maturité ?', '["Leur noyau", "Leur membrane", "Leur hémoglobine", "Leur cytoplasme"]', 'Leur noyau', 'Elles ont ainsi plus de place pour l''hémoglobine. Elles vivent environ 120 jours.', 'Moyen', 'NS3'),
('B21-13', NULL, 'Pourcentage du volume occupé par les globules rouges par rapport au volume total du sang, égal normalement à environ 40 %.', '["L''hématocrite", "L''hémoglobine", "La glycémie", "La volémie"]', 'L''hématocrite', 'Il est mesuré par une prise de sang ; il baisse en cas d''anémie.', 'Moyen', 'NS3'),
('B21-14', NULL, 'Globule blanc du sang caractérisé par des granulations neutrophiles, éosinophiles ou basophiles, et par un noyau polylobé.', '["Un granulocyte", "Un monocyte", "Un lymphocyte", "Une plaquette"]', 'Un granulocyte', 'On l''appelle aussi polynucléaire.', 'Moyen', 'NS3'),
('B21-15', NULL, 'Quels sont les trois types de granulocytes ?', '["Neutrophiles, éosinophiles, basophiles", "Neutrophiles, monocytes, basophiles", "Éosinophiles, lymphocytes, basophiles", "Neutrophiles, éosinophiles, plaquettes"]', 'Neutrophiles, éosinophiles, basophiles', 'Les neutrophiles sont les plus nombreux : ils détruisent les bactéries.', 'Difficile', 'NS3'),
('B21-16', NULL, 'Leucocyte mononucléé, la plus grande des cellules circulantes, qui assure essentiellement la phagocytose.', '["Un monocyte", "Un granulocyte", "Un lymphocyte", "Une hématie"]', 'Un monocyte', 'Dans les tissus, il se transforme en macrophage.', 'Moyen', 'NS3'),
('B21-17', NULL, 'Cellule du système immunitaire, responsable des réactions de défense de l''organisme contre les substances qu''il considère comme étrangères.', '["Un lymphocyte", "Un monocyte", "Un granulocyte", "Une hématie"]', 'Un lymphocyte', 'On distingue les lymphocytes B, qui fabriquent les anticorps, et les lymphocytes T.', 'Moyen', 'NS3'),
('B21-18', NULL, 'Substance molle, graisseuse, qui remplit le canal médullaire et les alvéoles de la substance spongieuse des différents os, responsable de la production de tous les éléments figurés du sang.', '["La moelle osseuse", "La moelle épinière", "Le cartilage", "Le périoste"]', 'La moelle osseuse', 'Le terme « éléments figurés » désigne les hématies, les leucocytes et les plaquettes.', 'Moyen', 'NS3'),
('B21-19', NULL, 'Formation des cellules du sang dans la moelle rouge des os et dans le tissu lymphoïde.', '["L''hématopoïèse", "L''hémolyse", "La coagulation", "La phagocytose"]', 'L''hématopoïèse', 'Toutes les cellules du sang dérivent de cellules souches de la moelle osseuse.', 'Moyen', 'NS3'),
('B21-21', NULL, 'Oligoélément indispensable à l''organisme, qui intervient dans de nombreuses réactions chimiques et permet notamment le transport de l''oxygène par l''hémoglobine des globules rouges.', '["Le fer", "Le calcium", "Le sodium", "Le zinc"]', 'Le fer', 'Un manque de fer provoque une anémie. Le foie, les haricots et les épinards en sont riches.', 'Moyen', 'NS3'),
('B21-22', NULL, 'Comment appelle-t-on l''hémoglobine combinée à l''oxygène ?', '["L''oxyhémoglobine", "La carboxyhémoglobine", "La myoglobine", "La globuline"]', 'L''oxyhémoglobine', 'Elle se forme dans les capillaires des poumons et libère l''oxygène dans les tissus.', 'Moyen', 'NS3'),
('B21-23', NULL, 'Combinaison réversible de l''oxyde de carbone avec l''hémoglobine.', '["La carboxyhémoglobine", "L''oxyhémoglobine", "La myoglobine", "La globuline"]', 'La carboxyhémoglobine', 'L''oxyde de carbone se fixe sur l''hémoglobine bien plus facilement que l''oxygène : les fumées de charbon dans une pièce fermée peuvent asphyxier.', 'Moyen', 'NS3'),
('B21-24', NULL, 'Sous quelle forme le dioxyde de carbone est-il surtout transporté dans le sang ?', '["Ions bicarbonate", "Gaz libre dans le plasma", "Fixé sur le fer", "Lié à la myoglobine"]', 'Ions bicarbonate', 'Le CO₂ est transporté vers les poumons, où il est rejeté dans l''air expiré.', 'Difficile', 'NS3'),
('B21-25', NULL, 'Insuffisance d''apport en oxygène aux organes et aux tissus vivants.', '["L''anoxie", "L''anémie", "La polyglobulie", "L''hémolyse"]', 'L''anoxie', 'Un muscle privé d''oxygène produit de l''énergie sans oxygène et fabrique de l''acide lactique.', 'Moyen', 'NS3'),
('B21-26', NULL, 'Diminution de la concentration d''oxygène dans le sang.', '["L''hypoxie", "L''hyperglycémie", "La polyglobulie", "L''hémolyse"]', 'L''hypoxie', 'Elle se produit par exemple en haute altitude.', 'Moyen', 'NS3'),
('B21-31', NULL, 'Ensemble des vaisseaux sanguins irriguant une région du corps, un organe ou un tissu.', '["La vascularisation", "La coagulation", "La ventilation", "L''oxygénation"]', 'La vascularisation', 'Les muscles, très consommateurs, sont richement vascularisés.', 'Moyen', 'NS3'),
('B21-32', NULL, 'Vaisseau sanguin de faible diamètre qui assure la liaison entre une artère et un capillaire.', '["Une artériole", "Une veinule", "Une artère", "Une veine"]', 'Une artériole', 'Ses parois musculaires règlent le débit sanguin vers les capillaires.', 'Moyen', 'NS3'),
('B21-33', NULL, 'Veine de petite dimension.', '["Une veinule", "Une artériole", "Un capillaire", "Une valvule"]', 'Une veinule', 'Elle recueille le sang des capillaires et le conduit vers les veines.', 'Moyen', 'NS3'),
('B21-34', NULL, 'Diminution du calibre des vaisseaux sanguins par contraction de leurs cellules musculaires.', '["La vasoconstriction", "La vasodilatation", "L''hémostase", "L''hémolyse"]', 'La vasoconstriction', 'Elle réduit le débit de sang dans la région concernée.', 'Moyen', 'NS3'),
('B21-35', NULL, 'Augmentation du calibre des vaisseaux sanguins par relâchement de leurs cellules musculaires.', '["La vasodilatation", "La vasoconstriction", "L''hémostase", "L''hémolyse"]', 'La vasodilatation', 'À l''effort, elle augmente l''apport de sang aux muscles actifs.', 'Moyen', 'NS3'),
('B21-36', NULL, 'Quel nutriment sucré le sang apporte-t-il aux muscles pour produire de l''énergie ?', '["Le glucose", "L''amidon", "Le cholestérol", "L''urée"]', 'Le glucose', 'Les muscles utilisent aussi des acides gras. Ils emmagasinent du glucose sous forme de glycogène.', 'Moyen', 'NS3'),
('B21-41', NULL, 'Arrêt de l''écoulement du sang, spontané (coagulation du sang) ou provoqué par différents moyens médicaux ou chirurgicaux.', '["L''hémostase", "L''hémolyse", "La transfusion", "L''hémorragie"]', 'L''hémostase', 'Elle comporte l''arrêt du vaisseau, le bouchon de plaquettes puis le caillot.', 'Moyen', 'NS3'),
('B21-42', NULL, 'Substance médicamenteuse ou naturelle s''opposant à la coagulation du sang.', '["Un anticoagulant", "Un antibiotique", "Un anticorps", "Un antalgique"]', 'Un anticoagulant', 'Les anticoagulants préviennent la formation de caillots dangereux.', 'Moyen', 'NS3'),
('B21-43', NULL, 'Écoulement de sang hors des vaisseaux sanguins.', '["Une hémorragie", "Un hématome", "Un caillot", "Un œdème"]', 'Une hémorragie', 'Elle peut être externe (plaie) ou interne.', 'Facile', 'NS3'),
('B21-44', NULL, 'Collection de sang dans une cavité naturelle ou dans un tissu, consécutive à une hémorragie.', '["Un hématome", "Un œdème", "Un abcès", "Une plaie"]', 'Un hématome', 'Familièrement, on parle d''un bleu.', 'Moyen', 'NS3'),
('B21-45', NULL, 'Destruction des globules rouges du sang.', '["L''hémolyse", "L''hémostase", "La coagulation", "La phagocytose"]', 'L''hémolyse', 'Elle libère l''hémoglobine dans le plasma.', 'Moyen', 'NS3'),
('B21-46', NULL, 'Injection, dans une veine d''un malade, de sang ou d''un produit dérivé préalablement prélevé sur un ou plusieurs donneurs ou sur le malade lui-même.', '["Une transfusion", "Une dialyse", "Une greffe", "Une perfusion"]', 'Une transfusion', 'Elle est indiquée après une hémorragie importante ou en cas d''anémie sévère.', 'Moyen', 'NS3'),
('B21-47', NULL, 'Augmentation de la masse totale des globules rouges de l''organisme.', '["La polyglobulie", "L''anémie", "La leucémie", "L''hémophilie"]', 'La polyglobulie', 'Elle s''observe notamment chez les personnes vivant en altitude.', 'Moyen', 'NS3'),
('B21-48', NULL, 'Maladie maligne caractérisée par la prolifération dans la moelle osseuse de globules blancs ou de leurs précurseurs, qui peuvent se répandre dans le sang.', '["La leucémie", "L''anémie", "L''hémophilie", "La polyglobulie"]', 'La leucémie', 'On parle aussi de cancer du sang.', 'Moyen', 'NS3'),
('B21-49', NULL, 'Maladie héréditaire caractérisée par une tendance plus ou moins grave aux hémorragies, du fait de l''insuffisance d''un facteur de coagulation dans le plasma.', '["L''hémophilie", "La leucémie", "L''anémie", "La drépanocytose"]', 'L''hémophilie', 'Elle touche presque uniquement les garçons.', 'Moyen', 'NS3'),
('B21-50', NULL, 'Spécialité médicale qui étudie le sang, les organes hématopoïétiques et leurs affections.', '["L''hématologie", "La cardiologie", "La néphrologie", "L''immunologie"]', 'L''hématologie', 'Les analyses de sang, comme la numération formule sanguine, relèvent de cette spécialité.', 'Moyen', 'NS3'),
('B21-51', NULL, 'Spécialiste d''hématologie.', '["Un hématologue", "Un cardiologue", "Un néphrologue", "Un urologue"]', 'Un hématologue', 'Il soigne par exemple les leucémies et l''hémophilie.', 'Facile', 'NS3');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Le sang et l''approvisionnement des muscles';
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
