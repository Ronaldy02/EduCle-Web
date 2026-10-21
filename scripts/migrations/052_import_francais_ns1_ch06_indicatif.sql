-- Import du chapitre Français « L'indicatif : temps simples et composés » (NS1, NS2, NS3, NS4) — questions validées par l'utilisateur
-- Idempotent : déplacement/mise à jour des questions déjà en base, insertion des nouvelles si absentes.
BEGIN;

CREATE TEMP TABLE imp (ref TEXT, ancien TEXT, enonce TEXT, choix JSONB, bonne TEXT, explication TEXT, complexite TEXT, niveau TEXT) ON COMMIT DROP;
INSERT INTO imp VALUES
('F06-01', NULL, 'Temps qui indique que l''action se passe au moment où l''on parle, ou qu''elle est non datée ?', '["Le présent", "Le futur simple", "L''imparfait", "Le passé composé"]', 'Le présent', 'Il exprime aussi une vérité générale ou une habitude.', 'Facile', 'NS1'),
('F06-03', NULL, 'Quelle valeur a le présent dans « Il prend le bus tous les matins » ?', '["Une habitude", "Une vérité générale", "Une action en cours", "Un fait passé"]', 'Une habitude', 'L''expression « tous les matins » marque la répétition.', 'Moyen', 'NS1'),
('F06-04', NULL, 'Quelle est la terminaison de la troisième personne du pluriel au présent des verbes du premier groupe ?', '["« -ent »", "« -ont »", "« -ant »", "« -ents »"]', '« -ent »', 'Ils chantent, elles parlent. Le « -ont » est celui du futur : ils chanteront.', 'Moyen', 'NS1'),
('F06-06', NULL, 'Quelle est la forme de « faire » à la deuxième personne du pluriel du présent ?', '["Vous faites", "Vous faisez", "Vous faisiez", "Vous ferez"]', 'Vous faites', 'Comme « dire » (vous dites) et « être » (vous êtes), « faire » fait « -tes » à cette personne.', 'Difficile', 'NS1'),
('F06-11', NULL, 'Temps du passé qui exprime une action non achevée, une habitude passée ou une description ?', '["L''imparfait", "Le passé simple", "Le passé composé", "Le plus-que-parfait"]', 'L''imparfait', 'Exemple : « Je parlais souvent avec lui ».', 'Moyen', 'NS1'),
('Q0195', 'À quoi sert l''imparfait de l''indicatif ?', 'À quoi sert l''imparfait de l''indicatif ?', '["Habitude ou description passée", "Action passée ponctuelle", "Action future", "Action possible"]', 'Habitude ou description passée', '« Elle habitait à Cap-Haïtien » décrit une situation passée. « Ils jouaient dans la cour » exprime une habitude passée.', 'Moyen', 'NS1'),
('F06-13', NULL, 'Quelle valeur a l''imparfait dans « Il pleuvait ce jour-là » ?', '["Une description du cadre", "Une action ponctuelle", "Une vérité générale", "Un ordre"]', 'Une description du cadre', 'L''imparfait plante le décor : il décrit la situation dans laquelle se déroule l''action.', 'Moyen', 'NS1'),
('F06-14', NULL, 'Quelle valeur a l''imparfait dans « Ils jouaient dans la cour chaque après-midi » ?', '["Une habitude passée", "Une action ponctuelle", "Une vérité générale", "Un fait achevé"]', 'Une habitude passée', '« Chaque après-midi » marque la répétition dans le passé.', 'Moyen', 'NS1'),
('F06-15', NULL, 'Quelle série de terminaisons est celle de l''imparfait ?', '["-ais, -ais, -ait, -ions, -iez, -aient", "-ai, -as, -a, -ons, -ez, -ont", "-ai, -as, -a, -âmes, -âtes, -èrent", "-e, -es, -e, -ons, -ez, -ent"]', '-ais, -ais, -ait, -ions, -iez, -aient', 'Les autres séries sont celles du futur simple, du passé simple (premier groupe) et du présent (premier groupe).', 'Difficile', 'NS1'),
('F06-21', NULL, 'Temps littéraire qui exprime une action passée, ponctuelle et achevée, employé dans le récit écrit ?', '["Le passé simple", "L''imparfait", "Le passé composé", "Le plus-que-parfait"]', 'Le passé simple', 'Exemple : « Il parla longuement à la foule ».', 'Moyen', 'NS1'),
('F06-22', NULL, 'Dans quel type de texte emploie-t-on surtout le passé simple ?', '["Le récit écrit", "La conversation courante", "Le dialogue oral", "La lettre amicale"]', 'Le récit écrit', 'À l''oral, on lui préfère le passé composé.', 'Moyen', 'NS1'),
('F06-23', NULL, 'Quel temps remplace le passé simple à l''oral ?', '["Le passé composé", "L''imparfait", "Le plus-que-parfait", "Le futur antérieur"]', 'Le passé composé', 'On écrit « Il partit à l''aube » mais on dit « Il est parti à l''aube ».', 'Moyen', 'NS1'),
('F06-24', NULL, 'À quel temps est « ils partirent » ?', '["Au passé simple", "Au présent", "À l''imparfait", "Au futur simple"]', 'Au passé simple', 'La terminaison « -irent » est celle du passé simple à la troisième personne du pluriel.', 'Moyen', 'NS1'),
('F06-25', NULL, 'Dans un récit au passé, quel temps exprime les actions principales, qui font avancer l''histoire ?', '["Le passé simple", "L''imparfait", "Le plus-que-parfait", "Le présent"]', 'Le passé simple', 'L''imparfait décrit le décor et les habitudes ; le passé simple raconte les événements : « Il pleuvait quand elle sortit ».', 'Difficile', 'NS1'),
('F06-26', NULL, 'Quelle série de terminaisons est celle du passé simple au premier groupe ?', '["-ai, -as, -a, -âmes, -âtes, -èrent", "-ais, -ais, -ait, -ions, -iez, -aient", "-ai, -as, -a, -ons, -ez, -ont", "-e, -es, -e, -ons, -ez, -ent"]', '-ai, -as, -a, -âmes, -âtes, -èrent', 'Exemple : je parlai, tu parlas, il parla, nous parlâmes, vous parlâtes, ils parlèrent.', 'Difficile', 'NS1'),
('F06-31', NULL, 'Forme verbale qui exprime qu''une action ou un état sont situés dans l''avenir ?', '["Le futur", "Le présent", "Le passé simple", "Le conditionnel"]', 'Le futur', 'Exemple : « Je parlerai demain à la réunion ».', 'Facile', 'NS1'),
('Q0207', 'Comment se forme le futur simple des verbes réguliers ?', 'Comment forme-t-on le futur simple des verbes réguliers ?', '["Infinitif + -ai, -as, -a", "Présent + terminaison", "Imparfait + -rai", "Avoir + participe présent"]', 'Infinitif + -ai, -as, -a', 'On ajoute à l''infinitif les terminaisons de l''auxiliaire « avoir » au présent : parler + ai = je parlerai, finir + as = tu finiras.', 'Moyen', 'NS1'),
('F06-41', NULL, 'Temps qui exprime une action passée et achevée, considérée dans son lien avec le présent ?', '["Le passé composé", "Le passé simple", "L''imparfait", "Le plus-que-parfait"]', 'Le passé composé', 'Exemple : « J''ai parlé à mon professeur ».', 'Moyen', 'NS1'),
('Q0196', 'À quoi sert le passé composé ?', 'À quoi sert le passé composé ?', '["Une action passée achevée", "Une habitude passée", "Une description passée", "Une action future"]', 'Une action passée achevée', 'Il rapporte un fait terminé dont les effets touchent encore le présent : « Il a réussi l''examen ».', 'Moyen', 'NS1'),
('F06-43', NULL, 'Comment se forme le passé composé ?', '["Auxiliaire au présent + participe passé", "Auxiliaire à l''imparfait + participe passé", "Auxiliaire au futur + participe passé", "Auxiliaire au conditionnel + participe passé"]', 'Auxiliaire au présent + participe passé', 'J''ai chanté = ai (avoir au présent) + chanté. Je suis parti = suis (être au présent) + parti.', 'Moyen', 'NS1'),
('F06-44', NULL, 'À quel temps est « elles sont arrivées » ?', '["Au passé composé", "Au plus-que-parfait", "Au futur antérieur", "Au passé antérieur"]', 'Au passé composé', '« Sont » est l''auxiliaire être au présent : le temps est le passé composé.', 'Moyen', 'NS1'),
('F06-51', NULL, 'Temps qui exprime une action passée, antérieure à une autre action passée ?', '["Le plus-que-parfait", "Le passé composé", "Le passé antérieur", "Le passé simple"]', 'Le plus-que-parfait', 'Exemple : « J''avais parlé avant qu''il n''arrive ».', 'Moyen', 'NS1'),
('F06-52', NULL, 'Comment se forme le plus-que-parfait ?', '["Auxiliaire à l''imparfait + participe passé", "Auxiliaire au présent + participe passé", "Auxiliaire au futur + participe passé", "Auxiliaire au passé simple + participe"]', 'Auxiliaire à l''imparfait + participe passé', 'J''avais chanté = avais (avoir à l''imparfait) + chanté. Il était parti = était (être à l''imparfait) + parti.', 'Moyen', 'NS1'),
('F06-53', NULL, 'À quel temps est « nous avions mangé » ?', '["Au plus-que-parfait", "Au passé composé", "À l''imparfait", "Au futur antérieur"]', 'Au plus-que-parfait', '« Avions » est l''auxiliaire avoir à l''imparfait.', 'Moyen', 'NS1'),
('F06-54', NULL, 'Dans « Tu avais fini quand je suis arrivé », quelle action s''est produite en premier ?', '["Tu avais fini", "Je suis arrivé", "Les deux en même temps", "On ne peut pas le savoir"]', 'Tu avais fini', 'Le plus-que-parfait marque l''antériorité par rapport à une autre action passée.', 'Moyen', 'NS1'),
('F06-61', NULL, 'Temps littéraire qui exprime une action passée immédiatement antérieure à une autre exprimée au passé simple ?', '["Le passé antérieur", "Le plus-que-parfait", "Le futur antérieur", "Le passé composé"]', 'Le passé antérieur', 'Exemple : « Quand il eut parlé, l''assemblée se tut ».', 'Difficile', 'NS1'),
('F06-62', NULL, 'Avec quel temps le passé antérieur s''emploie-t-il dans « Quand il eut parlé, l''assemblée se tut » ?', '["Le passé simple", "L''imparfait", "Le passé composé", "Le présent"]', 'Le passé simple', '« Eut parlé » est antérieur à « se tut », qui est au passé simple.', 'Difficile', 'NS1'),
('F06-63', NULL, 'À quel temps est « il fut parti » ?', '["Au passé antérieur", "Au plus-que-parfait", "Au passé simple", "Au futur antérieur"]', 'Au passé antérieur', '« Fut » est l''auxiliaire être au passé simple + le participe passé « parti ».', 'Difficile', 'NS1'),
('F06-64', NULL, 'Temps qui exprime une action future mais achevée avant une autre action future ?', '["Le futur antérieur", "Le futur simple", "Le plus-que-parfait", "Le conditionnel passé"]', 'Le futur antérieur', 'Exemple : « J''aurai parlé avant ton arrivée ».', 'Moyen', 'NS1'),
('F06-65', NULL, 'Comment se forme le futur antérieur ?', '["Auxiliaire au futur + participe passé", "Auxiliaire au conditionnel + participe passé", "Auxiliaire au présent + participe passé", "Auxiliaire à l''imparfait + participe passé"]', 'Auxiliaire au futur + participe passé', 'J''aurai chanté = aurai (avoir au futur simple) + chanté.', 'Moyen', 'NS1'),
('F06-66', NULL, 'À quel temps est « elles seront arrivées » ?', '["Au futur antérieur", "Au futur simple", "Au passé composé", "Au conditionnel passé"]', 'Au futur antérieur', '« Seront » est l''auxiliaire être au futur simple.', 'Moyen', 'NS1'),
('Q0211', 'Que signifie la concordance des temps ?', 'Que signifie la concordance des temps ?', '["L''accord des temps entre propositions", "L''accord du verbe avec le sujet", "L''accord du participe passé", "L''emploi d''un seul temps par phrase"]', 'L''accord des temps entre propositions', 'Si le verbe principal est au passé, les verbes subordonnés se mettent à un temps cohérent avec lui : « Il pensait qu''elle viendrait ».', 'Difficile', 'NS1'),
('F06-72', NULL, 'Dans un récit au passé, quel temps exprime ce qui s''est passé avant une action à l''imparfait ?', '["Le plus-que-parfait", "Le passé composé", "Le futur antérieur", "Le passé simple"]', 'Le plus-que-parfait', 'Exemple : « Il pleuvait parce que le ciel s''était couvert ».', 'Difficile', 'NS1');

CREATE TEMP TABLE cible ON COMMIT DROP AS SELECT id FROM chapitres WHERE matiere_id = 25 AND titre = 'L''indicatif : temps simples et composés';
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
