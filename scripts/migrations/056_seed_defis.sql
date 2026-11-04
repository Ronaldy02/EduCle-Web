-- Migration 056 : Seed initial des défis (quotidiens D01-D40, hebdo W01-W25, mensuels M01-M22)
-- Idempotente : INSERT ... ON CONFLICT DO NOTHING
-- Paliers : 1 = Facile, 2 = Moyen, 3 = Difficile
-- Métriques : ans=bonnes réponses, game=parties jouées, perf=partie parfaite, str=série
-- Filtres JSON optionnels : {"md":"rev"} = Révision uniquement, {"h":"N"} = avant Nh

-- ─── QUOTIDIENS (D01–D40) ───────────────────────────────────────────────────
INSERT INTO defis (id, type, palier, nom, description, metrique, cible, filtres) VALUES

-- Palier 1 — Facile (D01–D14)
('D01','d',1,'Première lueur',   'Réponds correctement à 5 questions.',               'ans',  5,  NULL),
('D02','d',1,'Bon démarrage',    'Joue une partie complète.',                          'game', 1,  NULL),
('D03','d',1,'Curieux du jour',  'Réponds correctement à 7 questions.',               'ans',  7,  NULL),
('D04','d',1,'Mise en jambe',    'Réponds correctement à 10 questions.',              'ans', 10,  NULL),
('D05','d',1,'Routine matinale', 'Joue une partie avant 12h.',                        'game', 1,  '{"h":"12"}'),
('D06','d',1,'Réveil en douceur','Réponds correctement à 5 questions en Révision.',   'ans',  5,  '{"md":"rev"}'),
('D07','d',1,'Petit sprint',     'Réponds correctement à 8 questions.',               'ans',  8,  NULL),
('D08','d',1,'Du calme',         'Joue deux parties dans la journée.',                'game', 2,  NULL),
('D09','d',1,'Fidèle apprenant', 'Réponds correctement à 10 questions en Révision.',  'ans', 10,  '{"md":"rev"}'),
('D10','d',1,'Pas à pas',        'Réponds correctement à 12 questions.',              'ans', 12,  NULL),
('D11','d',1,'Rythme soutenu',   'Joue deux parties et réponds correctement à 8 questions.','ans',8, NULL),
('D12','d',1,'Matière à réfléchir','Réponds correctement à 15 questions.',            'ans', 15,  NULL),
('D13','d',1,'Lancé!',           'Réponds correctement à 10 questions le matin.',     'ans', 10,  '{"h":"12"}'),
('D14','d',1,'Zéro faute',       'Réalise une partie parfaite.',                      'perf', 1,  NULL),

-- Palier 2 — Moyen (D15–D27)
('D15','d',2,'Montée en cadence','Réponds correctement à 20 questions.',              'ans', 20,  NULL),
('D16','d',2,'Accélération',     'Réponds correctement à 25 questions.',              'ans', 25,  NULL),
('D17','d',2,'Session intense',  'Joue trois parties dans la journée.',               'game', 3,  NULL),
('D18','d',2,'Maître de Révision','Réponds correctement à 20 questions en Révision.', 'ans', 20,  '{"md":"rev"}'),
('D19','d',2,'Journée studieuse','Réponds correctement à 30 questions.',              'ans', 30,  NULL),
('D20','d',2,'Double palier',    'Réalise deux parties parfaites.',                   'perf', 2,  NULL),
('D21','d',2,'Sans relâche',     'Joue quatre parties dans la journée.',              'game', 4,  NULL),
('D22','d',2,'Puissance 25',     'Réponds correctement à 25 questions en Révision.',  'ans', 25,  '{"md":"rev"}'),
('D23','d',2,'Grand trente',     'Réponds correctement à 30 questions avant midi.',   'ans', 30,  '{"h":"12"}'),
('D24','d',2,'Flot continu',     'Réponds correctement à 35 questions.',              'ans', 35,  NULL),
('D25','d',2,'Cinq parties',     'Joue cinq parties dans la journée.',                'game', 5,  NULL),
('D26','d',2,'Quarante questions','Réponds correctement à 40 questions.',             'ans', 40,  NULL),
('D27','d',2,'Triple zéro faute','Réalise trois parties parfaites.',                  'perf', 3,  NULL),

