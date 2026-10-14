-- Import du chapitre Biologie « Le cœur et la circulation sanguine » (NS2) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('B14-01', NULL, 'Liquide rouge qui circule dans tout l''organisme sous l''impulsion du cœur, apporte aux tissus les nutriments et l''oxygène et recueille leurs déchets.', '["Le sang", "La lymphe", "La sueur", "L''urine"]', 'Le sang', 'Un adulte en possède environ 5 litres.', 'Facile', 'NS2'),
('B14-02', NULL, 'Cellule sanguine qui transporte l''oxygène des poumons vers les tissus.', '["L''hématie", "Le leucocyte", "La plaquette", "Le neurone"]', 'L''hématie', 'On l''appelle aussi globule rouge ; sa couleur vient de l''hémoglobine.', 'Moyen', 'NS2'),
('Q1595', 'Quelle est la fonction principale des globules blancs (leucocytes) ?', 'Cellule du sang capable de se déplacer dans les tissus pour participer aux défenses de l''organisme.', '["Le globule blanc", "Le globule rouge", "La plaquette", "L''hématie"]', 'Le globule blanc', 'On l''appelle aussi leucocyte ; les lymphocytes en font partie.', 'Facile', 'NS2'),
('B14-03', NULL, 'Cellule sanguine sans noyau, qui joue un rôle important dans la coagulation du sang.', '["La plaquette", "L''hématie", "Le leucocyte", "Le lymphocyte"]', 'La plaquette', 'Elle aide à boucher une plaie en formant un caillot.', 'Moyen', 'NS2'),
('Q1587', 'Qu''est-ce qui caractérise l''anémie ?', 'Diminution du taux d''hémoglobine dans le sang.', '["L''anémie", "L''hypertension", "L''hématurie", "La leucémie"]', 'L''anémie', 'Le malade est pâle et vite fatigué ; un manque de fer en est une cause fréquente.', 'Moyen', 'NS2'),
('B14-04', NULL, 'Quel volume de sang le corps d''un adulte contient-il environ ?', '["Environ 5 litres", "Environ 1 litre", "Environ 20 litres", "Environ 50 litres"]', 'Environ 5 litres', 'Cela représente environ 7 % de la masse du corps.', 'Facile', 'NS2'),
('Q1572', 'Quel organe pompe le sang dans le corps humain ?', 'Organe musculaire creux, qui constitue l''élément moteur central de la circulation du sang.', '["Le cœur", "Le poumon", "Le foie", "L''estomac"]', 'Le cœur', 'Il bat environ 100 000 fois par jour.', 'Facile', 'NS2'),
('B14-05', NULL, 'Muscle du cœur dont les contractions assurent la vidange et le remplissage de ses cavités.', '["Le myocarde", "Le péricarde", "Le diaphragme", "Le septum"]', 'Le myocarde', 'Il se contracte sans jamais se fatiguer, toute la vie.', 'Difficile', 'NS2'),
('B14-06', NULL, 'Membrane formée de deux feuillets, qui enveloppe le cœur.', '["Le péricarde", "Le myocarde", "La plèvre", "Le péritoine"]', 'Le péricarde', 'Elle protège le cœur et facilite ses mouvements.', 'Moyen', 'NS2'),
('B14-07', NULL, 'Cavité du cœur qui reçoit le sang avant de le faire passer dans le ventricule correspondant.', '["L''oreillette", "Le ventricule", "L''aorte", "La valvule"]', 'L''oreillette', 'Le cœur en possède deux, une droite et une gauche.', 'Moyen', 'NS2'),
('B14-08', NULL, 'Cavité du cœur, à paroi épaisse, qui reçoit le sang de l''oreillette et le chasse dans une artère.', '["Le ventricule", "L''oreillette", "La veine cave", "Le péricarde"]', 'Le ventricule', 'Le gauche, qui envoie le sang dans tout le corps, a la paroi la plus épaisse.', 'Moyen', 'NS2'),
('B14-09', NULL, 'Cloison qui sépare le cœur droit du cœur gauche.', '["Le septum", "Le péricarde", "La valvule", "Le diaphragme"]', 'Le septum', 'Le sang des deux côtés ne se mélange donc jamais.', 'Difficile', 'NS2'),
('B14-10', NULL, 'Repli membraneux qui dirige le sang dans un seul sens et l''empêche de refluer.', '["La valvule", "Le septum", "Le péricarde", "L''oreillette"]', 'La valvule', 'On en trouve dans le cœur et dans les veines des jambes.', 'Moyen', 'NS2'),
('B14-11', NULL, 'Phase du cycle cardiaque correspondant à la contraction des oreillettes puis à celle des ventricules.', '["La systole", "La diastole", "L''inspiration", "La syncope"]', 'La systole', 'Elle chasse le sang dans les artères.', 'Difficile', 'NS2'),
('B14-12', NULL, 'Période qui suit la contraction du cœur, pendant laquelle les oreillettes et les ventricules se remplissent de sang.', '["La diastole", "La systole", "L''expiration", "L''apnée"]', 'La diastole', 'C''est la phase de relâchement du cœur.', 'Difficile', 'NS2'),
('B14-13', NULL, 'Onde provoquée par la contraction du cœur, que l''on sent sous le doigt posé sur une artère.', '["Le pouls", "La tension", "La systole", "Le souffle"]', 'Le pouls', 'On le prend souvent au poignet ou au cou.', 'Moyen', 'NS2'),
('B14-14', NULL, 'Combien de cavités le cœur humain possède-t-il ?', '["Quatre", "Deux", "Trois", "Six"]', 'Quatre', 'Deux oreillettes en haut, deux ventricules en bas.', 'Facile', 'NS2'),
('B14-15', NULL, 'Quel côté du cœur contient le sang riche en dioxygène ?', '["Le côté gauche", "Le côté droit", "Les deux côtés", "Aucun côté"]', 'Le côté gauche', 'Il revient des poumons par les veines pulmonaires.', 'Moyen', 'NS2'),
('B14-20', NULL, 'Canal dans lequel circule le sang ou la lymphe.', '["Un vaisseau", "Un nerf", "Un tendon", "Un ligament"]', 'Un vaisseau', 'Artères, veines et capillaires en sont les trois types.', 'Facile', 'NS2'),
('B14-21', NULL, 'Vaisseau qui conduit le sang sous pression du cœur vers les capillaires.', '["Une artère", "Une veine", "Un capillaire", "Un nerf"]', 'Une artère', 'Sa paroi est épaisse et élastique.', 'Facile', 'NS2'),
('B14-22', NULL, 'Vaisseau sanguin qui ramène le sang des organes vers le cœur.', '["Une veine", "Une artère", "Un capillaire", "Un nerf"]', 'Une veine', 'Sa paroi est mince ; celles des jambes ont des valvules.', 'Facile', 'NS2'),
('B14-23', NULL, 'Vaisseau très fin, qui relie les dernières ramifications des artères aux plus petites veines.', '["Un capillaire", "Une artère", "Une veine", "Une bronchiole"]', 'Un capillaire', 'C''est à son niveau que le sang échange avec les cellules.', 'Moyen', 'NS2'),
('B14-24', NULL, 'Principale artère de l''organisme, partant du ventricule gauche et distribuant le sang oxygéné dans tout le corps.', '["L''aorte", "La veine cave", "L''artère pulmonaire", "La carotide"]', 'L''aorte', 'C''est le plus gros vaisseau du corps.', 'Moyen', 'NS2'),
('B14-25', NULL, 'À quel niveau se font les échanges entre le sang et les cellules ?', '["Dans les capillaires", "Dans les artères", "Dans les veines", "Dans le cœur"]', 'Dans les capillaires', 'Leur paroi n''a qu''une seule couche de cellules.', 'Moyen', 'NS2'),
('B14-26', NULL, 'Quelle est la longueur totale approximative des vaisseaux sanguins d''un adulte ?', '["Environ 100 000 km", "Environ 100 km", "Environ 1 000 km", "Environ 1 million de km"]', 'Environ 100 000 km', 'C''est plus de deux fois le tour de la Terre.', 'Moyen', 'NS2'),
('B14-27', NULL, 'Pourquoi dit-on que la circulation sanguine humaine est close ?', '["Le sang reste dans des vaisseaux", "Le cœur est fermé", "Le sang reste dans le cœur", "Les vaisseaux sont bouchés"]', 'Le sang reste dans des vaisseaux', 'Chez certains animaux, le sang baigne directement les organes.', 'Moyen', 'NS2'),
('B14-30', NULL, 'Mouvement continu du sang dans les artères et les veines.', '["La circulation", "La respiration", "La digestion", "La coagulation"]', 'La circulation', 'Elle a été décrite par William Harvey en 1628.', 'Moyen', 'NS2'),
('B14-31', NULL, 'Trajet du sang du ventricule droit vers les poumons, puis retour à l''oreillette gauche.', '["La petite circulation", "La grande circulation", "La circulation lymphatique", "La circulation portale"]', 'La petite circulation', 'On l''appelle aussi circulation pulmonaire ; le sang s''y charge en dioxygène.', 'Moyen', 'NS2'),
('B14-32', NULL, 'Trajet du sang du ventricule gauche vers tous les organes, puis retour à l''oreillette droite.', '["La grande circulation", "La petite circulation", "La circulation pulmonaire", "La circulation lymphatique"]', 'La grande circulation', 'On l''appelle aussi circulation générale.', 'Moyen', 'NS2'),
('B14-33', NULL, 'Combien de fois le sang passe-t-il par le cœur lors d''un tour complet du corps ?', '["Deux fois", "Une fois", "Trois fois", "Quatre fois"]', 'Deux fois', 'C''est pourquoi on parle de double circulation.', 'Moyen', 'NS2'),
('B14-34', NULL, 'Quelle artère transporte du sang pauvre en dioxygène ?', '["L''artère pulmonaire", "L''aorte", "L''artère rénale", "La carotide"]', 'L''artère pulmonaire', 'Elle mène le sang du ventricule droit aux poumons.', 'Difficile', 'NS2'),
('B14-35', NULL, 'Par quels vaisseaux le sang revient-il des organes à l''oreillette droite ?', '["Les veines caves", "Les veines pulmonaires", "L''aorte", "Les artères pulmonaires"]', 'Les veines caves', 'Il y en a deux : la supérieure et l''inférieure.', 'Moyen', 'NS2'),
('B14-40', NULL, 'Liquide organique translucide qui joue un rôle important dans la défense de l''organisme.', '["La lymphe", "Le plasma", "La salive", "Le sang"]', 'La lymphe', 'Elle provient du liquide qui baigne les cellules et rejoint le sang.', 'Moyen', 'NS2'),
('B14-41', NULL, 'Petit renflement arrondi situé sur le trajet des vaisseaux qui transportent la lymphe.', '["Un ganglion", "Une valvule", "Un capillaire", "Une alvéole"]', 'Un ganglion', 'Il grossit quand l''organisme combat une infection.', 'Moyen', 'NS2');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Le cœur et la circulation sanguine';
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
