-- Import du chapitre Biologie « Les muscles : types, structure et propriétés » (NS3) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('B20-01', NULL, 'Organe capable de se contracter et d''assurer le mouvement.', '["Un muscle", "Un tendon", "Un ligament", "Un nerf"]', 'Un muscle', 'Le corps humain compte plus de 600 muscles. On les classe en trois types : lisse, strié squelettique et cardiaque.', 'Facile', 'NS3'),
('B20-02', NULL, 'Tissu contractile dont les cellules montrent, au microscope, des bandes claires et sombres alternées.', '["Le muscle strié", "Le muscle lisse", "Le muscle plat", "Le muscle court"]', 'Le muscle strié', 'Il comprend le muscle squelettique et le muscle cardiaque.', 'Moyen', 'NS3'),
('B20-03', NULL, 'Tissu contractile dont les cellules sont sans bandes visibles, à contraction lente et involontaire.', '["Le muscle lisse", "Le muscle strié", "Le muscle squelettique", "Le muscle annulaire"]', 'Le muscle lisse', 'Ses cellules ont la forme d''un fuseau et un seul noyau central.', 'Moyen', 'NS3'),
('B20-04', NULL, 'Tissu contractile strié fixé aux os par des tendons, à contraction volontaire.', '["Le muscle squelettique", "Le muscle cardiaque", "Le muscle lisse", "Le muscle annulaire"]', 'Le muscle squelettique', 'C''est le type le plus abondant : il assure les mouvements du corps et le maintien de la posture.', 'Moyen', 'NS3'),
('B20-05', NULL, 'Où trouve-t-on du muscle lisse ?', '["Dans la paroi des organes creux", "Fixé aux os par des tendons", "Dans la paroi du cœur", "Sous la peau du visage"]', 'Dans la paroi des organes creux', 'On le trouve dans l''estomac, l''intestin, la vessie et les vaisseaux sanguins.', 'Moyen', 'NS3'),
('B20-06', NULL, 'Comment est la contraction d''un muscle lisse ?', '["Lente et involontaire", "Rapide et volontaire", "Rapide et involontaire", "Lente et volontaire"]', 'Lente et involontaire', 'Elle est commandée par le système nerveux autonome, sans décision consciente.', 'Moyen', 'NS3'),
('B20-11', NULL, 'Muscle du bras dont une extrémité est rattachée à l''os par deux tendons séparés.', '["Le biceps", "Le triceps", "Le deltoïde", "Le trapèze"]', 'Le biceps', 'Le biceps brachial fléchit l''avant-bras sur le bras.', 'Facile', 'NS3'),
('B20-12', NULL, 'Muscle de l''arrière du bras qui étend l''avant-bras.', '["Le triceps", "Le biceps", "Le deltoïde", "Le quadriceps"]', 'Le triceps', 'Son nom vient de ses trois chefs, c''est-à-dire ses trois faisceaux d''attache.', 'Moyen', 'NS3'),
('B20-13', NULL, 'Muscle de la région supérieure de l''épaule, qui permet de lever le bras sur le côté.', '["Le deltoïde", "Le biceps", "Le pectoral", "Le fessier"]', 'Le deltoïde', 'Il a la forme d''un triangle, comme la lettre grecque delta.', 'Moyen', 'NS3'),
('B20-14', NULL, 'Saillie formée par les muscles de la partie postérieure de la jambe, entre la cheville et le genou.', '["Le mollet", "La cuisse", "Le talon", "Le tibia"]', 'Le mollet', 'Ses muscles relèvent le talon par le tendon d''Achille.', 'Facile', 'NS3'),
('B20-21', NULL, 'Du plus grand au plus petit, quelle suite décrit l''organisation d''un muscle strié ?', '["Muscle, faisceau, fibre, myofibrille", "Muscle, fibre, faisceau, myofibrille", "Faisceau, muscle, myofibrille, fibre", "Muscle, myofibrille, fibre, faisceau"]', 'Muscle, faisceau, fibre, myofibrille', 'On passe de l''observation à l''œil nu (muscle, faisceau) à l''observation au microscope (fibre, myofibrille).', 'Difficile', 'NS3'),
('B20-22', NULL, 'Longue cellule à plusieurs noyaux, unité de base des tissus capables de se contracter.', '["Une fibre musculaire", "Une fibre nerveuse", "Une fibre conjonctive", "Une fibre élastique"]', 'Une fibre musculaire', 'On l''appelle aussi myone. Elle peut atteindre plusieurs centimètres de long.', 'Moyen', 'NS3'),
('B20-23', NULL, 'Masse de cytoplasme limitée par une membrane, qui contient plusieurs noyaux et provient de la fusion de plusieurs cellules.', '["Un syncytium", "Un cytosquelette", "Un chromosome", "Un sarcomère"]', 'Un syncytium', 'Les fibres du muscle squelettique sont des syncytiums.', 'Difficile', 'NS3'),
('B20-24', NULL, 'Où se situent les noyaux d''une fibre de muscle squelettique ?', '["À la périphérie de la fibre", "Au centre de la fibre", "À une seule extrémité", "Dans chaque sarcomère"]', 'À la périphérie de la fibre', 'Les noyaux sont repoussés sous la membrane par les myofibrilles. C''est le contraire du muscle lisse, au noyau central.', 'Difficile', 'NS3'),
('B20-25', NULL, 'Structure en filament contractile qui remplit le cytoplasme des cellules striées.', '["Une myofibrille", "Un sarcomère", "Un ribosome", "Un tendon"]', 'Une myofibrille', 'Une fibre en contient des centaines, alignées dans sa longueur.', 'Moyen', 'NS3'),
('B20-26', NULL, 'Unité répétée de la myofibrille, comprise entre deux stries Z.', '["Un sarcomère", "Une myofibrille", "Un fascia", "Un faisceau"]', 'Un sarcomère', 'C''est l''unité de base de la contraction. Elle se raccourcit quand le muscle se contracte.', 'Difficile', 'NS3'),
('B20-27', NULL, 'Protéine contractile qui forme les filaments fins du sarcomère.', '["L''actine", "La myosine", "La kératine", "Le collagène"]', 'L''actine', 'Elle se lie à la myosine pendant la contraction.', 'Moyen', 'NS3'),
('B20-28', NULL, 'Protéine qui forme les filaments épais du sarcomère et libère l''énergie nécessaire à la contraction.', '["La myosine", "L''actine", "L''hémoglobine", "La myoglobine"]', 'La myosine', 'Ses têtes s''accrochent à l''actine puis pivotent pour la faire glisser.', 'Moyen', 'NS3'),
('B20-29', NULL, 'Protéine rouge qui fixe l''oxygène et le met en réserve dans les cellules striées.', '["La myoglobine", "L''hémoglobine", "La myosine", "La mélanine"]', 'La myoglobine', 'Elle donne leur couleur rouge aux muscles. Elle diffère de l''hémoglobine, qui circule dans les globules rouges.', 'Moyen', 'NS3'),
('B20-30', NULL, 'Qu''observe-t-on au microscope sur une coupe longitudinale de muscle squelettique ?', '["Des stries transversales", "Un seul noyau central", "Des cils vibratiles", "Des parois en cellulose"]', 'Des stries transversales', 'Ces stries correspondent à l''alternance des filaments d''actine et de myosine.', 'Moyen', 'NS3'),
('B20-31', NULL, 'Quelles fibres, riches en myoglobine et résistantes à la fatigue, conviennent à l''endurance ?', '["Les fibres lentes", "Les fibres rapides", "Les fibres lisses", "Les fibres nerveuses"]', 'Les fibres lentes', 'Elles dominent chez un marathonien. Les fibres rapides, plus puissantes, se fatiguent vite et dominent chez un sprinteur.', 'Moyen', 'NS3'),
('B20-41', NULL, 'Tissu fibreux par lequel un muscle s''attache à un os.', '["Un tendon", "Un ligament", "Un cartilage", "Un nerf"]', 'Un tendon', 'Les tendons transmettent la force du muscle à l''os pour produire le mouvement.', 'Facile', 'NS3'),
('B20-42', NULL, 'Quel tendon relie les muscles du mollet au talon ?', '["Le tendon d''Achille", "Le tendon rotulien", "Le tendon du biceps", "Le ligament croisé"]', 'Le tendon d''Achille', 'C''est le plus épais et le plus résistant du corps ; il peut se rompre lors d''un effort violent.', 'Moyen', 'NS3'),
('B20-43', NULL, 'Membrane conjonctive qui enveloppe les muscles ou les fixe aux os.', '["Une aponévrose", "Un cartilage", "Un nerf", "Un vaisseau"]', 'Une aponévrose', 'Elle ressemble à un tendon aplati, en forme de lame.', 'Difficile', 'NS3'),
('B20-44', NULL, 'Membrane fibreuse qui recouvre des muscles ou une région du corps.', '["Un fascia", "Un cartilage", "Un nerf", "Un tendon"]', 'Un fascia', 'Les fascias séparent les muscles entre eux et leur permettent de glisser les uns sur les autres.', 'Difficile', 'NS3'),
('B20-45', NULL, 'Ensemble de fibres conjonctives serrées qui unissent deux os au niveau d''une articulation.', '["Un ligament", "Un tendon", "Un cartilage", "Une aponévrose"]', 'Un ligament', 'Il stabilise l''articulation ; une entorse est une lésion des ligaments.', 'Moyen', 'NS3'),
('B20-46', NULL, 'Jointure entre deux os.', '["Une articulation", "Une vertèbre", "Un cartilage", "Un tendon"]', 'Une articulation', 'Le genou, le coude et l''épaule sont des articulations mobiles.', 'Facile', 'NS3'),
('B20-47', NULL, 'Charpente osseuse du corps de l''homme et des animaux.', '["Le squelette", "L''exosquelette", "Le cytosquelette", "Le crâne"]', 'Le squelette', 'Il soutient le corps et sert de point d''appui aux muscles.', 'Facile', 'NS3'),
('B20-51', NULL, 'Propriété d''une cellule nerveuse ou musculaire de réagir à une stimulation.', '["L''excitabilité", "La contractilité", "L''élasticité", "L''extensibilité"]', 'L''excitabilité', 'Synonyme : réactivité. Un muscle est excité par un influx nerveux.', 'Moyen', 'NS3'),
('B20-52', NULL, 'Capacité d''un muscle de se raccourcir en développant une force.', '["La contractilité", "L''excitabilité", "L''élasticité", "La motricité"]', 'La contractilité', 'C''est la propriété principale du muscle.', 'Moyen', 'NS3'),
('B20-53', NULL, 'Capacité d''un muscle de s''allonger quand on tire dessus.', '["L''extensibilité", "L''excitabilité", "La contractilité", "La tonicité"]', 'L''extensibilité', 'Les étirements après le sport l''entretiennent.', 'Moyen', 'NS3'),
('B20-54', NULL, 'Capacité d''un muscle étiré de reprendre sa forme et sa longueur initiales.', '["L''élasticité", "L''extensibilité", "L''excitabilité", "La motricité"]', 'L''élasticité', 'Un muscle étiré puis lâché revient à sa longueur de repos.', 'Moyen', 'NS3'),
('B20-55', NULL, 'État de légère tension permanente des muscles du squelette au repos.', '["Le tonus", "Le spasme", "La crampe", "La fatigue"]', 'Le tonus', 'Il maintient la posture, même sans mouvement. Il disparaît pendant le sommeil profond.', 'Moyen', 'NS3'),
('B20-56', NULL, 'Raccourcissement d''un muscle sous l''effet d''un ordre nerveux.', '["La contraction", "Le relâchement", "L''extension", "La flexion"]', 'La contraction', 'Elle consomme de l''énergie fournie par l''ATP.', 'Facile', 'NS3'),
('B20-57', NULL, 'Retour d''un muscle à l''état de repos, avec diminution de sa tension.', '["Le relâchement", "La contraction", "La flexion", "L''extension"]', 'Le relâchement', 'Contraction et relâchement alternent à chaque mouvement.', 'Facile', 'NS3'),
('B20-59', NULL, 'Ensemble des fonctions nerveuses et musculaires qui permettent les mouvements du corps.', '["La motricité", "La sensibilité", "L''excitabilité", "La coordination"]', 'La motricité', 'Elle comprend les mouvements volontaires et automatiques.', 'Moyen', 'NS3'),
('B20-61', NULL, 'Action de plier un membre en rapprochant ses deux segments.', '["La flexion", "L''extension", "La torsion", "La rotation"]', 'La flexion', 'Exemple : plier le coude ou le genou.', 'Moyen', 'NS3'),
('B20-62', NULL, 'Action d''allonger un membre en écartant ses deux segments.', '["L''extension", "La flexion", "La torsion", "La rotation"]', 'L''extension', 'Exemple : tendre le bras ou la jambe.', 'Moyen', 'NS3'),
('B20-63', NULL, 'Muscle dont la contraction plie un membre.', '["Un muscle fléchisseur", "Un muscle extenseur", "Un muscle sphincter", "Un muscle lisse"]', 'Un muscle fléchisseur', 'Le biceps est le fléchisseur du bras.', 'Moyen', 'NS3'),
('B20-64', NULL, 'Muscle dont la contraction allonge un segment de membre.', '["Un muscle extenseur", "Un muscle fléchisseur", "Un muscle sphincter", "Un muscle lisse"]', 'Un muscle extenseur', 'Le triceps est l''extenseur du bras.', 'Moyen', 'NS3'),
('B20-65', NULL, 'Muscle dont l''action produit le mouvement souhaité.', '["Un muscle agoniste", "Un muscle antagoniste", "Un muscle synergique", "Un muscle sphincter"]', 'Un muscle agoniste', 'Quand on plie le bras, le biceps est l''agoniste.', 'Moyen', 'NS3'),
('B20-66', NULL, 'Muscle dont l''action s''oppose à celle d''un autre muscle.', '["Un muscle antagoniste", "Un muscle agoniste", "Un muscle synergique", "Un muscle sphincter"]', 'Un muscle antagoniste', 'Les muscles fonctionnent par paires antagonistes : l''un se contracte pendant que l''autre se relâche.', 'Moyen', 'NS3'),
('B20-67', NULL, 'Quel muscle est l''antagoniste du biceps ?', '["Le triceps", "Le deltoïde", "Le trapèze", "Le pectoral"]', 'Le triceps', 'Quand le biceps se contracte, le triceps se relâche, et inversement.', 'Moyen', 'NS3');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 11 AND titre = 'Les muscles : types, structure et propriétés';
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