-- Palier 3 — Difficile (D28–D40)
('D28','d',3,'Cinquante bonnes', 'Réponds correctement à 50 questions.',              'ans', 50,  NULL),
('D29','d',3,'Titan du jour',    'Réponds correctement à 60 questions.',              'ans', 60,  NULL),
('D30','d',3,'Marathon matinal', 'Réponds correctement à 50 questions avant midi.',   'ans', 50,  '{"h":"12"}'),
('D31','d',3,'Révision extrême', 'Réponds correctement à 50 questions en Révision.',  'ans', 50,  '{"md":"rev"}'),
('D32','d',3,'Six parties',      'Joue six parties dans la journée.',                 'game', 6,  NULL),
('D33','d',3,'Soixante-dix',     'Réponds correctement à 70 questions.',              'ans', 70,  NULL),
('D34','d',3,'Perfection double','Réalise deux parties parfaites en Révision.',       'perf', 2,  '{"md":"rev"}'),
('D35','d',3,'Titan de Révision','Réponds correctement à 60 questions en Révision.',  'ans', 60,  '{"md":"rev"}'),
('D36','d',3,'Cent réponses',    'Réponds correctement à 100 questions.',             'ans',100,  NULL),
('D37','d',3,'Sept parties',     'Joue sept parties dans la journée.',                'game', 7,  NULL),
('D38','d',3,'Perfection totale','Réalise trois parties parfaites dans la journée.',  'perf', 3,  NULL),
('D39','d',3,'Quatre-vingts',    'Réponds correctement à 80 questions.',              'ans', 80,  NULL),
('D40','d',3,'Légende du jour',  'Réponds correctement à 50 questions avant midi et joue 5 parties.','ans',50,'{"h":"12"}')

ON CONFLICT (id) DO NOTHING;

-- ─── HEBDOMADAIRES (W01–W25) ────────────────────────────────────────────────
INSERT INTO defis (id, type, palier, nom, description, metrique, cible, filtres) VALUES

-- Palier 1
('W01','w',1,'Semaine engagée',  'Joue 5 parties cette semaine.',                     'game',  5, NULL),
('W02','w',1,'Cap des 50',       'Réponds correctement à 50 questions cette semaine.', 'ans',  50, NULL),
('W03','w',1,'Révision semaine', 'Réponds correctement à 30 questions en Révision.',   'ans',  30, '{"md":"rev"}'),
('W04','w',1,'Perfectionniste',  'Réalise 3 parties parfaites cette semaine.',         'perf',  3, NULL),
('W05','w',1,'Dix parties',      'Joue 10 parties cette semaine.',                    'game', 10, NULL),
('W06','w',1,'Cap des 80',       'Réponds correctement à 80 questions cette semaine.', 'ans',  80, NULL),
('W07','w',1,'Réviseur assidu',  'Réponds correctement à 50 questions en Révision.',   'ans',  50, '{"md":"rev"}'),
('W08','w',1,'Cinq perfections', 'Réalise 5 parties parfaites cette semaine.',         'perf',  5, NULL),
('W09','w',1,'Rythme hebdo',     'Joue 15 parties cette semaine.',                    'game', 15, NULL),

-- Palier 2
('W10','w',2,'Cent réponses',    'Réponds correctement à 100 questions cette semaine.','ans', 100, NULL),
('W11','w',2,'Révision avancée', 'Réponds correctement à 80 questions en Révision.',   'ans',  80, '{"md":"rev"}'),
('W12','w',2,'Expert semaine',   'Joue 20 parties cette semaine.',                    'game', 20, NULL),
('W13','w',2,'Dix perfections',  'Réalise 10 parties parfaites cette semaine.',        'perf', 10, NULL),
('W14','w',2,'Cent cinquante',   'Réponds correctement à 150 questions cette semaine.','ans', 150, NULL),
('W15','w',2,'Réviseur expert',  'Réponds correctement à 120 questions en Révision.',  'ans', 120, '{"md":"rev"}'),
('W16','w',2,'Vingt-cinq parties','Joue 25 parties cette semaine.',                   'game', 25, NULL),
('W17','w',2,'Quinze perfections','Réalise 15 parties parfaites cette semaine.',       'perf', 15, NULL),

