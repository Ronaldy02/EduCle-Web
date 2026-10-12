-- Création des chapitres manquants pour Géographie Secondaire (matiere_id = 28)
-- À exécuter AVANT v2_supp_28_geographie_ns1ns2.sql et v2_supp_28_geographie_ns3ns4.sql

INSERT INTO chapitres (matiere_id, titre, niveau_v4)
VALUES
  (28, 'Géographie physique d''Haïti : relief, hydrographie et climat', 'NS1'),
  (28, 'Géographie humaine et économique d''Haïti',                     'NS1'),
  (28, 'Géographie de la Caraïbe et de l''Amérique latine',             'NS2'),
  (28, 'Géographie mondiale : mondialisation et enjeux géopolitiques',  'NS3'),
  (28, 'Géopolitique d''Haïti : histoire et défis actuels',             'NS4')
ON CONFLICT DO NOTHING;