-- Palier 3
('W18','w',3,'Deux cents',       'Réponds correctement à 200 questions cette semaine.','ans', 200, NULL),
('W19','w',3,'Titan hebdo',      'Joue 30 parties cette semaine.',                    'game', 30, NULL),
('W20','w',3,'Maître de Révision','Réponds correctement à 150 questions en Révision.','ans', 150, '{"md":"rev"}'),
('W21','w',3,'Perfection totale','Réalise 20 parties parfaites cette semaine.',        'perf', 20, NULL),
('W22','w',3,'Trois cents',      'Réponds correctement à 300 questions cette semaine.','ans', 300, NULL),
('W23','w',3,'Trente-cinq parties','Joue 35 parties cette semaine.',                  'game', 35, NULL),
('W24','w',3,'Réviseur légendaire','Réponds correctement à 200 questions en Révision.','ans', 200, '{"md":"rev"}'),
('W25','w',3,'Semaine légendaire','Réponds correctement à 400 questions cette semaine.','ans',400, NULL)

ON CONFLICT (id) DO NOTHING;

-- ─── MENSUELS (M01–M22) ─────────────────────────────────────────────────────
INSERT INTO defis (id, type, palier, nom, description, metrique, cible, filtres) VALUES

-- Palier 1
('M01','m',1,'Mois engagé',      'Joue 30 parties ce mois.',                          'game',  30, NULL),
('M02','m',1,'Cap des 300',      'Réponds correctement à 300 questions ce mois.',      'ans',  300, NULL),
('M03','m',1,'Révision mensuelle','Réponds correctement à 200 questions en Révision.', 'ans',  200, '{"md":"rev"}'),
('M04','m',1,'Perfectionniste',  'Réalise 10 parties parfaites ce mois.',              'perf',  10, NULL),
('M05','m',1,'Cinquante parties','Joue 50 parties ce mois.',                          'game',  50, NULL),
('M06','m',1,'Cap des 500',      'Réponds correctement à 500 questions ce mois.',      'ans',  500, NULL),
('M07','m',1,'Grand réviseur',   'Réponds correctement à 400 questions en Révision.',  'ans',  400, '{"md":"rev"}'),
('M08','m',1,'Vingt perfections','Réalise 20 parties parfaites ce mois.',              'perf',  20, NULL),

-- Palier 2
('M09','m',2,'Cent parties',     'Joue 100 parties ce mois.',                         'game', 100, NULL),
('M10','m',2,'Mille réponses',   'Réponds correctement à 1 000 questions ce mois.',    'ans', 1000, NULL),
('M11','m',2,'Réviseur d'élite', 'Réponds correctement à 700 questions en Révision.',  'ans',  700, '{"md":"rev"}'),
('M12','m',2,'Trente perfections','Réalise 30 parties parfaites ce mois.',             'perf',  30, NULL),
('M13','m',2,'Cent cinquante parties','Joue 150 parties ce mois.',                    'game', 150, NULL),
('M14','m',2,'Quinze cents réponses','Réponds correctement à 1 500 questions ce mois.','ans', 1500, NULL),
('M15','m',2,'Révision intensive','Réponds correctement à 1 000 questions en Révision.','ans',1000, '{"md":"rev"}'),

-- Palier 3
('M16','m',3,'Deux mille réponses','Réponds correctement à 2 000 questions ce mois.', 'ans', 2000, NULL),
('M17','m',3,'Deux cents parties','Joue 200 parties ce mois.',                        'game', 200, NULL),
('M18','m',3,'Cinquante perfections','Réalise 50 parties parfaites ce mois.',          'perf',  50, NULL),
('M19','m',3,'Réviseur légendaire','Réponds correctement à 1 500 questions en Révision.','ans',1500,'{"md":"rev"}'),
('M20','m',3,'Trois mille',      'Réponds correctement à 3 000 questions ce mois.',    'ans', 3000, NULL),
('M21','m',3,'Deux cent cinquante parties','Joue 250 parties ce mois.',               'game', 250, NULL),
('M22','m',3,'Mois légendaire',  'Réponds correctement à 4 000 questions ce mois.',    'ans', 4000, NULL)

ON CONFLICT (id) DO NOTHING;
