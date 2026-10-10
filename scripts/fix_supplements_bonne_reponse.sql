-- Correction bonne_reponse supplements (> 40 caracteres)
-- 1331 questions mises a jour

BEGIN;

UPDATE questions SET 
  bonne_reponse = 'Un système de mesure universel',
  choix = '["Un système américain avec 5 unités","Un système de mesure universel","Un système métrique avec 10 unités","Un système avec uniquement des unités dérivées"]'::jsonb
WHERE enonce = 'Qu''est-ce que le Système International d''unités (SI) et combien d''unités de base contient-il ?';

UPDATE questions SET 
  bonne_reponse = 'La plage de valeurs dans laquelle la',
  choix = '["L''erreur humaine du physicien","La plage de valeurs dans laquelle la","La précision maximale d''un instrument","Une valeur fixe"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''incertitude de mesure et comment l''exprime-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'La vérification de la cohérence des',
  choix = '["La mesure des dimensions géométriques","La vérification de la cohérence des","Une méthode graphique","Un calcul d''erreur"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''analyse dimensionnelle en physique ?';

UPDATE questions SET 
  bonne_reponse = 'L''écriture d''un nombre sous la forme a',
  choix = '["Une écriture littéraire des nombres","L''écriture d''un nombre sous la forme a","Un arrondi approximatif","Une notation réservée aux astronomes"]'::jsonb
WHERE enonce = 'Qu''est-ce que la notation scientifique et comment l''utilise-t-on en physique ?';

UPDATE questions SET 
  bonne_reponse = 'Un scalaire est défini par sa seule',
  choix = '["Aucune différence","Un scalaire est défini par sa seule","Les vecteurs n''ont pas de valeur numérique","Les scalaires ne s''utilisent pas en physique"]'::jsonb
WHERE enonce = 'Quelle est la différence entre une grandeur scalaire et une grandeur vectorielle ?';

UPDATE questions SET 
  bonne_reponse = 'L''estimation à la puissance de dix près',
  choix = '["Une valeur très précise","L''estimation à la puissance de dix près","Une valeur arrondie à l''entier","Une erreur de mesure"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''ordre de grandeur en physique et pourquoi est-il utile ?';

UPDATE questions SET 
  bonne_reponse = 'On multiplie par le facteur de',
  choix = '["On change arbitrairement les chiffres","On multiplie par le facteur de","On arrondit la valeur","On change le symbole uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que la conversion d''unités et comment réalise-t-on un changement d''unités correctement ?';

UPDATE questions SET 
  bonne_reponse = 'Multimètre (courant/tension)',
  choix = '["Uniquement la règle et l''horloge","Multimètre (courant/tension)","Uniquement le microscope","Uniquement la balance"]'::jsonb
WHERE enonce = 'Quels sont les principaux instruments de mesure en physique et leur grandeur mesurée ?';

UPDATE questions SET 
  bonne_reponse = 'La précision = capacité à reproduire la',
  choix = '["Elles sont identiques","La précision = capacité à reproduire la","La précision est plus importante que l''exactitude","Seule l''exactitude compte en science"]'::jsonb
WHERE enonce = 'Qu''est-ce que la précision et l''exactitude en métrologie et comment les distingue-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'g ≈ 9,81 m/s² à la surface de la Terre',
  choix = '["g = 10 km/s² (constante absolue)","g ≈ 9,81 m/s² à la surface de la Terre","g = 1 m/s²","g = 100 m/s²"]'::jsonb
WHERE enonce = 'Quelle est la valeur de g (accélération gravitationnelle à la surface de la Terre) et comment varie-t-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Le rapport de la distance parcourue sur',
  choix = '["La vitesse à un instant t","Le rapport de la distance parcourue sur","La vitesse maximale atteinte","L''accélération divisée par le temps"]'::jsonb
WHERE enonce = 'Qu''est-ce que la vitesse moyenne et comment se calcule-t-elle ?';

UPDATE questions SET 
  bonne_reponse = 'La variation de la vitesse par unité de',
  choix = '["Le changement de position","La variation de la vitesse par unité de","La vitesse divisée par la distance","L''unité est m/s"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''accélération et quelle est son unité SI ?';

UPDATE questions SET 
  bonne_reponse = 'v(t) = v₀ + a·t',
  choix = '["v = d/t","v(t) = v₀ + a·t","v = a·d","v(t) = ½·a·t²"]'::jsonb
WHERE enonce = 'Pour un mouvement uniformément accéléré (MRUA), quelle est l''équation de la vitesse en fonction du temps ?';

UPDATE questions SET 
  bonne_reponse = 'Un mouvement sur un cercle à vitesse',
  choix = '["Un mouvement sans accélération","Un mouvement sur un cercle à vitesse","Un mouvement avec vitesse variable","Un mouvement rectiligne"]'::jsonb
WHERE enonce = 'Qu''est-ce que le mouvement circulaire uniforme (MCU) et quelle est son accélération ?';

UPDATE questions SET 
  bonne_reponse = 'La trajectoire courbe d''un objet lancé',
  choix = '["Une ligne droite","La trajectoire courbe d''un objet lancé","Un mouvement circulaire","Un mouvement aléatoire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la trajectoire parabolique d''un projectile (tir oblique) ?';

UPDATE questions SET 
  bonne_reponse = 'La chute d''un objet en l''absence de',
  choix = '["Un mouvement avec résistance de l''air","La chute d''un objet en l''absence de","Un mouvement sans accélération","Un mouvement horizontal"]'::jsonb
WHERE enonce = 'Qu''est-ce que la chute libre et quelles en sont les équations ?';

UPDATE questions SET 
  bonne_reponse = 'Par une droite sur le graphique',
  choix = '["Par une courbe parabolique","Par une droite sur le graphique","Par une droite sur le graphique vitesse-temps uniquement","Par une courbe exponentielle"]'::jsonb
WHERE enonce = 'Comment représente-t-on graphiquement un mouvement rectiligne uniforme (MRU) ?';

UPDATE questions SET 
  bonne_reponse = 'La période T est le temps pour',
  choix = '["La distance parcourue","La période T est le temps pour","L''amplitude du mouvement","La vitesse angulaire uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que la période et la fréquence dans un mouvement circulaire ou oscillatoire ?';

UPDATE questions SET 
  bonne_reponse = 'Le déplacement est un vecteur entre',
  choix = '["Ils sont identiques","Le déplacement est un vecteur entre","La distance est toujours inférieure au déplacement","Le déplacement est toujours plus grand"]'::jsonb
WHERE enonce = 'Qu''est-ce que le vecteur déplacement et comment diffère-t-il de la distance parcourue ?';

UPDATE questions SET 
  bonne_reponse = 'Tout corps persévère dans son état de',
  choix = '["Tout corps accélère naturellement","Tout corps persévère dans son état de","La force est proportionnelle à la masse","À toute action correspond une réaction égale et opposée"]'::jsonb
WHERE enonce = 'Quelle est la première loi de Newton (loi d''inertie) ?';

UPDATE questions SET 
  bonne_reponse = 'ΣF = m·a',
  choix = '["F = mv","ΣF = m·a","F = m/a","a = m/F"]'::jsonb
WHERE enonce = 'Quelle est la deuxième loi de Newton et quelle est sa formule ?';

UPDATE questions SET 
  bonne_reponse = 'Lorsque A exerce une force sur B',
  choix = '["Les forces s''annulent","Lorsque A exerce une force sur B","Les forces s''additionnent toujours","La force dépend de la vitesse"]'::jsonb
WHERE enonce = 'Quelle est la troisième loi de Newton (loi des actions réciproques) ?';

UPDATE questions SET 
  bonne_reponse = 'Une force de contact s''opposant au',
  choix = '["Une force toujours nulle","Une force de contact s''opposant au","Une force qui accélère l''objet","Une force gravitationnelle"]'::jsonb
WHERE enonce = 'Qu''est-ce que la force de frottement et comment l''exprime-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'La masse m est une propriété',
  choix = '["Ils sont identiques","La masse m est une propriété","La masse est en Newton","Le poids est en kilogramme"]'::jsonb
WHERE enonce = 'Qu''est-ce que le poids et comment diffère-t-il de la masse ?';

UPDATE questions SET 
  bonne_reponse = 'La force attractive entre deux masses',
  choix = '["La loi de l''inertie","La force attractive entre deux masses","La loi de Coulomb","La loi des ressorts"]'::jsonb
WHERE enonce = 'Qu''est-ce que la loi de la gravitation universelle de Newton ?';

UPDATE questions SET 
  bonne_reponse = 'W = F·d·cosθ',
  choix = '["L''énergie cinétique d''un objet","W = F·d·cosθ","La puissance fournie","La force multipliée par le temps"]'::jsonb
WHERE enonce = 'Qu''est-ce que le travail d''une force en physique et comment le calcule-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'Ec = ½mv²',
  choix = '["L''énergie de position","Ec = ½mv²","L''énergie potentielle","La puissance mécanique"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''énergie cinétique et le théorème énergie-travail ?';

UPDATE questions SET 
  bonne_reponse = 'En l''absence de forces dissipatives',
  choix = '["L''énergie disparaît après une collision","En l''absence de forces dissipatives","L''énergie cinétique seule se conserve","La conservation ne s''applique pas aux systèmes réels"]'::jsonb
WHERE enonce = 'Qu''est-ce que la conservation de l''énergie mécanique ?';

UPDATE questions SET 
  bonne_reponse = 'p = m·v (vecteur)',
  choix = '["La vitesse d''un objet","p = m·v (vecteur)","L''énergie cinétique","La force appliquée"]'::jsonb
WHERE enonce = 'Qu''est-ce que la quantité de mouvement (impulsion) et sa conservation ?';

UPDATE questions SET 
  bonne_reponse = 'U = R·I',
  choix = '["I = R/U","U = R·I","R = U·I","U = I/R"]'::jsonb
WHERE enonce = 'Quelle est la loi d''Ohm et comment s''applique-t-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Loi des nœuds (ΣI_entrant = ΣI_sortant)',
  choix = '["La loi des charges et la loi des masses","Loi des nœuds (ΣI_entrant = ΣI_sortant)","La loi d''Ohm uniquement","La loi de Faraday"]'::jsonb
WHERE enonce = 'Quelles sont les lois de Kirchhoff pour l''analyse des circuits électriques ?';

UPDATE questions SET 
  bonne_reponse = 'En série : Req = R₁ + R₂ + ...',
  choix = '["Identique dans les deux cas","En série : Req = R₁ + R₂ + ...","En série : 1/Req = 1/R₁ + 1/R₂","En parallèle : Req = R₁ + R₂"]'::jsonb
WHERE enonce = 'Comment calcule-t-on la résistance équivalente en série et en parallèle ?';

UPDATE questions SET 
  bonne_reponse = 'P = U·I = R·I² = U²/R, exprimée en watts',
  choix = '["L''énergie stockée","P = U·I = R·I² = U²/R, exprimée en watts","La résistance divisée par la tension","Le courant multiplié par la résistance"]'::jsonb
WHERE enonce = 'Qu''est-ce que la puissance électrique et son expression ?';

UPDATE questions SET 
  bonne_reponse = 'Un composant stockant de l''énergie',
  choix = '["Un générateur de courant","Un composant stockant de l''énergie","Une résistance variable","Un transformateur"]'::jsonb
WHERE enonce = 'Qu''est-ce que le condensateur et sa capacité ?';

UPDATE questions SET 
  bonne_reponse = 'La force entre deux charges q₁ et q₂',
  choix = '["La loi gravitationnelle","La force entre deux charges q₁ et q₂","La loi d''Ohm généralisée","La force magnétique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la loi de Coulomb et la force électrostatique ?';

UPDATE questions SET 
  bonne_reponse = 'Le CC circule dans un sens fixe (piles)',
  choix = '["Ils sont identiques","Le CC circule dans un sens fixe (piles)","Le CA est plus dangereux","Le CC est utilisé dans les maisons"]'::jsonb
WHERE enonce = 'Qu''est-ce que le courant alternatif (CA) et en quoi diffère-t-il du courant continu (CC) ?';

UPDATE questions SET 
  bonne_reponse = 'Un dispositif à deux bobines couplées',
  choix = '["Un générateur d''électricité","Un dispositif à deux bobines couplées","Un moteur électrique","Un condensateur haute tension"]'::jsonb
WHERE enonce = 'Qu''est-ce que le transformateur et quel est son principe de fonctionnement ?';

UPDATE questions SET 
  bonne_reponse = 'La connexion d''un conducteur de',
  choix = '["Une décoration","La connexion d''un conducteur de","Un court-circuit","Un fusible"]'::jsonb
WHERE enonce = 'Qu''est-ce que la mise à la terre (mise à la masse) dans une installation électrique ?';

UPDATE questions SET 
  bonne_reponse = 'c = 3 × 10⁸ m/s',
  choix = '["1000 m/s","c = 3 × 10⁸ m/s","c = 3 × 10⁵ m/s","c = 3 × 10⁶ km/s"]'::jsonb
WHERE enonce = 'Quelle est la vitesse de la lumière dans le vide et sa signification en physique ?';

UPDATE questions SET 
  bonne_reponse = 'Le changement de direction de la',
  choix = '["La réflexion totale","Le changement de direction de la","La diffraction","La polarisation"]'::jsonb
WHERE enonce = 'Qu''est-ce que la réfraction de la lumière et la loi de Snell-Descartes ?';

UPDATE questions SET 
  bonne_reponse = 'Lorsque la lumière passe d''un milieu',
  choix = '["Un miroir ordinaire","Lorsque la lumière passe d''un milieu","Une lentille divergente","L''arc-en-ciel"]'::jsonb
WHERE enonce = 'Qu''est-ce que la réflexion totale interne et quelle est son application dans les fibres optiques ?';

UPDATE questions SET 
  bonne_reponse = 'La décomposition de la lumière blanche',
  choix = '["Un défaut des lentilles","La décomposition de la lumière blanche","Une réflexion","Une absorption"]'::jsonb
WHERE enonce = 'Qu''est-ce que la dispersion de la lumière et comment explique-t-elle l''arc-en-ciel ?';

UPDATE questions SET 
  bonne_reponse = 'La lumière se comporte comme une onde',
  choix = '["La lumière est exclusivement une onde","La lumière se comporte comme une onde","La lumière est exclusivement un corpuscule","La dualité n''existe que pour les électrons"]'::jsonb
WHERE enonce = 'Qu''est-ce que la nature duale de la lumière (onde-corpuscule) ?';

UPDATE questions SET 
  bonne_reponse = 'Elle concentre les rayons parallèles en',
  choix = '["Elle diffuse la lumière","Elle concentre les rayons parallèles en","Elle n''a pas de foyer","Elle crée uniquement des images droites"]'::jsonb
WHERE enonce = 'Comment fonctionne une lentille convergente et où se forme l''image d''un objet ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des ondes électromagnétiques',
  choix = '["Uniquement la lumière visible","L''ensemble des ondes électromagnétiques","La lumière visible et l''ultraviolet uniquement","Uniquement les rayons X et gamma"]'::jsonb
WHERE enonce = 'Qu''est-ce que le spectre électromagnétique et quels types de rayonnements comprend-il ?';

UPDATE questions SET 
  bonne_reponse = 'La propriété de la lumière dont les',
  choix = '["Un filtre de couleur","La propriété de la lumière dont les","La diffraction","La réflexion totale"]'::jsonb
WHERE enonce = 'Qu''est-ce que la polarisation de la lumière et ses applications pratiques ?';

UPDATE questions SET 
  bonne_reponse = 'Le décalage de fréquence d''une source',
  choix = '["Un effet uniquement sonore","Le décalage de fréquence d''une source","Un type de réfraction","Un effet de miroir"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''effet Doppler pour la lumière et ses applications en astronomie ?';

UPDATE questions SET 
  bonne_reponse = 'La variation d''énergie interne d''un',
  choix = '["L''énergie peut être créée","La variation d''énergie interne d''un","L''entropie augmente toujours","La chaleur va du froid au chaud"]'::jsonb
WHERE enonce = 'Quel est le premier principe de la thermodynamique et sa signification ?';

UPDATE questions SET 
  bonne_reponse = 'Dans un système isolé',
  choix = '["L''entropie peut diminuer dans un système isolé","Dans un système isolé","L''énergie se conserve","L''entropie ne change jamais"]'::jsonb
WHERE enonce = 'Quel est le deuxième principe de la thermodynamique et la notion d''entropie ?';

UPDATE questions SET 
  bonne_reponse = 'Conduction (contact direct',
  choix = '["Uniquement la conduction","Conduction (contact direct","Uniquement le rayonnement","Conduction et radiation uniquement"]'::jsonb
WHERE enonce = 'Quels sont les trois modes de transfert thermique et leurs caractéristiques ?';

UPDATE questions SET 
  bonne_reponse = 'L''énergie absorbée ou libérée lors d''un',
  choix = '["La chaleur transmise par conduction","L''énergie absorbée ou libérée lors d''un","La chaleur massique","La conduction thermique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la chaleur latente et comment intervient-elle lors des changements d''état ?';

UPDATE questions SET 
  bonne_reponse = 'Q = m·c·ΔT',
  choix = '["La chaleur latente","Q = m·c·ΔT","Q = m·L","Q = m·c/ΔT"]'::jsonb
WHERE enonce = 'Qu''est-ce que la capacité calorifique massique et la formule de la chaleur sensible ?';

UPDATE questions SET 
  bonne_reponse = 'PV = nRT',
  choix = '["P×V = constante uniquement","PV = nRT","P/T = constante","V/T = constante uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que la loi des gaz parfaits (loi de Boyle-Mariotte, Gay-Lussac, Charles) ?';

UPDATE questions SET 
  bonne_reponse = 'Le rendement η = W_utile / Q_absorbé ≤ 1',
  choix = '["100% toujours","Le rendement η = W_utile / Q_absorbé ≤ 1","Le rendement d''un moteur est toujours supérieur à celui de Carnot","Carnot s''applique uniquement aux réfrigérateurs"]'::jsonb
WHERE enonce = 'Qu''est-ce que le rendement d''un moteur thermique et la limite de Carnot ?';

UPDATE questions SET 
  bonne_reponse = 'L''émission spontanée de rayonnements',
  choix = '["Un phénomène artificiel uniquement","L''émission spontanée de rayonnements","Un type de chimie","Un phénomène uniquement terrestre"]'::jsonb
WHERE enonce = 'Qu''est-ce que la radioactivité naturelle et quels sont ses types principaux ?';

UPDATE questions SET 
  bonne_reponse = 'Le temps T₁/₂ après lequel la moitié',
  choix = '["Le temps pour désintégration totale","Le temps T₁/₂ après lequel la moitié","Le temps pour doublement","La durée de vie d''un neutron"]'::jsonb
WHERE enonce = 'Qu''est-ce que la demi-vie radioactive (période) et comment l''utilise-t-on en datation ?';

UPDATE questions SET 
  bonne_reponse = 'La division d''un noyau lourd',
  choix = '["La fusion de deux noyaux légers","La division d''un noyau lourd","La désintégration alpha","La radioactivité bêta"]'::jsonb
WHERE enonce = 'Qu''est-ce que la fission nucléaire et comment est-elle utilisée dans les centrales ?';

UPDATE questions SET 
  bonne_reponse = 'E = mc²',
  choix = '["E = mv","E = mc²","E = m/c²","E = c/m"]'::jsonb
WHERE enonce = 'Quelle est la relation énergie-masse d''Einstein et son application à la physique nucléaire ?';

UPDATE questions SET 
  bonne_reponse = 'L''union de deux noyaux légers formant',
  choix = '["La fission de l''uranium","L''union de deux noyaux légers formant","La radioactivité naturelle","La désintégration bêta"]'::jsonb
WHERE enonce = 'Qu''est-ce que la fusion nucléaire et son intérêt énergétique ?';

UPDATE questions SET 
  bonne_reponse = 'Le modèle quantique remplace les',
  choix = '["Le modèle planétaire de Rutherford","Le modèle quantique remplace les","Le modèle de Thomson","Le modèle classique de Dalton"]'::jsonb
WHERE enonce = 'Qu''est-ce que le modèle quantique de l''atome et ses différences avec le modèle de Bohr ?';

UPDATE questions SET 
  bonne_reponse = 'Il est fondamentalement impossible de',
  choix = '["On peut mesurer précisément position et vitesse simultanément","Il est fondamentalement impossible de","C''est une limitation technique","Il s''applique uniquement aux photons"]'::jsonb
WHERE enonce = 'Qu''est-ce que le principe d''incertitude de Heisenberg et sa signification ?';

UPDATE questions SET 
  bonne_reponse = 'L''émission d''électrons par un métal',
  choix = '["Un phénomène mécanique","L''émission d''électrons par un métal","Un effet magnétique","Un effet thermique"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''effet photoélectrique et comment Einstein l''a-t-il expliqué ?';

UPDATE questions SET 
  bonne_reponse = 'La physique sous-tend toutes les',
  choix = '["La physique n''a pas de rôle","La physique sous-tend toutes les","La physique concerne uniquement la recherche fondamentale","Les énergies renouvelables ne nécessitent pas de physique"]'::jsonb
WHERE enonce = 'Quel est le rôle de la physique dans le développement durable et les énergies renouvelables ?';

UPDATE questions SET 
  bonne_reponse = 'Dmitri Mendeleïev en 1869',
  choix = '["Dalton en 1803","Dmitri Mendeleïev en 1869","Einstein en 1905","Lavoisier en 1789"]'::jsonb
WHERE enonce = 'Qui a proposé le tableau périodique des éléments et en quelle année ?';

UPDATE questions SET 
  bonne_reponse = 'Z est le nombre de protons dans le noyau',
  choix = '["Z est le nombre de neutrons, A est le nombre de protons","Z est le nombre de protons dans le noyau","Z est la masse atomique","A est le numéro de période"]'::jsonb
WHERE enonce = 'Qu''est-ce que le numéro atomique Z et le nombre de masse A d''un élément ?';

UPDATE questions SET 
  bonne_reponse = 'La distribution des électrons dans les',
  choix = '["L''arrangement des protons","La distribution des électrons dans les","Le nombre de neutrons","La masse atomique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la configuration électronique d''un atome et comment la détermine-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'Les électrons de la couche externe',
  choix = '["Tous les électrons d''un atome","Les électrons de la couche externe","Les électrons du noyau","Les électrons de cœur"]'::jsonb
WHERE enonce = 'Qu''est-ce que les électrons de valence et pourquoi sont-ils importants en chimie ?';

UPDATE questions SET 
  bonne_reponse = 'L''électronégativité augmente de gauche',
  choix = '["L''électronégativité augmente de droite à gauche","L''électronégativité augmente de gauche","L''électronégativité est constante","L''électronégativité augmente de haut en bas"]'::jsonb
WHERE enonce = 'Quelles sont les tendances générales de l''électronégativité dans le tableau périodique ?';

UPDATE questions SET 
  bonne_reponse = 'Des atomes du même élément (même Z)',
  choix = '["Des éléments différents","Des atomes du même élément (même Z)","Des ions de charge différente","Des composés chimiques différents"]'::jsonb
WHERE enonce = 'Qu''est-ce que les isotopes d''un élément et en quoi diffèrent-ils ?';

UPDATE questions SET 
  bonne_reponse = 'Un atome ou groupe d''atomes ayant perdu',
  choix = '["Un atome neutre","Un atome ou groupe d''atomes ayant perdu","Un mélange d''éléments","Une molécule neutre"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un ion et comment se forme-t-il ?';

UPDATE questions SET 
  bonne_reponse = 'Les métaux (à gauche) sont conducteurs',
  choix = '["Il n''y a pas de distinction","Les métaux (à gauche) sont conducteurs","Tous les éléments sont des métaux","Les non-métaux sont toujours liquides"]'::jsonb
WHERE enonce = 'Qu''est-ce que la différence entre un métal, un métalloïde et un non-métal dans le tableau périodique ?';

UPDATE questions SET 
  bonne_reponse = 'La tendance des atomes à acquérir une',
  choix = '["Tous les atomes veulent 4 électrons de valence","La tendance des atomes à acquérir une","La règle s''applique à tous les atomes sans exception","Seul le carbone suit cette règle"]'::jsonb
WHERE enonce = 'Qu''est-ce que la règle de l''octet et ses exceptions ?';

UPDATE questions SET 
  bonne_reponse = 'L''énergie nécessaire pour arracher un',
  choix = '["L''énergie libérée lors d''une liaison","L''énergie nécessaire pour arracher un","La chaleur de combustion","L''énergie de liaison C-H"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''énergie d''ionisation et ses tendances dans le tableau périodique ?';

UPDATE questions SET 
  bonne_reponse = 'Liaison ionique',
  choix = '["Elles sont identiques","Liaison ionique","La liaison covalente implique des métaux","La liaison ionique forme des molécules"]'::jsonb
WHERE enonce = 'Quelle est la différence entre une liaison ionique et une liaison covalente ?';

UPDATE questions SET 
  bonne_reponse = 'Une liaison faible entre un H lié à un',
  choix = '["Une liaison covalente forte","Une liaison faible entre un H lié à un","Une liaison ionique","Une liaison métallique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la liaison hydrogène et son importance en chimie ?';

UPDATE questions SET 
  bonne_reponse = 'La forme géométrique d''une molécule est',
  choix = '["Les molécules sont toujours sphériques","La forme géométrique d''une molécule est","Toutes les molécules sont linéaires","La géométrie ne dépend que des liaisons doubles"]'::jsonb
WHERE enonce = 'Qu''est-ce que la géométrie moléculaire selon la théorie VSEPR ?';

UPDATE questions SET 
  bonne_reponse = 'Une molécule est polaire si elle',
  choix = '["Toutes les molécules sont polaires","Une molécule est polaire si elle","Les molécules polaires ne se dissolvent pas dans l''eau","La polarité ne dépend pas de la géométrie"]'::jsonb
WHERE enonce = 'Qu''est-ce que la polarité d''une molécule et quels en sont les exemples ?';

UPDATE questions SET 
  bonne_reponse = 'Un nuage d''électrons délocalisés autour',
  choix = '["Une liaison ionique forte","Un nuage d''électrons délocalisés autour","Une liaison covalente polaire","Une liaison de Van der Waals"]'::jsonb
WHERE enonce = 'Qu''est-ce que la liaison métallique et comment explique-t-elle les propriétés des métaux ?';

UPDATE questions SET 
  bonne_reponse = 'La représentation des liaisons et des',
  choix = '["Un diagramme des niveaux d''énergie","La représentation des liaisons et des","Un spectre d''absorption","La configuration électronique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la structure de Lewis d''une molécule et comment la dessiner ?';

UPDATE questions SET 
  bonne_reponse = 'Liaison simple (σ',
  choix = '["Toutes les liaisons sont identiques","Liaison simple (σ","Les liaisons doubles sont plus faibles que les simples","Les liaisons triples sont les plus longues"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une liaison covalente simple, double et triple et leurs caractéristiques ?';

UPDATE questions SET 
  bonne_reponse = 'Lorsqu''une structure de Lewis unique ne',
  choix = '["Une vibration moléculaire","Lorsqu''une structure de Lewis unique ne","Une réaction réversible","Un type de liaison ionique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la résonance en chimie et quand s''applique-t-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Les forces intermoléculaires faibles',
  choix = '["Des liaisons covalentes faibles","Les forces intermoléculaires faibles","Des liaisons ioniques","Des liaisons hydrogène renforcées"]'::jsonb
WHERE enonce = 'Qu''est-ce que les interactions de Van der Waals et leur importance ?';

UPDATE questions SET 
  bonne_reponse = 'L''étude quantitative des réactifs et',
  choix = '["L''étude des propriétés des matériaux","L''étude quantitative des réactifs et","L''étude des catalyseurs","La mesure de la vitesse des réactions"]'::jsonb
WHERE enonce = 'Qu''est-ce que la stœchiométrie et la mole en chimie ?';

UPDATE questions SET 
  bonne_reponse = 'En ajustant les coefficients',
  choix = '["En ajoutant des éléments","En ajustant les coefficients","En changeant les formules chimiques","En ajoutant des flèches"]'::jsonb
WHERE enonce = 'Comment équilibre-t-on une équation chimique et quelle loi respecte-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'Le réactif qui est entièrement consommé',
  choix = '["Le réactif le plus abondant","Le réactif qui est entièrement consommé","Le réactif le moins réactif","Le réactif dont la masse molaire est la plus grande"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un réactif limitant dans une réaction chimique ?';

UPDATE questions SET 
  bonne_reponse = 'η = (quantité obtenue / quantité',
  choix = '["Toujours 100%","η = (quantité obtenue / quantité","η = masse des réactifs / masse des produits","η = vitesse de réaction"]'::jsonb
WHERE enonce = 'Qu''est-ce que le rendement d''une réaction et comment le calcule-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'Une réaction avec transfert d''électrons',
  choix = '["Une réaction acide-base uniquement","Une réaction avec transfert d''électrons","Une réaction de précipitation","Une réaction uniquement inorganique"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une réaction d''oxydoréduction (redox) et ses composants ?';

UPDATE questions SET 
  bonne_reponse = 'Un acide de Brønsted-Lowry est un',
  choix = '["Les acides ont un goût sucré","Un acide de Brønsted-Lowry est un","Seuls les hydroxides sont des bases","Les acides sont uniquement inorganiques"]'::jsonb
WHERE enonce = 'Qu''est-ce que la théorie acide-base de Brønsted-Lowry ?';

UPDATE questions SET 
  bonne_reponse = 'pH = -log[H₃O⁺]',
  choix = '["La pression hydrostatique","pH = -log[H₃O⁺]","pH = [H₃O⁺]","pH = masse molaire / volume"]'::jsonb
WHERE enonce = 'Qu''est-ce que le pH et comment se calcule-t-il ?';

UPDATE questions SET 
  bonne_reponse = 'L''état où les vitesses de la réaction',
  choix = '["Une réaction qui n''avance pas","L''état où les vitesses de la réaction","Une réaction complète","Une réaction sans produits"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un équilibre chimique et la constante d''équilibre K ?';

UPDATE questions SET 
  bonne_reponse = 'Si on perturbe un système à l''équilibre',
  choix = '["Les équilibres ne peuvent pas être déplacés","Si on perturbe un système à l''équilibre","L''équilibre est immuable","La température ne déplace pas l''équilibre"]'::jsonb
WHERE enonce = 'Qu''est-ce que le principe de Le Chatelier et comment s''applique-t-il ?';

UPDATE questions SET 
  bonne_reponse = 'L''étude de la vitesse des réactions',
  choix = '["L''étude de l''énergie des réactions","L''étude de la vitesse des réactions","La stœchiométrie uniquement","L''équilibre chimique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la cinétique chimique et les facteurs influençant la vitesse de réaction ?';

UPDATE questions SET 
  bonne_reponse = 'L''étude des composés du carbone',
  choix = '["L''étude des organismes vivants uniquement","L''étude des composés du carbone","La chimie des métaux","La chimie des minéraux"]'::jsonb
WHERE enonce = 'Qu''est-ce que la chimie organique et pourquoi le carbone est-il au cœur de cette chimie ?';

UPDATE questions SET 
  bonne_reponse = 'Alcool (-OH)',
  choix = '["Uniquement les alcools","Alcool (-OH)","Uniquement les acides","Uniquement les esters"]'::jsonb
WHERE enonce = 'Quels sont les groupes fonctionnels principaux en chimie organique et leurs propriétés ?';

UPDATE questions SET 
  bonne_reponse = 'Des composés de même formule brute mais',
  choix = '["Des molécules identiques","Des composés de même formule brute mais","Des molécules de masses différentes","Des allotropes du carbone"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''isomérie en chimie organique et quels en sont les types ?';

UPDATE questions SET 
  bonne_reponse = 'Des réactions où un nucléophile (riche',
  choix = '["Des réactions d''oxydation","Des réactions où un nucléophile (riche","Des réactions d''addition uniquement","Des réactions de polymérisation"]'::jsonb
WHERE enonce = 'Qu''est-ce que les réactions de substitution nucléophile (SN1/SN2) en chimie organique ?';

UPDATE questions SET 
  bonne_reponse = 'La réaction assemblant de nombreuses',
  choix = '["La décomposition des polymères","La réaction assemblant de nombreuses","Une réaction de combustion","Une réaction d''hydrolyse"]'::jsonb
WHERE enonce = 'Qu''est-ce que la polymérisation et ses types principaux ?';

UPDATE questions SET 
  bonne_reponse = 'Un système international basant le nom',
  choix = '["Un système arbitraire","Un système international basant le nom","Le nom vulgaire des composés","Un système uniquement français"]'::jsonb
WHERE enonce = 'Qu''est-ce que la nomenclature IUPAC des composés organiques et ses règles de base ?';

UPDATE questions SET 
  bonne_reponse = 'Des composés cycliques insaturés',
  choix = '["Des composés aliphatiques","Des composés cycliques insaturés","Des alcanes cycliques","Des polymères naturels"]'::jsonb
WHERE enonce = 'Qu''est-ce que les hydrocarbures aromatiques (benzène et dérivés) et leurs propriétés ?';

UPDATE questions SET 
  bonne_reponse = 'Des biomolécules hydrophobes incluant',
  choix = '["Des glucides","Des biomolécules hydrophobes incluant","Des protéines non polaires","Des acides nucléiques"]'::jsonb
WHERE enonce = 'Qu''est-ce que les lipides en chimie organique et leur structure ?';

UPDATE questions SET 
  bonne_reponse = 'Des biomolécules de formule générale',
  choix = '["Des lipides","Des biomolécules de formule générale","Des acides aminés","Des nucléotides"]'::jsonb
WHERE enonce = 'Qu''est-ce que les glucides (saccharides) et leur structure en chimie organique ?';

UPDATE questions SET 
  bonne_reponse = 'La philosophie de conception chimique',
  choix = '["La chimie des plantes vertes","La philosophie de conception chimique","La chimie uniquement biologique","La chimie des pesticides"]'::jsonb
WHERE enonce = 'Qu''est-ce que la chimie verte (chimie durable) et ses 12 principes ?';

UPDATE questions SET 
  bonne_reponse = 'Un dispositif transformant l''énergie',
  choix = '["Un condensateur","Un dispositif transformant l''énergie","Un transformateur","Un générateur mécanique"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une pile électrochimique et comment produit-elle de l''électricité ?';

UPDATE questions SET 
  bonne_reponse = 'L''électrolyse utilise de l''électricité',
  choix = '["L''électrolyse est spontanée","L''électrolyse utilise de l''électricité","L''électrolyse produit de l''électricité","L''électrolyse et la pile sont identiques"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''électrolyse et comment diffère-t-elle d''une pile galvanique ?';

UPDATE questions SET 
  bonne_reponse = 'La dégradation électrochimique d''un',
  choix = '["Un processus bénéfique","La dégradation électrochimique d''un","Un simple ternissement","Une réaction de combustion"]'::jsonb
WHERE enonce = 'Qu''est-ce que la corrosion et comment la prévenir ?';

UPDATE questions SET 
  bonne_reponse = 'E = E°_cathode - E°_anode',
  choix = '["La résistance interne","E = E°_cathode - E°_anode","La charge de la pile","L''intensité du courant"]'::jsonb
WHERE enonce = 'Qu''est-ce que la force électromotrice (FEM) d''une pile et comment la calculer ?';

UPDATE questions SET 
  bonne_reponse = 'Une batterie rechargeable où les ions',
  choix = '["Une pile zinc-carbone améliorée","Une batterie rechargeable où les ions","Une batterie au plomb","Une batterie à combustible"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une batterie lithium-ion et pourquoi domine-t-elle dans les appareils portables ?';

UPDATE questions SET 
  bonne_reponse = '1ère',
  choix = '["Des lois de la thermodynamique","1ère","Les lois d''Ohm généralisées","Les lois de Newton appliquées aux ions"]'::jsonb
WHERE enonce = 'Qu''est-ce que les lois de Faraday en électrolyse ?';

UPDATE questions SET 
  bonne_reponse = 'Des dispositifs électrochimiques',
  choix = '["Des batteries rechargeables classiques","Des dispositifs électrochimiques","Des moteurs à explosion améliorés","Des panneaux solaires"]'::jsonb
WHERE enonce = 'Qu''est-ce que les piles à combustible et leur potentiel pour l''énergie propre ?';

UPDATE questions SET 
  bonne_reponse = 'L''étude des réactions déclenchées par',
  choix = '["Un type de chromographie","L''étude des réactions déclenchées par","Un type d''électrolyse","Un procédé de synthèse thermique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la photochimie et l''effet photovoltaïque en chimie ?';

UPDATE questions SET 
  bonne_reponse = 'La chimie fournit les engrais minéraux',
  choix = '["La chimie n''a aucun rôle en agriculture","La chimie fournit les engrais minéraux","Uniquement les pesticides","Uniquement les engrais chimiques"]'::jsonb
WHERE enonce = 'Comment la chimie contribue-t-elle à la sécurité alimentaire et à l''agriculture en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des techniques d''analyse',
  choix = '["Une technique de séparation","L''ensemble des techniques d''analyse","Une méthode de synthèse","Une technique de filtration"]'::jsonb
WHERE enonce = 'Qu''est-ce que la spectroscopie et son utilisation en chimie analytique ?';

UPDATE questions SET 
  bonne_reponse = 'Toute cellule provient d''une cellule',
  choix = '["Les cellules se forment spontanément","Toute cellule provient d''une cellule","Les cellules ne se divisent pas","Seules les cellules animales ont un noyau"]'::jsonb
WHERE enonce = 'Quelle est la théorie cellulaire fondamentale formulée au XIXe siècle ?';

UPDATE questions SET 
  bonne_reponse = 'La présence ou l''absence d''un noyau',
  choix = '["La taille","La présence ou l''absence d''un noyau","La présence de ribosomes","La présence d''ADN"]'::jsonb
WHERE enonce = 'Quelle est la principale différence entre cellule procaryote et eucaryote ?';

UPDATE questions SET 
  bonne_reponse = 'Le ribosome',
  choix = '["Le noyau","La mitochondrie","Le ribosome","Le réticulum endoplasmique"]'::jsonb
WHERE enonce = 'Quel organite est responsable de la synthèse des protéines ?';

UPDATE questions SET 
  bonne_reponse = 'Production d''ATP par respiration',
  choix = '["Synthèse des protéines","Production d''ATP par respiration","Stockage de l''ADN","Digestion intracellulaire"]'::jsonb
WHERE enonce = 'Quelle est la fonction principale de la mitochondrie ?';

UPDATE questions SET 
  bonne_reponse = 'Une bicouche phospholipidique avec des',
  choix = '["Uniquement des protéines","Une bicouche phospholipidique avec des","De l''ADN et des lipides","Du glucose et des acides aminés"]'::jsonb
WHERE enonce = 'Quelle est la composition de la membrane plasmique selon le modèle de la mosaïque fluide ?';

UPDATE questions SET 
  bonne_reponse = 'Le chloroplaste',
  choix = '["La mitochondrie","Le chloroplaste","La vacuole","Le centrosome"]'::jsonb
WHERE enonce = 'Quel organite est exclusif aux cellules végétales et permet la photosynthèse ?';

UPDATE questions SET 
  bonne_reponse = 'Un réseau de membranes parsemé de',
  choix = '["Un organite de dégradation","Un réseau de membranes parsemé de","Le siège de la photosynthèse","Un organite de stockage énergétique"]'::jsonb
WHERE enonce = 'Qu''est-ce que le réticulum endoplasmique rugueux (RER) ?';

UPDATE questions SET 
  bonne_reponse = 'Tri',
  choix = '["Synthèse d''ADN","Tri","Production d''énergie","Digestion des déchets cellulaires"]'::jsonb
WHERE enonce = 'Quelle est la fonction de l''appareil de Golgi ?';

UPDATE questions SET 
  bonne_reponse = 'Une enveloppe rigide externe composée',
  choix = '["Une membrane lipidique riche en protéines","Une enveloppe rigide externe composée","Un organite interne","Une structure exclusivement animale"]'::jsonb
WHERE enonce = 'Qu''est-ce que la paroi cellulaire végétale et quel est son composant principal ?';

UPDATE questions SET 
  bonne_reponse = 'Digestion des macromolécules et des',
  choix = '["Photosynthèse","Digestion des macromolécules et des","Production d''ATP","Synthèse des lipides"]'::jsonb
WHERE enonce = 'Quel est le rôle du lysosome dans la cellule animale ?';

UPDATE questions SET 
  bonne_reponse = 'Du milieu le plus concentré vers le',
  choix = '["Du milieu le moins concentré vers le plus concentré avec dépense d''énergie","Du milieu le plus concentré vers le","Uniquement pour les ions","Uniquement pour les grandes molécules"]'::jsonb
WHERE enonce = 'Comment se réalise la diffusion simple à travers la membrane plasmique ?';

UPDATE questions SET 
  bonne_reponse = 'Le mouvement de l''eau à travers une',
  choix = '["Le transport actif du glucose","Le mouvement de l''eau à travers une","La diffusion des ions","Le transport des protéines"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''osmose et son importance pour les cellules vivantes ?';

UPDATE questions SET 
  bonne_reponse = 'Le microscope électronique à',
  choix = '["Le microscope optique","Le microscope électronique à","La loupe binoculaire","Le microscope à fluorescence"]'::jsonb
WHERE enonce = 'Quel microscope utilise-t-on pour observer la structure interne fine d''une cellule (ultrastructure) ?';

UPDATE questions SET 
  bonne_reponse = 'Le processus par lequel des cellules',
  choix = '["Toutes les cellules d''un organisme sont identiques","Le processus par lequel des cellules","La division cellulaire","La mort programmée des cellules"]'::jsonb
WHERE enonce = 'Qu''est-ce que la spécialisation cellulaire (différenciation) dans les organismes pluricellulaires ?';

UPDATE questions SET 
  bonne_reponse = 'Organisation du fuseau mitotique',
  choix = '["Synthèse des protéines","Organisation du fuseau mitotique","Production d''énergie","Stockage des nutriments"]'::jsonb
WHERE enonce = 'Quel est le rôle du centrosome dans la division cellulaire ?';

UPDATE questions SET 
  bonne_reponse = 'La mitose produit 2 cellules diploïdes',
  choix = '["Aucune différence","La mitose produit 2 cellules diploïdes","La mitose produit 4 cellules ; la méiose en produit 2","La méiose est plus rapide que la mitose"]'::jsonb
WHERE enonce = 'Quelle est la différence fondamentale entre mitose et méiose en termes de résultats ?';

UPDATE questions SET 
  bonne_reponse = 'Prophase, métaphase, anaphase, télophase',
  choix = '["Interphase, anaphase, prophase, métaphase, télophase","Prophase, métaphase, anaphase, télophase","Métaphase, prophase, anaphase, télophase","Anaphase, métaphase, télophase, prophase"]'::jsonb
WHERE enonce = 'Dans quel ordre se succèdent les phases de la mitose ?';

UPDATE questions SET 
  bonne_reponse = 'La division du cytoplasme se produisant',
  choix = '["La condensation des chromosomes","La division du cytoplasme se produisant","La séparation des chromatides","La réplication de l''ADN"]'::jsonb
WHERE enonce = 'Qu''est-ce que la cytocinèse et quand se produit-elle ?';

UPDATE questions SET 
  bonne_reponse = 'L''échange de segments homologues entre',
  choix = '["Une mutation délétère","L''échange de segments homologues entre","Une réplication d''ADN supplémentaire","Un arrêt de la division cellulaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que le crossing-over (enjambement) en méiose et son importance ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des étapes de la vie d''une',
  choix = '["Uniquement la mitose","L''ensemble des étapes de la vie d''une","La différenciation cellulaire","La mort cellulaire programmée"]'::jsonb
WHERE enonce = 'Qu''est-ce que le cycle cellulaire et quelles en sont les phases principales ?';

UPDATE questions SET 
  bonne_reponse = 'Les chromosomes homologues sont des',
  choix = '["Ils sont identiques","Les chromosomes homologues sont des","Les chromatides sœurs sont différentes génétiquement","Les chromosomes homologues sont toujours identiques"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un chromosome homologue et comment diffère-t-il d''une chromatide sœur ?';

UPDATE questions SET 
  bonne_reponse = 'Vérifier que chaque phase est',
  choix = '["Accélérer la division","Vérifier que chaque phase est","Arrêter définitivement la division","Permettre la différenciation cellulaire"]'::jsonb
WHERE enonce = 'Quel est le rôle des points de contrôle (checkpoints) du cycle cellulaire ?';

UPDATE questions SET 
  bonne_reponse = 'La mort cellulaire programmée',
  choix = '["Une division cellulaire rapide","La mort cellulaire programmée","Une mutation génétique","Un processus uniquement pathologique"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''apoptose et quel est son rôle dans l''organisme ?';

UPDATE questions SET 
  bonne_reponse = 'Anaphase I',
  choix = '["Anaphase II","Anaphase I","Métaphase I","Prophase II"]'::jsonb
WHERE enonce = 'En méiose, à quelle phase les chromosomes homologues se séparent-ils ?';

UPDATE questions SET 
  bonne_reponse = 'La présence de plus de deux sets de',
  choix = '["Une diminution du nombre de chromosomes","La présence de plus de deux sets de","Une anomalie létale","Un phénomène uniquement animal"]'::jsonb
WHERE enonce = 'Qu''est-ce que la polyploïdie et dans quel règne est-elle fréquente ?';

UPDATE questions SET 
  bonne_reponse = 'La formation des spermatozoïdes par',
  choix = '["La formation des ovules dans les ovaires","La formation des spermatozoïdes par","La fécondation","La nidation de l''embryon"]'::jsonb
WHERE enonce = 'Qu''est-ce que la spermatogenèse et où se déroule-t-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Des gamètes avec un chromosome en plus',
  choix = '["Des cellules normales","Des gamètes avec un chromosome en plus","Une polyploïdie","Un arrêt de la méiose"]'::jsonb
WHERE enonce = 'Quel est l''effet d''une non-disjonction chromosomique en méiose ?';

UPDATE questions SET 
  bonne_reponse = 'Elle réduit la ploïdie de moitié',
  choix = '["Elle augmente le nombre de chromosomes","Elle réduit la ploïdie de moitié","Elle empêche la variation génétique","Elle remplace la mitose"]'::jsonb
WHERE enonce = 'Pourquoi la méiose est-elle essentielle à la reproduction sexuée des organismes diploïdes ?';

UPDATE questions SET 
  bonne_reponse = 'Les deux allèles d''un gène se séparent',
  choix = '["Les deux allèles d''un gène se retrouvent toujours ensemble dans le gamète","Les deux allèles d''un gène se séparent","Les gènes sont transmis en blocs","Les allèles dominants masquent toujours les récessifs"]'::jsonb
WHERE enonce = 'Quelle est la première loi de Mendel (loi de ségrégation) ?';

UPDATE questions SET 
  bonne_reponse = 'Les allèles de deux gènes situés sur',
  choix = '["Les gènes proches sur un chromosome sont toujours transmis ensemble","Les allèles de deux gènes situés sur","Les gènes sont tous liés","La dominance est toujours complète"]'::jsonb
WHERE enonce = 'Qu''est-ce que la deuxième loi de Mendel (loi d''assortiment indépendant) ?';

UPDATE questions SET 
  bonne_reponse = '3/4 dominant : 1/4 récessif',
  choix = '["1/4 dominant : 3/4 récessif","3/4 dominant : 1/4 récessif","1/2 dominant : 1/2 récessif","Tous dominants"]'::jsonb
WHERE enonce = 'Dans un croisement Aa × Aa, quelle est la proportion phénotypique attendue si A est dominant ?';

UPDATE questions SET 
  bonne_reponse = 'Un allèle qui ne s''exprime',
  choix = '["Un allèle qui s''exprime toujours","Un allèle qui ne s''exprime","Un allèle dominant","Un allèle léthal"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un allèle récessif et comment s''exprime-t-il ?';

UPDATE questions SET 
  bonne_reponse = 'L''expression simultanée et complète des',
  choix = '["Une dominance partielle où le phénotype est intermédiaire","L''expression simultanée et complète des","L''absence d''expression phénotypique","Une liaison génique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la codominance et quel en est un exemple classique ?';

UPDATE questions SET 
  bonne_reponse = 'Des gènes sur le même chromosome qui',
  choix = '["Des gènes sur le même chromosome qui","Des gènes sur des chromosomes différents","Un phénomène exclusivement végétal","Une mutation"]'::jsonb
WHERE enonce = 'Qu''est-ce que la liaison génique (linkage) et son effet sur la 2ème loi de Mendel ?';

UPDATE questions SET 
  bonne_reponse = 'Par un gène à 3 allèles (IA',
  choix = '["Par un seul gène biallélique","Par un gène à 3 allèles (IA","Par deux gènes distincts","Par l''environnement uniquement"]'::jsonb
WHERE enonce = 'Comment les groupes sanguins ABO sont-ils déterminés génétiquement ?';

UPDATE questions SET 
  bonne_reponse = 'La transmission de gènes portés sur les',
  choix = '["Un mode de transmission identique chez les deux sexes","La transmission de gènes portés sur les","Une maladie génétique","L''hérédité maternelle uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''hérédité liée au sexe (hérédité gonosomique) ?';

UPDATE questions SET 
  bonne_reponse = 'Les proportions phénotypiques révèlent',
  choix = '["Uniquement des individus dominants","Les proportions phénotypiques révèlent","Tous les individus seront hétérozygotes","Le résultat ne donne aucune information"]'::jsonb
WHERE enonce = 'Quel est le résultat d''un croisement test (testcross) entre un individu de génotype inconnu et un individu homozygote récessif ?';

UPDATE questions SET 
  bonne_reponse = 'Un gène influençant plusieurs',
  choix = '["Un gène contrôlant un seul caractère","Un gène influençant plusieurs","Plusieurs gènes contrôlant un seul caractère","Une mutation létale"]'::jsonb
WHERE enonce = 'Qu''est-ce que la pléiotropie en génétique ?';

UPDATE questions SET 
  bonne_reponse = 'En divisant le nombre de descendants',
  choix = '["On ne peut pas la calculer","En divisant le nombre de descendants","En comparant les allèles dominants","Par la formule de Hardy-Weinberg"]'::jsonb
WHERE enonce = 'Comment calcule-t-on la fréquence de recombinaison entre deux gènes liés ?';

UPDATE questions SET 
  bonne_reponse = 'L''interaction entre deux gènes',
  choix = '["La dominance allélique","L''interaction entre deux gènes","La codominance","Une mutation létale"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''épistasie en génétique ?';

UPDATE questions SET 
  bonne_reponse = 'Un carbone central (Cα) portant un',
  choix = '["Un groupement carboxyle seul","Un carbone central (Cα) portant un","Un acide gras et un alcool","Un nucléotide"]'::jsonb
WHERE enonce = 'Quelle est la structure de base d''un acide aminé ?';

UPDATE questions SET 
  bonne_reponse = 'Une liaison covalente entre le',
  choix = '["Une liaison hydrogène entre protéines","Une liaison covalente entre le","Une liaison ionique","Une liaison hydrophobe"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une liaison peptidique et comment se forme-t-elle ?';

UPDATE questions SET 
  bonne_reponse = 'La conformation locale stabilisée par',
  choix = '["La séquence en acides aminés","La conformation locale stabilisée par","Les interactions à longue portée de la chaîne","L''assemblage de plusieurs chaînes peptidiques"]'::jsonb
WHERE enonce = 'Qu''est-ce que la structure secondaire d''une protéine ?';

UPDATE questions SET 
  bonne_reponse = 'La perte de la structure',
  choix = '["La synthèse d''une protéine","La perte de la structure","La dégradation en acides aminés","La traduction de l''ARNm"]'::jsonb
WHERE enonce = 'Qu''est-ce que la dénaturation d''une protéine ?';

UPDATE questions SET 
  bonne_reponse = 'Les acides gras saturés n''ont pas de',
  choix = '["Ils ont des formules différentes","Les acides gras saturés n''ont pas de","Les saturés sont liquides et les insaturés solides","Les insaturés ont plus de carbones"]'::jsonb
WHERE enonce = 'Quelle est la différence entre un acide gras saturé et insaturé ?';

UPDATE questions SET 
  bonne_reponse = 'L''adénosine triphosphate',
  choix = '["Un acide aminé","L''adénosine triphosphate","Un lipide","Un glucide"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''ATP et pourquoi est-il la "monnaie énergétique" de la cellule ?';

UPDATE questions SET 
  bonne_reponse = 'Les monosaccharides sont des sucres',
  choix = '["Ils ont des fonctions identiques","Les monosaccharides sont des sucres","Ils diffèrent par leur composition en acides aminés","Les polysaccharides sont des lipides"]'::jsonb
WHERE enonce = 'Quelle est la différence entre un monosaccharide, un disaccharide et un polysaccharide ?';

UPDATE questions SET 
  bonne_reponse = 'Une molécule composée d''un sucre',
  choix = '["Un acide aminé","Une molécule composée d''un sucre","Un acide gras","Un polysaccharide"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un nucléotide et quelle est sa structure ?';

UPDATE questions SET 
  bonne_reponse = 'L''ADN est double brin avec désoxyribose',
  choix = '["Ils sont identiques","L''ADN est double brin avec désoxyribose","L''ARN est double brin","L''ADN contient de l''uracile"]'::jsonb
WHERE enonce = 'Quelle est la différence entre l''ADN et l''ARN en termes de structure ?';

UPDATE questions SET 
  bonne_reponse = 'Un biocatalyseur protéique abaissant',
  choix = '["Un substrat","Un biocatalyseur protéique abaissant","Un produit de réaction","Un lipide membranaire"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une enzyme et comment catalyse-t-elle une réaction ?';

UPDATE questions SET 
  bonne_reponse = 'Chaque enzyme ne catalyse qu''un type de',
  choix = '["Les enzymes catalysent toutes les réactions","Chaque enzyme ne catalyse qu''un type de","Les enzymes fonctionnent sans substrat","La spécificité enzymatique dépend du pH uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que la spécificité enzymatique et comment s''explique-t-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Chaque enzyme a un pH et une',
  choix = '["Ils n''ont aucun effet","Chaque enzyme a un pH et une","Les enzymes fonctionnent mieux à pH basique","La température n''affecte pas les enzymes"]'::jsonb
WHERE enonce = 'Comment le pH et la température affectent-ils l''activité enzymatique ?';

UPDATE questions SET 
  bonne_reponse = '6CO2 + 6H2O + lumière → C6H12O6 + 6O2',
  choix = '["C6H12O6 + 6O2 → 6CO2 + 6H2O","6CO2 + 6H2O + lumière → C6H12O6 + 6O2","CO2 + H2O → sucre","6O2 + lumière → 6CO2"]'::jsonb
WHERE enonce = 'Quelle est l''équation globale de la photosynthèse ?';

UPDATE questions SET 
  bonne_reponse = 'Dans les membranes des thylakoïdes du',
  choix = '["Dans la matrice du chloroplaste (stroma)","Dans les membranes des thylakoïdes du","Dans les mitochondries","Dans le cytoplasme"]'::jsonb
WHERE enonce = 'Où se déroulent les réactions lumineuses (phase claire) de la photosynthèse ?';

UPDATE questions SET 
  bonne_reponse = 'La fixation du CO2 en glucides en',
  choix = '["Les réactions de la phase claire","La fixation du CO2 en glucides en","La respiration cellulaire","La photolyse de l''eau"]'::jsonb
WHERE enonce = 'Qu''est-ce que le cycle de Calvin (phase sombre) de la photosynthèse ?';

UPDATE questions SET 
  bonne_reponse = 'C6H12O6 + 6O2 → 6CO2 + 6H2O + ATP',
  choix = '["6CO2 + 6H2O → C6H12O6 + 6O2","C6H12O6 + 6O2 → 6CO2 + 6H2O + ATP","Glucose → acide lactique","Glucose + lumière → ATP"]'::jsonb
WHERE enonce = 'Quelle est l''équation globale de la respiration cellulaire aérobie ?';

UPDATE questions SET 
  bonne_reponse = 'Glycolyse (cytoplasme)',
  choix = '["Glycolyse uniquement","Glycolyse (cytoplasme)","Photosynthèse, glycolyse, fermentation","Cycle de Calvin, glycolyse, ATP-synthase"]'::jsonb
WHERE enonce = 'Quelles sont les trois étapes principales de la respiration cellulaire aérobie ?';

UPDATE questions SET 
  bonne_reponse = 'La production d''ATP en absence d''O2',
  choix = '["La respiration aérobie","La production d''ATP en absence d''O2","La photosynthèse","La dégradation des lipides"]'::jsonb
WHERE enonce = 'Qu''est-ce que la fermentation et dans quelles conditions se produit-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Le rapport CO2 produit / O2 consommé',
  choix = '["La quantité d''ATP produite","Le rapport CO2 produit / O2 consommé","La quantité d''eau produite","Le taux de photosynthèse"]'::jsonb
WHERE enonce = 'Qu''est-ce que le coefficient respiratoire (CR) et que révèle-t-il ?';

UPDATE questions SET 
  bonne_reponse = 'Synthétiser l''ATP en utilisant le',
  choix = '["Dégrader les protéines","Synthétiser l''ATP en utilisant le","Transporter les électrons","Dégrader le glucose"]'::jsonb
WHERE enonce = 'Quel est le rôle de l''ATP synthase dans la mitochondrie ?';

UPDATE questions SET 
  bonne_reponse = 'Les autotrophes synthétisent leur',
  choix = '["Aucune différence nutritionnelle","Les autotrophes synthétisent leur","Les hétérotrophes font la photosynthèse","Les autotrophes ne respirent pas"]'::jsonb
WHERE enonce = 'Quelle est la différence entre l''autotrophie et l''hétérotrophie ?';

UPDATE questions SET 
  bonne_reponse = 'Jusqu''à une concentration optimale',
  choix = '["Elle n''a aucun effet","Jusqu''à une concentration optimale","Le CO2 inhibe la photosynthèse","Le CO2 n''est pas utilisé en photosynthèse"]'::jsonb
WHERE enonce = 'Comment la concentration en CO2 affecte-t-elle le taux de photosynthèse ?';

UPDATE questions SET 
  bonne_reponse = 'L''intensité lumineuse à laquelle la',
  choix = '["Le maximum de photosynthèse","L''intensité lumineuse à laquelle la","L''absence totale de photosynthèse","La saturation en chlorophylle"]'::jsonb
WHERE enonce = 'Qu''est-ce que le point de compensation photosynthétique ?';

UPDATE questions SET 
  bonne_reponse = 'Watson et Crick en 1953',
  choix = '["Mendel en 1865","Watson et Crick en 1953","Pasteur en 1870","Lamarck en 1809"]'::jsonb
WHERE enonce = 'Qui a déterminé la structure en double hélice de l''ADN et en quelle année ?';

UPDATE questions SET 
  bonne_reponse = 'Adénine (A) s''apparie avec Thymine (T)',
  choix = '["Toutes les bases s''apparient avec toutes","Adénine (A) s''apparie avec Thymine (T)","A-G et T-C s''apparient","Les bases ne s''apparient pas"]'::jsonb
WHERE enonce = 'Qu''est-ce que la complémentarité des bases azotées dans l''ADN ?';

UPDATE questions SET 
  bonne_reponse = 'Chaque brin parental sert de matrice',
  choix = '["Chaque brin parental est dégradé","Chaque brin parental sert de matrice","Les deux brins sont reconstruits entièrement","La réplication est conservative (les deux brins parentaux restent ensemble)"]'::jsonb
WHERE enonce = 'Qu''est-ce que la réplication semi-conservative de l''ADN ?';

UPDATE questions SET 
  bonne_reponse = 'Synthétiser le nouveau brin d''ADN en',
  choix = '["Couper l''ADN","Synthétiser le nouveau brin d''ADN en","Dérouler la double hélice","Lier les fragments d''Okazaki"]'::jsonb
WHERE enonce = 'Quel est le rôle de l''ADN polymérase dans la réplication ?';

UPDATE questions SET 
  bonne_reponse = 'La synthèse d''un ARNm à partir d''un',
  choix = '["La synthèse d''une protéine","La synthèse d''un ARNm à partir d''un","La réplication de l''ADN","La traduction de l''ARNm"]'::jsonb
WHERE enonce = 'Qu''est-ce que la transcription et où se déroule-t-elle dans une cellule eucaryote ?';

UPDATE questions SET 
  bonne_reponse = 'La synthèse d''une chaîne polypeptidique',
  choix = '["La transcription de l''ADN","La synthèse d''une chaîne polypeptidique","La réplication de l''ARN","La dégradation des protéines"]'::jsonb
WHERE enonce = 'Qu''est-ce que la traduction et où se déroule-t-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Une séquence de 3 nucléotides de l''ARNm',
  choix = '["Un nucléotide unique","Une séquence de 3 nucléotides de l''ARNm","Une protéine","Un intron"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un codon et comment code-t-il pour un acide aminé ?';

UPDATE questions SET 
  bonne_reponse = 'La coiffe 5''',
  choix = '["L''ARNm est directement traduit sans modification","La coiffe 5''","L''ARNm est dégradé immédiatement","L''ARN polymérase modifie l''ARNm"]'::jsonb
WHERE enonce = 'Qu''est-ce que le traitement (maturation) de l''ARNm chez les eucaryotes ?';

UPDATE questions SET 
  bonne_reponse = 'La possibilité d''inclure ou d''exclure',
  choix = '["Un type de mutation","La possibilité d''inclure ou d''exclure","Un mécanisme de réplication","Un processus de dégradation de l''ARN"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''épissage alternatif et quelle est son importance ?';

UPDATE questions SET 
  bonne_reponse = 'Un changement d''un seul nucléotide dans',
  choix = '["Le remplacement d''un chromosome entier","Un changement d''un seul nucléotide dans","Une mutation chromosomique","Une polyploïdie"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une mutation ponctuelle et quels en sont les types ?';

UPDATE questions SET 
  bonne_reponse = 'Il transporte un acide aminé spécifique',
  choix = '["Il code pour les protéines","Il transporte un acide aminé spécifique","Il sert de matrice pour l''ARNm","Il dégrade les protéines"]'::jsonb
WHERE enonce = 'Quel est le rôle de l''ARN de transfert (ARNt) dans la traduction ?';

UPDATE questions SET 
  bonne_reponse = 'Un ensemble de gènes structuraux sous',
  choix = '["Un gène unique","Un ensemble de gènes structuraux sous","Un mécanisme de recombinaison","Un plasmide"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''opéron lac chez E. coli et son intérêt pour comprendre la régulation des gènes ?';

UPDATE questions SET 
  bonne_reponse = 'Allonger les télomères qui',
  choix = '["Initier la réplication","Allonger les télomères qui","Réparer les cassures double brin","Épissage des introns"]'::jsonb
WHERE enonce = 'Quel est le rôle de la télomérase dans les cellules eucaryotes ?';

UPDATE questions SET 
  bonne_reponse = 'Les individus les mieux adaptés à leur',
  choix = '["Les espèces sont immuables","Les individus les mieux adaptés à leur","L''évolution est dirigée vers la complexité","Les caractères acquis sont héréditaires"]'::jsonb
WHERE enonce = 'Quelle est la théorie de l''évolution par la sélection naturelle proposée par Darwin ?';

UPDATE questions SET 
  bonne_reponse = 'Lamarck proposait l''hérédité des',
  choix = '["Elles sont identiques","Lamarck proposait l''hérédité des","Darwin est antérieur à Lamarck","Lamarck n''a pas théorisé l''évolution"]'::jsonb
WHERE enonce = 'Quelle est la différence entre l''évolution de Lamarck et celle de Darwin ?';

UPDATE questions SET 
  bonne_reponse = 'La dérive génétique est une variation',
  choix = '["Elles sont identiques","La dérive génétique est une variation","La dérive génétique augmente toujours l''adaptation","La sélection naturelle est aléatoire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la dérive génétique et comment diffère-t-elle de la sélection naturelle ?';

UPDATE questions SET 
  bonne_reponse = 'La formation d''une nouvelle espèce',
  choix = '["La spéciation par compétition directe","La formation d''une nouvelle espèce","La spéciation en sympatrie","La spéciation par polyploïdie uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que la spéciation allopatrique et quand se produit-elle ?';

UPDATE questions SET 
  bonne_reponse = 'La comparaison des séquences',
  choix = '["L''absence de similitudes","La comparaison des séquences","La différence de taille entre espèces","L''absence de fossiles"]'::jsonb
WHERE enonce = 'Quelles sont les preuves moléculaires de l''évolution commune ?';

UPDATE questions SET 
  bonne_reponse = 'Regrouper les organismes selon leur',
  choix = '["Classer les organismes par ressemblance morphologique","Regrouper les organismes selon leur","Classer par habitat","Classer par taille"]'::jsonb
WHERE enonce = 'Qu''est-ce que la classification phylogénétique (cladistique) ?';

UPDATE questions SET 
  bonne_reponse = 'La synthèse de la sélection naturelle',
  choix = '["La sélection naturelle seule explique tout","La synthèse de la sélection naturelle","L''évolution est uniquement moléculaire","Les espèces n''évoluent pas"]'::jsonb
WHERE enonce = 'Quel est le principe de la théorie synthétique de l''évolution (néo-darwinisme) ?';

UPDATE questions SET 
  bonne_reponse = 'Les organes homologues ont une même',
  choix = '["Ils sont identiques","Les organes homologues ont une même","Les analogues ont la même origine","Les homologues ont des fonctions identiques"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un organe homologue et comment diffère-t-il d''un organe analogue ?';

UPDATE questions SET 
  bonne_reponse = 'Chaque espèce est nommée par deux mots',
  choix = '["Un nom unique pour chaque individu","Chaque espèce est nommée par deux mots","Une classification en 3 règnes","Un système de classification numérique"]'::jsonb
WHERE enonce = 'Quelle est la signification de la nomenclature binominale de Linné ?';

UPDATE questions SET 
  bonne_reponse = 'L''évolution mutuelle de deux espèces',
  choix = '["L''évolution indépendante de deux espèces","L''évolution mutuelle de deux espèces","L''évolution uniquement parasitaire","La convergence évolutive"]'::jsonb
WHERE enonce = 'Qu''est-ce que la coévolution et quel en est un exemple classique ?';

UPDATE questions SET 
  bonne_reponse = 'La théorie selon laquelle des bactéries',
  choix = '["Une théorie réfutée","La théorie selon laquelle des bactéries","Une forme de parasitisme","Un mécanisme de division cellulaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''endosymbiose et comment explique-t-elle l''origine des mitochondries et des chloroplastes ?';

UPDATE questions SET 
  bonne_reponse = 'La sélection sexuelle favorise les',
  choix = '["Elles sont identiques","La sélection sexuelle favorise les","La sélection sexuelle est purement aléatoire","Elle n''existe que chez les insectes"]'::jsonb
WHERE enonce = 'Qu''est-ce que la sélection sexuelle et comment diffère-t-elle de la sélection naturelle de survie ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble formé par une communauté',
  choix = '["Uniquement les organismes vivants","L''ensemble formé par une communauté","Un groupe d''espèces de même genre","Un habitat forestier uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un écosystème et quels en sont les composants principaux ?';

UPDATE questions SET 
  bonne_reponse = 'La chaîne alimentaire montre les',
  choix = '["Des séquences de décomposeurs","La chaîne alimentaire montre les","Des relations symbiotiques uniquement","Des cycles biogéochimiques"]'::jsonb
WHERE enonce = 'Qu''est-ce que la chaîne alimentaire et le réseau trophique ?';

UPDATE questions SET 
  bonne_reponse = 'L''énergie circule à sens unique',
  choix = '["L''énergie est recyclée indéfiniment","L''énergie circule à sens unique","Toute l''énergie est transférée","L''énergie augmente à chaque niveau trophique"]'::jsonb
WHERE enonce = 'Qu''est-ce que le flux d''énergie dans un écosystème et la règle des 10% ?';

UPDATE questions SET 
  bonne_reponse = 'Le mouvement du carbone entre',
  choix = '["Un cycle mineur","Le mouvement du carbone entre","Un cycle uniquement terrestre","Un processus sans lien avec le vivant"]'::jsonb
WHERE enonce = 'Qu''est-ce que le cycle du carbone et son importance pour le climat ?';

UPDATE questions SET 
  bonne_reponse = 'Le remplacement progressif de',
  choix = '["Un phénomène de migration","Le remplacement progressif de","Une extinction d''espèces","Un cycle saisonnier"]'::jsonb
WHERE enonce = 'Qu''est-ce que la succession écologique et quels en sont les types ?';

UPDATE questions SET 
  bonne_reponse = 'La variété du vivant à l''échelle des',
  choix = '["Le nombre total d''espèces","La variété du vivant à l''échelle des","La biomasse totale","Le nombre d''individus"]'::jsonb
WHERE enonce = 'Qu''est-ce que la biodiversité et comment la mesure-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'La destruction et fragmentation des',
  choix = '["Uniquement la pollution","La destruction et fragmentation des","Uniquement le changement climatique","L''introduction d''espèces sauvages"]'::jsonb
WHERE enonce = 'Quelles sont les principales causes actuelles de l''érosion de la biodiversité ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des rôles fonctionnels et',
  choix = '["Son habitat géographique","L''ensemble des rôles fonctionnels et","Son nom scientifique","Sa taille de population"]'::jsonb
WHERE enonce = 'Qu''est-ce que la niche écologique d''une espèce ?';

UPDATE questions SET 
  bonne_reponse = 'Deux espèces occupant exactement la',
  choix = '["Les espèces coexistent toujours","Deux espèces occupant exactement la","Les espèces se partagent toujours les ressources","La compétition est rare en nature"]'::jsonb
WHERE enonce = 'Qu''est-ce que le principe d''exclusion compétitive de Gause ?';

UPDATE questions SET 
  bonne_reponse = 'Le réchauffement global causé',
  choix = '["Un phénomène naturel sans importance","Le réchauffement global causé","Un phénomène limité aux pôles","Un problème exclusivement industriel"]'::jsonb
WHERE enonce = 'Qu''est-ce que le changement climatique et ses effets sur les écosystèmes haïtiens ?';

UPDATE questions SET 
  bonne_reponse = 'L''utilisation d''organismes vivants',
  choix = '["La destruction des écosystèmes","L''utilisation d''organismes vivants","Un processus uniquement chimique","Une technique agricole uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que la biorestauration et comment peut-elle aider des écosystèmes dégradés ?';

UPDATE questions SET 
  bonne_reponse = 'La discipline scientifique visant à',
  choix = '["La gestion des fermes","La discipline scientifique visant à","La biologie moléculaire uniquement","L''agriculture intensive"]'::jsonb
WHERE enonce = 'Qu''est-ce que la biologie de la conservation et ses outils principaux ?';

UPDATE questions SET 
  bonne_reponse = 'Une technique d''amplification in vitro',
  choix = '["Une technique de séquençage","Une technique d''amplification in vitro","Une technique de chromatographie","Une méthode d''électrophorèse"]'::jsonb
WHERE enonce = 'Qu''est-ce que la PCR (réaction en chaîne par polymérase) et à quoi sert-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Un système d''édition génomique précis',
  choix = '["Un type de PCR","Un système d''édition génomique précis","Une technique de séquençage","Un outil de clonage classique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la technologie CRISPR-Cas9 et ses applications ?';

UPDATE questions SET 
  bonne_reponse = 'L''insertion d''un fragment d''ADN dans un',
  choix = '["La reproduction asexuée d''un animal","L''insertion d''un fragment d''ADN dans un","Une technique de PCR","Le séquençage de génome"]'::jsonb
WHERE enonce = 'Qu''est-ce que le clonage moléculaire et ses étapes principales ?';

UPDATE questions SET 
  bonne_reponse = 'Des organismes dont le génome a été',
  choix = '["Des mutants naturels","Des organismes dont le génome a été","Des organismes clonés","Des hybrides naturels"]'::jsonb
WHERE enonce = 'Qu''est-ce que les organismes génétiquement modifiés (OGM) et leurs controverses ?';

UPDATE questions SET 
  bonne_reponse = 'L''introduction d''une version',
  choix = '["La chirurgie traditionnelle","L''introduction d''une version","La chimiothérapie","La greffe d''organes"]'::jsonb
WHERE enonce = 'Qu''est-ce que la thérapie génique et quels sont ses principes ?';

UPDATE questions SET 
  bonne_reponse = 'L''adaptation des traitements médicaux',
  choix = '["La médecine traditionnelle","L''adaptation des traitements médicaux","La médecine homéopathique","La médecine préventive classique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la médecine personnalisée et comment la génomique y contribue-t-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Des cellules indifférenciées capables',
  choix = '["Des cellules différenciées","Des cellules indifférenciées capables","Des cellules cancéreuses","Des cellules reproductrices"]'::jsonb
WHERE enonce = 'Qu''est-ce que les cellules souches et leurs types principaux ?';

UPDATE questions SET 
  bonne_reponse = 'L''utilisation de l''informatique et des',
  choix = '["La biologie des insectes","L''utilisation de l''informatique et des","La biotechnologie agricole","La biologie marine informatisée"]'::jsonb
WHERE enonce = 'Qu''est-ce que la bioinformatique et quel est son rôle en biologie moderne ?';

UPDATE questions SET 
  bonne_reponse = 'Le projet international (1990-2003) qui',
  choix = '["Un projet d''agriculture","Le projet international (1990-2003) qui","Un projet uniquement américain","Un projet de clonage humain"]'::jsonb
WHERE enonce = 'Qu''est-ce que le Projet Génome Humain et ses résultats principaux ?';

UPDATE questions SET 
  bonne_reponse = 'Les biotechnologies peuvent améliorer',
  choix = '["Aucune application locale","Les biotechnologies peuvent améliorer","Uniquement des applications ornementales","Les biotechnologies sont inaccessibles aux pays en développement"]'::jsonb
WHERE enonce = 'Quelles sont les applications de la biologie en agroalimentaire et en médecine en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Croûte, manteau, noyau',
  choix = '["Eau, roche, métal","Croûte, manteau, noyau","Sol, granite, fer","Lithosphère, atmosphère, hydrosphère"]'::jsonb
WHERE enonce = 'Quelles sont les trois couches principales de la structure interne de la Terre, de l''extérieur vers l''intérieur ?';

UPDATE questions SET 
  bonne_reponse = 'En analysant les ondes sismiques (P et',
  choix = '["Par des forages jusqu''au centre","En analysant les ondes sismiques (P et","Par des volcans uniquement","Par des satellites"]'::jsonb
WHERE enonce = 'Comment les scientifiques étudient-ils l''intérieur de la Terre qu''ils ne peuvent pas observer directement ?';

UPDATE questions SET 
  bonne_reponse = 'La croûte océanique est plus dense',
  choix = '["Aucune différence","La croûte océanique est plus dense","La croûte continentale est plus dense","Elles ont la même composition"]'::jsonb
WHERE enonce = 'Quelle est la différence entre la croûte océanique et la croûte continentale ?';

UPDATE questions SET 
  bonne_reponse = 'Une couche solide (mais pouvant se',
  choix = '["Un liquide homogène","Une couche solide (mais pouvant se","Un gaz","Uniquement du fer"]'::jsonb
WHERE enonce = 'Qu''est-ce que le manteau terrestre et quel est son état ?';

UPDATE questions SET 
  bonne_reponse = 'Un noyau externe liquide et un noyau',
  choix = '["Granite solide","Un noyau externe liquide et un noyau","Du basalte liquide","Du calcium et du magnésium"]'::jsonb
WHERE enonce = 'Quelle est la composition probable du noyau terrestre et son état ?';

UPDATE questions SET 
  bonne_reponse = 'L''équilibre gravitationnel entre la',
  choix = '["La rigidité de la croûte","L''équilibre gravitationnel entre la","La solidité du noyau","Le gradient géothermique"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''isostasie terrestre ?';

UPDATE questions SET 
  bonne_reponse = 'L''augmentation de température avec la',
  choix = '["La variation de pression avec la profondeur","L''augmentation de température avec la","La conductivité électrique de la croûte","La densité de la croûte"]'::jsonb
WHERE enonce = 'Qu''est-ce que le gradient géothermique et quelle est sa valeur approximative ?';

UPDATE questions SET 
  bonne_reponse = 'La lithosphère est la partie rigide',
  choix = '["Deux types de roches","La lithosphère est la partie rigide","Deux couches du noyau","Des zones atmosphériques"]'::jsonb
WHERE enonce = 'Qu''est-ce que la lithosphère et l''asthénosphère ?';

UPDATE questions SET 
  bonne_reponse = 'Il est généré par la rotation du noyau',
  choix = '["Il est permanent et immuable","Il est généré par la rotation du noyau","Il provient de la croûte","Il est généré par les volcans"]'::jsonb
WHERE enonce = 'Qu''est-ce que le champ magnétique terrestre et comment se forme-t-il ?';

UPDATE questions SET 
  bonne_reponse = 'À 12 km de profondeur',
  choix = '["Il a atteint le manteau","À 12 km de profondeur","Il n''a rien découvert","Il a trouvé du fer pur"]'::jsonb
WHERE enonce = 'Qu''est-ce que le forage scientifique de Kola (Russie) a révélé sur l''intérieur de la Terre ?';

UPDATE questions SET 
  bonne_reponse = 'Les chondrites métalliques (composées',
  choix = '["Elles ne fournissent aucune information","Les chondrites métalliques (composées","Les météorites sont composées de granit","Les météorites sont uniquement utiles pour dater la Terre"]'::jsonb
WHERE enonce = 'Comment les météorites nous informent-elles sur la composition du noyau terrestre ?';

UPDATE questions SET 
  bonne_reponse = '4',
  choix = '["10 000 ans","4","100 millions d''années","1 milliard d''années"]'::jsonb
WHERE enonce = 'Quel est l''âge estimé de la Terre et comment le détermine-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'Alfred Wegener en 1912',
  choix = '["Isaac Newton","Alfred Wegener en 1912","Charles Darwin","Albert Einstein"]'::jsonb
WHERE enonce = 'Qui a proposé la théorie de la dérive des continents et sur quelles preuves ?';

UPDATE questions SET 
  bonne_reponse = 'Une chaîne de montagnes sous-marines où',
  choix = '["Une fosse océanique","Une chaîne de montagnes sous-marines où","Un volcan continental","Un archipel de corail"]'::jsonb
WHERE enonce = 'Qu''est-ce que la dorsale océanique et quel est son rôle dans la tectonique des plaques ?';

UPDATE questions SET 
  bonne_reponse = 'L''enfoncement d''une plaque océanique',
  choix = '["La création de croûte","L''enfoncement d''une plaque océanique","Un mouvement horizontal des plaques","L''ouverture d''un rift"]'::jsonb
WHERE enonce = 'Qu''est-ce que la subduction et dans quel contexte se produit-elle ?';

UPDATE questions SET 
  bonne_reponse = 'La convection du manteau',
  choix = '["La rotation de la Terre","La convection du manteau","Les marées océaniques","Le vent solaire"]'::jsonb
WHERE enonce = 'Quel est le mécanisme moteur du déplacement des plaques tectoniques ?';

UPDATE questions SET 
  bonne_reponse = 'Par la collision de plaques tectoniques',
  choix = '["Par l''érosion uniquement","Par la collision de plaques tectoniques","Par les volcans uniquement","Par les tremblements de terre uniquement"]'::jsonb
WHERE enonce = 'Comment se forment les chaînes de montagnes selon la tectonique des plaques ?';

UPDATE questions SET 
  bonne_reponse = 'Une faille où deux plaques glissent',
  choix = '["Une faille normale","Une faille où deux plaques glissent","Une zone de subduction","Une dorsale océanique"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une faille transformante et quel en est un exemple célèbre ?';

UPDATE questions SET 
  bonne_reponse = 'Quelques centimètres par an (2-15 cm/an',
  choix = '["Quelques mètres par an","Quelques centimètres par an (2-15 cm/an","Quelques kilomètres par an","Immobiles"]'::jsonb
WHERE enonce = 'Quelle est la vitesse typique de déplacement des plaques tectoniques ?';

UPDATE questions SET 
  bonne_reponse = 'Les points chauds sont des panaches de',
  choix = '["Ils sont identiques","Les points chauds sont des panaches de","Les points chauds se trouvent uniquement aux dorsales","Le volcanisme de subduction est plus calme"]'::jsonb
WHERE enonce = 'Qu''est-ce que le volcanisme de point chaud et comment diffère-t-il du volcanisme de zone de subduction ?';

UPDATE questions SET 
  bonne_reponse = 'La plaque Caraïbe est coincée entre les',
  choix = '["Les Caraïbes ne sont pas concernées","La plaque Caraïbe est coincée entre les","Les Antilles sont sur une seule plaque","Il n''y a pas de tectonique dans les Caraïbes"]'::jsonb
WHERE enonce = 'Comment la tectonique des plaques influence-t-elle la géologie des Caraïbes et d''Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'L''étude du magnétisme fossile des roches',
  choix = '["L''étude des aimants","L''étude du magnétisme fossile des roches","L''étude de la boussole","La datation par le carbone 14"]'::jsonb
WHERE enonce = 'Qu''est-ce que la paléomagnétisme et comment a-t-il confirmé l''expansion océanique ?';

UPDATE questions SET 
  bonne_reponse = 'Le supercontinent unique regroupant',
  choix = '["Un continent actuel","Le supercontinent unique regroupant","Un continent hypothétique futur","L''Antarctique seul"]'::jsonb
WHERE enonce = 'Qu''est-ce que le supercontinent Pangée et quand a-t-il existé ?';

UPDATE questions SET 
  bonne_reponse = 'Ignées (refroidissement du magma)',
  choix = '["Marbre, calcaire, granit","Ignées (refroidissement du magma)","Sable, argile, basalte","Diamant, charbon, quartz"]'::jsonb
WHERE enonce = 'Quels sont les trois grands types de roches et comment se forment-ils ?';

UPDATE questions SET 
  bonne_reponse = 'Les plutoniques (granite) se forment',
  choix = '["Par leur couleur","Les plutoniques (granite) se forment","Par leur âge","Par leur composition chimique uniquement"]'::jsonb
WHERE enonce = 'Comment différencie-t-on les roches magmatiques plutoniques des roches volcaniques ?';

UPDATE questions SET 
  bonne_reponse = 'La transformation de roches',
  choix = '["La formation de roches sédimentaires","La transformation de roches","La solidification du magma","L''érosion des roches"]'::jsonb
WHERE enonce = 'Qu''est-ce que le métamorphisme et quels facteurs le contrôlent ?';

UPDATE questions SET 
  bonne_reponse = 'Par l''accumulation',
  choix = '["Par refroidissement du magma","Par l''accumulation","Par métamorphisme","Par fusion des roches"]'::jsonb
WHERE enonce = 'Comment se forment les roches sédimentaires et quel est leur intérêt pour la géologie ?';

UPDATE questions SET 
  bonne_reponse = 'Le cycle géologique dans lequel les',
  choix = '["Un cycle uniquement magmatique","Le cycle géologique dans lequel les","Un cycle uniquement sédimentaire","Un processus irréversible"]'::jsonb
WHERE enonce = 'Qu''est-ce que le cycle des roches et quels processus y participent ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des transformations',
  choix = '["La fusion des roches","L''ensemble des transformations","Le métamorphisme regional","L''érosion chimique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la diagenèse dans la formation des roches sédimentaires ?';

UPDATE questions SET 
  bonne_reponse = 'L''étude scientifique des minéraux',
  choix = '["L''étude des fossiles","L''étude scientifique des minéraux","L''étude des roches","L''étude des volcans"]'::jsonb
WHERE enonce = 'Qu''est-ce que la minéralogie et quel est le minéral le plus abondant de la croûte terrestre ?';

UPDATE questions SET 
  bonne_reponse = 'En mesurant le rapport isotope',
  choix = '["Par la couleur des roches","En mesurant le rapport isotope","Par la dureté des minéraux","Par la position stratigraphique uniquement"]'::jsonb
WHERE enonce = 'Comment la datation radiométrique permet-elle de dater les roches ?';

UPDATE questions SET 
  bonne_reponse = 'Dans une séquence sédimentaire non',
  choix = '["La couche la plus ancienne est au sommet","Dans une séquence sédimentaire non","Les couches sont toujours horizontales","Les couches se forment verticalement"]'::jsonb
WHERE enonce = 'Qu''est-ce que le principe de superposition en stratigraphie et qui l''a établi ?';

UPDATE questions SET 
  bonne_reponse = 'Haïti présente des roches volcaniques',
  choix = '["Haïti n''a que des roches sédimentaires","Haïti présente des roches volcaniques","Haïti ne présente que du granite","Haïti n''a aucune roche volcanique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la géologie haïtienne et quels types de roches y trouve-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'Le foyer est le point de rupture dans',
  choix = '["Ils désignent le même point","Le foyer est le point de rupture dans","L''épicentre est plus profond","Le foyer est à la surface"]'::jsonb
WHERE enonce = 'Quelle est la différence entre le foyer (hypocentre) et l''épicentre d''un séisme ?';

UPDATE questions SET 
  bonne_reponse = 'Richter (magnitude) mesure l''énergie',
  choix = '["Elles mesurent la même chose","Richter (magnitude) mesure l''énergie","Mercalli mesure la profondeur","Richter mesure la durée"]'::jsonb
WHERE enonce = 'Quelle est la différence entre l''échelle de Richter et l''échelle de Mercalli ?';

UPDATE questions SET 
  bonne_reponse = 'Ondes P (primaires',
  choix = '["Ondes alpha et bêta","Ondes P (primaires","Ondes X et Y","Ondes de surface uniquement"]'::jsonb
WHERE enonce = 'Quels sont les deux types principaux d''ondes sismiques et leurs caractéristiques ?';

UPDATE questions SET 
  bonne_reponse = 'Un tremblement de terre sous-marin (ou',
  choix = '["Un vent fort sur l''océan","Un tremblement de terre sous-marin (ou","Une éruption volcanique terrestre uniquement","Une marée exceptionnelle"]'::jsonb
WHERE enonce = 'Comment se forme un tsunami et quelles sont les conditions nécessaires ?';

UPDATE questions SET 
  bonne_reponse = 'Le comportement de certains sols',
  choix = '["Un phénomène volcanique","Le comportement de certains sols","Un type de faille","Un glissement de terrain classique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la liquéfaction des sols lors d''un séisme et pourquoi est-elle dangereuse ?';

UPDATE questions SET 
  bonne_reponse = 'Volcans boucliers (basaltiques',
  choix = '["Petits et grands","Volcans boucliers (basaltiques","Volcans actifs et éteints","Volcans sous-marins et terrestres"]'::jsonb
WHERE enonce = 'Quels sont les deux grands types de volcans selon leur structure et leur mode d''éruption ?';

UPDATE questions SET 
  bonne_reponse = 'Un écoulement pyroclastique rapide de',
  choix = '["Un nuage de vapeur d''eau","Un écoulement pyroclastique rapide de","Une coulée de lave lente","Un tsunami volcanique"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une nuée ardente et quel est son exemple historique le plus célèbre ?';

UPDATE questions SET 
  bonne_reponse = 'Le risque sismique = aléa (probabilité',
  choix = '["Le risque = magnitude uniquement","Le risque sismique = aléa (probabilité","Le risque = nombre de séismes","Le risque est identique partout"]'::jsonb
WHERE enonce = 'Comment se définit le risque sismique et quels sont ses facteurs ?';

UPDATE questions SET 
  bonne_reponse = 'Des réseaux de capteurs sismiques qui',
  choix = '["Des boucliers contre les séismes","Des réseaux de capteurs sismiques qui","Des constructions parasismiques","Des abris souterrains"]'::jsonb
WHERE enonce = 'Qu''est-ce que le parc de prévention et les systèmes d''alerte sismique précoce ?';

UPDATE questions SET 
  bonne_reponse = 'L''injection de fluides en profondeur',
  choix = '["Les séismes sont uniquement naturels","L''injection de fluides en profondeur","L''exploitation minière ne cause pas de séismes","Les séismes induits sont toujours plus forts que les naturels"]'::jsonb
WHERE enonce = 'Qu''est-ce que la sismicité induite et comment les activités humaines peuvent-elles causer des séismes ?';

UPDATE questions SET 
  bonne_reponse = 'Haïti est exposée à des séismes majeurs',
  choix = '["Haïti n''a pas de risques géologiques","Haïti est exposée à des séismes majeurs","Les risques sont uniquement climatiques","Les séismes en Haïti sont mineurs"]'::jsonb
WHERE enonce = 'Qu''est-ce que le géorisque en Haïti et comment y faire face ?';

UPDATE questions SET 
  bonne_reponse = 'Construire des bâtiments capables',
  choix = '["Construire en béton lourd","Construire des bâtiments capables","Construire sous terre","Construire en matériaux légers uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que la construction parasismique et ses principes fondamentaux ?';

UPDATE questions SET 
  bonne_reponse = 'Par la décomposition de matière',
  choix = '["Par refroidissement du magma","Par la décomposition de matière","Par métamorphisme des roches calcaires","Par l''érosion du granite"]'::jsonb
WHERE enonce = 'Comment se forment les gisements de pétrole et de gaz naturel ?';

UPDATE questions SET 
  bonne_reponse = 'Par concentration hydrothermale',
  choix = '["Par précipitation atmosphérique","Par concentration hydrothermale","Par érosion uniquement","Par refroidissement rapide de la lave"]'::jsonb
WHERE enonce = 'Comment se forment les gisements de minerais métalliques ?';

UPDATE questions SET 
  bonne_reponse = 'Des gisements d''or',
  choix = '["Aucun potentiel","Des gisements d''or","Uniquement du calcaire","Uniquement du pétrole offshore"]'::jsonb
WHERE enonce = 'Quels sont les potentiels miniers d''Haïti selon les études géologiques récentes ?';

UPDATE questions SET 
  bonne_reponse = 'L''exploitation de la chaleur interne de',
  choix = '["L''énergie solaire","L''exploitation de la chaleur interne de","L''énergie des marées","L''énergie nucléaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''énergie géothermique et comment peut-elle être exploitée ?';

UPDATE questions SET 
  bonne_reponse = 'L''application de la géologie à la',
  choix = '["L''étude des fossiles","L''application de la géologie à la","L''astronomie","La géologie marine uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que la géologie environnementale et ses applications ?';

UPDATE questions SET 
  bonne_reponse = 'En enlevant le couvert végétal',
  choix = '["Elle n''a aucun effet","En enlevant le couvert végétal","Elle favorise la minéralisation","Elle réduit le risque sismique"]'::jsonb
WHERE enonce = 'Comment la déforestation en Haïti amplifie-t-elle les risques géologiques ?';

UPDATE questions SET 
  bonne_reponse = 'L''exploitation des ressources minières',
  choix = '["L''exploitation maximale sans contrainte","L''exploitation des ressources minières","L''arrêt total de l''exploitation","L''exploitation uniquement par des entreprises étrangères"]'::jsonb
WHERE enonce = 'Qu''est-ce que la gestion durable des ressources minières ?';

UPDATE questions SET 
  bonne_reponse = 'Des formations géologiques poreuses et',
  choix = '["Des roches sans eau","Des formations géologiques poreuses et","Des volcans sous-marins","Des formations de basalte"]'::jsonb
WHERE enonce = 'Qu''est-ce que les aquifères et leur importance en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'En modifiant les régimes de pluie et en',
  choix = '["Sans effet","En modifiant les régimes de pluie et en","En augmentant les aquifères","En créant de nouveaux aquifères"]'::jsonb
WHERE enonce = 'Comment les changements climatiques affectent-ils les ressources en eau souterraine ?';

UPDATE questions SET 
  bonne_reponse = 'Des outils permettant l''analyse',
  choix = '["Des instruments de forage","Des outils permettant l''analyse","Des techniques de datation","Des méthodes de laboratoire uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que la télédétection et les SIG (Systèmes d''Information Géographique) en géologie ?';

UPDATE questions SET 
  bonne_reponse = 'L''étude des rapports isotopiques dans',
  choix = '["L''étude des roches uniquement","L''étude des rapports isotopiques dans","Une technique d''exploration pétrolière uniquement","L''étude des isotopes radioactifs médicaux"]'::jsonb
WHERE enonce = 'Qu''est-ce que la géologie isotopique et ses applications à la géochimie ?';

UPDATE questions SET 
  bonne_reponse = 'Les archives géologiques (carottes de',
  choix = '["La géologie n''est pas liée au climat","Les archives géologiques (carottes de","La géologie concerne uniquement les roches solides","Les géologues ne s''intéressent pas au climat"]'::jsonb
WHERE enonce = 'Comment la géologie contribue-t-elle à la compréhension du changement climatique passé et futur ?';

UPDATE questions SET 
  bonne_reponse = 'Tigre et Euphrate',
  choix = '["Nil et Congo","Tigre et Euphrate","Indus et Gange","Huang He et Yangtsé"]'::jsonb
WHERE enonce = 'Entre quels fleuves la Mésopotamie, considérée comme un berceau de la civilisation, est-elle située ?';

UPDATE questions SET 
  bonne_reponse = 'Le cunéiforme (écriture à coins) apparu',
  choix = '["L''alphabet latin","Le cunéiforme (écriture à coins) apparu","Les hiéroglyphes égyptiens","L''alphabet grec"]'::jsonb
WHERE enonce = 'Quelle est l''une des premières formes d''écriture connue de l''humanité et dans quelle civilisation est-elle apparue ?';

UPDATE questions SET 
  bonne_reponse = 'Un ensemble de 282 lois gravées sur une',
  choix = '["Un texte religieux","Un ensemble de 282 lois gravées sur une","Un traité commercial","Un récit mythologique"]'::jsonb
WHERE enonce = 'Qu''est-ce que le Code d''Hammurabi et quelle est son importance historique ?';

UPDATE questions SET 
  bonne_reponse = 'La source de fertilité des terres grâce',
  choix = '["Un obstacle à la civilisation","La source de fertilité des terres grâce","Une frontière uniquement","Un moyen de défense"]'::jsonb
WHERE enonce = 'Quel est le rôle du Nil dans la civilisation égyptienne antique ?';

UPDATE questions SET 
  bonne_reponse = 'Des tombeaux monumentaux des pharaons',
  choix = '["Des greniers à céréales","Des tombeaux monumentaux des pharaons","Des observatoires astronomiques","Des fortifications militaires"]'::jsonb
WHERE enonce = 'Quelle est la signification historique des pyramides de Gizeh ?';

UPDATE questions SET 
  bonne_reponse = 'Un système où les citoyens libres mâles',
  choix = '["Une démocratie universelle","Un système où les citoyens libres mâles","Un régime aristocratique","Une monarchie éclairée"]'::jsonb
WHERE enonce = 'Qu''est-ce que la démocratie athénienne du Ve siècle av. J.-C. et quelles en étaient les limites ?';

UPDATE questions SET 
  bonne_reponse = 'En conquérant un empire s''étendant de',
  choix = '["Il a unifié l''Europe","En conquérant un empire s''étendant de","Il a fondé Rome","Il a colonisé l''Afrique"]'::jsonb
WHERE enonce = 'Comment Alexandre le Grand a-t-il transformé le monde méditerranéen entre 336 et 323 av. J.-C. ?';

UPDATE questions SET 
  bonne_reponse = 'Le droit romain (base des systèmes',
  choix = '["Uniquement militaires","Le droit romain (base des systèmes","Uniquement artistiques","Uniquement architecturales"]'::jsonb
WHERE enonce = 'Quelles sont les principales contributions de la civilisation romaine à l''Europe et au monde occidental ?';

UPDATE questions SET 
  bonne_reponse = 'En Mésoamérique (Guatemala',
  choix = '["En Amérique du Nord","En Mésoamérique (Guatemala","En Amérique du Sud","En Amérique du Nord-Est"]'::jsonb
WHERE enonce = 'Qu''est-ce que la civilisation maya et où s''était-elle développée ?';

UPDATE questions SET 
  bonne_reponse = 'Des Amérindiens (sous-groupe Arawak)',
  choix = '["Des Africains","Des Amérindiens (sous-groupe Arawak)","Des Européens pré-colombiens","Des Asiatiques"]'::jsonb
WHERE enonce = 'Qu''est-ce que les premiers habitants d''Haïti (les Taïnos) et quelle était leur civilisation ?';

UPDATE questions SET 
  bonne_reponse = 'Un réseau de routes commerciales',
  choix = '["Un itinéraire exclusivement maritime","Un réseau de routes commerciales","Une route militaire romaine","Une route africaine uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que la Route de la Soie et son importance dans l''histoire des échanges ?';

UPDATE questions SET 
  bonne_reponse = 'La capitale de l''Empire byzantin',
  choix = '["Une ville secondaire","La capitale de l''Empire byzantin","Une cité phénicienne","Une colonie romaine mineure"]'::jsonb
WHERE enonce = 'Quel fut le rôle de Constantinople (Byzance) comme carrefour entre Orient et Occident ?';

UPDATE questions SET 
  bonne_reponse = '1492',
  choix = '["1415","1492","1519","1607"]'::jsonb
WHERE enonce = 'Quelle date marque le «premier voyage» de Christophe Colomb en Amérique et quelle en a été la conséquence pour Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Le commerce d''esclaves africains vers',
  choix = '["Un commerce de marchandises","Le commerce d''esclaves africains vers","Un échange culturel","Une migration volontaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la traite négrière transatlantique et quel fut son impact sur Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'La première révolution des colonies',
  choix = '["Un conflit purement local","La première révolution des colonies","Une guerre civile anglaise","Un conflit commercial mineur"]'::jsonb
WHERE enonce = 'Quelle est la signification de la Révolution américaine (1775-1783) dans l''histoire mondiale ?';

UPDATE questions SET 
  bonne_reponse = 'Les inégalités fiscales et sociales de',
  choix = '["Uniquement une querelle dynastique","Les inégalités fiscales et sociales de","Un coup d''État militaire simple","Une révolution purement économique"]'::jsonb
WHERE enonce = 'Quelles sont les causes et les principales phases de la Révolution française (1789) ?';

UPDATE questions SET 
  bonne_reponse = 'L''ex-esclave devenu chef militaire',
  choix = '["Un planteur français","L''ex-esclave devenu chef militaire","Un gouverneur colonial","Un révolutionnaire français"]'::jsonb
WHERE enonce = 'Quel est le rôle de Toussaint Louverture dans la révolution haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'La dernière grande bataille de la',
  choix = '["Une défaite haïtienne","La dernière grande bataille de la","Une bataille contre l''Espagne","Une rébellion interne"]'::jsonb
WHERE enonce = 'Quelle est la signification de la Bataille de Vertières (18 novembre 1803) dans l''histoire haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'C''est la seule révolution d''esclaves',
  choix = '["Elle n''est pas unique","C''est la seule révolution d''esclaves","Elle a été aidée par les États-Unis","Elle était pacifique"]'::jsonb
WHERE enonce = 'Pourquoi la révolution haïtienne de 1804 est-elle unique dans l''histoire mondiale ?';

UPDATE questions SET 
  bonne_reponse = 'La transformation économique débutée en',
  choix = '["Une révolution agricole","La transformation économique débutée en","Une révolution politique","Une révolution française"]'::jsonb
WHERE enonce = 'Qu''est-ce que la Révolution industrielle (XVIIIe-XIXe siècle) et où a-t-elle débuté ?';

UPDATE questions SET 
  bonne_reponse = 'L''expansion territoriale des puissances',
  choix = '["Un processus bénéfique","L''expansion territoriale des puissances","Un échange équitable","Un phénomène limité à l''Asie"]'::jsonb
WHERE enonce = 'Qu''est-ce que le colonialisme européen du XIXe siècle et ses justifications idéologiques ?';

UPDATE questions SET 
  bonne_reponse = 'Le paiement imposé par la France à',
  choix = '["Un don français","Le paiement imposé par la France à","Une aide internationale","Un emprunt haïtien volontaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la dette de l''indépendance haïtienne de 1825 et ses conséquences à long terme ?';

UPDATE questions SET 
  bonne_reponse = 'Les guerres menées par Napoléon',
  choix = '["Des conflits mineurs","Les guerres menées par Napoléon","Des révolutions populaires","Des guerres de religion"]'::jsonb
WHERE enonce = 'Qu''est-ce que les guerres napoléoniennes et leur impact sur l''Europe et le monde ?';

UPDATE questions SET 
  bonne_reponse = 'Un faisceau de causes',
  choix = '["Uniquement l''assassinat de Franz Ferdinand","Un faisceau de causes","Un conflit commercial uniquement","Une révolution socialiste"]'::jsonb
WHERE enonce = 'Quelles sont les principales causes de la Première Guerre mondiale (1914-1918) ?';

UPDATE questions SET 
  bonne_reponse = 'Des conditions humiliantes (clause de',
  choix = '["Des conditions modérées","Des conditions humiliantes (clause de","Un traité équitable","Un traité bénéfique pour l''Allemagne"]'::jsonb
WHERE enonce = 'Quelles sont les conséquences du Traité de Versailles (1919) sur l''Allemagne et le monde ?';

UPDATE questions SET 
  bonne_reponse = 'Le génocide systématique des Juifs',
  choix = '["Un événement mineur","Le génocide systématique des Juifs","Une guerre civile","Un bombardement isolé"]'::jsonb
WHERE enonce = 'Qu''est-ce que la Shoah (Holocauste) et combien de victimes a-t-elle causées ?';

UPDATE questions SET 
  bonne_reponse = 'Le traité humiliant de Versailles',
  choix = '["La Première Guerre mondiale seule","Le traité humiliant de Versailles","Un conflit territorial uniquement","Une révolution communiste mondiale"]'::jsonb
WHERE enonce = 'Quelles sont les principales causes de la Deuxième Guerre mondiale ?';

UPDATE questions SET 
  bonne_reponse = 'Les bombes d''Hiroshima (6 août 1945) et',
  choix = '["Elle n''a pas eu d''impact","Les bombes d''Hiroshima (6 août 1945) et","Elles ont été utilisées en Europe","Elles n''ont pas causé de victimes"]'::jsonb
WHERE enonce = 'Quel est le rôle de la bombe atomique dans la fin de la Seconde Guerre mondiale ?';

UPDATE questions SET 
  bonne_reponse = 'Une organisation internationale créée',
  choix = '["Une organisation économique","Une organisation internationale créée","Une alliance militaire","Un tribunal international uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''ONU et pourquoi a-t-elle été créée en 1945 ?';

UPDATE questions SET 
  bonne_reponse = 'Le processus d''accession à',
  choix = '["Un phénomène mineur","Le processus d''accession à","Un cadeau des puissances coloniales","Un processus uniquement africain"]'::jsonb
WHERE enonce = 'Qu''est-ce que la décolonisation et comment s''est-elle déroulée après 1945 ?';

UPDATE questions SET 
  bonne_reponse = 'L''affrontement idéologique et',
  choix = '["Un conflit armé direct","L''affrontement idéologique et","Un conflit exclusivement économique","Une alliance militaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la Guerre froide et quels en ont été les principaux moments de crise ?';

UPDATE questions SET 
  bonne_reponse = 'L''occupation américaine d''Haïti',
  choix = '["Relations inexistantes","L''occupation américaine d''Haïti","Une alliance militaire exclusive","Une relation purement commerciale"]'::jsonb
WHERE enonce = 'Quelle a été la relation entre Haïti et les États-Unis au XXe siècle, notamment l''occupation américaine ?';

UPDATE questions SET 
  bonne_reponse = 'Une dictature familiale (François',
  choix = '["Une période de démocratie","Une dictature familiale (François","Une brève parenthèse militaire","Une période de prospérité"]'::jsonb
WHERE enonce = 'Quel a été le règne des Duvalier et son impact sur Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Le renversement de Batista par Castro a',
  choix = '["Un événement mineur","Le renversement de Batista par Castro a","Une révolution pro-américaine","Une révolution pacifique sans impact"]'::jsonb
WHERE enonce = 'Quelle est la signification de la révolution cubaine de 1959 pour les Caraïbes et l''Amérique latine ?';

UPDATE questions SET 
  bonne_reponse = 'La conférence de 29 pays',
  choix = '["Un sommet des grandes puissances","La conférence de 29 pays","Un traité militaire","Une organisation économique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la Conférence de Bandung (1955) et le mouvement des Non-Alignés ?';

UPDATE questions SET 
  bonne_reponse = 'L''intensification des échanges',
  choix = '["L''uniformisation culturelle","L''intensification des échanges","Un phénomène uniquement économique","La domination américaine"]'::jsonb
WHERE enonce = 'Qu''est-ce que la mondialisation et quelles en sont les dimensions principales ?';

UPDATE questions SET 
  bonne_reponse = 'Des institutions de gouvernance',
  choix = '["Des organisations humanitaires","Des institutions de gouvernance","Des organisations militaires","Des organisations régionales uniquement"]'::jsonb
WHERE enonce = 'Quel est le rôle des organisations économiques internationales (FMI, Banque mondiale, OMC) ?';

UPDATE questions SET 
  bonne_reponse = 'Le contrôle des ressources (pétrole',
  choix = '["Les ressources n''ont pas d''impact","Le contrôle des ressources (pétrole","Les ressources sont équitablement distribuées","La géopolitique concerne uniquement les frontières"]'::jsonb
WHERE enonce = 'Qu''est-ce que la géopolitique des ressources naturelles et comment structure-t-elle les relations internationales ?';

UPDATE questions SET 
  bonne_reponse = 'L''essor du Brésil',
  choix = '["Des pays en développement mineurs","L''essor du Brésil","Un groupe exclusivement asiatique","Un regroupement commercial de niche"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''émergence des pays BRICS et leur impact sur l''ordre mondial ?';

UPDATE questions SET 
  bonne_reponse = 'Un enjeu qui menace la sécurité des',
  choix = '["Un problème purement scientifique","Un enjeu qui menace la sécurité des","Un problème limité aux pôles","Un enjeu uniquement économique"]'::jsonb
WHERE enonce = 'Qu''est-ce que le changement climatique comme enjeu géopolitique majeur du XXIe siècle ?';

UPDATE questions SET 
  bonne_reponse = 'Une organisation régionale',
  choix = '["Une organisation militaire","Une organisation régionale","Une zone de libre-échange mondiale","Un organisme des Nations Unies"]'::jsonb
WHERE enonce = 'Qu''est-ce que la Communauté des Caraïbes (CARICOM) et quel est son rôle pour Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'La diaspora haïtienne (~2 millions de',
  choix = '["Un phénomène marginal","La diaspora haïtienne (~2 millions de","La migration ne concerne pas Haïti","Un phénomène uniquement illégal"]'::jsonb
WHERE enonce = 'Qu''est-ce que la question de la migration internationale et ses enjeux pour Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Des relations complexes sur une île',
  choix = '["Des relations toujours hostiles","Des relations complexes sur une île","Des relations d''égalité totale","Des relations sans histoire"]'::jsonb
WHERE enonce = 'Comment comprendre les relations haïtiano-dominicaines dans un contexte géopolitique régional ?';

UPDATE questions SET 
  bonne_reponse = 'L''aide internationale à Haïti',
  choix = '["L''aide résout tous les problèmes","L''aide internationale à Haïti","L''aide n''a aucun effet","Haïti ne reçoit pas d''aide internationale"]'::jsonb
WHERE enonce = 'Qu''est-ce que la communauté internationale et l''aide au développement : le cas d''Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des institutions',
  choix = '["Un gouvernement mondial unifié","L''ensemble des institutions","La domination d''un seul État","Un idéal irréalisable"]'::jsonb
WHERE enonce = 'Qu''est-ce que la gouvernance mondiale et ses défis actuels ?';

UPDATE questions SET 
  bonne_reponse = 'Sa position dans la zone sismique des',
  choix = '["Elle n''influence pas la vulnérabilité","Sa position dans la zone sismique des","Sa géographie est protectrice","Sa vulnérabilité est uniquement sociale"]'::jsonb
WHERE enonce = 'Comment la géographie physique d''Haïti influence-t-elle sa vulnérabilité aux catastrophes naturelles ?';

UPDATE questions SET 
  bonne_reponse = 'La DUDH (1948) a établi des standards',
  choix = '["Un mouvement récent sans impact","La DUDH (1948) a établi des standards","Les droits de l''homme sont uniquement théoriques","Les droits sont uniquement civils et politiques"]'::jsonb
WHERE enonce = 'Quel est le mouvement mondial des droits de l''homme depuis 1948 et ses avancées et limites ?';

UPDATE questions SET 
  bonne_reponse = 'La rareté des ressources face à des',
  choix = '["La pauvreté","La rareté des ressources face à des","L''inégalité des revenus","Le chômage"]'::jsonb
WHERE enonce = 'Quel est le problème économique fondamental qui justifie l''existence de l''économie ?';

UPDATE questions SET 
  bonne_reponse = 'La valeur de la meilleure alternative',
  choix = '["Le prix d''un bien","La valeur de la meilleure alternative","Le coût de production","La taxe sur un bien"]'::jsonb
WHERE enonce = 'Qu''est-ce que le coût d''opportunité ?';

UPDATE questions SET 
  bonne_reponse = 'Le besoin est vital/essentiel',
  choix = '["Aucune","Le besoin est vital/essentiel","Le désir est économique, le besoin est biologique","Le besoin est illimité, le désir est limité"]'::jsonb
WHERE enonce = 'Quelle est la différence entre besoin et désir en économie ?';

UPDATE questions SET 
  bonne_reponse = 'Tout bien ou service rare ayant une',
  choix = '["Tout objet matériel","Tout bien ou service rare ayant une","Un bien gratuit","Un service public"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un bien économique ?';

UPDATE questions SET 
  bonne_reponse = 'Les combinaisons maximales de deux',
  choix = '["La demande totale","Les combinaisons maximales de deux","Le niveau de prix","Le PIB"]'::jsonb
WHERE enonce = 'Que représente la courbe de possibilités de production (CPP) ?';

UPDATE questions SET 
  bonne_reponse = 'Micro = comportements',
  choix = '["La microéconomie étudie les pays riches","Micro = comportements","La macro est plus précise","La micro étudie les prix mondiaux"]'::jsonb
WHERE enonce = 'Quelle est la différence entre microéconomie et macroéconomie ?';

UPDATE questions SET 
  bonne_reponse = 'Une ressource utilisée pour produire',
  choix = '["Un produit vendu","Une ressource utilisée pour produire","Un impôt","Un indicateur économique"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un facteur de production ?';

UPDATE questions SET 
  bonne_reponse = 'Le gain de satisfaction procuré par une',
  choix = '["L''utilité totale","Le gain de satisfaction procuré par une","Le prix d''un bien","La demande du marché"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''utilité marginale ?';

UPDATE questions SET 
  bonne_reponse = 'Transmettre l''information sur la rareté',
  choix = '["Fixer les salaires","Transmettre l''information sur la rareté","Redistribuer les revenus","Contrôler la production"]'::jsonb
WHERE enonce = 'Quel est le rôle du signal prix dans une économie de marché ?';

UPDATE questions SET 
  bonne_reponse = 'Un effet (positif ou négatif) d''une',
  choix = '["Un coût de production","Un effet (positif ou négatif) d''une","Un impôt sur la production","Un bien public"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une externalité en économie ?';

UPDATE questions SET 
  bonne_reponse = 'Au-delà d''un certain niveau',
  choix = '["Plus on produit, plus c''est rentable","Au-delà d''un certain niveau","Les prix baissent toujours","La productivité augmente indéfiniment"]'::jsonb
WHERE enonce = 'Qu''est-ce que la loi des rendements décroissants ?';

UPDATE questions SET 
  bonne_reponse = 'Produire à un coût d''opportunité',
  choix = '["Produire moins cher que les autres","Produire à un coût d''opportunité","Avoir la meilleure technologie","Exporter davantage qu''importer"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''avantage comparatif dans le commerce international ?';

UPDATE questions SET 
  bonne_reponse = 'Usage = utilité pour le possesseur',
  choix = '["Aucune différence","Usage = utilité pour le possesseur","Usage = prix de marché, échange = coût de production","Usage = valeur morale, échange = valeur commerciale"]'::jsonb
WHERE enonce = 'Qu''est-ce que la valeur d''usage et la valeur d''échange selon Marx ?';

UPDATE questions SET 
  bonne_reponse = 'La demande diminue',
  choix = '["La demande augmente","La demande diminue","La demande reste stable","La demande s''inverse"]'::jsonb
WHERE enonce = 'Que se passe-t-il sur la demande quand le prix d''un bien augmente (toutes choses égales) ?';

UPDATE questions SET 
  bonne_reponse = 'La sensibilité de la quantité demandée',
  choix = '["Le prix optimal","La sensibilité de la quantité demandée","La variation de l''offre","Le revenu des consommateurs"]'::jsonb
WHERE enonce = 'Que représente l''élasticité-prix de la demande ?';

UPDATE questions SET 
  bonne_reponse = 'Un bien inférieur dont la demande',
  choix = '["Un bien de luxe","Un bien inférieur dont la demande","Un bien normal","Un bien complémentaire"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un bien de Giffen ?';

UPDATE questions SET 
  bonne_reponse = 'Un bien pouvant remplacer un autre',
  choix = '["Un bien complémentaire","Un bien pouvant remplacer un autre","Un bien inférieur","Un bien Giffen"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un bien substituable ?';

UPDATE questions SET 
  bonne_reponse = 'Le prix où la quantité offerte est',
  choix = '["Le prix fixé par l''État","Le prix où la quantité offerte est","Le prix maximum","Le coût de production"]'::jsonb
WHERE enonce = 'Quel est le prix d''équilibre sur un marché concurrentiel ?';

UPDATE questions SET 
  bonne_reponse = 'La différence entre ce qu''un',
  choix = '["Le profit du producteur","La différence entre ce qu''un","L''excédent de production","Le chiffre d''affaires"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un surplus du consommateur ?';

UPDATE questions SET 
  bonne_reponse = 'Un surplus (excédent d''offre)',
  choix = '["Un déficit (pénurie)","Un surplus (excédent d''offre)","L''équilibre parfait","Une hausse de la demande"]'::jsonb
WHERE enonce = 'Que provoque un prix plancher (prix minimum légal) supérieur au prix d''équilibre ?';

UPDATE questions SET 
  bonne_reponse = 'Un marché avec de nombreux acheteurs et',
  choix = '["Quelques vendeurs dominants","Un marché avec de nombreux acheteurs et","Un monopole compétitif","Un marché régulé"]'::jsonb
WHERE enonce = 'Qu''est-ce que la concurrence parfaite ?';

UPDATE questions SET 
  bonne_reponse = 'Une situation où le marché libre',
  choix = '["Une crise boursière","Une situation où le marché libre","Un monopole naturel","Une externalité positive"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une défaillance de marché ?';

UPDATE questions SET 
  bonne_reponse = 'Un bien non rival et non excluable',
  choix = '["Un bien vendu par l''État","Un bien non rival et non excluable","Un bien subventionné","Un bien avec TVA réduite"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un bien public au sens économique ?';

UPDATE questions SET 
  bonne_reponse = 'Quand une partie dispose de plus',
  choix = '["Des prix différents selon les marchés","Quand une partie dispose de plus","Un manque de communication","La publicité mensongère"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''asymétrie d''information ?';

UPDATE questions SET 
  bonne_reponse = 'Un marché où une seule entreprise peut',
  choix = '["Un monopole illégal","Un marché où une seule entreprise peut","Un bien public","Un oligopole"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un monopole naturel ?';

UPDATE questions SET 
  bonne_reponse = 'Elle augmente l''offre et baisse le prix',
  choix = '["Elle diminue l''offre","Elle augmente l''offre et baisse le prix","Elle n''affecte pas l''offre","Elle augmente la demande seulement"]'::jsonb
WHERE enonce = 'Quel est l''effet d''une subvention sur l''offre d''un bien ?';

UPDATE questions SET 
  bonne_reponse = 'Intermédiaire des échanges',
  choix = '["Épargne, investissement, spéculation","Intermédiaire des échanges","Moyen de paiement, crédit, assurance","Production, distribution, consommation"]'::jsonb
WHERE enonce = 'Quelles sont les trois fonctions classiques de la monnaie ?';

UPDATE questions SET 
  bonne_reponse = 'Les billets, pièces et dépôts à vue',
  choix = '["Toute l''épargne nationale","Les billets, pièces et dépôts à vue","Les obligations d''État","Les réserves de change"]'::jsonb
WHERE enonce = 'Qu''est-ce que la masse monétaire M1 ?';

UPDATE questions SET 
  bonne_reponse = 'Réguler la politique monétaire',
  choix = '["Accorder des crédits aux entreprises","Réguler la politique monétaire","Gérer le budget de l''État","Superviser la bourse"]'::jsonb
WHERE enonce = 'Quel est le rôle principal d''une banque centrale ?';

UPDATE questions SET 
  bonne_reponse = 'Une hausse générale et durable du',
  choix = '["Une hausse du chômage","Une hausse générale et durable du","Une crise financière","Une baisse de la production"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''inflation ?';

UPDATE questions SET 
  bonne_reponse = 'Le taux auquel la banque centrale prête',
  choix = '["Le taux de change","Le taux auquel la banque centrale prête","Le taux d''imposition","Le taux de croissance"]'::jsonb
WHERE enonce = 'Qu''est-ce que le taux directeur d''une banque centrale ?';

UPDATE questions SET 
  bonne_reponse = 'Octroyer des crédits qui créent des',
  choix = '["Imprimer des billets","Octroyer des crédits qui créent des","Stocker de l''or","Transférer de l''argent"]'::jsonb
WHERE enonce = 'Qu''est-ce que la création monétaire par les banques commerciales ?';

UPDATE questions SET 
  bonne_reponse = 'Le prix d''une monnaie exprimé en une',
  choix = '["Le prix d''une action","Le prix d''une monnaie exprimé en une","Le taux d''intérêt","Le coût du crédit"]'::jsonb
WHERE enonce = 'Qu''est-ce que le taux de change ?';

UPDATE questions SET 
  bonne_reponse = 'Une hausse excessive des prix d''actifs',
  choix = '["Une inflation normale","Une hausse excessive des prix d''actifs","Un déficit budgétaire","Une crise de liquidité"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une bulle spéculative ?';

UPDATE questions SET 
  bonne_reponse = 'Une action',
  choix = '["Une obligation","Une action","Un bon du trésor","Un certificat de dépôt"]'::jsonb
WHERE enonce = 'Quel instrument financier représente une part de propriété dans une entreprise ?';

UPDATE questions SET 
  bonne_reponse = 'Abaisser les taux d''intérêt et',
  choix = '["Augmenter les impôts","Abaisser les taux d''intérêt et","Réduire les dépenses publiques","Limiter les crédits"]'::jsonb
WHERE enonce = 'Qu''est-ce que la politique monétaire expansionniste ?';

UPDATE questions SET 
  bonne_reponse = 'La coexistence d''inflation et de',
  choix = '["Une forte croissance avec inflation","La coexistence d''inflation et de","Une déflation rapide","Une récession sans inflation"]'::jsonb
WHERE enonce = 'Qu''est-ce que la stagflation ?';

UPDATE questions SET 
  bonne_reponse = 'Le risque qu''une défaillance locale se',
  choix = '["Le risque d''un seul emprunteur","Le risque qu''une défaillance locale se","Le risque de change","Le risque d''inflation"]'::jsonb
WHERE enonce = 'Qu''est-ce que le risque systémique dans le système financier ?';

UPDATE questions SET 
  bonne_reponse = 'La valeur totale des biens et services',
  choix = '["La valeur des exportations","La valeur totale des biens et services","Le revenu des ménages","La somme des profits des entreprises"]'::jsonb
WHERE enonce = 'Qu''est-ce que le PIB (Produit Intérieur Brut) ?';

UPDATE questions SET 
  bonne_reponse = 'Accumulation du capital',
  choix = '["Consommation et épargne","Accumulation du capital","Importations et exportations","Dépenses publiques et impôts"]'::jsonb
WHERE enonce = 'Quels sont les facteurs classiques de la croissance économique selon Solow ?';

UPDATE questions SET 
  bonne_reponse = 'Un développement qui satisfait les',
  choix = '["La croissance économique rapide","Un développement qui satisfait les","La protection de l''environnement uniquement","Le développement des pays pauvres"]'::jsonb
WHERE enonce = 'Qu''est-ce que le développement durable ?';

UPDATE questions SET 
  bonne_reponse = 'Les compétences',
  choix = '["Les machines d''une entreprise","Les compétences","Les ressources naturelles","Le capital financier"]'::jsonb
WHERE enonce = 'Qu''est-ce que le capital humain ?';

UPDATE questions SET 
  bonne_reponse = 'Deux trimestres consécutifs de',
  choix = '["Une croissance lente","Deux trimestres consécutifs de","Un chômage élevé uniquement","Une inflation forte"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une récession économique ?';

UPDATE questions SET 
  bonne_reponse = 'Une mesure composite de l''espérance de',
  choix = '["Uniquement le PIB","Une mesure composite de l''espérance de","La croissance économique","L''inégalité des revenus"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''Indice de Développement Humain (IDH) mesure ?';

UPDATE questions SET 
  bonne_reponse = 'Le processus par lequel l''innovation',
  choix = '["La crise industrielle","Le processus par lequel l''innovation","La politique budgétaire","Le protectionnisme"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "destruction créatrice" selon Schumpeter ?';

UPDATE questions SET 
  bonne_reponse = 'Une augmentation des dépenses qui',
  choix = '["Le taux de croissance","Une augmentation des dépenses qui","L''effet d''une hausse des impôts","Le ratio PIB/emploi"]'::jsonb
WHERE enonce = 'Qu''est-ce que le multiplicateur keynésien ?';

UPDATE questions SET 
  bonne_reponse = 'Les pays pauvres tendent à croître plus',
  choix = '["Les pays riches s''appauvrissent","Les pays pauvres tendent à croître plus","Les pays convergent vers la même monnaie","L''harmonisation fiscale"]'::jsonb
WHERE enonce = 'Qu''est-ce que la convergence économique en économie du développement ?';

UPDATE questions SET 
  bonne_reponse = 'Le degré d''inégalité dans la',
  choix = '["Le PIB par habitant","Le degré d''inégalité dans la","Le chômage structurel","L''inflation"]'::jsonb
WHERE enonce = 'Que mesure le coefficient de Gini ?';

UPDATE questions SET 
  bonne_reponse = 'Augmenter les dépenses en période de',
  choix = '["Augmenter les dépenses en période de","Augmenter les dépenses en récession et réduire en période de croissance forte","Équilibrer toujours le budget","Réduire la dette en toute circonstance"]'::jsonb
WHERE enonce = 'Qu''est-ce que la politique budgétaire contra-cyclique ?';

UPDATE questions SET 
  bonne_reponse = 'Échange de biens du même secteur entre',
  choix = '["Échange de biens différents","Échange de biens du même secteur entre","Commerce entre pays du Sud","Le protectionnisme sectoriel"]'::jsonb
WHERE enonce = 'Qu''est-ce que le commerce intra-branche ?';

UPDATE questions SET 
  bonne_reponse = 'Chaque pays se spécialise dans les',
  choix = '["Les pays échangent des biens identiques","Chaque pays se spécialise dans les","Le libre-échange est toujours bénéfique","Le protectionnisme augmente le bien-être"]'::jsonb
WHERE enonce = 'Quel est le théorème HOS (Heckscher-Ohlin-Samuelson) sur le commerce international ?';

UPDATE questions SET 
  bonne_reponse = 'Une taxe sur les importations qui',
  choix = '["Une taxe sur les importations qui","Une subvention aux exportateurs","Un quota d''importation","Un accord commercial"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un tarif douanier et son effet ?';

UPDATE questions SET 
  bonne_reponse = 'Une limite quantitative sur les',
  choix = '["Une taxe sur les biens importés","Une limite quantitative sur les","Une subvention à l''exportation","Un accord de libre-échange"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un quota d''importation ?';

UPDATE questions SET 
  bonne_reponse = 'La différence entre exportations et',
  choix = '["Le total des dettes d''un pays","La différence entre exportations et","Le PIB net","Le solde budgétaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la balance commerciale ?';

UPDATE questions SET 
  bonne_reponse = 'OMC (Organisation Mondiale du Commerce)',
  choix = '["FMI","Banque Mondiale","OMC (Organisation Mondiale du Commerce)","OCDE"]'::jsonb
WHERE enonce = 'Quel organisme régule le commerce international depuis 1995 ?';

UPDATE questions SET 
  bonne_reponse = 'Vendre un bien à l''étranger en dessous',
  choix = '["Exporter des matières premières","Vendre un bien à l''étranger en dessous","Un accord commercial bilatéral","Une subvention cachée"]'::jsonb
WHERE enonce = 'Qu''est-ce que le dumping dans le commerce international ?';

UPDATE questions SET 
  bonne_reponse = 'Le document qui enregistre toutes les',
  choix = '["Le budget de l''État","Le document qui enregistre toutes les","Le solde commercial","La dette extérieure"]'::jsonb
WHERE enonce = 'Qu''est-ce que la balance des paiements ?';

UPDATE questions SET 
  bonne_reponse = 'Les États-Unis exportent des biens',
  choix = '["Les États-Unis exportent des biens","Les pays pauvres exportent plus","Le libre-échange nuit aux riches","Les tarifs stimulent la croissance"]'::jsonb
WHERE enonce = 'Quel est le paradoxe de Leontief ?';

UPDATE questions SET 
  bonne_reponse = 'L''intégration croissante des marchés',
  choix = '["L''unification des monnaies","L''intégration croissante des marchés","Le commerce de marchandises","L''aide internationale"]'::jsonb
WHERE enonce = 'Qu''est-ce que la globalisation financière ?';

UPDATE questions SET 
  bonne_reponse = 'Les États-Unis',
  choix = '["Trois grandes banques","Les États-Unis","Trois matières premières","Les trois plus grands pays exportateurs"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "triade" dans le commerce mondial ?';

UPDATE questions SET 
  bonne_reponse = 'Protéger temporairement une nouvelle',
  choix = '["Protéger les industries déclinantes","Protéger temporairement une nouvelle","Restreindre toutes les importations","Subventionner les exportations"]'::jsonb
WHERE enonce = 'Quel est l''argument de l''industrie naissante pour le protectionnisme ?';

UPDATE questions SET 
  bonne_reponse = 'La désindustrialisation causée par',
  choix = '["Une pandémie économique","La désindustrialisation causée par","Un problème bancaire","Une crise de la dette"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "maladie hollandaise" ?';

UPDATE questions SET 
  bonne_reponse = 'Un accord entre pays supprimant les',
  choix = '["Un pays sans douane interne","Un accord entre pays supprimant les","Une union monétaire","Un accord tarifaire commun"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une zone de libre-échange ?';

UPDATE questions SET 
  bonne_reponse = 'Le chômage temporaire lié à la',
  choix = '["Le chômage dû à la crise","Le chômage temporaire lié à la","Le chômage de longue durée","Le sous-emploi"]'::jsonb
WHERE enonce = 'Qu''est-ce que le chômage frictionnel ?';

UPDATE questions SET 
  bonne_reponse = 'Une relation inverse entre inflation et',
  choix = '["Une relation positive entre inflation et chômage","Une relation inverse entre inflation et","Une relation entre PIB et emploi","La neutralité de la monnaie"]'::jsonb
WHERE enonce = 'Qu''est-ce que la courbe de Phillips originale (années 1960) établit ?';

UPDATE questions SET 
  bonne_reponse = 'Le taux de chômage compatible avec une',
  choix = '["Zéro chômage","Le taux de chômage compatible avec une","Le taux de chômage en pleine crise","Le plein emploi absolu"]'::jsonb
WHERE enonce = 'Qu''est-ce que le taux de chômage naturel (NAIRU) ?';

UPDATE questions SET 
  bonne_reponse = 'L''utilisation des dépenses publiques et',
  choix = '["La politique de la banque centrale","L''utilisation des dépenses publiques et","La politique commerciale","La régulation financière"]'::jsonb
WHERE enonce = 'Qu''est-ce que la politique budgétaire ?';

UPDATE questions SET 
  bonne_reponse = 'L''excès des dépenses publiques sur les',
  choix = '["La dette totale d''un pays","L''excès des dépenses publiques sur les","Le déficit commercial","L''inflation budgétaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que le déficit public ?';

UPDATE questions SET 
  bonne_reponse = 'Réduction du déficit par coupes dans',
  choix = '["Des dépenses illimitées","Réduction du déficit par coupes dans","Une politique de relance","La nationalisation d''entreprises"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''austérité budgétaire et ses effets débattus ?';

UPDATE questions SET 
  bonne_reponse = 'Des achats d''actifs par la banque',
  choix = '["Un impôt sur les transactions","Des achats d''actifs par la banque","Une réforme fiscale","Un contrôle des capitaux"]'::jsonb
WHERE enonce = 'Qu''est-ce que le quantitative easing (QE) ?';

UPDATE questions SET 
  bonne_reponse = 'Une situation où la politique monétaire',
  choix = '["Un excès d''épargne","Une situation où la politique monétaire","Une crise bancaire","Un déficit de consommation"]'::jsonb
WHERE enonce = 'Qu''est-ce que la trappe à liquidité (Keynes) ?';

UPDATE questions SET 
  bonne_reponse = 'Une règle prescrivant le taux directeur',
  choix = '["Un accord international","Une règle prescrivant le taux directeur","Un indicateur de croissance","Un modèle de change"]'::jsonb
WHERE enonce = 'Qu''est-ce que la règle de Taylor en politique monétaire ?';

UPDATE questions SET 
  bonne_reponse = 'Des dépenses publiques financées par',
  choix = '["Un effet multiplicateur positif","Des dépenses publiques financées par","Une réduction des impôts","Un effet de la politique monétaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''effet d''éviction en politique budgétaire ?';

UPDATE questions SET 
  bonne_reponse = 'La relation entre masse monétaire (M)',
  choix = '["La valeur de la monnaie","La relation entre masse monétaire (M)","Le taux de change","Le multiplicateur de crédit"]'::jsonb
WHERE enonce = 'Qu''est-ce que la théorie quantitative de la monnaie (MV = PQ) ?';

UPDATE questions SET 
  bonne_reponse = 'Ce qui est raisonnable pour un ménage',
  choix = '["Épargner est toujours bénéfique","Ce qui est raisonnable pour un ménage","L''épargne est inutile","L''investissement dépend du revenu"]'::jsonb
WHERE enonce = 'Qu''est-ce que le paradoxe de l''épargne (Keynes) ?';

UPDATE questions SET 
  bonne_reponse = 'La volatilité des marchés émergents',
  choix = '["Un type de crise agricole","La volatilité des marchés émergents","Une crise de la zone euro","Un choc pétrolier"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "taper tantrum" et quel risque illustre-t-il ?';

UPDATE questions SET 
  bonne_reponse = 'Pauvreté monétaire (seuil < 2',
  choix = '["PIB et exportations","Pauvreté monétaire (seuil < 2","Taux de change et inflation","Dette extérieure et déficit"]'::jsonb
WHERE enonce = 'Quels sont les principaux indicateurs de la pauvreté selon la Banque Mondiale ?';

UPDATE questions SET 
  bonne_reponse = 'Faible revenu → faible épargne → faible',
  choix = '["Les pauvres ne veulent pas travailler","Faible revenu → faible épargne → faible","La corruption gouvernementale","Le manque d''aide internationale"]'::jsonb
WHERE enonce = 'Qu''est-ce que le cercle vicieux de la pauvreté (Nurkse) ?';

UPDATE questions SET 
  bonne_reponse = 'Principal flux de revenus extérieurs',
  choix = '["Aucun rôle significatif","Principal flux de revenus extérieurs","Uniquement des investissements","Un fardeau pour l''économie"]'::jsonb
WHERE enonce = 'Quel rôle jouent les transferts de la diaspora pour les économies comme Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'L''appréciation de la monnaie et la',
  choix = '["Une épidémie économique","L''appréciation de la monnaie et la","Un avantage concurrentiel","La dépendance aux importations"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "dutch disease" (maladie hollandaise) appliqué aux pays pétroliers ?';

UPDATE questions SET 
  bonne_reponse = 'Des réformes libérales conditionnant',
  choix = '["Des aides sans conditions","Des réformes libérales conditionnant","Des nationalisations","Des politiques protectionnistes"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''ajustement structurel imposé par le FMI aux pays en développement ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des activités économiques',
  choix = '["L''économie souterraine criminelle","L''ensemble des activités économiques","Le secteur agricole","Le commerce de rue légal"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''économie informelle dans les pays en développement ?';

UPDATE questions SET 
  bonne_reponse = 'Une destruction d''une part considérable',
  choix = '["Un impact mineur","Une destruction d''une part considérable","Une opportunité de croissance","Un renforcement des institutions"]'::jsonb
WHERE enonce = 'Quel est l''impact du séisme de 2010 sur l''économie haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Des services financiers (microcrédit',
  choix = '["Des prêts aux grandes entreprises","Des services financiers (microcrédit","Une politique monétaire","Des subventions directes"]'::jsonb
WHERE enonce = 'Qu''est-ce que la microfinance comme outil de développement ?';

UPDATE questions SET 
  bonne_reponse = 'L''idée qu''un investissement massif et',
  choix = '["Une aide humanitaire","L''idée qu''un investissement massif et","Une politique commerciale","Un plan d''austérité"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "big push" en économie du développement (Rosenstein-Rodan) ?';

UPDATE questions SET 
  bonne_reponse = 'Les choix passés (institutions',
  choix = '["Un pays ne peut jamais changer","Les choix passés (institutions","Le développement linéaire","Le déterminisme géographique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la dépendance au sentier (path dependency) appliquée aux économies ? ';

UPDATE questions SET 
  bonne_reponse = 'Un ensemble de politiques libérales',
  choix = '["Un accord de paix","Un ensemble de politiques libérales","Un traité commercial","Une doctrine militaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que le consensus de Washington et ses critiques ?';

UPDATE questions SET 
  bonne_reponse = 'La tendance des pays pauvres et',
  choix = '["Un problème alimentaire","La tendance des pays pauvres et","La dépendance à l''aide","Le protectionnisme militaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la trappe à conflits (Paul Collier) et comment affecte-t-elle les PED ?';

UPDATE questions SET 
  bonne_reponse = 'Les institutions inclusives créent les',
  choix = '["Aucun rôle","Les institutions inclusives créent les","Seule la géographie détermine le développement","L''aide internationale suffit"]'::jsonb
WHERE enonce = 'Quel est le rôle des institutions dans le développement économique selon North et Acemoglu ?';

UPDATE questions SET 
  bonne_reponse = 'Socrate',
  choix = '["Platon","Aristote","Socrate","Thalès"]'::jsonb
WHERE enonce = 'Quel philosophe grec est considéré comme le père de la philosophie occidentale ?';

UPDATE questions SET 
  bonne_reponse = 'Amour du savoir',
  choix = '["Amour du savoir","Science de la nature","Art de la parole","Connaissance des dieux"]'::jsonb
WHERE enonce = 'Que signifie étymologiquement le mot "philosophie" ?';

UPDATE questions SET 
  bonne_reponse = 'La maïeutique',
  choix = '["La dialectique","La rhétorique","La maïeutique","La sophistique"]'::jsonb
WHERE enonce = 'Quelle est la méthode philosophique de Socrate fondée sur le dialogue ?';

UPDATE questions SET 
  bonne_reponse = 'Le logos (raison et langage)',
  choix = '["Sa force physique","Sa beauté","Le logos (raison et langage)","Sa longévité"]'::jsonb
WHERE enonce = 'Selon Aristote, l''être humain se distingue des animaux principalement par ?';

UPDATE questions SET 
  bonne_reponse = 'L''étonnement (thaumazein)',
  choix = '["La certitude","L''étonnement (thaumazein)","L''indifférence","La croyance"]'::jsonb
WHERE enonce = 'Quelle attitude intellectuelle est au fondement de la démarche philosophique selon Platon ?';

UPDATE questions SET 
  bonne_reponse = 'Doxa = opinion',
  choix = '["Aucune différence","Doxa = opinion","Doxa = science, épistémè = opinion","Doxa = forme, épistémè = matière"]'::jsonb
WHERE enonce = 'Quelle est la différence entre la doxa et l''épistémè chez Platon ?';

UPDATE questions SET 
  bonne_reponse = 'Le passage de l''ignorance à la',
  choix = '["La géographie de la Grèce","Le passage de l''ignorance à la","La nature des dieux","La politique d''Athènes"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''allégorie de la caverne de Platon illustre ?';

UPDATE questions SET 
  bonne_reponse = 'L''épistémologie',
  choix = '["L''ontologie","L''épistémologie","La métaphysique","L''éthique"]'::jsonb
WHERE enonce = 'Quelle discipline philosophique s''interroge sur la nature de la connaissance ?';

UPDATE questions SET 
  bonne_reponse = 'Réflexion sur la morale et les règles',
  choix = '["Science des lois naturelles","Réflexion sur la morale et les règles","Étude de la beauté","Théorie de la connaissance"]'::jsonb
WHERE enonce = 'Que signifie le terme "éthique" en philosophie ?';

UPDATE questions SET 
  bonne_reponse = 'Descartes',
  choix = '["Descartes","Kant","Rousseau","Locke"]'::jsonb
WHERE enonce = 'Quel philosophe a écrit "Je pense donc je suis" (Cogito ergo sum) ?';

UPDATE questions SET 
  bonne_reponse = 'Les fondements de l''être et de la',
  choix = '["Les êtres vivants","Les fondements de l''être et de la","Les lois physiques","La politique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la métaphysique étudie ?';

UPDATE questions SET 
  bonne_reponse = 'La question métaphysique fondamentale',
  choix = '["Une question de physique","La question métaphysique fondamentale","Une question d''éthique","Une question religieuse sans intérêt philosophique"]'::jsonb
WHERE enonce = 'Quelle est la question fondamentale de Leibniz : "Pourquoi y a-t-il quelque chose plutôt que rien ?" ?';

UPDATE questions SET 
  bonne_reponse = 'La métaphysique',
  choix = '["La logique","L''éthique","La métaphysique","La rhétorique"]'::jsonb
WHERE enonce = 'Que désigne la "philosophie première" chez Aristote ?';

UPDATE questions SET 
  bonne_reponse = 'L''esthétique',
  choix = '["L''éthique","L''épistémologie","L''esthétique","La logique"]'::jsonb
WHERE enonce = 'Quelle discipline philosophique étudie la beauté et l''art ?';

UPDATE questions SET 
  bonne_reponse = 'Des réalités objectives éternelles et',
  choix = '["Des représentations mentales subjectives","Des réalités objectives éternelles et","Des opinions communes","Des concepts scientifiques"]'::jsonb
WHERE enonce = 'Selon Platon, les Idées (ou Formes) sont ?';

UPDATE questions SET 
  bonne_reponse = 'La pensée en acte',
  choix = '["La certitude du monde extérieur","La pensée en acte","Le corps et l''âme réunis","Les instincts naturels"]'::jsonb
WHERE enonce = 'Quelle est la définition de la conscience chez Descartes ?';

UPDATE questions SET 
  bonne_reponse = 'L''homme est d''abord existence et se',
  choix = '["L''homme naît avec une nature déterminée","L''homme est d''abord existence et se","La conscience précède la matière","L''âme est immortelle"]'::jsonb
WHERE enonce = 'Sartre affirme que "l''existence précède l''essence". Que signifie cette formule ?';

UPDATE questions SET 
  bonne_reponse = 'La capacité de la volonté à se',
  choix = '["La liberté de faire ce qu''on veut sans contrainte","La capacité de la volonté à se","L''absence de lois","L''instinct naturel"]'::jsonb
WHERE enonce = 'Qu''est-ce que le libre arbitre ?';

UPDATE questions SET 
  bonne_reponse = 'La connaissance et l''acceptation de la',
  choix = '["L''absence de toute contrainte","La connaissance et l''acceptation de la","Le libre arbitre absolu","L''indépendance économique"]'::jsonb
WHERE enonce = 'Selon Spinoza, la liberté est ?';

UPDATE questions SET 
  bonne_reponse = 'Un faisceau de perceptions sans',
  choix = '["Une substance permanente","Un faisceau de perceptions sans","L''âme immortelle","La conscience transcendantale"]'::jsonb
WHERE enonce = 'Que désigne le "moi" dans la philosophie de Hume ?';

UPDATE questions SET 
  bonne_reponse = 'La liberté respecte la loi morale',
  choix = '["Aucune","La liberté respecte la loi morale","La licence est plus noble","La liberté est naturelle, la licence est civile"]'::jsonb
WHERE enonce = 'Quelle est la différence entre liberté et licence pour Rousseau ?';

UPDATE questions SET 
  bonne_reponse = 'Se fuir soi-même en prétendant être',
  choix = '["Le mensonge délibéré","Se fuir soi-même en prétendant être","L''ignorance des valeurs","La lâcheté morale"]'::jsonb
WHERE enonce = 'Qu''est-ce que la mauvaise foi chez Sartre ?';

UPDATE questions SET 
  bonne_reponse = 'La continuité de la conscience et de la',
  choix = '["L''âme immortelle","La continuité de la conscience et de la","Le corps physique","La volonté divine"]'::jsonb
WHERE enonce = 'Selon Locke, l''identité personnelle est fondée sur ?';

UPDATE questions SET 
  bonne_reponse = 'Kant',
  choix = '["Hegel","Kant","Descartes","Sartre"]'::jsonb
WHERE enonce = 'Quel philosophe a développé la notion de "sujet transcendantal" ?';

UPDATE questions SET 
  bonne_reponse = 'La thèse que tout événement est',
  choix = '["La croyance en la liberté totale","La thèse que tout événement est","L''indéterminisme quantique","La fatalité religieuse"]'::jsonb
WHERE enonce = 'Qu''est-ce que le déterminisme en philosophie ?';

UPDATE questions SET 
  bonne_reponse = 'Un processus dialectique de',
  choix = '["La simple introspection","Un processus dialectique de","La certitude cartésienne","L''instinct de survie"]'::jsonb
WHERE enonce = 'Que signifie la "conscience de soi" chez Hegel ?';

UPDATE questions SET 
  bonne_reponse = 'Le déterminisme n''empêche pas une forme',
  choix = '["Ils sont incompatibles","Le déterminisme n''empêche pas une forme","La liberté est une illusion","Le déterminisme est faux"]'::jsonb
WHERE enonce = 'Quelle est la position compatibiliste sur liberté et déterminisme ?';

UPDATE questions SET 
  bonne_reponse = 'La transparence de la conscience à',
  choix = '["La liberté économique","La transparence de la conscience à","La réalité du monde extérieur","Le déterminisme"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''inconscient selon Freud remet en question ?';

UPDATE questions SET 
  bonne_reponse = 'Assumer pleinement sa liberté et vivre',
  choix = '["Se conformer aux normes sociales","Assumer pleinement sa liberté et vivre","Vivre sans se soucier des autres","Rechercher le bonheur matériel"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''authenticité chez les existentialistes ?';

UPDATE questions SET 
  bonne_reponse = 'La personne a une valeur intrinsèque',
  choix = '["La personne est vivante","La personne a une valeur intrinsèque","La personne est consciente","La personne a des droits légaux"]'::jsonb
WHERE enonce = 'Selon Kant, qu''est-ce qui distingue la personne d''une chose ?';

UPDATE questions SET 
  bonne_reponse = 'L''empirisme',
  choix = '["Le rationalisme","L''empirisme","L''idéalisme","Le scepticisme"]'::jsonb
WHERE enonce = 'Quel courant philosophique affirme que toute connaissance vient de l''expérience sensible ?';

UPDATE questions SET 
  bonne_reponse = 'Le rationalisme',
  choix = '["L''empirisme","L''utilitarisme","Le rationalisme","Le pragmatisme"]'::jsonb
WHERE enonce = 'Quel courant affirme que la raison est la source principale de la connaissance vraie ?';

UPDATE questions SET 
  bonne_reponse = 'Le doute méthodique sur la possibilité',
  choix = '["La certitude absolue","Le doute méthodique sur la possibilité","L''agnosticisme religieux","Le relativisme moral"]'::jsonb
WHERE enonce = 'Qu''est-ce que le scepticisme philosophique ?';

UPDATE questions SET 
  bonne_reponse = 'Ce n''est plus l''objet qui détermine la',
  choix = '["La rotation de la Terre","Ce n''est plus l''objet qui détermine la","La fin du géocentrisme","La naissance de la physique moderne"]'::jsonb
WHERE enonce = 'Que signifie la "révolution copernicienne" de Kant en philosophie ?';

UPDATE questions SET 
  bonne_reponse = 'Kant',
  choix = '["Hume","Descartes","Kant","Hegel"]'::jsonb
WHERE enonce = 'Quel philosophe a distingué les jugements analytiques et synthétiques a priori ?';

UPDATE questions SET 
  bonne_reponse = 'Une idée est vraie si elle est utile et',
  choix = '["La vérité est éternelle","Une idée est vraie si elle est utile et","La vérité est subjective","La vérité n''existe pas"]'::jsonb
WHERE enonce = 'Qu''est-ce que le pragmatisme affirme sur la vérité ?';

UPDATE questions SET 
  bonne_reponse = 'Toutes les croyances pouvant être mises',
  choix = '["Seulement les opinions vulgaires","Toutes les croyances pouvant être mises","Uniquement la religion","La morale"]'::jsonb
WHERE enonce = 'Que réfute Descartes par son doute hyperbolique ?';

UPDATE questions SET 
  bonne_reponse = 'Une vérité connue indépendamment de',
  choix = '["Une vérité vérifiée par l''expérience","Une vérité connue indépendamment de","Une vérité probable","Une vérité empirique"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une vérité a priori ?';

UPDATE questions SET 
  bonne_reponse = 'On ne peut logiquement justifier le',
  choix = '["La déduction est impossible","On ne peut logiquement justifier le","Les mathématiques sont incertaines","Le raisonnement déductif est circulaire"]'::jsonb
WHERE enonce = 'Quel est le problème de l''induction soulevé par Hume ?';

UPDATE questions SET 
  bonne_reponse = 'Une proposition est vraie si elle',
  choix = '["La vérité est ce qui est utile","Une proposition est vraie si elle","La vérité est cohérence interne","La vérité est consensus"]'::jsonb
WHERE enonce = 'Qu''est-ce que la correspondance comme théorie de la vérité ?';

UPDATE questions SET 
  bonne_reponse = 'Toute théorie scientifique doit être',
  choix = '["Rejeter toute théorie non prouvée","Toute théorie scientifique doit être","Accepter toutes les théories","Confier la vérité à l''expérience seule"]'::jsonb
WHERE enonce = 'Qu''est-ce que le rationalisme critique de Karl Popper ?';

UPDATE questions SET 
  bonne_reponse = 'La vérité est objective',
  choix = '["Ce sont des synonymes","La vérité est objective","La certitude est objective","La vérité est plus subjective"]'::jsonb
WHERE enonce = 'Quelle est la différence entre vérité et certitude ?';

UPDATE questions SET 
  bonne_reponse = 'Habermas',
  choix = '["Nietzsche","Habermas","Foucault","Derrida"]'::jsonb
WHERE enonce = 'Quel philosophe a critiqué la "vérité comme consensus" par son éthique de la discussion ?';

UPDATE questions SET 
  bonne_reponse = 'La vérité dépend du contexte culturel',
  choix = '["La vérité est absolue","La vérité dépend du contexte culturel","L''empirie est la seule source de vérité","La logique est subjective"]'::jsonb
WHERE enonce = 'Qu''est-ce que le relativisme épistémologique ?';

UPDATE questions SET 
  bonne_reponse = 'Dire du vrai ce qui est vrai et du faux',
  choix = '["Dire du vrai ce qui est vrai et du faux","La vérité est dans les Idées de Platon","La vérité dépend de l''opinion","Toute vérité est relative à la culture"]'::jsonb
WHERE enonce = 'Quelle affirmation résume la position d''Aristote sur la vérité ?';

UPDATE questions SET 
  bonne_reponse = 'Agis seulement selon la maxime que tu',
  choix = '["Agis de manière à obtenir le plus de bonheur","Agis seulement selon la maxime que tu","Respecte les lois de ton pays","Suis tes instincts naturels"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''impératif catégorique de Kant ?';

UPDATE questions SET 
  bonne_reponse = 'La plus grande utilité pour le plus',
  choix = '["La morale du devoir","La plus grande utilité pour le plus","L''égoïsme rationnel","La vertu aristotélicienne"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''utilitarisme défend ?';

UPDATE questions SET 
  bonne_reponse = 'Un juste milieu entre deux extrêmes',
  choix = '["Le respect des lois","Un juste milieu entre deux extrêmes","L''obéissance divine","La recherche du plaisir"]'::jsonb
WHERE enonce = 'Selon Aristote, qu''est-ce que la vertu ?';

UPDATE questions SET 
  bonne_reponse = 'La morale = norme universelle',
  choix = '["Aucune","La morale = norme universelle","La morale est plus récente","L''éthique est plus contraignante"]'::jsonb
WHERE enonce = 'Quelle est la différence entre morale et éthique selon Ricoeur ?';

UPDATE questions SET 
  bonne_reponse = 'L''obligation d''agir conformément au',
  choix = '["Agir pour maximiser les conséquences positives","L''obligation d''agir conformément au","Suivre les normes sociales","Développer les vertus"]'::jsonb
WHERE enonce = 'Qu''est-ce que la morale du devoir (déontologie) ?';

UPDATE questions SET 
  bonne_reponse = 'La morale des esclaves comme',
  choix = '["L''origine divine de la morale","La morale des esclaves comme","L''évolution naturelle des normes","L''utilitarisme primitif"]'::jsonb
WHERE enonce = 'Selon Nietzsche, quelle est la "généalogie de la morale" ?';

UPDATE questions SET 
  bonne_reponse = 'Agir selon la raison et la nature',
  choix = '["Rechercher le plaisir","Agir selon la raison et la nature","Obéir aux lois civiles","Maximiser son intérêt"]'::jsonb
WHERE enonce = 'Quelle est la position stoïcienne sur la morale ?';

UPDATE questions SET 
  bonne_reponse = 'Un pacte par lequel les individus',
  choix = '["Un accord économique","Un pacte par lequel les individus","Un traité international","Une loi naturelle"]'::jsonb
WHERE enonce = 'Qu''est-ce que le contrat social selon Rousseau ?';

UPDATE questions SET 
  bonne_reponse = 'Les valeurs morales varient selon les',
  choix = '["Il existe des valeurs morales universelles","Les valeurs morales varient selon les","La morale est fondée sur Dieu","La morale naturelle prime"]'::jsonb
WHERE enonce = 'Qu''est-ce que le relativisme moral ?';

UPDATE questions SET 
  bonne_reponse = 'Un dilemme illustrant les tensions',
  choix = '["Un paradoxe économique","Un dilemme illustrant les tensions","Un exemple de logique formelle","Un problème politique"]'::jsonb
WHERE enonce = 'Quel est le paradoxe du trolley (Foot) en éthique ?';

UPDATE questions SET 
  bonne_reponse = 'Ce que ferait une personne vertueuse',
  choix = '["Ce qui respecte des règles","Ce que ferait une personne vertueuse","Ce qui maximise l''utilité","Ce qui respecte le droit"]'::jsonb
WHERE enonce = 'Selon l''éthique de la vertu, qu''est-ce qui est moral ?';

UPDATE questions SET 
  bonne_reponse = 'Une éthique centrée sur les relations',
  choix = '["Une éthique des droits individuels","Une éthique centrée sur les relations","Une éthique utilitariste","L''éthique kantienne appliquée aux soins"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''éthique du care ?';

UPDATE questions SET 
  bonne_reponse = 'Fais aux autres ce que tu voudrais',
  choix = '["Fais aux autres ce que tu voudrais","Maximise ton bonheur","Obéis toujours à l''autorité","Respecte la loi naturelle"]'::jsonb
WHERE enonce = 'Qu''est-ce que la règle d''or éthique présente dans de nombreuses traditions ?';

UPDATE questions SET 
  bonne_reponse = 'La faculté intérieure de discerner le',
  choix = '["La simple connaissance des lois","La faculté intérieure de discerner le","Le surmoi freudien uniquement","Les règles sociales intériorisées"]'::jsonb
WHERE enonce = 'Qu''est-ce que la conscience morale ?';

UPDATE questions SET 
  bonne_reponse = 'Rawls',
  choix = '["Rawls","Nozick","Habermas","Walzer"]'::jsonb
WHERE enonce = 'Quel philosophe a développé la notion de "justice comme équité" ?';

UPDATE questions SET 
  bonne_reponse = 'Montesquieu',
  choix = '["Hobbes","Locke","Montesquieu","Rousseau"]'::jsonb
WHERE enonce = 'Quel philosophe a théorisé la séparation des pouvoirs ?';

UPDATE questions SET 
  bonne_reponse = 'Un État fort issu d''un contrat social',
  choix = '["Un État minimal","Un État fort issu d''un contrat social","Un État démocratique","Un État fondé sur la religion"]'::jsonb
WHERE enonce = 'Quelle est la conception de l''État selon Hobbes dans le Léviathan ?';

UPDATE questions SET 
  bonne_reponse = 'Les citoyens participent directement',
  choix = '["Les citoyens votent pour des représentants","Les citoyens participent directement","Le gouvernement des experts","Le régime présidentiel"]'::jsonb
WHERE enonce = 'Qu''est-ce que la démocratie directe ?';

UPDATE questions SET 
  bonne_reponse = 'L''intérêt commun de tous les citoyens',
  choix = '["La somme des volontés individuelles","L''intérêt commun de tous les citoyens","La volonté du roi","L''opinion de la majorité"]'::jsonb
WHERE enonce = 'Qu''est-ce que la volonté générale chez Rousseau ?';

UPDATE questions SET 
  bonne_reponse = 'Le droit reconnu d''exercer l''autorité',
  choix = '["La force militaire","Le droit reconnu d''exercer l''autorité","Le nombre de sujets","La richesse du gouvernant"]'::jsonb
WHERE enonce = 'Qu''est-ce que la légitimité du pouvoir politique ?';

UPDATE questions SET 
  bonne_reponse = 'L''instrument de domination de la classe',
  choix = '["Un arbitre neutre","L''instrument de domination de la classe","Une institution divine","Un garant des droits naturels"]'::jsonb
WHERE enonce = 'Selon Marx, qu''est-ce que l''État dans la société capitaliste ?';

UPDATE questions SET 
  bonne_reponse = 'La politie (constitution mixte)',
  choix = '["L''oligarchie","La démocratie pure","La politie (constitution mixte)","La monarchie absolue"]'::jsonb
WHERE enonce = 'Quelle forme de gouvernement Aristote considère comme la meilleure en pratique ?';

UPDATE questions SET 
  bonne_reponse = 'La priorité des droits individuels et',
  choix = '["L''État doit contrôler l''économie","La priorité des droits individuels et","L''État doit diriger la société","La démocratie directe universelle"]'::jsonb
WHERE enonce = 'Qu''est-ce que le libéralisme politique ?';

UPDATE questions SET 
  bonne_reponse = 'Le refus non violent de se soumettre à',
  choix = '["Une rébellion armée","Le refus non violent de se soumettre à","La démocratie directe","L''anarchisme"]'::jsonb
WHERE enonce = 'Qu''est-ce que la désobéissance civile selon Thoreau ?';

UPDATE questions SET 
  bonne_reponse = 'Un régime cherchant à dominer tous les',
  choix = '["Un État autoritaire ordinaire","Un régime cherchant à dominer tous les","Une dictature militaire","Un régime monarchique absolu"]'::jsonb
WHERE enonce = 'Qu''est-ce que le totalitarisme selon Hannah Arendt ?';

UPDATE questions SET 
  bonne_reponse = 'L''État est une domination illégitime',
  choix = '["L''État est nécessaire","L''État doit être minimal","L''État est une domination illégitime","L''État doit être démocratique"]'::jsonb
WHERE enonce = 'Quelle est la position anarchiste sur l''État ?';

UPDATE questions SET 
  bonne_reponse = 'Permettre l''expression des opinions',
  choix = '["Accepter toutes les opinions comme vraies","Permettre l''expression des opinions","L''indifférence face aux injustices","L''acceptation de toute loi"]'::jsonb
WHERE enonce = 'Qu''est-ce que le principe de tolérance en philosophie politique ?';

UPDATE questions SET 
  bonne_reponse = 'Un dispositif de pensée où on choisit',
  choix = '["Un principe religieux","Un dispositif de pensée où on choisit","Un type de censure","Un mythe philosophique"]'::jsonb
WHERE enonce = 'Qu''est-ce que le voile d''ignorance de Rawls ?';

UPDATE questions SET 
  bonne_reponse = 'Négative = absence de contrainte',
  choix = '["Aucune","Négative = absence de contrainte","Négative est plus récente","Positive est plus libérale"]'::jsonb
WHERE enonce = 'Quelle est la différence entre liberté négative et positive selon Berlin ?';

UPDATE questions SET 
  bonne_reponse = 'Les philosophes-rois',
  choix = '["Les guerriers","Les philosophes-rois","Les artisans","Le peuple"]'::jsonb
WHERE enonce = 'Selon Platon dans La République, qui devrait gouverner la cité idéale ?';

UPDATE questions SET 
  bonne_reponse = 'C''est une imitation d''imitation',
  choix = '["Il est trop coûteux","C''est une imitation d''imitation","Il distrait les guerriers","Il glorifie les tyrans"]'::jsonb
WHERE enonce = 'Selon Platon, pourquoi l''art est-il une menace pour la cité idéale ?';

UPDATE questions SET 
  bonne_reponse = 'Une émotion face à ce qui dépasse notre',
  choix = '["La beauté parfaite","Une émotion face à ce qui dépasse notre","L''art classique","La beauté naturelle"]'::jsonb
WHERE enonce = 'Qu''est-ce que le sublime chez Kant ?';

UPDATE questions SET 
  bonne_reponse = 'Kant',
  choix = '["Hegel","Nietzsche","Kant","Heidegger"]'::jsonb
WHERE enonce = 'Quel philosophe a théorisé l''art comme "jeu libre" des facultés (imagination et entendement) ?';

UPDATE questions SET 
  bonne_reponse = 'L''art est le devenir de l''Esprit absolu',
  choix = '["L''art est éternel","L''art est le devenir de l''Esprit absolu","L''art décline progressivement","L''art est purement subjectif"]'::jsonb
WHERE enonce = 'Selon Hegel, quel est le sens de l''histoire de l''art ?';

UPDATE questions SET 
  bonne_reponse = 'La philosophie et la religion ont',
  choix = '["L''art a disparu","La philosophie et la religion ont","Les artistes sont morts","L''art est devenu commercial"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "mort de l''art" selon Hegel ?';

UPDATE questions SET 
  bonne_reponse = 'Les limites de mon monde',
  choix = '["Les limites de ma culture","Les limites de mon monde","Les limites de ma grammaire","Les limites de la logique"]'::jsonb
WHERE enonce = 'Selon Wittgenstein, les limites de mon langage signifient ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des pratiques sociales dans',
  choix = '["Une métaphore littéraire","L''ensemble des pratiques sociales dans","Un exercice logique","Un jeu de mots"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "jeu de langage" chez Wittgenstein tardif ?';

UPDATE questions SET 
  bonne_reponse = 'Austin',
  choix = '["Saussure","Chomsky","Austin","Searle seulement"]'::jsonb
WHERE enonce = 'Quel philosophe a développé la théorie des actes de langage (speech acts) ?';

UPDATE questions SET 
  bonne_reponse = 'Le signe est arbitraire (lien',
  choix = '["Aucune","Le signe est arbitraire (lien","Le symbole est plus abstrait","Le signe est iconique"]'::jsonb
WHERE enonce = 'Quelle est la différence entre signe et symbole selon Saussure ?';

UPDATE questions SET 
  bonne_reponse = 'L''art de l''interprétation des textes et',
  choix = '["L''analyse logique","L''art de l''interprétation des textes et","La sémiologie","La phénoménologie"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''herméneutique selon Gadamer ?';

UPDATE questions SET 
  bonne_reponse = 'Apollinien = ordre',
  choix = '["Apollinien = ordre","Apollinien = beau, dionysiaque = vrai","Apollinien = art classique, dionysiaque = art moderne","Apollinien = plastique, dionysiaque = musique uniquement"]'::jsonb
WHERE enonce = 'Selon Nietzsche, quelle est la vision apollinienne et dionysiaque de l''art ?';

UPDATE questions SET 
  bonne_reponse = 'La reproduction technique détruit',
  choix = '["La photographie est mauvaise","La reproduction technique détruit","L''art moderne est dégénéré","Le cinéma n''est pas un art"]'::jsonb
WHERE enonce = 'Que critique Benjamin dans "L''œuvre d''art à l''ère de sa reproductibilité technique" ?';

UPDATE questions SET 
  bonne_reponse = 'Une lecture qui dévoile les tensions et',
  choix = '["La destruction des textes","Une lecture qui dévoile les tensions et","Une méthode scientifique","La critique littéraire classique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la déconstruction chez Derrida ?';

UPDATE questions SET 
  bonne_reponse = 'Nietzsche',
  choix = '["Platon","Hegel","Nietzsche","Schopenhauer"]'::jsonb
WHERE enonce = 'Quel philosophe a dit que "la vérité est femme" en parlant de la philosophie ?';

UPDATE questions SET 
  bonne_reponse = 'Elle "met en œuvre la vérité" en',
  choix = '["Elle imite la réalité","Elle "met en œuvre la vérité" en","Elle divertit","Elle embellit le monde"]'::jsonb
WHERE enonce = 'Selon Heidegger, que fait l''œuvre d''art ?';

UPDATE questions SET 
  bonne_reponse = 'L''argument de la contingence',
  choix = '["L''argument ontologique","L''argument de la contingence","L''argument moral","L''argument du pari"]'::jsonb
WHERE enonce = 'Quel argument cosmologique classique tente de prouver l''existence de Dieu ?';

UPDATE questions SET 
  bonne_reponse = 'L''idée d''un être parfait implique son',
  choix = '["Dieu est cause du monde","L''idée d''un être parfait implique son","La complexité du monde prouve Dieu","Dieu est moral"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''argument ontologique de saint Anselme ?';

UPDATE questions SET 
  bonne_reponse = 'Il vaut mieux croire en Dieu car si',
  choix = '["Il vaut mieux croire en Dieu car si","La prière est rationnelle","La foi est supérieure à la raison","Dieu est évident"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "pari de Pascal" ?';

UPDATE questions SET 
  bonne_reponse = 'Nietzsche',
  choix = '["Marx","Nietzsche","Feuerbach","Comte"]'::jsonb
WHERE enonce = 'Quel philosophe a affirmé que "Dieu est mort" ?';

UPDATE questions SET 
  bonne_reponse = 'Si Dieu est bon et tout-puissant',
  choix = '["Pourquoi les hommes font le mal","Si Dieu est bon et tout-puissant","La question du péché originel","Le problème de la punition divine"]'::jsonb
WHERE enonce = 'Qu''est-ce que le problème du mal (théodicée) ?';

UPDATE questions SET 
  bonne_reponse = 'Retour aux choses mêmes par suspension',
  choix = '["L''étude des phénomènes naturels","Retour aux choses mêmes par suspension","La philosophie du langage","Le structuralisme"]'::jsonb
WHERE enonce = 'Qu''est-ce que la phénoménologie de Husserl ?';

UPDATE questions SET 
  bonne_reponse = 'L''existence humaine est',
  choix = '["Vivre sur la Terre","L''existence humaine est","L''homme est un animal","La finitude humaine"]'::jsonb
WHERE enonce = 'Que signifie "être-dans-le-monde" chez Heidegger ?';

UPDATE questions SET 
  bonne_reponse = 'La recherche des structures',
  choix = '["L''étude des structures sociales","La recherche des structures","Une méthode historique","L''analyse des institutions"]'::jsonb
WHERE enonce = 'Qu''est-ce que le structuralisme en philosophie (Lévi-Strauss, Saussure, Lacan) ?';

UPDATE questions SET 
  bonne_reponse = 'Les structures stables',
  choix = '["La nécessité de la philosophie","Les structures stables","La science","La politique"]'::jsonb
WHERE enonce = 'Qu''est-ce que le post-structuralisme (Derrida, Foucault, Deleuze) remet en question ?';

UPDATE questions SET 
  bonne_reponse = 'La force créatrice fondamentale qui',
  choix = '["Le désir de dominer autrui","La force créatrice fondamentale qui","L''instinct de mort","La politique du fort"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "volonté de puissance" chez Nietzsche ?';

UPDATE questions SET 
  bonne_reponse = 'Un réseau diffus de relations qui',
  choix = '["La force militaire","Un réseau diffus de relations qui","L''État seul","L''autorité des experts"]'::jsonb
WHERE enonce = 'Selon Foucault, qu''est-ce que le pouvoir ?';

UPDATE questions SET 
  bonne_reponse = 'Les structures de domination',
  choix = '["Le rationalisme","Les structures de domination","La logique formelle","La métaphysique classique"]'::jsonb
WHERE enonce = 'Qu''est-ce que le féminisme philosophique remet en question ?';

UPDATE questions SET 
  bonne_reponse = 'La féminité est une construction',
  choix = '["La biologie détermine le sexe","La féminité est une construction","Les femmes sont plus évoluées","Le genre est inné"]'::jsonb
WHERE enonce = 'Que signifie "On ne naît pas femme, on le devient" (Beauvoir) ?';

UPDATE questions SET 
  bonne_reponse = 'Responsabilité envers les générations',
  choix = '["Responsabilité des actes passés","Responsabilité envers les générations","Responsabilité civile","Responsabilité juridique"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''éthique de la responsabilité selon Jonas ?';

UPDATE questions SET 
  bonne_reponse = 'La structure de la conscience qui se',
  choix = '["La communication entre sujets","La structure de la conscience qui se","L''objectivité scientifique","La subjectivité absolue"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''intersubjectivité en philosophie contemporaine ?';

UPDATE questions SET 
  bonne_reponse = 'Un ensemble de croyances',
  choix = '["Un exemple de raisonnement","Un ensemble de croyances","Une théorie réfutée","Un modèle mathématique"]'::jsonb
WHERE enonce = 'Selon Kuhn, qu''est-ce qu''un paradigme scientifique ?';

UPDATE questions SET 
  bonne_reponse = 'Le remplacement d''un paradigme par un',
  choix = '["Un progrès graduel","Le remplacement d''un paradigme par un","Une découverte importante","Un changement de méthode"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une révolution scientifique selon Kuhn ?';

UPDATE questions SET 
  bonne_reponse = 'Les théories scientifiques décrivent la',
  choix = '["Les théories sont de simples outils","Les théories scientifiques décrivent la","La science est une construction sociale","Seul ce qui est observable existe"]'::jsonb
WHERE enonce = 'Qu''est-ce que le réalisme scientifique ?';

UPDATE questions SET 
  bonne_reponse = 'Les théories sont des instruments de',
  choix = '["Les théories décrivent la réalité","Les théories sont des instruments de","La science est infaillible","Toute théorie est vraie"]'::jsonb
WHERE enonce = 'Quelle est la position de l''instrumentalisme en philosophie des sciences ?';

UPDATE questions SET 
  bonne_reponse = 'Les mêmes données empiriques peuvent',
  choix = '["Les théories manquent de données","Les mêmes données empiriques peuvent","Les théories sont trop complexes","Les expériences sont subjectives"]'::jsonb
WHERE enonce = 'Qu''est-ce que le problème de la sous-détermination des théories ?';

UPDATE questions SET 
  bonne_reponse = 'Toutes les propositions scientifiques',
  choix = '["Toutes les sciences utilisent les mathématiques","Toutes les propositions scientifiques","Les sciences sociales sont fausses","La physique prime sur tout"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''unité des sciences selon le positivisme logique (Cercle de Vienne) ?';

UPDATE questions SET 
  bonne_reponse = 'L''épistémologie doit devenir une',
  choix = '["L''épistémologie doit rester normative","L''épistémologie doit devenir une","La connaissance est a priori","La logique est fondement de tout"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''épistémologie naturalisée de Quine ?';

UPDATE questions SET 
  bonne_reponse = 'Une théorie ne peut être testée',
  choix = '["Chaque théorie est testée isolément","Une théorie ne peut être testée","Toutes les théories sont vraies ensemble","Le holisme est une position religieuse"]'::jsonb
WHERE enonce = 'Qu''est-ce que le holisme épistémologique (Duhem-Quine) ?';

UPDATE questions SET 
  bonne_reponse = 'Expliquer les phénomènes complexes en',
  choix = '["Simplifier les théories","Expliquer les phénomènes complexes en","Rejeter les grandes théories","La méthode historique"]'::jsonb
WHERE enonce = 'Qu''est-ce que le réductionnisme en philosophie des sciences ?';

UPDATE questions SET 
  bonne_reponse = 'Traiter un système complexe uniquement',
  choix = '["Un ordinateur mystérieux","Traiter un système complexe uniquement","Une théorie secrète","Un problème insoluble"]'::jsonb
WHERE enonce = 'Qu''est-ce que le concept de "boîte noire" en épistémologie ?';

UPDATE questions SET 
  bonne_reponse = 'Un noyau dur de postulats entourés',
  choix = '["Une seule théorie","Un noyau dur de postulats entourés","Un paradigme au sens de Kuhn","Un ensemble d''observations"]'::jsonb
WHERE enonce = 'Selon Lakatos, qu''est-ce qu''un programme de recherche scientifique ?';

UPDATE questions SET 
  bonne_reponse = 'L''anarchisme scientifique',
  choix = '["L''anarchisme scientifique","La tolérance morale","L''absence de vérité","Le relativisme absolu en morale"]'::jsonb
WHERE enonce = 'Que signifie "tout est bon" (anything goes) chez Feyerabend ?';

UPDATE questions SET 
  bonne_reponse = 'La production sociale des faits',
  choix = '["Les lois de la nature","La production sociale des faits","La logique des théories","La psychologie des chercheurs"]'::jsonb
WHERE enonce = 'Qu''est-ce que la sociologie des sciences (Bloor, Latour) étudie ?';

UPDATE questions SET 
  bonne_reponse = 'Comment une théorie explique un',
  choix = '["Trouver les causes premières","Comment une théorie explique un","La causalité divine","La corrélation statistique"]'::jsonb
WHERE enonce = 'Qu''est-ce que le problème de l''explication causale en philosophie des sciences ?';

UPDATE questions SET 
  bonne_reponse = 'Plusieurs traductions radicalement',
  choix = '["On ne peut pas traduire les langues mortes","Plusieurs traductions radicalement","La traduction est subjective","Les langues sont incommensurables"]'::jsonb
WHERE enonce = 'Que signifie l''indétermination de la traduction chez Quine ?';

UPDATE questions SET 
  bonne_reponse = 'L''Esprit absolu (Geist) vers la pleine',
  choix = '["La Providence divine","L''Esprit absolu (Geist) vers la pleine","La nature","Les forces économiques"]'::jsonb
WHERE enonce = 'Selon Hegel, l''histoire est le déploiement de quoi ?';

UPDATE questions SET 
  bonne_reponse = 'Les forces et rapports de production',
  choix = '["Les idées des grands hommes","Les forces et rapports de production","La religion","Le hasard"]'::jsonb
WHERE enonce = 'Selon Marx, qu''est-ce qui détermine l''histoire ?';

UPDATE questions SET 
  bonne_reponse = 'La Raison use des passions et intérêts',
  choix = '["La tromperie des philosophes","La Raison use des passions et intérêts","Le cynisme politique","L''ironie socratique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "ruse de la raison" (List der Vernunft) chez Hegel ?';

UPDATE questions SET 
  bonne_reponse = 'La victoire définitive de la démocratie',
  choix = '["La destruction de la civilisation","La victoire définitive de la démocratie","Le déclin de l''Occident","L''apocalypse"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "fin de l''histoire" selon Fukuyama ?';

UPDATE questions SET 
  bonne_reponse = 'La raison instrumentale et la',
  choix = '["La démocratie","La raison instrumentale et la","La science naturelle","Le marxisme orthodoxe"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''École de Francfort (Horkheimer, Adorno, Marcuse) critique ?';

UPDATE questions SET 
  bonne_reponse = 'La vie sociale remplacée par une',
  choix = '["Le cinéma","La vie sociale remplacée par une","La politique démocratique","Le capitalisme industriel"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "société du spectacle" selon Debord ?';

UPDATE questions SET 
  bonne_reponse = 'L''absence de pensée critique chez des',
  choix = '["La volonté de mal","L''absence de pensée critique chez des","Le totalitarisme ordinaire","La cruauté calculée"]'::jsonb
WHERE enonce = 'Quel concept d''Arendt désigne la banalité du mal dans le nazisme ?';

UPDATE questions SET 
  bonne_reponse = 'La méfiance envers les grands récits de',
  choix = '["Le retour aux Lumières","La méfiance envers les grands récits de","Le structuralisme renouvelé","Le néo-marxisme"]'::jsonb
WHERE enonce = 'Qu''est-ce que le postmodernisme en philosophie selon Lyotard ?';

UPDATE questions SET 
  bonne_reponse = 'Les futurs conflits seront culturels et',
  choix = '["L''accord universel","Les futurs conflits seront culturels et","La fin de la géopolitique","L''unification mondiale"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "choc des civilisations" selon Huntington ?';

UPDATE questions SET 
  bonne_reponse = 'L''universalisme européen et la',
  choix = '["Les sciences naturelles","L''universalisme européen et la","La démocratie","La modernité technique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la philosophie décoloniale (Quijano, Dussel) conteste ?';

UPDATE questions SET 
  bonne_reponse = 'Ces penseurs remettent en question la',
  choix = '["La suspicion envers les autres","Ces penseurs remettent en question la","La critique littéraire","Le doute cartésien renouvelé"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''herméneutique des soupçons selon Ricoeur (Marx, Nietzsche, Freud) ?';

UPDATE questions SET 
  bonne_reponse = 'Le déplacement de l''attention vers le',
  choix = '["L''étude des langues étrangères","Le déplacement de l''attention vers le","La grammaire structurale","La traductologie"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "tournant linguistique" (linguistic turn) en philosophie du XXe siècle ?';

UPDATE questions SET 
  bonne_reponse = 'L''image dialectique qui cristallise le',
  choix = '["Le marxisme sans lutte","L''image dialectique qui cristallise le","La fin du temps","L''instant statique"]'::jsonb
WHERE enonce = 'Selon Benjamin, qu''est-ce que la "dialectique à l''arrêt" ?';

UPDATE questions SET 
  bonne_reponse = 'Un besoin fondamental que les individus',
  choix = '["La connaissance des autres","Un besoin fondamental que les individus","L''identité nationale","La solidarité économique"]'::jsonb
WHERE enonce = 'Qu''est-ce que le concept de "reconnaissance" (Anerkennung) chez Honneth ?';

UPDATE questions SET 
  bonne_reponse = 'La fluidification des identités',
  choix = '["Un progrès uniforme","La fluidification des identités","L''uniformisation culturelle","La disparition des États"]'::jsonb
WHERE enonce = 'Qu''est-ce que la mondialisation selon Bauman (modernité liquide) ?';

UPDATE questions SET 
  bonne_reponse = 'Le système binaire (base 2)',
  choix = '["Le système décimal (base 10)", "Le système binaire (base 2)", "Le système hexadécimal (base 16)", "Le système octal (base 8)"]'::jsonb
WHERE enonce = 'Quel est le système de numération utilisé par les ordinateurs en interne ?';

UPDATE questions SET 
  bonne_reponse = '10',
  choix = '["8", "10", "12", "15"]'::jsonb
WHERE enonce = 'Que représente le nombre binaire 1010 en décimal ?';

UPDATE questions SET 
  bonne_reponse = '256',
  choix = '["8", "16", "128", "256"]'::jsonb
WHERE enonce = 'Combien de valeurs différentes peut représenter un octet (8 bits) ?';

UPDATE questions SET 
  bonne_reponse = 'Un bit est la plus petite unité',
  choix = '["Ce sont des synonymes", "Un bit est la plus petite unité", "Un bit représente une lettre ; un octet représente un chiffre", "Un octet est plus petit qu''un bit"]'::jsonb
WHERE enonce = 'Quelle est la différence entre un bit et un octet ?';

UPDATE questions SET 
  bonne_reponse = 'Un standard qui associe chaque',
  choix = '["Un code de programmation pour créer des interfaces graphiques", "Un standard qui associe chaque", "Un protocole de communication entre ordinateurs sur Internet", "Un système de compression de fichiers"]'::jsonb
WHERE enonce = 'Qu''est-ce que le code ASCII et à quoi sert-il ?';

UPDATE questions SET 
  bonne_reponse = '1101',
  choix = '["1101", "1011", "1110", "1001"]'::jsonb
WHERE enonce = 'Comment convertir le nombre décimal 13 en binaire ?';

UPDATE questions SET 
  bonne_reponse = 'La mémoire vive',
  choix = '["La mémoire de stockage permanente des données", "La mémoire vive", "Le disque dur de l''ordinateur", "La mémoire graphique de la carte vidéo"]'::jsonb
WHERE enonce = 'Qu''est-ce que la mémoire RAM d''un ordinateur ?';

UPDATE questions SET 
  bonne_reponse = 'Le système d''exploitation (OS) gère les',
  choix = '["Ce sont des synonymes", "Le système d''exploitation (OS) gère les", "L''OS est payant ; les applications sont gratuites", "L''OS fonctionne sur Internet ; les applications sur l''ordinateur"]'::jsonb
WHERE enonce = 'Quelle est la différence entre un système d''exploitation et une application ?';

UPDATE questions SET 
  bonne_reponse = 'Un ensemble de données stockées sous un',
  choix = '["Un programme en cours d''exécution", "Un ensemble de données stockées sous un", "Une connexion réseau entre deux ordinateurs", "Un composant matériel de l''ordinateur"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "fichier" en informatique ?';

UPDATE questions SET 
  bonne_reponse = 'Un système de numération en base 16',
  choix = '["Un système de numération en base 16", "Un système de numération en base 12 utilisé pour les calculs scientifiques", "Un type de code de programmation pour les jeux vidéo", "Un protocole de communication réseau"]'::jsonb
WHERE enonce = 'Qu''est-ce que le système hexadécimal et pour quoi est-il utilisé en informatique ?';

UPDATE questions SET 
  bonne_reponse = 'La RAM est rapide et volatile',
  choix = '["La RAM est plus grande ; le disque dur est plus petit", "La RAM est rapide et volatile", "La RAM stocke des fichiers ; le disque dur stocke des programmes", "Il n''y a pas de différence fonctionnelle"]'::jsonb
WHERE enonce = 'Quelle est la différence entre la mémoire RAM et le disque dur (SSD/HDD) ?';

UPDATE questions SET 
  bonne_reponse = 'Le composant qui exécute les',
  choix = '["Le composant qui affiche l''image sur l''écran", "Le composant qui exécute les", "Le composant qui stocke les données de façon permanente", "Le composant qui gère la connexion Internet"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "processeur" (CPU) et quel est son rôle ?';

UPDATE questions SET 
  bonne_reponse = 'On inverse tous les bits du nombre',
  choix = '["On ajoute un signe moins devant le nombre binaire", "On inverse tous les bits du nombre", "On met le bit de poids fort à 1 uniquement", "Les ordinateurs ne peuvent pas représenter les nombres négatifs"]'::jsonb
WHERE enonce = 'Comment représente-t-on un nombre négatif en informatique avec la notation en "complément à deux" ?';

UPDATE questions SET 
  bonne_reponse = 'La convention qui définit comment les',
  choix = '["Une technique de compression des fichiers", "La convention qui définit comment les", "Un procédé de sécurisation des données par chiffrement", "La méthode d''organisation des fichiers sur le disque dur"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"encodage" des données et pourquoi est-il important ?';

UPDATE questions SET 
  bonne_reponse = 'Un modèle d''ordinateur avec une unité',
  choix = '["Une architecture graphique pour les interfaces utilisateur", "Un modèle d''ordinateur avec une unité", "Une architecture matérielle uniquement pour les superordinateurs", "Un système d''exploitation développé dans les années 1940"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''architecture "Von Neumann" sur laquelle sont basés la plupart des ordinateurs modernes ?';

UPDATE questions SET 
  bonne_reponse = 'Une suite d''instructions finies et',
  choix = '["Un programme informatique écrit dans un langage de programmation spécifique", "Une suite d''instructions finies et", "Un type de matériel informatique pour accélérer les calculs", "Un virus informatique qui se reproduit automatiquement"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un algorithme ?';

UPDATE questions SET 
  bonne_reponse = 'Elle exécute différentes instructions',
  choix = '["Elle répète des instructions plusieurs fois", "Elle exécute différentes instructions", "Elle définit une nouvelle variable", "Elle appelle une fonction externe"]'::jsonb
WHERE enonce = 'Que fait une structure "conditionnelle" (if/else) en programmation ?';

UPDATE questions SET 
  bonne_reponse = 'La boucle ''for'' répète un nombre connu',
  choix = '["Elles font exactement la même chose", "La boucle ''for'' répète un nombre connu", "La boucle ''for'' est plus rapide que la boucle ''while''", "La boucle ''for'' est pour les chiffres ; la boucle ''while'' est pour les textes"]'::jsonb
WHERE enonce = 'Quelle est la différence entre une boucle "for" et une boucle "while" ?';

UPDATE questions SET 
  bonne_reponse = 'Un espace nommé en mémoire qui stocke',
  choix = '["Un type de boucle particulier", "Un espace nommé en mémoire qui stocke", "Une instruction qui arrête le programme", "Une connexion réseau dans le programme"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "variable" en programmation ?';

UPDATE questions SET 
  bonne_reponse = 'O(n) - linéaire',
  choix = '["O(1) - temps constant", "O(log n) - logarithmique", "O(n) - linéaire", "O(n²) - quadratique"]'::jsonb
WHERE enonce = 'Quelle est la complexité temporelle d''un algorithme de recherche linéaire dans un tableau non trié de n éléments ?';

UPDATE questions SET 
  bonne_reponse = 'Un bloc de code nommé et réutilisable',
  choix = '["Un type de variable qui stocke plusieurs valeurs", "Un bloc de code nommé et réutilisable", "Une boucle qui s''appelle elle-même", "Un commentaire dans le code"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "fonction" (ou procédure) en programmation ?';

UPDATE questions SET 
  bonne_reponse = 'Une collection ordonnée d''éléments du',
  choix = '["Un programme organisé en tableaux", "Une collection ordonnée d''éléments du", "Un type de variable qui ne peut contenir qu''un seul chiffre", "Une connexion entre deux fonctions"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "tableau" (ou liste) comme structure de données ?';

UPDATE questions SET 
  bonne_reponse = 'Le processus d''identification et de',
  choix = '["L''action d''écrire un nouveau programme", "Le processus d''identification et de", "La compression d''un programme pour le rendre plus petit", "La traduction d''un programme d''un langage à un autre"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "débogage" (debugging) en programmation ?';

UPDATE questions SET 
  bonne_reponse = 'Un tri qui recherche le minimum',
  choix = '["Un tri qui sélectionne aléatoirement les éléments ; complexité O(1)", "Un tri qui recherche le minimum", "Un tri qui divise le tableau en deux à chaque étape ; complexité O(n log n)", "Un tri qui compare des paires adjacentes et les échange ; complexité O(n)"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''algorithme de tri par sélection et quelle est sa complexité ?';

UPDATE questions SET 
  bonne_reponse = 'Une technique où une fonction s''appelle',
  choix = '["Une technique pour accélérer les boucles", "Une technique où une fonction s''appelle", "Un type de variable qui se duplique", "Un algorithme qui trie les données de façon récurrente"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "récursivité" en programmation ?';

UPDATE questions SET 
  bonne_reponse = 'Un compilateur traduit l''intégralité du',
  choix = '["Ce sont des synonymes", "Un compilateur traduit l''intégralité du", "Un compilateur est pour les langages web ; un interpréteur pour les logiciels de bureau", "Un compilateur est plus lent qu''un interpréteur"]'::jsonb
WHERE enonce = 'Quelle est la différence entre un "compilateur" et un "interpréteur" ?';

UPDATE questions SET 
  bonne_reponse = 'Une façon d''organiser et de stocker les',
  choix = '["Le style de codage utilisé par un programmeur", "Une façon d''organiser et de stocker les", "La taille totale des données d''un programme", "La disposition visuelle du code source"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "structure de données" et pourquoi son choix est-il important ?';

UPDATE questions SET 
  bonne_reponse = 'Une structure LIFO (Last In, First Out)',
  choix = '["Une structure d''accès aléatoire par indice", "Une structure LIFO (Last In, First Out)", "Une structure FIFO (First In, First Out) : le premier ajouté est le premier retiré", "Une structure arborescente avec des nœuds parents et enfants"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "pile" (stack) comme structure de données et quel principe suit-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Une description informelle d''un',
  choix = '["Un code informatique illégal ou non officiel", "Une description informelle d''un", "Un code écrit dans un langage de programmation obsolète", "Un code généré automatiquement par un compilateur"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "pseudo-code" et pourquoi l''utilise-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'Un identifiant numérique unique',
  choix = '["Un identifiant numérique unique", "Le mot de passe d''une connexion Wi-Fi", "Le nom de domaine d''un site web", "La vitesse de connexion Internet en Mbps"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une adresse IP et à quoi sert-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Des protocoles de transfert de données',
  choix = '["Des types de connexions Wi-Fi", "Des protocoles de transfert de données", "Des systèmes d''exploitation pour serveurs web", "Des langages de programmation pour créer des sites web"]'::jsonb
WHERE enonce = 'Qu''est-ce que le protocole HTTP et HTTPS ?';

UPDATE questions SET 
  bonne_reponse = 'Un équipement réseau qui aiguille les',
  choix = '["Un appareil qui stocke des sites web en cache", "Un équipement réseau qui aiguille les", "Un logiciel de sécurité qui bloque les virus", "Un câble de connexion entre deux ordinateurs"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "routeur" dans un réseau informatique ?';

UPDATE questions SET 
  bonne_reponse = 'La suite de protocoles fondamentaux',
  choix = '["Un langage de programmation pour créer des applications réseau", "La suite de protocoles fondamentaux", "Un système d''exploitation pour les serveurs web", "Un protocole de sécurité pour les communications chiffrées"]'::jsonb
WHERE enonce = 'Qu''est-ce que le protocole TCP/IP et pourquoi est-il fondamental sur Internet ?';

UPDATE questions SET 
  bonne_reponse = 'Un service qui traduit les noms de',
  choix = '["Un système de sécurité qui protège les sites web des hackers", "Un service qui traduit les noms de", "Un protocole de transfert de fichiers entre ordinateurs", "Un type de connexion Internet haute vitesse"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "DNS" (Domain Name System) ?';

UPDATE questions SET 
  bonne_reponse = 'Internet est le réseau physique mondial',
  choix = '["Ce sont des synonymes", "Internet est le réseau physique mondial", "Internet est accessible uniquement par ordinateur ; le Web est accessible par smartphone", "Internet est gratuit ; le Web est payant"]'::jsonb
WHERE enonce = 'Quelle est la différence entre Internet et le Web (World Wide Web) ?';

UPDATE questions SET 
  bonne_reponse = 'Un système de sécurité réseau qui',
  choix = '["Un logiciel qui accélère la connexion Internet", "Un système de sécurité réseau qui", "Un type de routeur haute performance", "Un antivirus qui scanne les fichiers téléchargés"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "pare-feu" (firewall) et quel est son rôle ?';

UPDATE questions SET 
  bonne_reponse = 'L''adresse MAC est un identifiant',
  choix = '["Elles sont identiques", "L''adresse MAC est un identifiant", "L''adresse MAC est pour les ordinateurs Apple ; l''adresse IP pour les autres", "L''adresse MAC identifie un réseau ; l''adresse IP identifie un appareil"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "adresse MAC" et en quoi diffère-t-elle d''une adresse IP ?';

UPDATE questions SET 
  bonne_reponse = 'Une technologie de réseau sans fil qui',
  choix = '["Un câble de connexion réseau haute vitesse", "Une technologie de réseau sans fil qui", "Un protocole de sécurité pour les connexions Internet", "Un type de connexion satellite pour les zones rurales"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "Wi-Fi" et comment fonctionne-t-il ?';

UPDATE questions SET 
  bonne_reponse = 'Un modèle de référence à 7 couches pour',
  choix = '["Un modèle de programmation orientée objet à 3 couches", "Un modèle de référence à 7 couches pour", "Un système d''exploitation pour serveurs à 5 niveaux de sécurité", "Un protocole de sécurité Internet à 4 couches"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "modèle OSI" et combien de couches compte-t-il ?';

UPDATE questions SET 
  bonne_reponse = 'Un numéro de 0 à 65535 qui identifie un',
  choix = '["Un connecteur physique sur l''ordinateur pour brancher des câbles", "Un numéro de 0 à 65535 qui identifie un", "Un type de routeur réseau haute performance", "La vitesse de transmission des données sur un réseau"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "port" réseau en informatique ?';

UPDATE questions SET 
  bonne_reponse = 'La fourniture de ressources',
  choix = '["Un type de stockage sur une clé USB en forme de nuage", "La fourniture de ressources", "Une technologie de connexion Internet sans fil par satellite", "Un système de sauvegarde automatique sur le disque dur local"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "cloud computing" (informatique en nuage) ?';

UPDATE questions SET 
  bonne_reponse = 'La quantité maximale de données pouvant',
  choix = '["Le nombre d''appareils pouvant se connecter simultanément au Wi-Fi", "La quantité maximale de données pouvant", "Le coût mensuel d''un abonnement Internet", "La distance maximale couverte par un signal Wi-Fi"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "bande passante" d''une connexion Internet ?';

UPDATE questions SET 
  bonne_reponse = 'Une attaque qui submerge un serveur de',
  choix = '["Un virus qui chiffre les fichiers d''un ordinateur contre rançon", "Une attaque qui submerge un serveur de", "Une technique de vol de mots de passe par ingénierie sociale", "Une intrusion discrète dans un système pour voler des données"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "attaque DDoS" (Distributed Denial of Service) ?';

UPDATE questions SET 
  bonne_reponse = 'Un ensemble de données organisées en',
  choix = '["Un fichier Excel avec plusieurs colonnes", "Un ensemble de données organisées en", "Un dossier de fichiers sur un disque dur", "Un programme qui envoie des données sur Internet"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une base de données relationnelle ?';

UPDATE questions SET 
  bonne_reponse = 'Récupère toutes les colonnes de tous',
  choix = '["Supprime tous les élèves avec une note supérieure à 10", "Récupère toutes les colonnes de tous", "Met à jour la note de tous les élèves à 10", "Compte le nombre d''élèves avec une note supérieure à 10"]'::jsonb
WHERE enonce = 'Que fait la commande SQL SELECT * FROM eleves WHERE note > 10 ?';

UPDATE questions SET 
  bonne_reponse = 'Un attribut (ou ensemble d''attributs)',
  choix = '["Le premier enregistrement d''une table", "Un attribut (ou ensemble d''attributs)", "Le mot de passe pour accéder à la base de données", "La colonne la plus importante de la table"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "clé primaire" dans une table de base de données ?';

UPDATE questions SET 
  bonne_reponse = 'INSERT INTO table (col1, col2) VALUES',
  choix = '["UPDATE table SET colonne = valeur", "SELECT colonne FROM table", "INSERT INTO table (col1, col2) VALUES", "ALTER TABLE table ADD colonne type"]'::jsonb
WHERE enonce = 'Quelle commande SQL permet d''insérer un nouvel enregistrement dans une table ?';

UPDATE questions SET 
  bonne_reponse = 'Une opération qui combine les lignes de',
  choix = '["Une commande pour fusionner deux bases de données distinctes", "Une opération qui combine les lignes de", "Une opération de tri sur plusieurs colonnes simultanément", "Un index qui accélère les recherches sur une table"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "jointure" (JOIN) en SQL et pourquoi l''utilise-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'Un processus d''organisation des tables',
  choix = '["La compression des données pour économiser l''espace disque", "Un processus d''organisation des tables", "La mise à jour automatique des données quand une source change", "La synchronisation d''une base de données locale avec le cloud"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "normalisation" d''une base de données ?';

UPDATE questions SET 
  bonne_reponse = 'SQL utilise un schéma fixe et des',
  choix = '["SQL est pour les petites données ; NoSQL pour les grandes", "SQL utilise un schéma fixe et des", "SQL est gratuit ; NoSQL est payant", "SQL est plus récent que NoSQL"]'::jsonb
WHERE enonce = 'Quelle est la différence entre une base de données SQL et NoSQL ?';

UPDATE questions SET 
  bonne_reponse = 'Elle regroupe les lignes ayant la même',
  choix = '["Elle trie les enregistrements par ordre alphabétique", "Elle regroupe les lignes ayant la même", "Elle supprime les doublons d''une table", "Elle crée une nouvelle table à partir des résultats d''un SELECT"]'::jsonb
WHERE enonce = 'Que fait la commande SQL GROUP BY avec une fonction d''agrégation ?';

UPDATE questions SET 
  bonne_reponse = 'Un ensemble d''opérations atomiques',
  choix = '["Une requête SQL complexe avec plusieurs jointures", "Un ensemble d''opérations atomiques", "Un type de connexion entre client et serveur de base de données", "Un script de sauvegarde automatique de la base"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "transaction" en base de données et quelles sont ses propriétés ACID ?';

UPDATE questions SET 
  bonne_reponse = 'Une structure de données auxiliaire qui',
  choix = '["Une liste alphabétique de tous les noms de tables", "Une structure de données auxiliaire qui", "Le numéro d''ordre d''un enregistrement dans une table", "Un résumé statistique des données d''une table"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "index" en base de données et quel est son effet sur les performances ?';

UPDATE questions SET 
  bonne_reponse = 'Une attaque qui insère du code SQL',
  choix = '["Une technique d''optimisation des requêtes SQL", "Une attaque qui insère du code SQL", "Un mécanisme de sauvegarde automatique", "Un outil de migration de données entre bases"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"injection SQL" et comment s''en protéger ?';

UPDATE questions SET 
  bonne_reponse = 'Un langage standardisé pour interroger',
  choix = '["Un langage de programmation pour créer des applications web", "Un langage standardisé pour interroger", "Un langage de description de pages web similaire à HTML", "Un protocole de communication entre bases de données distribuées"]'::jsonb
WHERE enonce = 'Qu''est-ce que le langage SQL (Structured Query Language) et quel est son rôle ?';

UPDATE questions SET 
  bonne_reponse = 'UPDATE table SET colonne = valeur WHERE',
  choix = '["INSERT INTO table VALUES (...)", "ALTER TABLE table MODIFY colonne", "UPDATE table SET colonne = valeur WHERE", "REPLACE INTO table VALUES (...)"]'::jsonb
WHERE enonce = 'Quelle commande SQL permet de modifier des enregistrements existants ?';

UPDATE questions SET 
  bonne_reponse = 'Un attribut dans une table qui',
  choix = '["Une clé primaire d''une table importée depuis une base étrangère", "Un attribut dans une table qui", "Un index secondaire créé automatiquement par le SGBDR", "Un champ chiffré pour sécuriser les données sensibles"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "clé étrangère" (FOREIGN KEY) dans une base de données relationnelle ?';

UPDATE questions SET 
  bonne_reponse = 'Un paradigme de programmation qui',
  choix = '["Un style de programmation qui utilise uniquement des fonctions mathématiques", "Un paradigme de programmation qui", "Un langage de programmation spécifique", "Une méthode de débogage pour les grands programmes"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "programmation orientée objet" (POO) ?';

UPDATE questions SET 
  bonne_reponse = 'Encapsulation',
  choix = '["Boucles, conditions, fonctions, variables", "Encapsulation", "Compilation, interprétation, débogage, optimisation", "Classes, méthodes, attributs, instances"]'::jsonb
WHERE enonce = 'Quels sont les quatre principes fondamentaux de la POO ?';

UPDATE questions SET 
  bonne_reponse = 'Un mécanisme qui permet à une classe',
  choix = '["La récupération des données d''un objet supprimé", "Un mécanisme qui permet à une classe", "La copie d''un objet pour en créer un nouveau", "Le partage d''objets entre plusieurs programmes"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"héritage" en POO ?';

UPDATE questions SET 
  bonne_reponse = 'Le principe de cacher les détails',
  choix = '["La compression d''un objet pour économiser la mémoire", "Le principe de cacher les détails", "La copie d''un objet dans un autre objet", "Le regroupement de plusieurs objets dans une même variable"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"encapsulation" en POO ?';

UPDATE questions SET 
  bonne_reponse = 'Une structure de données arborescente',
  choix = '["Un algorithme de tri pour les listes", "Une structure de données arborescente", "Un type de tableau à deux dimensions", "Une structure de données circulaire"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "arbre binaire de recherche" (ABR) ?';

UPDATE questions SET 
  bonne_reponse = 'Une structure de données qui utilise',
  choix = '["Un tableau trié par ordre alphabétique", "Une structure de données qui utilise", "Une structure arborescente à branches multiples", "Un tableau de deux dimensions utilisé pour les matrices"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "table de hachage" (hash table) et quelle est sa complexité d''accès ?';

UPDATE questions SET 
  bonne_reponse = 'La capacité d''objets de classes',
  choix = '["La capacité d''un objet à changer de classe en cours d''exécution", "La capacité d''objets de classes", "La copie d''un objet avec des attributs modifiés", "La fusion de deux objets en un seul"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "polymorphisme" en POO et comment fonctionne-t-il ?';

UPDATE questions SET 
  bonne_reponse = 'O(1) en moyenne',
  choix = '["O(n²)", "O(n log n)", "O(n)", "O(1) en moyenne"]'::jsonb
WHERE enonce = 'Quelle est la complexité temporelle de la recherche dans une table de hachage bien conçue ?';

UPDATE questions SET 
  bonne_reponse = 'Une liste chaînée est une série de',
  choix = '["Ce sont des structures identiques", "Une liste chaînée est une série de", "Une liste chaînée est une liste triée par ordre croissant", "Une liste chaînée utilise moins de mémoire qu''un tableau"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "liste chaînée" et en quoi diffère-t-elle d''un tableau ?';

UPDATE questions SET 
  bonne_reponse = 'Un patron de conception qui garantit',
  choix = '["Un patron de conception qui permet de créer des copies identiques d''un objet", "Un patron de conception qui garantit", "Un patron de conception pour organiser les classes en hiérarchie", "Un patron de conception pour simplifier une interface complexe"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "design pattern" Singleton et quand l''utilise-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'Un contrat qui spécifie les méthodes',
  choix = '["Une fenêtre graphique de l''application", "Un contrat qui spécifie les méthodes", "Un type de liste chaînée", "Une méthode qui accepte plusieurs types de paramètres"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "interface" (ou classe abstraite) en POO ?';

UPDATE questions SET 
  bonne_reponse = 'Une structure qui suit les appels de',
  choix = '["L''ordre de compilation des fichiers d''un programme", "Une structure qui suit les appels de", "Une liste de tous les bugs détectés dans un programme", "La mémoire utilisée pour les variables globales"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "pile d''appels" (call stack) dans l''exécution d''un programme ?';

UPDATE questions SET 
  bonne_reponse = 'Un tri qui choisit un pivot',
  choix = '["Un tri stable O(n) qui utilise une table de hachage", "Un tri qui choisit un pivot", "Un tri qui divise le tableau en deux moitiés égales et les fusionne ; O(n log n)", "Un tri qui compare des paires adjacentes ; O(n²)"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "algorithme de tri rapide" (QuickSort) et quelle est sa complexité ?';

UPDATE questions SET 
  bonne_reponse = 'Un mécanisme automatique qui libère la',
  choix = '["Un outil de débogage qui détecte les erreurs de mémoire", "Un mécanisme automatique qui libère la", "Un compilateur optimiseur qui supprime le code mort", "Un outil de compression du code source pour réduire sa taille"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "garbage collector" (ramasse-miettes) dans les langages de programmation modernes ?';

UPDATE questions SET 
  bonne_reponse = 'Décrire la structure et le contenu',
  choix = '["Définir les styles visuels (couleurs, polices, mise en page) d''une page web", "Décrire la structure et le contenu", "Gérer les interactions de l''utilisateur (clics, animations) sur une page web", "Envoyer des requêtes au serveur web pour récupérer des données"]'::jsonb
WHERE enonce = 'Quel est le rôle du HTML dans le développement web ?';

UPDATE questions SET 
  bonne_reponse = 'Définir la présentation visuelle (styles',
  choix = '["Décrire la structure du contenu d''une page web", "Définir la présentation visuelle (styles", "Gérer la logique et les interactions côté client", "Communiquer avec la base de données du serveur"]'::jsonb
WHERE enonce = 'Quel est le rôle du CSS dans le développement web ?';

UPDATE questions SET 
  bonne_reponse = 'Frontend est la partie visible par',
  choix = '["Frontend est pour les applications mobiles ; backend pour les applications web", "Frontend est la partie visible par", "Frontend utilise Python ; backend utilise JavaScript", "Il n''y a pas de différence fonctionnelle"]'::jsonb
WHERE enonce = 'Quelle est la différence entre le développement "frontend" et "backend" ?';

UPDATE questions SET 
  bonne_reponse = 'Une architecture d''API web qui utilise',
  choix = '["Un type de base de données pour les applications web", "Une architecture d''API web qui utilise", "Un framework de développement frontend JavaScript", "Un protocole de sécurité pour les connexions web"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "API REST" et comment fonctionne-t-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Une approche de conception web qui',
  choix = '["Un design qui répond aux clics de l''utilisateur avec des animations", "Une approche de conception web qui", "Un design qui se charge rapidement sur les connexions lentes", "Un design accessible aux personnes handicapées visuelles"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "responsive design" et pourquoi est-il important ?';

UPDATE questions SET 
  bonne_reponse = 'Un langage de programmation qui',
  choix = '["Un langage de description de données similaire à JSON", "Un langage de programmation qui", "Un protocole de communication entre navigateur et serveur", "Un langage de template pour générer du HTML côté serveur"]'::jsonb
WHERE enonce = 'Qu''est-ce que JavaScript côté client et quel est son rôle dans une page web ?';

UPDATE questions SET 
  bonne_reponse = 'Une app native est développée',
  choix = '["Ce sont des termes synonymes pour les applications mobiles", "Une app native est développée", "Une app native ne nécessite pas Internet ; une PWA nécessite toujours Internet", "Une app native est plus sécurisée qu''une PWA"]'::jsonb
WHERE enonce = 'Quelle est la différence entre une application web "native" et une application web progressive (PWA) ?';

UPDATE questions SET 
  bonne_reponse = 'Une représentation en arbre de la',
  choix = '["Un langage de programmation pour créer des animations web", "Une représentation en arbre de la", "Un format de base de données utilisé par les navigateurs", "Un protocole de communication entre le navigateur et le serveur"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "DOM" (Document Object Model) en développement web ?';

UPDATE questions SET 
  bonne_reponse = 'Un framework de Google qui permet de',
  choix = '["Un framework JavaScript pour créer des sites web", "Un framework de Google qui permet de", "Un système d''exploitation mobile open source", "Un outil de débogage pour les applications Android"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "framework" Flutter et quel est son avantage principal ?';

UPDATE questions SET 
  bonne_reponse = 'Un format de données léger basé sur du',
  choix = '["Un langage de balisage similaire à HTML pour structurer les pages web", "Un format de données léger basé sur du", "Un protocole de transfert de fichiers entre serveurs", "Un système de chiffrement des communications web"]'::jsonb
WHERE enonce = 'Qu''est-ce que le format JSON et pourquoi est-il omniprésent dans le développement web ?';

UPDATE questions SET 
  bonne_reponse = 'Un protocole qui chiffre les données',
  choix = '["Un protocole plus rapide que HTTP car il compresse les données", "Un protocole qui chiffre les données", "Un protocole qui authentifie uniquement le navigateur auprès du serveur", "Un protocole réservé aux transactions bancaires en ligne"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "HTTPS" et comment le certificat SSL/TLS protège-t-il les communications ?';

UPDATE questions SET 
  bonne_reponse = 'Un patron d''architecture qui sépare',
  choix = '["Un modèle de données pour les bases de données relationnelles", "Un patron d''architecture qui sépare", "Un protocole de communication entre frontend et backend", "Un système de gestion de versions pour le code source"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"architecture MVC" (Model-View-Controller) dans le développement web ?';

UPDATE questions SET 
  bonne_reponse = 'Une attaque qui injecte du code',
  choix = '["Une attaque qui surcharge le serveur de requêtes simultanées", "Une attaque qui injecte du code", "Une attaque qui vole les fichiers du serveur web", "Une technique pour contourner l''authentification d''un site"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "sécurité XSS" (Cross-Site Scripting) et comment s''en protéger ?';

UPDATE questions SET 
  bonne_reponse = 'Un système de contrôle de versions qui',
  choix = '["Un système de sauvegarde automatique des fichiers sur le cloud", "Un système de contrôle de versions qui", "Un outil de débogage pour les applications web", "Un protocole de déploiement d''applications sur les serveurs"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "versionnage" du code avec Git et pourquoi est-il indispensable ?';

UPDATE questions SET 
  bonne_reponse = 'Quasi-linéaire',
  choix = '["Linéaire","Quasi-linéaire","Quadratique","Constante"]'::jsonb
WHERE enonce = 'Que signifie la notation O(n log n) pour un algorithme ?';

UPDATE questions SET 
  bonne_reponse = 'Diviser pour régner',
  choix = '["Programmation dynamique","Diviser pour régner","Algorithmes gloutons","Backtracking"]'::jsonb
WHERE enonce = 'Quel paradigme décompose un problème en sous-problèmes indépendants résolus récursivement ?';

UPDATE questions SET 
  bonne_reponse = 'Mémoriser les résultats de',
  choix = '["Un langage dynamique","Mémoriser les résultats de","Compiler le code à la volée","Une technique de parallélisme"]'::jsonb
WHERE enonce = 'Qu''est-ce que la programmation dynamique ?';

UPDATE questions SET 
  bonne_reponse = 'O(n log n)',
  choix = '["O(n)","O(n log n)","O(n²)","O(log n)"]'::jsonb
WHERE enonce = 'Quelle est la complexité du tri fusion (MergeSort) ?';

UPDATE questions SET 
  bonne_reponse = 'Dijkstra',
  choix = '["BFS","DFS","Dijkstra","Kruskal"]'::jsonb
WHERE enonce = 'Quel algorithme résout le problème du plus court chemin dans un graphe pondéré ?';

UPDATE questions SET 
  bonne_reponse = 'Un algorithme faisant le meilleur choix',
  choix = '["Un algorithme qui teste toutes les solutions","Un algorithme faisant le meilleur choix","Un algorithme récursif sans mémoïsation","Un algorithme de tri parallèle"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un algorithme glouton (greedy) ?';

UPDATE questions SET 
  bonne_reponse = 'NP-complet',
  choix = '["P","NP","NP-complet","PSPACE"]'::jsonb
WHERE enonce = 'Quelle classe de problèmes NP-complets est symbolisée par le problème du voyageur de commerce ?';

UPDATE questions SET 
  bonne_reponse = 'O(log n)',
  choix = '["O(1)","O(log n)","O(n)","O(n²)"]'::jsonb
WHERE enonce = 'Quelle est la complexité de la recherche binaire dans un tableau trié de n éléments ?';

UPDATE questions SET 
  bonne_reponse = 'Une technique qui explore des chemins',
  choix = '["Un algorithme de tri","Une technique qui explore des chemins","Un type de récursion terminale","Un algorithme de compression"]'::jsonb
WHERE enonce = 'Qu''est-ce que le backtracking ?';

UPDATE questions SET 
  bonne_reponse = 'File (queue)',
  choix = '["Pile","File (queue)","Tableau trié","Arbre AVL"]'::jsonb
WHERE enonce = 'Quelle structure de données est utilisée dans l''algorithme BFS (Breadth-First Search) ?';

UPDATE questions SET 
  bonne_reponse = 'Mémoïsation = top-down (récursif)',
  choix = '["Aucune","Mémoïsation = top-down (récursif)","Tabulation est plus récente","Mémoïsation ne marche qu''avec les arbres"]'::jsonb
WHERE enonce = 'Quelle est la différence entre memoization et tabulation en programmation dynamique ?';

UPDATE questions SET 
  bonne_reponse = 'Le problème possède une propriété de',
  choix = '["La taille du problème est petite","Le problème possède une propriété de","Le problème est NP-complet","Les données sont triées"]'::jsonb
WHERE enonce = 'Quelle condition doit être satisfaite pour appliquer un algorithme glouton avec succès ?';

UPDATE questions SET 
  bonne_reponse = 'Prim ou Kruskal',
  choix = '["Dijkstra","Bellman-Ford","Prim ou Kruskal","Floyd-Warshall"]'::jsonb
WHERE enonce = 'Quel algorithme calcule l''arbre couvrant minimal d''un graphe pondéré ?';

UPDATE questions SET 
  bonne_reponse = 'Une récursion où l''appel récursif est',
  choix = '["Une récursion sans cas de base","Une récursion où l''appel récursif est","Une récursion indirecte","Une récursion avec mémoïsation"]'::jsonb
WHERE enonce = 'Qu''est-ce que la récursion terminale (tail recursion) ?';

UPDATE questions SET 
  bonne_reponse = 'O(n)',
  choix = '["O(1)","O(n)","O(m)","O(n+m)"]'::jsonb
WHERE enonce = 'Quelle est la complexité en espace de l''algorithme DFS récursif sur un graphe de n sommets et m arêtes ?';

UPDATE questions SET 
  bonne_reponse = 'Cryptographie asymétrique',
  choix = '["Cryptographie symétrique","Cryptographie asymétrique","Cryptographie par substitution","Chiffrement par flot"]'::jsonb
WHERE enonce = 'Quel type de cryptographie utilise une paire de clés publique/privée ?';

UPDATE questions SET 
  bonne_reponse = 'Une fonction qui transforme des données',
  choix = '["Une fonction réversible","Une fonction qui transforme des données","Une méthode de chiffrement symétrique","Un protocole réseau"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une fonction de hachage cryptographique ?';

UPDATE questions SET 
  bonne_reponse = 'Tester toutes les combinaisons',
  choix = '["Une attaque exploitant une vulnérabilité logicielle","Tester toutes les combinaisons","Une attaque de déni de service","Un phishing ciblé"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une attaque par force brute ?';

UPDATE questions SET 
  bonne_reponse = 'Secure Sockets Layer / Transport Layer',
  choix = '["Standard Security Layer / Transport Layer Security","Secure Sockets Layer / Transport Layer","System Security Login / Token Layer Service","Secured Server Link / Transport Link Security"]'::jsonb
WHERE enonce = 'Que signifie SSL/TLS dans la sécurité web ?';

UPDATE questions SET 
  bonne_reponse = 'Combiner un secret connu + un facteur',
  choix = '["Un double mot de passe","Combiner un secret connu + un facteur","Deux serveurs d''authentification","Un certificat numérique double"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''authentification à deux facteurs (2FA) ?';

UPDATE questions SET 
  bonne_reponse = 'Man-in-the-Middle (MitM)',
  choix = '["Phishing","Man-in-the-Middle (MitM)","DDoS","Ransomware"]'::jsonb
WHERE enonce = 'Quelle attaque intercepte les communications entre deux parties à leur insu ?';

UPDATE questions SET 
  bonne_reponse = 'AES',
  choix = '["DES","3DES","AES","RSA"]'::jsonb
WHERE enonce = 'Quel algorithme de chiffrement symétrique est standard depuis 2001 ?';

UPDATE questions SET 
  bonne_reponse = 'Un document électronique liant une clé',
  choix = '["Un mot de passe haché","Un document électronique liant une clé","Un type de pare-feu","Un algorithme de signature"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un certificat numérique X.509 ?';

UPDATE questions SET 
  bonne_reponse = 'Une faille non encore connue du vendeur',
  choix = '["Une attaque très lente","Une faille non encore connue du vendeur","Un virus de type ransomware","Une attaque par déni de service"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une vulnérabilité zero-day ?';

UPDATE questions SET 
  bonne_reponse = 'Principe du moindre privilège',
  choix = '["Défense en profondeur","Principe du moindre privilège","Séparation des tâches","Sécurité par obscurité"]'::jsonb
WHERE enonce = 'Quel principe de sécurité recommande de n''accorder que les droits strictement nécessaires ?';

UPDATE questions SET 
  bonne_reponse = 'Seuls les utilisateurs communiquant',
  choix = '["Le chiffrement des données sur le disque","Seuls les utilisateurs communiquant","Le chiffrement du trafic réseau","Le chiffrement des mots de passe en base de données"]'::jsonb
WHERE enonce = 'Qu''est-ce que le chiffrement de bout en bout (E2EE) ?';

UPDATE questions SET 
  bonne_reponse = 'Un système qui filtre le trafic réseau',
  choix = '["Un antivirus","Un système qui filtre le trafic réseau","Un protocole de chiffrement","Un type de VPN"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un pare-feu (firewall) ?';

UPDATE questions SET 
  bonne_reponse = 'Diffie-Hellman',
  choix = '["RSA","Diffie-Hellman","AES","MD5"]'::jsonb
WHERE enonce = 'Quelle technique cryptographique permet à deux parties d''échanger une clé secrète sur un canal non sécurisé ?';

UPDATE questions SET 
  bonne_reponse = 'Un test autorisé simulant des attaques',
  choix = '["Une attaque réelle contre un système","Un test autorisé simulant des attaques","Un logiciel antivirus","Un protocole réseau de sécurité"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un audit de sécurité (pentest) ?';

UPDATE questions SET 
  bonne_reponse = 'Intégrité',
  choix = '["Confidentialité","Authenticité","Intégrité","Non-répudiation"]'::jsonb
WHERE enonce = 'Quelle propriété garantit qu''un message n''a pas été altéré pendant la transmission ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des ressources',
  choix = '["Un ordinateur unique","L''ensemble des ressources","Un logiciel de comptabilité","Un réseau d''entreprise"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un système d''information (SI) ?';

UPDATE questions SET 
  bonne_reponse = 'Un bloc de code SQL précompilé stocké',
  choix = '["Un fichier SQL externe","Un bloc de code SQL précompilé stocké","Un type d''index","Un déclencheur automatique"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une procédure stockée (stored procedure) en SQL ?';

UPDATE questions SET 
  bonne_reponse = 'Un bloc de code exécuté automatiquement',
  choix = '["Une procédure stockée","Un bloc de code exécuté automatiquement","Une contrainte d''intégrité","Un type de JOIN"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un trigger (déclencheur) SQL ?';

UPDATE questions SET 
  bonne_reponse = 'Maintenir des copies synchronisées',
  choix = '["Sauvegarder une BDD sur CD","Maintenir des copies synchronisées","Dupliquer des tables dans la même BDD","Exporter des données en CSV"]'::jsonb
WHERE enonce = 'Qu''est-ce que la réplication de base de données ?';

UPDATE questions SET 
  bonne_reponse = 'Un système optimisé pour l''analyse et',
  choix = '["Une BDD transactionnelle","Un système optimisé pour l''analyse et","Un serveur de fichiers","Un cloud public"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un entrepôt de données (data warehouse) ?';

UPDATE questions SET 
  bonne_reponse = '3NF',
  choix = '["1NF","2NF","3NF","BCNF"]'::jsonb
WHERE enonce = 'Quelle est la forme normale qui élimine les dépendances transitives ?';

UPDATE questions SET 
  bonne_reponse = 'La partition horizontale des données',
  choix = '["Un type de chiffrement","La partition horizontale des données","Une technique de sauvegarde","Un type d''index"]'::jsonb
WHERE enonce = 'Qu''est-ce que le sharding dans les bases de données ?';

UPDATE questions SET 
  bonne_reponse = 'Une requête SELECT sauvegardée comme',
  choix = '["Une table temporaire","Une requête SELECT sauvegardée comme","Un type d''index","Une procédure stockée"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une vue (VIEW) SQL ?';

UPDATE questions SET 
  bonne_reponse = 'Document',
  choix = '["Clé-valeur","Colonne","Document","Graphe"]'::jsonb
WHERE enonce = 'Quel modèle NoSQL organise les données en documents JSON/BSON ?';

UPDATE questions SET 
  bonne_reponse = 'Un théorème affirmant qu''on ne peut',
  choix = '["Un algorithme de tri","Un théorème affirmant qu''on ne peut","Un protocole de sécurité","Un modèle de données"]'::jsonb
WHERE enonce = 'Qu''est-ce que CAP théorème dans les systèmes distribués ?';

UPDATE questions SET 
  bonne_reponse = 'Une technique mappant les objets du',
  choix = '["Un protocole réseau","Une technique mappant les objets du","Un type de cache","Un algorithme de compression"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''ORM (Object-Relational Mapping) ?';

UPDATE questions SET 
  bonne_reponse = 'Cohérence',
  choix = '["Atomicité","Cohérence","Isolation","Durabilité"]'::jsonb
WHERE enonce = 'Quelle propriété SQL garantit qu''une transaction laisse la BDD dans un état valide ?';

UPDATE questions SET 
  bonne_reponse = 'Volume, Vélocité, Variété',
  choix = '["Données très volumineuses uniquement","Volume, Vélocité, Variété","Données chiffrées distribuées","Bases de données relationnelles massives"]'::jsonb
WHERE enonce = 'Qu''est-ce que le Big Data et quelles sont ses caractéristiques (3V) ?';

UPDATE questions SET 
  bonne_reponse = 'Extract, Transform, Load',
  choix = '["Un protocole réseau","Extract, Transform, Load","Un type de BDD","Un algorithme de hachage"]'::jsonb
WHERE enonce = 'Qu''est-ce que le ETL dans le contexte des données ?';

UPDATE questions SET 
  bonne_reponse = 'Introduire intentionnellement de la',
  choix = '["Supprimer les contraintes","Introduire intentionnellement de la","Normaliser en 4NF","Supprimer les index"]'::jsonb
WHERE enonce = 'Qu''est-ce que la dénormalisation d''une base de données ?';

UPDATE questions SET 
  bonne_reponse = 'L''IA faible est spécialisée',
  choix = '["L''IA faible est moins rapide","L''IA faible est spécialisée","L''IA forte utilise moins de données","L''IA faible est plus ancienne"]'::jsonb
WHERE enonce = 'Quelle est la différence entre IA faible et IA forte ?';

UPDATE questions SET 
  bonne_reponse = 'L''IA apprend à partir d''exemples',
  choix = '["L''IA apprend sans données","L''IA apprend à partir d''exemples","L''IA découvre des patterns sans labels","L''IA apprend par essai-erreur avec récompenses"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''apprentissage supervisé (supervised learning) ?';

UPDATE questions SET 
  bonne_reponse = 'Un modèle de calcul inspiré du cerveau',
  choix = '["Un réseau informatique biologique","Un modèle de calcul inspiré du cerveau","Un algorithme de tri","Un protocole de communication"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un réseau de neurones artificiels ?';

UPDATE questions SET 
  bonne_reponse = 'Le modèle mémorise les données',
  choix = '["Le modèle ne s''entraîne pas assez","Le modèle mémorise les données","Le modèle est trop simple","Le modèle prend trop de temps"]'::jsonb
WHERE enonce = 'Qu''est-ce que le surapprentissage (overfitting) en machine learning ?';

UPDATE questions SET 
  bonne_reponse = 'SVM (Support Vector Machine)',
  choix = '["K-Means","Forêts aléatoires","SVM (Support Vector Machine)","K-Plus Proches Voisins"]'::jsonb
WHERE enonce = 'Quel algorithme de ML est utilisé pour les problèmes de classification par séparation linéaire ?';

UPDATE questions SET 
  bonne_reponse = 'Un agent apprend en interagissant avec',
  choix = '["Apprendre sur des données étiquetées","Un agent apprend en interagissant avec","Regrouper des données sans labels","Apprendre à partir d''exemples non supervisés"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''apprentissage par renforcement (reinforcement learning) ?';

UPDATE questions SET 
  bonne_reponse = 'Des discriminations systématiques',
  choix = '["Une erreur de programmation","Des discriminations systématiques","Un problème de performance","Un type de bug logiciel"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un biais algorithmique ?';

UPDATE questions SET 
  bonne_reponse = 'Traitement automatique du langage',
  choix = '["Network Layer Protocol","Traitement automatique du langage","New Learning Program","Neural Logic Processing"]'::jsonb
WHERE enonce = 'Que signifie NLP (Natural Language Processing) ?';

UPDATE questions SET 
  bonne_reponse = 'Explicabilité (explainability)',
  choix = '["Efficacité","Explicabilité (explainability)","Automatisation","Scalabilité"]'::jsonb
WHERE enonce = 'Quel principe éthique recommande que les décisions d''une IA puissent être expliquées ?';

UPDATE questions SET 
  bonne_reponse = 'Un sous-domaine du ML utilisant des',
  choix = '["Un machine learning avec peu de données","Un sous-domaine du ML utilisant des","Un algorithme de tri","Une technique de compression"]'::jsonb
WHERE enonce = 'Qu''est-ce que le deep learning ?';

UPDATE questions SET 
  bonne_reponse = 'La protection des données personnelles',
  choix = '["La vitesse de traitement","La protection des données personnelles","Le coût des algorithmes","La compatibilité des langages"]'::jsonb
WHERE enonce = 'Quelle est la problématique du RGPD vis-à-vis de l''IA ?';

UPDATE questions SET 
  bonne_reponse = 'Réutiliser un modèle pré-entraîné sur',
  choix = '["Copier un modèle","Réutiliser un modèle pré-entraîné sur","Partager des données entre modèles","Un type de fédération"]'::jsonb
WHERE enonce = 'Qu''est-ce que le transfert d''apprentissage (transfer learning) ?';

UPDATE questions SET 
  bonne_reponse = 'K-Means',
  choix = '["Régression linéaire","K-Means","Forêt aléatoire","SVM"]'::jsonb
WHERE enonce = 'Quel algorithme non supervisé regroupe les données en clusters ?';

UPDATE questions SET 
  bonne_reponse = 'L''IA ne doit pas causer de tort aux',
  choix = '["L''IA doit être rapide","L''IA ne doit pas causer de tort aux","L''IA doit être open source","L''IA doit être précise"]'::jsonb
WHERE enonce = 'Qu''est-ce que le principe de non-malveillance dans l''éthique de l''IA ?';

UPDATE questions SET 
  bonne_reponse = 'F1-Score',
  choix = '["Précision (accuracy)","F1-Score","Rappel (recall)","AUC-ROC"]'::jsonb
WHERE enonce = 'Quelle mesure évalue la performance d''un modèle de classification sur toutes les classes ?';

UPDATE questions SET 
  bonne_reponse = 'L''Internet des Objets',
  choix = '["Internet of Technology","L''Internet des Objets","Internal Operating Technology","Input/Output Transmission"]'::jsonb
WHERE enonce = 'Que signifie IoT (Internet of Things) ?';

UPDATE questions SET 
  bonne_reponse = 'IaaS, PaaS, SaaS',
  choix = '["FaaS, BaaS, SaaS","IaaS, PaaS, SaaS","HaaS, NaaS, DaaS","CaaS, DBaaS, AIaaS"]'::jsonb
WHERE enonce = 'Quels sont les trois principaux modèles de service cloud ?';

UPDATE questions SET 
  bonne_reponse = 'Le traitement des données près de leur',
  choix = '["Un type de cloud centralisé","Le traitement des données près de leur","Un protocole réseau","Un système d''exploitation"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''edge computing ?';

UPDATE questions SET 
  bonne_reponse = 'Un registre distribué',
  choix = '["Une base de données centralisée","Un registre distribué","Un protocole de chiffrement","Un réseau social décentralisé"]'::jsonb
WHERE enonce = 'Qu''est-ce que la blockchain ?';

UPDATE questions SET 
  bonne_reponse = 'Une culture combinant développement et',
  choix = '["Un langage de programmation","Une culture combinant développement et","Un type de base de données","Un protocole réseau"]'::jsonb
WHERE enonce = 'Qu''est-ce que le DevOps ?';

UPDATE questions SET 
  bonne_reponse = 'Empaqueter une application et ses',
  choix = '["Un type de virtualisation matérielle","Empaqueter une application et ses","Un protocole de sécurité","Un service cloud"]'::jsonb
WHERE enonce = 'Qu''est-ce que la conteneurisation (Docker, Kubernetes) ?';

UPDATE questions SET 
  bonne_reponse = 'Intégrer les technologies numériques',
  choix = '["Acheter de nouveaux ordinateurs","Intégrer les technologies numériques","Migrer vers le cloud uniquement","Former les employés à l''informatique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la transformation numérique d''une organisation ?';

UPDATE questions SET 
  bonne_reponse = 'MQTT',
  choix = '["HTTP","FTP","MQTT","SMTP"]'::jsonb
WHERE enonce = 'Quel protocole léger est souvent utilisé pour la communication entre appareils IoT ?';

UPDATE questions SET 
  bonne_reponse = 'Ajouter davantage de serveurs pour',
  choix = '["Augmenter la puissance d''un seul serveur","Ajouter davantage de serveurs pour","Réduire le nombre de serveurs","Augmenter la capacité disque"]'::jsonb
WHERE enonce = 'Qu''est-ce que la scalabilité horizontale dans le cloud ?';

UPDATE questions SET 
  bonne_reponse = 'Consommation d''énergie et d''eau',
  choix = '["Nul, le numérique est propre","Consommation d''énergie et d''eau","Réduction de l''empreinte carbone uniquement","Impact uniquement sur les réseaux"]'::jsonb
WHERE enonce = 'Quel est l''impact environnemental du numérique et du cloud computing ?';

UPDATE questions SET 
  bonne_reponse = 'Intégration Continue/Déploiement Continu',
  choix = '["Contrôle d''identité/Code de déploiement","Intégration Continue/Déploiement Continu","Compilation instantanée/Code dynamique","Certification infrastructure/Cloud delivery"]'::jsonb
WHERE enonce = 'Qu''est-ce que le CI/CD dans le développement logiciel moderne ?';

UPDATE questions SET 
  bonne_reponse = 'Le fog est une couche intermédiaire',
  choix = '["Ce sont des synonymes","Le fog est une couche intermédiaire","Le fog est plus centralisé que le cloud","Le edge est plus puissant que le fog"]'::jsonb
WHERE enonce = 'Qu''est-ce que le fog computing par rapport à l''edge computing ?';

UPDATE questions SET 
  bonne_reponse = 'Une application décomposée en petits',
  choix = '["Une application monolithique légère","Une application décomposée en petits","Un protocole de communication","Un type de base de données distribuée"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une architecture microservices ?';

UPDATE questions SET 
  bonne_reponse = 'Le droit d''un État ou individu à',
  choix = '["La vitesse de traitement des données","Le droit d''un État ou individu à","La sécurité des mots de passe","La compression des données"]'::jsonb
WHERE enonce = 'Quel est l''enjeu de la souveraineté des données numériques ?';

UPDATE questions SET 
  bonne_reponse = 'Un modèle où le fournisseur cloud gère',
  choix = '["Un ordinateur sans système d''exploitation","Un modèle où le fournisseur cloud gère","Un réseau sans serveurs physiques","Un type de cloud privé"]'::jsonb
WHERE enonce = 'Qu''est-ce que le serverless computing ?';

UPDATE questions SET 
  bonne_reponse = 'Le roman',
  choix = '["La poésie","Le roman","La nouvelle","La fable"]'::jsonb
WHERE enonce = 'Quel genre littéraire se caractérise par une narration en prose d''une histoire fictive développée ?';

UPDATE questions SET 
  bonne_reponse = 'La comparaison',
  choix = '["La métaphore","La comparaison","L''allégorie","L''hyperbole"]'::jsonb
WHERE enonce = 'Quelle figure de style compare deux éléments avec un outil de comparaison (comme, tel...) ?';

UPDATE questions SET 
  bonne_reponse = 'Une pièce mettant en scène des',
  choix = '["Un roman triste","Une pièce mettant en scène des","Un poème épique","Une comédie noire"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une tragédie au sens classique du terme ?';

UPDATE questions SET 
  bonne_reponse = 'La purification des émotions du',
  choix = '["La décoration de la scène","La purification des émotions du","Le chant du chœur","Le dénouement heureux"]'::jsonb
WHERE enonce = 'Qu''est-ce que la catharsis dans le théâtre grec ?';

UPDATE questions SET 
  bonne_reponse = 'Situation initiale',
  choix = '["Introduction, développement, conclusion","Situation initiale","Exposition, nœud, dénouement","Début, milieu, fin"]'::jsonb
WHERE enonce = 'Quel est le schéma narratif canonique d''un récit selon Propp/Larivaille ?';

UPDATE questions SET 
  bonne_reponse = 'Un narrateur qui est personnage dans',
  choix = '["Un narrateur extérieur au récit","Un narrateur qui est personnage dans","Le lecteur implicite","L''auteur réel"]'::jsonb
WHERE enonce = 'Qu''est-ce que le narrateur intradiégétique ?';

UPDATE questions SET 
  bonne_reponse = 'Un poème de 14 vers divisé en 2',
  choix = '["Un poème de longueur libre","Un poème de 14 vers divisé en 2","Un poème épique","Une ballade médiévale"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un sonnet ?';

UPDATE questions SET 
  bonne_reponse = 'Un long poème narratif racontant les',
  choix = '["Un roman moderne","Un long poème narratif racontant les","Une tragédie musicale","Un dialogue philosophique"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''épopée comme genre littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'La personnification',
  choix = '["La comparaison","La métonymie","La personnification","L''euphémisme"]'::jsonb
WHERE enonce = 'Quelle figure de style consiste à attribuer des qualités humaines à des objets ou abstractions ?';

UPDATE questions SET 
  bonne_reponse = 'Le lecteur ne sait que ce que sait le',
  choix = '["Voir la scène de l''extérieur","Le lecteur ne sait que ce que sait le","Tout voir de l''extérieur","Vision omnisciente"]'::jsonb
WHERE enonce = 'Qu''est-ce que la focalisation interne dans un récit ?';

UPDATE questions SET 
  bonne_reponse = 'Représenter fidèlement la réalité',
  choix = '["Idéaliser la réalité","Représenter fidèlement la réalité","Fuir la réalité","Créer des mondes fantastiques"]'::jsonb
WHERE enonce = 'Qu''est-ce que le réalisme littéraire du XIXe siècle vise ?';

UPDATE questions SET 
  bonne_reponse = 'Dire le contraire de ce qu''on pense',
  choix = '["Dire exactement ce qu''on pense","Dire le contraire de ce qu''on pense","Exagérer pour choquer","Comparer deux éléments"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''ironie dans un texte littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'Un récit bref en prose centré sur un',
  choix = '["Un roman court","Un récit bref en prose centré sur un","Un poème narratif","Un extrait de roman"]'::jsonb
WHERE enonce = 'Qu''est-ce que la nouvelle comme genre littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'Un récit fictif représentant de façon',
  choix = '["Une simple comparaison","Un récit fictif représentant de façon","Un jeu de mots","Une figure sonore"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''allégorie dans la littérature ?';

UPDATE questions SET 
  bonne_reponse = 'Les relations entre un texte et les',
  choix = '["Les notes de bas de page","Les relations entre un texte et les","La biographie de l''auteur","L''index d''un livre"]'::jsonb
WHERE enonce = 'Que désigne le terme "intertextualité" en littérature ?';

UPDATE questions SET 
  bonne_reponse = 'Homère',
  choix = '["Virgile","Homère","Sophocle","Hésiode"]'::jsonb
WHERE enonce = 'Qui est l''auteur présumé de l''Iliade et de l''Odyssée ?';

UPDATE questions SET 
  bonne_reponse = 'Le retour d''Ulysse à Ithaque après la',
  choix = '["La guerre de Troie","Le retour d''Ulysse à Ithaque après la","La fondation de Rome","Les travaux d''Hercule"]'::jsonb
WHERE enonce = 'Quel est le thème central de l''Odyssée d''Homère ?';

UPDATE questions SET 
  bonne_reponse = 'Les pérégrinations d''Énée',
  choix = '["Les guerres de Julio César","Les pérégrinations d''Énée","La vie d''Auguste","La chute de Carthage"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''Énéide de Virgile raconte ?';

UPDATE questions SET 
  bonne_reponse = 'Sophocle',
  choix = '["Euripide","Aristophane","Sophocle","Eschyle"]'::jsonb
WHERE enonce = 'Quel auteur grec a écrit Œdipe Roi et Antigone ?';

UPDATE questions SET 
  bonne_reponse = 'Un voyage allégorique à travers l''Enfer',
  choix = '["Un poème lyrique","Un voyage allégorique à travers l''Enfer","Un roman médiéval","Une chanson de geste"]'::jsonb
WHERE enonce = 'Qu''est-ce que La Divine Comédie de Dante Alighieri ?';

UPDATE questions SET 
  bonne_reponse = 'Un long poème épique narrant les',
  choix = '["Un poème lyrique d''amour","Un long poème épique narrant les","Un conte moral","Un roman courtois"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une chanson de geste au Moyen Âge ?';

UPDATE questions SET 
  bonne_reponse = 'Un amour idéalisé, souvent adultère',
  choix = '["La guerre et la gloire","Un amour idéalisé, souvent adultère","La religion monacale","La politique féodale"]'::jsonb
WHERE enonce = 'Quel est le thème de l''amour courtois dans la littérature médiévale ?';

UPDATE questions SET 
  bonne_reponse = 'Ovide',
  choix = '["Virgile","Homère","Ovide","Horace"]'::jsonb
WHERE enonce = 'Qui a écrit Les Métamorphoses (recueil de mythes de la création à César) ?';

UPDATE questions SET 
  bonne_reponse = 'Un long poème allégorique sur la',
  choix = '["Un roman policier","Un long poème allégorique sur la","Un traité politique","Un livre de prières"]'::jsonb
WHERE enonce = 'Qu''est-ce que le Roman de la Rose (XIIIe s.) ?';

UPDATE questions SET 
  bonne_reponse = 'Un recueil de 100 nouvelles racontées',
  choix = '["Un poème épique","Un recueil de 100 nouvelles racontées","Un traité de philosophie","Un récit de voyage"]'::jsonb
WHERE enonce = 'Qu''est-ce que Le Décaméron de Boccace ?';

UPDATE questions SET 
  bonne_reponse = 'Le chœur commente l''action',
  choix = '["Le chœur dirige les acteurs","Le chœur commente l''action","Le chœur joue tous les rôles","Le chœur est silencieux"]'::jsonb
WHERE enonce = 'Quelle est la particularité du théâtre grec antique concernant le chœur ?';

UPDATE questions SET 
  bonne_reponse = 'L''une des premières œuvres littéraires',
  choix = '["Le premier roman","L''une des premières œuvres littéraires","Un texte religieux mineur","Un texte mathématique"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''épopée de Gilgamesh représente dans l''histoire littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'Un poème épique anglo-saxon narrant les',
  choix = '["Un roman d''amour","Un poème épique anglo-saxon narrant les","Un traité chrétien","Une chronique historique"]'::jsonb
WHERE enonce = 'Qu''est-ce que le Beowulf dans la littérature médiévale anglaise ?';

UPDATE questions SET 
  bonne_reponse = 'Les Géorgiques',
  choix = '["L''Énéide","Les Géorgiques","Les Bucoliques","L''Iliade latine"]'::jsonb
WHERE enonce = 'Quelle œuvre latine de Virgile conseille-t-elle sur l''agriculture et célèbre la campagne romaine ?';

UPDATE questions SET 
  bonne_reponse = 'Cervantès',
  choix = '["Dante","Cervantès","Rabelais","Shakespeare"]'::jsonb
WHERE enonce = 'Qui a écrit Don Quichotte, considéré comme le premier roman moderne ?';

UPDATE questions SET 
  bonne_reponse = 'L''étude de soi-même comme objet',
  choix = '["La politique française","L''étude de soi-même comme objet","La religion réformée","La géographie du monde"]'::jsonb
WHERE enonce = 'Quel est le thème central des Essais de Montaigne ?';

UPDATE questions SET 
  bonne_reponse = 'Le retour aux textes antiques et la',
  choix = '["Le rejet de l''Antiquité","Le retour aux textes antiques et la","Le protestantisme littéraire","Le réalisme social"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''humanisme de la Renaissance littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'Hamlet',
  choix = '["Macbeth","Othello","Hamlet","Le Roi Lear"]'::jsonb
WHERE enonce = 'Quelle pièce de Shakespeare met en scène un prince danois confronté à la mort de son père ?';

UPDATE questions SET 
  bonne_reponse = 'Un style exubérant',
  choix = '["Un style simple et équilibré","Un style exubérant","Le classicisme français","Le réalisme du XVIIe siècle"]'::jsonb
WHERE enonce = 'Qu''est-ce que le baroque littéraire (XVIIe s.) ?';

UPDATE questions SET 
  bonne_reponse = 'Unité de temps (24h)',
  choix = '["Unité de style, de langue et de personnages","Unité de temps (24h)","Unité d''auteur, de genre et de public","Unité de décors, de musique et de danse"]'::jsonb
WHERE enonce = 'Quelle est la règle des trois unités dans le théâtre classique français ?';

UPDATE questions SET 
  bonne_reponse = 'La raison',
  choix = '["La tradition et la religion","La raison","Le retour au Moyen Âge","L''absolutisme royal"]'::jsonb
WHERE enonce = 'Qu''est-ce que les Lumières (XVIIIe s.) défendent en littérature ?';

UPDATE questions SET 
  bonne_reponse = 'L''optimisme béat de Leibniz face aux',
  choix = '["La démocratie","L''optimisme béat de Leibniz face aux","La religion catholique seulement","L''esclavage uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que Candide de Voltaire critique principalement ?';

UPDATE questions SET 
  bonne_reponse = 'Le conte philosophique',
  choix = '["Le conte philosophique","La tragédie classique","Le roman réaliste","La poésie lyrique"]'::jsonb
WHERE enonce = 'Quel genre littéraire philosophique des Lumières expose des idées sous forme de voyage imaginaire ?';

UPDATE questions SET 
  bonne_reponse = 'Jonathan Swift',
  choix = '["Daniel Defoe","Jonathan Swift","Henry Fielding","Samuel Richardson"]'::jsonb
WHERE enonce = 'Qui a écrit Gulliver''s Travels, satire de la société anglaise du XVIIIe s. ?';

UPDATE questions SET 
  bonne_reponse = 'Un roman écrit sous forme de lettres',
  choix = '["Un roman historique","Un roman écrit sous forme de lettres","Un roman policier","Un roman d''apprentissage"]'::jsonb
WHERE enonce = 'Qu''est-ce que le roman épistolaire au XVIIIe siècle ?';

UPDATE questions SET 
  bonne_reponse = 'Pantagruel et Gargantua',
  choix = '["Les Essais","Pantagruel et Gargantua","Les Fables","L''Heptaméron"]'::jsonb
WHERE enonce = 'Quelle œuvre de Rabelais met en scène des géants voyageant pour l''éducation humaniste ?';

UPDATE questions SET 
  bonne_reponse = 'Ce qui paraît crédible et acceptable au',
  choix = '["Ce qui est vrai","Ce qui paraît crédible et acceptable au","Ce qui respecte l''histoire","Ce qui est scientifiquement prouvé"]'::jsonb
WHERE enonce = 'Que signifie la notion de "vraisemblance" dans la poétique classique ?';

UPDATE questions SET 
  bonne_reponse = 'Le Sturm und Drang',
  choix = '["Le classicisme","Le Sturm und Drang","Le réalisme","L''encyclopédisme"]'::jsonb
WHERE enonce = 'Quel mouvement littéraire du XVIIIe s. préfigure le romantisme avec le culte de la sensibilité ?';

UPDATE questions SET 
  bonne_reponse = 'Le moi',
  choix = '["La raison et l''ordre","Le moi","La société industrielle","Le positivisme scientifique"]'::jsonb
WHERE enonce = 'Qu''est-ce que le romantisme littéraire (XIXe s.) valorise ?';

UPDATE questions SET 
  bonne_reponse = 'Dostoïevski',
  choix = '["Tolstoï","Dostoïevski","Tchékhov","Tourgueniev"]'::jsonb
WHERE enonce = 'Qui est l''auteur de Crime et Châtiment et des Frères Karamazov ?';

UPDATE questions SET 
  bonne_reponse = 'L''application des méthodes',
  choix = '["L''idéalisation de la nature","L''application des méthodes","Le romantisme tardif","L''exotisme colonial"]'::jsonb
WHERE enonce = 'Qu''est-ce que le naturalisme littéraire (Zola) ?';

UPDATE questions SET 
  bonne_reponse = 'Suggérer les états d''âme par des',
  choix = '["La description objective","Suggérer les états d''âme par des","La narration réaliste","La satire sociale"]'::jsonb
WHERE enonce = 'Qu''est-ce que le symbolisme poétique (Mallarmé, Verlaine, Rimbaud) recherche ?';

UPDATE questions SET 
  bonne_reponse = 'La Métamorphose',
  choix = '["Le Procès","La Métamorphose","Le Château","Amerika"]'::jsonb
WHERE enonce = 'Quel roman de Kafka met en scène un homme transformé en insecte ?';

UPDATE questions SET 
  bonne_reponse = 'La technique narrative rendant le flux',
  choix = '["Un résumé de l''action","La technique narrative rendant le flux","Un monologue théâtral","La focalisation externe"]'::jsonb
WHERE enonce = 'Qu''est-ce que le courant de conscience (stream of consciousness) dans le roman moderniste ?';

UPDATE questions SET 
  bonne_reponse = 'Un courant dramatique qui met en scène',
  choix = '["Un théâtre comique","Un courant dramatique qui met en scène","Le théâtre réaliste","La comédie classique"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''absurde dans le théâtre de Beckett et Ionesco ?';

UPDATE questions SET 
  bonne_reponse = 'Marcel Proust',
  choix = '["Flaubert","Zola","Marcel Proust","Gide"]'::jsonb
WHERE enonce = 'Qui a écrit À la Recherche du Temps Perdu, célèbre roman de la mémoire ?';

UPDATE questions SET 
  bonne_reponse = 'La liberté radicale',
  choix = '["L''art pour l''art","La liberté radicale","Le réalisme social","La tradition classique"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''existentialisme de Sartre en littérature (La Nausée, Les Mouches) ?';

UPDATE questions SET 
  bonne_reponse = 'L''insertion d''éléments magiques dans un',
  choix = '["Le réalisme ordinaire","L''insertion d''éléments magiques dans un","Le réalisme socialiste","La science-fiction tropicale"]'::jsonb
WHERE enonce = 'Qu''est-ce que le réalisme magique dans la littérature latino-américaine ?';

UPDATE questions SET 
  bonne_reponse = 'Gabriel García Márquez',
  choix = '["Pablo Neruda","Gabriel García Márquez","Borges","Vargas Llosa"]'::jsonb
WHERE enonce = 'Qui a reçu le prix Nobel de Littérature pour One Hundred Years of Solitude ?';

UPDATE questions SET 
  bonne_reponse = 'Un courant refusant les conventions',
  choix = '["Le roman policier","Un courant refusant les conventions","Le roman autobiographique","Le roman historique"]'::jsonb
WHERE enonce = 'Qu''est-ce que le nouveau roman (Robbe-Grillet, Sarraute) dans la littérature française ?';

UPDATE questions SET 
  bonne_reponse = 'Une fiction dépeignant une société',
  choix = '["Une utopie réalisée","Une fiction dépeignant une société","Un genre de science-fiction optimiste","Un roman historique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la dystopie dans la littérature du XXe siècle ?';

UPDATE questions SET 
  bonne_reponse = 'Léon Tolstoï',
  choix = '["Dostoïevski","Tourgueniev","Léon Tolstoï","Gorki"]'::jsonb
WHERE enonce = 'Quel auteur russe a écrit Guerre et Paix et Anna Karénine ?';

UPDATE questions SET 
  bonne_reponse = 'Juste Chanlatte',
  choix = '["Ignace Nau","Juste Chanlatte","Madiou","Liautaud Ethéart"]'::jsonb
WHERE enonce = 'Qui est considéré comme le premier poète haïtien avec "L''Union fait la force" ?';

UPDATE questions SET 
  bonne_reponse = 'Ignace Nau',
  choix = '["Ignace Nau","Thomas Madiou","B. Ardouin","Demesvar Delorme"]'::jsonb
WHERE enonce = 'Qui a fondé la première revue littéraire haïtienne L''Union en 1837 ?';

UPDATE questions SET 
  bonne_reponse = 'Oswald Durand',
  choix = '["Oswald Durand","Justin Lhérisson","Antoine Innocent","Georges Sylvain"]'::jsonb
WHERE enonce = 'Quel écrivain haïtien du XIXe s. est l''auteur de Sous les bambous (poèmes) ?';

UPDATE questions SET 
  bonne_reponse = 'Un amour déçu avec une mulâtresse',
  choix = '["La révolution","Un amour déçu avec une mulâtresse","L''histoire d''Haïti","La mort d''un héros"]'::jsonb
WHERE enonce = 'Quel est le thème principal du poème "Choucoune" d''Oswald Durand ?';

UPDATE questions SET 
  bonne_reponse = 'La famille des Pitite-Caille',
  choix = '["La famille des Pitite-Caille","Le fils noir","Mimola","Thémistocle Épaminondas Labasterre"]'::jsonb
WHERE enonce = 'Quel roman historique de Justin Lhérisson décrit la société haïtienne rurale ?';

UPDATE questions SET 
  bonne_reponse = 'Thomas Madiou',
  choix = '["Beaubrun Ardouin","Thomas Madiou","Hannibal Price","Demesvar Delorme"]'::jsonb
WHERE enonce = 'Quel auteur haïtien du XIXe s. a écrit une Histoire d''Haïti en 3 volumes (1847-1848) ?';

UPDATE questions SET 
  bonne_reponse = 'Stella d''Émeric Bergeaud',
  choix = '["Stella d''Émeric Bergeaud","La Famille des Pitite-Caille","Mimola","Les Thazard"]'::jsonb
WHERE enonce = 'Quel est le premier roman haïtien publié ?';

UPDATE questions SET 
  bonne_reponse = 'Un mouvement littéraire valorisant les',
  choix = '["Un mouvement politique","Un mouvement littéraire valorisant les","Un mouvement religieux","Un courant réaliste"]'::jsonb
WHERE enonce = 'Qu''est-ce que le mouvement indigéniste haïtien des années 1920-1940 ?';

UPDATE questions SET 
  bonne_reponse = 'Jacques Roumain',
  choix = '["René Depestre","Jean Price-Mars","Jacques Roumain","Frankétienne"]'::jsonb
WHERE enonce = 'Qui est l''auteur du roman Gouverneurs de la Rosée (1944) ?';

UPDATE questions SET 
  bonne_reponse = 'La réconciliation d''un village divisé',
  choix = '["La vie urbaine","La réconciliation d''un village divisé","La politique nationale","L''occupation américaine"]'::jsonb
WHERE enonce = 'Quel est le thème central de Gouverneurs de la Rosée de Jacques Roumain ?';

UPDATE questions SET 
  bonne_reponse = 'Ainsi parla l''Oncle',
  choix = '["Panorama de la Littérature","Ainsi parla l''Oncle","De Saint-Domingue à Haïti","La Vocation de l''Élite"]'::jsonb
WHERE enonce = 'Quel ouvrage de Jean Price-Mars fonde l''indigénisme haïtien en valorisant le vodou et la culture africaine ?';

UPDATE questions SET 
  bonne_reponse = 'Réalisme poétique avec des éléments du',
  choix = '["Réalisme magique","Réalisme poétique avec des éléments du","Naturalisme zolien","Existentialisme sartrien"]'::jsonb
WHERE enonce = 'Quel est le style narratif dominant dans Gouverneurs de la Rosée ?';

UPDATE questions SET 
  bonne_reponse = 'Massillon Coicou',
  choix = '["Oswald Durand","Massillon Coicou","Georges Sylvain","Alcibiade Fleury-Battier"]'::jsonb
WHERE enonce = 'Quel poète haïtien a publié Étincelles (1901) et milité pour les droits des Noirs ?';

UPDATE questions SET 
  bonne_reponse = 'Georges Sylvain',
  choix = '["Oswald Durand","Justin Lhérisson","Georges Sylvain","Ignace Nau"]'::jsonb
WHERE enonce = 'Quel premier auteur haïtien du XIXe s. a écrit des fables en créole (Cric ? Crac !) ?';

UPDATE questions SET 
  bonne_reponse = 'La fierté de l''indépendance',
  choix = '["L''amour romantique uniquement","La fierté de l''indépendance","La nature tropicale uniquement","La religion catholique"]'::jsonb
WHERE enonce = 'Quel thème est récurrent dans la poésie patriotique du XIXe siècle haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Un mouvement littéraire affirmant la',
  choix = '["Un mouvement politique africain","Un mouvement littéraire affirmant la","Un mouvement haïtien seul","Un mouvement religieux"]'::jsonb
WHERE enonce = 'Qu''est-ce que le mouvement de la Négritude et qui en sont les fondateurs ?';

UPDATE questions SET 
  bonne_reponse = 'L''indigénisme haïtien (Price-Mars)',
  choix = '["Aucun lien","L''indigénisme haïtien (Price-Mars)","La Négritude précède l''indigénisme","Ce sont des mouvements opposés"]'::jsonb
WHERE enonce = 'Quel lien existe entre la Négritude et le mouvement indigéniste haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Jacques Stéphen Alexis',
  choix = '["René Depestre","Jacques Stéphen Alexis","Frankétienne","Edwidge Danticat"]'::jsonb
WHERE enonce = 'Quel écrivain haïtien a écrit Compère Général Soleil (1955) et Black Label ?';

UPDATE questions SET 
  bonne_reponse = 'La fusion du réel haïtien avec le',
  choix = '["Le réalisme magique","La fusion du réel haïtien avec le","Le surréalisme","La science-fiction haïtienne"]'::jsonb
WHERE enonce = 'Qu''est-ce que le réalisme merveilleux défini par Jacques Stéphen Alexis ?';

UPDATE questions SET 
  bonne_reponse = 'Le créateur du spiralisme',
  choix = '["Un historien","Le créateur du spiralisme","Un poète classique","Un conteur populaire"]'::jsonb
WHERE enonce = 'Qui est Frankétienne et quelle est son importance dans la littérature haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Un mouvement esthétique haïtien',
  choix = '["Un courant réaliste","Un mouvement esthétique haïtien","Le surréalisme haïtien","Le réalisme merveilleux"]'::jsonb
WHERE enonce = 'Qu''est-ce que le spiralisme de Frankétienne ?';

UPDATE questions SET 
  bonne_reponse = 'Hadriana dans tous mes rêves',
  choix = '["Pays sans chapeau","Hadriana dans tous mes rêves","Le Mât de cocagne","Bonjour et adieu à la négritude"]'::jsonb
WHERE enonce = 'Quel roman de René Depestre est considéré son chef-d''œuvre ?';

UPDATE questions SET 
  bonne_reponse = 'La tension entre modernité',
  choix = '["La révolution politique","La tension entre modernité","L''exil haïtien","La nature tropicale"]'::jsonb
WHERE enonce = 'Quel est le thème central du roman Les Arbres Musiciens de Jacques Stéphen Alexis ?';

UPDATE questions SET 
  bonne_reponse = 'Le premier roman écrit en créole haïtien',
  choix = '["Le premier roman policier","Le premier roman écrit en créole haïtien","La première épopée","Le premier roman réaliste"]'::jsonb
WHERE enonce = 'Qu''est-ce que Dezafi de Frankétienne représente dans l''histoire littéraire haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Anthony Phelps',
  choix = '["René Depestre","Jean-Claude Charles","Anthony Phelps","Marc Exavier"]'::jsonb
WHERE enonce = 'Quel poète haïtien de la diaspora a écrit Poèmes d''une saison en enfer haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'L''exil massif des écrivains',
  choix = '["Un épanouissement créatif","L''exil massif des écrivains","Une production abondante locale","L''indigénisme renouvelé"]'::jsonb
WHERE enonce = 'Qu''est-ce qui caractérise la littérature haïtienne de la période duvaliériste (1957-1986) ?';

UPDATE questions SET 
  bonne_reponse = 'Amour, Colère et Folie',
  choix = '["Gouverneurs de la Rosée","Amour, Colère et Folie","Les Rapaces","La Danse sur le Volcan"]'::jsonb
WHERE enonce = 'Quel roman de Marie Vieux-Chauvet aborde la répression duvaliériste ?';

UPDATE questions SET 
  bonne_reponse = 'Dany Laferrière',
  choix = '["Dany Laferrière","Yanick Lahens","Gary Victor","Kettly Mars"]'::jsonb
WHERE enonce = 'Quel écrivain haïtien a reçu le Prix Médicis en 2011 pour L''Art de perdre ?';

UPDATE questions SET 
  bonne_reponse = 'Le regard croisé sur la race',
  choix = '["L''histoire d''Haïti","Le regard croisé sur la race","La nostalgie du pays","La religion vodou"]'::jsonb
WHERE enonce = 'Quel thème est central dans Comment Faire l''Amour avec un Nègre sans se Fatiguer de Dany Laferrière ?';

UPDATE questions SET 
  bonne_reponse = 'Bain de Lune',
  choix = '["Bain de Lune","Caïque","Failles","Pendant ce temps"]'::jsonb
WHERE enonce = 'Quel roman de Yanick Lahens décrit la vie haïtienne après le séisme de 2010 ?';

UPDATE questions SET 
  bonne_reponse = 'Le retour en Haïti et le voyage dans le',
  choix = '["L''exil en Amérique","Le retour en Haïti et le voyage dans le","La révolution haïtienne","L''enfance en province"]'::jsonb
WHERE enonce = 'Quel est le thème de Pays sans chapeau de Dany Laferrière ?';

UPDATE questions SET 
  bonne_reponse = 'Une écrivaine haïtienne-américaine qui',
  choix = '["Une historienne","Une écrivaine haïtienne-américaine qui","Une poète classique","Une journaliste"]'::jsonb
WHERE enonce = 'Qui est Edwidge Danticat et pourquoi est-elle importante ?';

UPDATE questions SET 
  bonne_reponse = 'Le diable dans un thé à la citronnelle',
  choix = '["Clair de manbo","Le diable dans un thé à la citronnelle","Les masques déchirés","Avec le cœur de l''arbre"]'::jsonb
WHERE enonce = 'Quel roman de Gary Victor mêle policier, vodou et critique sociale haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Un débat central sur l''usage du',
  choix = '["Une question résolue","Un débat central sur l''usage du","Une question politique uniquement","Un problème technique d''édition"]'::jsonb
WHERE enonce = 'Qu''est-ce que la question de la langue dans la littérature haïtienne contemporaine ?';

UPDATE questions SET 
  bonne_reponse = 'La tension entre appartenance à Haïti',
  choix = '["L''oubli d''Haïti","La tension entre appartenance à Haïti","La nostalgie uniquement","La politique haïtienne"]'::jsonb
WHERE enonce = 'Quel thème unit la plupart des œuvres de la diaspora haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Avant que les ombres s''effacent',
  choix = '["Maître-Minuit","Avant que les ombres s''effacent","Maudite Education","Así en la tierra"]'::jsonb
WHERE enonce = 'Quel roman de Louis-Philippe Dalembert traite de l''expérience migratoire haïtienne en Méditerranée ?';

UPDATE questions SET 
  bonne_reponse = 'Un système de valeurs culturelles',
  choix = '["Un élément exotique sans signification","Un système de valeurs culturelles","Une superstition condamnée","Un simple décor narratif"]'::jsonb
WHERE enonce = 'Quel est le rôle du vodou dans la littérature haïtienne contemporaine ?';

UPDATE questions SET 
  bonne_reponse = 'Yanick Lahens',
  choix = '["Dany Laferrière","Yanick Lahens","Kettly Mars","James Noël"]'::jsonb
WHERE enonce = 'Quel écrivain haïtien a reçu le Prix des Amériques en 2021 ?';

UPDATE questions SET 
  bonne_reponse = 'Une exploration de la mémoire',
  choix = '["Un roman historique","Une exploration de la mémoire","Un roman d''amour","Un roman de formation"]'::jsonb
WHERE enonce = 'Que représente le roman Mémoire en Colin-Maillard de Syto Cavé dans la littérature haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'L''identité caribéenne comme synthèse de',
  choix = '["La langue créole uniquement","L''identité caribéenne comme synthèse de","Le réalisme magique","La Négritude renouvelée"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "créolité" comme concept littéraire caribéen ?';

UPDATE questions SET 
  bonne_reponse = 'En témoignant du traumatisme',
  choix = '["En l''ignorant","En témoignant du traumatisme","En glorifiant l''aide internationale","En abandonnant toute fiction"]'::jsonb
WHERE enonce = 'Comment la littérature haïtienne post-séisme 2010 a-t-elle traité la catastrophe ?';

UPDATE questions SET 
  bonne_reponse = 'L''exploration de la sexualité féminine',
  choix = '["La poésie épique","L''exploration de la sexualité féminine","Le roman policier","L''histoire coloniale"]'::jsonb
WHERE enonce = 'Quel aspect de l''œuvre de Kettly Mars la distingue dans la littérature haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Complément d''objet direct (COD)',
  choix = '["Sujet", "Complément d''objet direct (COD)", "Complément d''objet indirect (COI)", "Attribut du sujet"]'::jsonb
WHERE enonce = 'Quelle est la fonction grammaticale du groupe nominal en italique dans : "Le professeur corrige les copies" ?';

UPDATE questions SET 
  bonne_reponse = 'Les pronoms',
  choix = '["Les adjectifs", "Les pronoms", "Les adverbes", "Les conjonctions"]'::jsonb
WHERE enonce = 'Quelle classe grammaticale désigne les mots qui remplacent un nom ou un groupe nominal ?';

UPDATE questions SET 
  bonne_reponse = 'Adverbe',
  choix = '["Adjectif qualificatif", "Nom commun", "Adverbe", "Préposition"]'::jsonb
WHERE enonce = 'Dans la phrase "Il travaille sérieusement", à quelle classe grammaticale appartient "sérieusement" ?';

UPDATE questions SET 
  bonne_reponse = 'Le groupe nominal ou pronominal dont le',
  choix = '["Le mot qui suit directement le verbe", "Le groupe nominal ou pronominal dont le", "Le complément qui répond à la question ''à qui ?''", "Le mot qui qualifie le verbe"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "sujet" d''un verbe ?';

UPDATE questions SET 
  bonne_reponse = 'COD du verbe ''enseigner'' dans la',
  choix = '["Sujet de la proposition relative", "COD du verbe ''enseigner'' dans la", "Attribut du sujet dans la proposition principale", "Complément circonstanciel"]'::jsonb
WHERE enonce = 'Dans "Les élèves que j''enseigne sont brillants", quelle est la fonction du pronom relatif "que" ?';

UPDATE questions SET 
  bonne_reponse = 'Il s''accorde avec le COD quand celui-ci',
  choix = '["Il s''accorde toujours avec le sujet", "Il s''accorde avec le COD quand celui-ci", "Il est toujours invariable", "Il s''accorde avec le COI"]'::jsonb
WHERE enonce = 'Comment s''accorde le participe passé employé avec l''auxiliaire "avoir" ?';

UPDATE questions SET 
  bonne_reponse = 'Une phrase contenant au moins deux',
  choix = '["Une phrase avec beaucoup de mots", "Une phrase contenant au moins deux", "Une phrase sans verbe", "Une phrase avec un verbe à un temps composé"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "phrase complexe" en grammaire française ?';

UPDATE questions SET 
  bonne_reponse = 'Le complément circonstanciel est',
  choix = '["Les compléments circonstanciels sont toujours des adverbes ; les compléments essentiels sont toujours des noms", "Le complément circonstanciel est", "Il n''y a pas de différence", "Les compléments essentiels se placent toujours devant le verbe"]'::jsonb
WHERE enonce = 'Quelle est la différence entre un complément circonstanciel supprimable et un complément essentiel ?';

UPDATE questions SET 
  bonne_reponse = 'Une construction où le sujet subit',
  choix = '["Une phrase où le sujet est inconnu", "Une construction où le sujet subit", "Une phrase négative", "Une phrase interrogative indirecte"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "voix passive" en français et comment la forme-t-on ?';

UPDATE questions SET 
  bonne_reponse = 'Il s''accorde en genre et en nombre avec',
  choix = '["Il s''accorde uniquement en genre avec le nom", "Il s''accorde en genre et en nombre avec", "Il est toujours invariable", "Il s''accorde avec le verbe de la phrase"]'::jsonb
WHERE enonce = 'Quelle est la règle d''accord de l''adjectif qualificatif en français ?';

UPDATE questions SET 
  bonne_reponse = 'Une proposition introduite par un',
  choix = '["Une proposition qui suit toujours la principale", "Une proposition introduite par un", "Une proposition introduite par ''que'' exprimant un souhait", "Une proposition qui exprime une condition"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "proposition subordonnée relative" ?';

UPDATE questions SET 
  bonne_reponse = '"Leur" pronom est invariable et',
  choix = '["Ils sont identiques et interchangeables", "\"Leur\" pronom est invariable et", "''Leur'' pronom s''accorde toujours ; ''leur'' adjectif est invariable", "Il n''y a pas de ''leur'' adjectif possessif en français"]'::jsonb
WHERE enonce = 'Comment distingue-t-on "leur" pronom personnel de "leur" adjectif possessif ?';

UPDATE questions SET 
  bonne_reponse = 'Le discours rapporté sans guillemets',
  choix = '["Le discours rapporté sans guillemets", "Le discours rapporté en gardant exactement les mêmes mots avec des guillemets", "Un discours public ou politique", "Une citation littérale d''un auteur"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "discours indirect" et comment transforme-t-on le discours direct en indirect ?';

UPDATE questions SET 
  bonne_reponse = 'Il qualifie ou caractérise le sujet par',
  choix = '["Il complète directement le verbe d''action", "Il qualifie ou caractérise le sujet par", "Il indique la circonstance de l''action", "Il est toujours un adverbe"]'::jsonb
WHERE enonce = 'Quelle est la fonction de l''attribut du sujet ?';

UPDATE questions SET 
  bonne_reponse = 'Le subjonctif',
  choix = '["L''indicatif", "L''impératif", "Le subjonctif", "L''infinitif"]'::jsonb
WHERE enonce = 'Quel mode verbal exprime une action éventuelle, souhaitée ou subordonnée à un sentiment ou un jugement ?';

UPDATE questions SET 
  bonne_reponse = 'La plus petite unité de sens d''une',
  choix = '["Un mot complet isolé", "La plus petite unité de sens d''une", "Une syllabe d''un mot", "Un groupe de mots formant une expression"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "morphème" en linguistique et en grammaire française ?';

UPDATE questions SET 
  bonne_reponse = 'Une lecture attentive qui identifie et',
  choix = '["Une lecture rapide pour en comprendre l''essentiel", "Une lecture attentive qui identifie et", "Une lecture à voix haute pour la classe", "Une lecture qui résume le texte en moins de mots"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "lecture analytique" d''un texte ?';

UPDATE questions SET 
  bonne_reponse = 'Un procédé d''écriture particulier qui',
  choix = '["Une illustration graphique dans le texte", "Un procédé d''écriture particulier qui", "Un paragraphe de transition entre deux idées", "Un personnage secondaire de récit"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "figure de style" dans un texte littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'La métaphore identifie implicitement',
  choix = '["Elles sont identiques", "La métaphore identifie implicitement", "La métaphore n''utilise que des animaux ; la comparaison utilise des personnes", "La métaphore est réservée à la poésie ; la comparaison à la prose"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "métaphore" et en quoi diffère-t-elle de la comparaison ?';

UPDATE questions SET 
  bonne_reponse = 'En identifiant le sujet central dont',
  choix = '["En cherchant le mot qui revient le plus souvent", "En identifiant le sujet central dont", "En lisant uniquement le début et la fin du texte", "En comptant le nombre de personnages"]'::jsonb
WHERE enonce = 'Comment identifier le "thème principal" d''un texte ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des effets produits par le',
  choix = '["Le niveau de langue utilisé (familier, courant, soutenu)", "L''ensemble des effets produits par le", "La longueur des phrases du texte", "Le type de narrateur utilisé"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "registre" d''un texte (aussi appelé tonalité) ?';

UPDATE questions SET 
  bonne_reponse = 'La répétition d''un mot ou d''un groupe',
  choix = '["La répétition d''un mot ou d''un groupe", "Une comparaison entre deux réalités très différentes", "Une question posée sans attendre de réponse", "Une exagération délibérée pour produire un effet"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"anaphore" comme figure de style ?';

UPDATE questions SET 
  bonne_reponse = 'Une exagération délibérée pour',
  choix = '["Une atténuation délibérée de la réalité", "Une exagération délibérée pour", "Une comparaison avec un élément très petit", "Un retour en arrière dans la narration"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"hyperbole" comme figure de style ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des mots appartenant à un',
  choix = '["Le vocabulaire difficile d''un texte", "L''ensemble des mots appartenant à un", "Les mots de liaison entre les paragraphes", "Le registre de langue utilisé par l''auteur"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "champ lexical" dans l''analyse d''un texte ?';

UPDATE questions SET 
  bonne_reponse = 'Quand l''auteur dit le contraire de ce',
  choix = '["Par la présence de points d''exclamation", "Quand l''auteur dit le contraire de ce", "Par l''utilisation du vocabulaire mélioratif", "Uniquement dans les textes comiques"]'::jsonb
WHERE enonce = 'Comment repère-t-on l''"ironie" dans un texte littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'Introduction (présentation +',
  choix = '["Introduction - Résumé - Conclusion", "Introduction (présentation +", "Résumé - Analyse stylistique - Biographie de l''auteur", "Thèse - Antithèse - Synthèse uniquement pour les textes argumentatifs"]'::jsonb
WHERE enonce = 'Quelle est la structure d''une explication de texte en français ?';

UPDATE questions SET 
  bonne_reponse = 'Attribuer des caractéristiques',
  choix = '["Donner un nom propre à un personnage fictif", "Attribuer des caractéristiques", "Décrire une personne en détail", "Utiliser un pronom personnel à la première personne"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "personnification" comme figure de style ?';

UPDATE questions SET 
  bonne_reponse = 'En identifiant qui voit et qui sait',
  choix = '["En cherchant si l''auteur apparaît physiquement dans le texte", "En identifiant qui voit et qui sait", "En comptant le nombre de fois que le narrateur utilise ''je''", "En lisant uniquement les dialogues"]'::jsonb
WHERE enonce = 'Comment analyser le "point de vue" d''un narrateur dans un récit ?';

UPDATE questions SET 
  bonne_reponse = 'Une omission narrative',
  choix = '["Une phrase trop longue", "Une omission narrative", "Un personnage muet dans le récit", "Une répétition inutile dans le texte"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"ellipse" dans un récit ?';

UPDATE questions SET 
  bonne_reponse = 'Le texte argumentatif défend une thèse',
  choix = '["Par la présence de personnages", "Le texte argumentatif défend une thèse", "Par la longueur du texte", "Par l''absence de temps verbaux au passé"]'::jsonb
WHERE enonce = 'Comment reconnaître un texte "argumentatif" d''un texte "narratif" ?';

UPDATE questions SET 
  bonne_reponse = 'L''association de deux termes',
  choix = '["Une comparaison entre deux réalités très proches", "L''association de deux termes", "La répétition d''un son consonantique dans une phrase", "Une énumération de qualités opposées"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"oxymore" comme figure de style ?';

UPDATE questions SET 
  bonne_reponse = 'La problématique',
  choix = '["Quel est le résumé du texte ?", "La problématique", "Qui est l''auteur du texte ?", "Combien de figures de style y a-t-il dans le texte ?"]'::jsonb
WHERE enonce = 'Quelle question fondamentale guide l''analyse d''un texte littéraire lors d''une explication de texte ?';

UPDATE questions SET 
  bonne_reponse = 'Introduction - Développement en',
  choix = '["Résumé - Analyse - Biographie de l''auteur", "Introduction - Développement en", "Thèse uniquement - Exemples - Fin", "Introduction - Exemples - Résumé"]'::jsonb
WHERE enonce = 'Quelle est la structure classique d''une dissertation littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'La question centrale à laquelle la',
  choix = '["La liste des exemples qu''on va utiliser", "La question centrale à laquelle la", "Le résumé du sujet donné", "Le plan détaillé de la dissertation"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "problématique" dans une dissertation ?';

UPDATE questions SET 
  bonne_reponse = 'Une entrée en matière qui captive le',
  choix = '["La définition de tous les termes du sujet", "Une entrée en matière qui captive le", "La formulation immédiate de la thèse", "Un résumé du plan de la dissertation"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"accroche" en début d''introduction d''une dissertation ?';

UPDATE questions SET 
  bonne_reponse = 'En formulant un bilan de la partie',
  choix = '["En commençant simplement la nouvelle partie sans transition", "En formulant un bilan de la partie", "En répétant la problématique au début de chaque partie", "En ajoutant des citations entre les parties"]'::jsonb
WHERE enonce = 'Comment rédiger une "transition" entre deux parties d''une dissertation ?';

UPDATE questions SET 
  bonne_reponse = 'Présenter le sujet',
  choix = '["Présenter tous les arguments de la dissertation", "Présenter le sujet", "Donner la réponse définitive à la question posée", "Résumer les conclusions de la dissertation"]'::jsonb
WHERE enonce = 'Quel est le rôle de l''introduction dans une dissertation ?';

UPDATE questions SET 
  bonne_reponse = 'Une raison logique et générale qui',
  choix = '["Un exemple tiré d''un roman ou d''un film", "Une raison logique et générale qui", "Une citation d''auteur", "Un fait historique précis"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "argument" dans un développement de dissertation ?';

UPDATE questions SET 
  bonne_reponse = 'Faire le bilan de la réflexion en',
  choix = '["Répéter l''introduction mot pour mot", "Faire le bilan de la réflexion en", "Introduire de nouveaux arguments non développés dans le corps", "Donner son opinion personnelle sur le sujet"]'::jsonb
WHERE enonce = 'Quel est le rôle de la conclusion dans une dissertation ?';

UPDATE questions SET 
  bonne_reponse = 'Un plan où l''on défend d''abord une',
  choix = '["Un plan avec trois parties identiques", "Un plan où l''on défend d''abord une", "Un plan uniquement pour les dissertations philosophiques", "Un plan avec deux parties opposées sans synthèse"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "plan dialectique" (thèse-antithèse-synthèse) ?';

UPDATE questions SET 
  bonne_reponse = 'En choisissant un exemple précis et',
  choix = '["En citant n''importe quel livre ou film connu", "En choisissant un exemple précis et", "En résumant longuement une œuvre entière", "En donnant plusieurs exemples sans les analyser"]'::jsonb
WHERE enonce = 'Comment illustrer un argument avec un exemple dans une dissertation ?';

UPDATE questions SET 
  bonne_reponse = 'La logique et la progression des idées',
  choix = '["La longueur appropriée du texte", "La logique et la progression des idées", "L''absence de fautes d''orthographe", "L''utilisation de citations littéraires"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "cohérence" dans un texte rédigé ?';

UPDATE questions SET 
  bonne_reponse = 'La paraphrase reformule le texte sans',
  choix = '["Il n''y a aucune différence", "La paraphrase reformule le texte sans", "La paraphrase est réservée aux textes difficiles ; l''analyse aux textes simples", "La paraphrase est plus longue que l''analyse"]'::jsonb
WHERE enonce = 'Quelle est la différence entre une "paraphrase" et une véritable "analyse" dans une dissertation ?';

UPDATE questions SET 
  bonne_reponse = 'En récapitulant l''argument développé',
  choix = '["En répétant le sujet de la dissertation", "En récapitulant l''argument développé", "En introduisant un nouveau sujet pour le paragraphe suivant", "En donnant un exemple supplémentaire"]'::jsonb
WHERE enonce = 'Comment formuler une "phrase de conclusion de paragraphe" efficace ?';

UPDATE questions SET 
  bonne_reponse = 'Ils organisent la progression logique',
  choix = '["Ils servent uniquement à commencer chaque paragraphe", "Ils organisent la progression logique", "Ils remplacent les citations d''auteurs", "Ils servent uniquement dans les introductions"]'::jsonb
WHERE enonce = 'Quel est le rôle des "connecteurs logiques" dans une dissertation ?';

UPDATE questions SET 
  bonne_reponse = 'Redire le sujet en d''autres mots pour',
  choix = '["Copier exactement le sujet donné", "Redire le sujet en d''autres mots pour", "Choisir un autre sujet plus facile", "Résumer ce qu''on va dire dans le développement"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "reformulation du sujet" dans l''introduction d''une dissertation ?';

UPDATE questions SET 
  bonne_reponse = 'Un paragraphe structuré',
  choix = '["Un paragraphe d''au moins 10 lignes", "Un paragraphe structuré", "Un paragraphe avec plusieurs citations d''auteurs", "Un paragraphe sans introduction ni conclusion"]'::jsonb
WHERE enonce = 'Dans une rédaction, qu''est-ce qu''un "paragraphe développé" (PEEL ou méthode équivalente) ?';

UPDATE questions SET 
  bonne_reponse = 'Parce que la dissertation exige un',
  choix = '["Parce que le ''je'' est grammaticalement incorrect", "Parce que la dissertation exige un", "Parce que les correcteurs ne comprennent pas le ''je''", "Parce que c''est une règle arbitraire sans raison logique"]'::jsonb
WHERE enonce = 'Pourquoi faut-il éviter le "je" dans une dissertation académique ?';

UPDATE questions SET 
  bonne_reponse = 'Le baroque',
  choix = '["Le classicisme", "Le romantisme", "Le baroque", "L''humanisme"]'::jsonb
WHERE enonce = 'Quel est le mouvement littéraire caractéristique de la fin du XVIe et du début du XVIIe siècle, marqué par l''abondance ornementale et le mouvement ?';

UPDATE questions SET 
  bonne_reponse = 'Le classicisme',
  choix = '["Le baroque", "Le romantisme", "Le classicisme", "Le symbolisme"]'::jsonb
WHERE enonce = 'Quel mouvement littéraire du XVIIe siècle prône la raison, l''ordre, la clarté et l''imitation des Anciens ?';

UPDATE questions SET 
  bonne_reponse = 'Jean de La Fontaine',
  choix = '["Jean Racine", "Jean de La Fontaine", "Molière", "Pierre Corneille"]'::jsonb
WHERE enonce = 'Qui a écrit "Les Fables" au XVIIe siècle, courts récits poétiques mettant souvent en scène des animaux pour illustrer une morale ?';

UPDATE questions SET 
  bonne_reponse = 'Unité de temps (24h)',
  choix = '["Unité de style, de personnages et de décors", "Unité de temps (24h)", "Unité de langue, de ton et de morale", "Unité d''auteur, d''époque et de genre"]'::jsonb
WHERE enonce = 'Quelle est la règle des "trois unités" dans le théâtre classique français du XVIIe siècle ?';

UPDATE questions SET 
  bonne_reponse = 'Un mouvement qui place l''être humain au',
  choix = '["Un mouvement qui rejette l''Antiquité au profit de la modernité", "Un mouvement qui place l''être humain au", "Un mouvement exclusivement religieux", "Un mouvement qui s''oppose à toute forme d''art"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"Humanisme" de la Renaissance (XVIe siècle) en littérature française ?';

UPDATE questions SET 
  bonne_reponse = 'Voltaire (François-Marie Arouet)',
  choix = '["Jean-Jacques Rousseau", "Denis Diderot", "Voltaire (François-Marie Arouet)", "Montesquieu"]'::jsonb
WHERE enonce = 'Quel philosophe et écrivain du XVIIIe siècle a écrit "Candide" (1759), conte philosophique critiquant l''optimisme de Leibniz ?';

UPDATE questions SET 
  bonne_reponse = 'Un mouvement philosophique qui défend',
  choix = '["Un mouvement artistique centré sur la peinture lumineuse", "Un mouvement philosophique qui défend", "Un mouvement religieux mystique", "Un courant littéraire privilégiant les descriptions de la nature"]'::jsonb
WHERE enonce = 'Qu''est-ce que les "Lumières" (XVIIIe siècle) en France ?';

UPDATE questions SET 
  bonne_reponse = 'Jean-Jacques Rousseau',
  choix = '["Voltaire", "Diderot", "Montesquieu", "Jean-Jacques Rousseau"]'::jsonb
WHERE enonce = 'Quel philosophe du XVIIIe siècle a écrit "Du Contrat Social" (1762) et développé la théorie de la souveraineté populaire ?';

UPDATE questions SET 
  bonne_reponse = 'Le roman courtois',
  choix = '["La fable", "L''épopée antique", "Le roman courtois", "La tragédie classique"]'::jsonb
WHERE enonce = 'Quel est le genre littéraire dominant du Moyen Âge qui raconte les aventures de chevaliers en quête de gloire ou d''amour courtois ?';

UPDATE questions SET 
  bonne_reponse = 'Tartuffe ou l''Imposteur',
  choix = '["L''Avare", "Le Misanthrope", "Tartuffe ou l''Imposteur", "Dom Juan"]'::jsonb
WHERE enonce = 'Quelle pièce de Molière (1622-1673) critique l''hypocrisie religieuse et le faux dévot ?';

UPDATE questions SET 
  bonne_reponse = 'Le genre des textes écrits sous forme',
  choix = '["Le genre dramatique ; le Cid de Corneille", "Le genre des textes écrits sous forme", "Le genre des mémoires autobiographiques ; Les Confessions de Rousseau", "Le genre des textes philosophiques ; l''Encyclopédie de Diderot"]'::jsonb
WHERE enonce = 'Quel est le "genre épistolaire" en littérature française et quelle œuvre du XVIIIe siècle en est un chef-d''œuvre ?';

UPDATE questions SET 
  bonne_reponse = 'Pierre de Ronsard',
  choix = '["François Villon", "Joachim du Bellay", "Pierre de Ronsard", "Agrippa d''Aubigné"]'::jsonb
WHERE enonce = 'Quel poète de la Pléiade du XVIe siècle est l''auteur des "Sonnets pour Hélène" et a popularisé le sonnet en France ?';

UPDATE questions SET 
  bonne_reponse = 'La règle selon laquelle certaines',
  choix = '["La règle selon laquelle le spectacle dure au maximum 2 heures", "La règle selon laquelle certaines", "La règle exigeant que tous les personnages soient de rang noble", "La règle interdisant les personnages féminins sur scène"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "bienséance" dans le théâtre classique français du XVIIe siècle ?';

UPDATE questions SET 
  bonne_reponse = 'Le scepticisme et la connaissance de soi',
  choix = '["La supériorité de la civilisation européenne sur toutes les autres", "Le scepticisme et la connaissance de soi", "La nécessité d''obéir aux autorités religieuses", "La séparation absolue de la philosophie et de la religion"]'::jsonb
WHERE enonce = 'Quelle est la thèse philosophique principale développée par Montaigne dans ses "Essais" (1580-1588) ?';

UPDATE questions SET 
  bonne_reponse = 'Un genre dramatique représentant la',
  choix = '["Une pièce comique se terminant par un mariage", "Un genre dramatique représentant la", "Un texte philosophique en prose sur la mort", "Un récit épique en vers sur des batailles"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "tragédie classique" au XVIIe siècle en France et quels en sont les thèmes principaux ?';

UPDATE questions SET 
  bonne_reponse = 'La presse à imprimer à caractères',
  choix = '["La presse à imprimer à caractères", "L''invention du papier en Europe", "La création des premières bibliothèques universitaires", "L''introduction de l''alphabet latin dans les langues vernaculaires"]'::jsonb
WHERE enonce = 'Quelle invention du XVe siècle a révolutionné la diffusion de la littérature et favorisé l''Humanisme et la Renaissance ?';

UPDATE questions SET 
  bonne_reponse = 'Le romantisme',
  choix = '["Le réalisme", "Le symbolisme", "Le romantisme", "Le naturalisme"]'::jsonb
WHERE enonce = 'Quel mouvement littéraire du XIXe siècle réagit contre la raison des Lumières et valorise les sentiments, la nature et le moi ?';

UPDATE questions SET 
  bonne_reponse = 'Les Misérables',
  choix = '["Notre-Dame de Paris", "Les Misérables", "Le Dernier Jour d''un condamné", "L''Homme qui rit"]'::jsonb
WHERE enonce = 'Quel roman de Victor Hugo (1862) dénonce les injustices sociales à travers les aventures de Jean Valjean et du policier Javert ?';

UPDATE questions SET 
  bonne_reponse = 'Le réalisme',
  choix = '["Le romantisme", "Le symbolisme", "Le réalisme", "Le surréalisme"]'::jsonb
WHERE enonce = 'Quel mouvement littéraire du XIXe siècle cherche à représenter la réalité sociale avec objectivité et exactitude, s''opposant à l''idéalisation romantique ?';

UPDATE questions SET 
  bonne_reponse = 'Germinal',
  choix = '["L''Assommoir", "Nana", "Germinal", "Au Bonheur des Dames"]'::jsonb
WHERE enonce = 'Quelle œuvre d''Émile Zola (1885) décrit la vie des mineurs du nord de la France et constitue le 13e volume des Rougon-Macquart ?';

UPDATE questions SET 
  bonne_reponse = 'Le surréalisme',
  choix = '["Le réalisme", "Le naturalisme", "Le surréalisme", "L''existentialisme"]'::jsonb
WHERE enonce = 'Quel est le mouvement littéraire du début du XXe siècle qui explore l''inconscient, les rêves et libère l''écriture des contraintes rationnelles ?';

UPDATE questions SET 
  bonne_reponse = 'Jean-Paul Sartre',
  choix = '["Albert Camus", "Simone de Beauvoir", "Jean-Paul Sartre", "André Malraux"]'::jsonb
WHERE enonce = 'Quel philosophe et romancier français du XXe siècle est le représentant majeur de l''existentialisme et auteur de "L''Être et le Néant" et "La Nausée" ?';

UPDATE questions SET 
  bonne_reponse = 'L''Étranger',
  choix = '["La Chute", "L''Étranger", "La Peste", "Le Mythe de Sisyphe"]'::jsonb
WHERE enonce = 'Quel roman d''Albert Camus (1942) met en scène Meursault, un homme qui tue un Arabe sans émotion apparente, illustrant l''absurde ?';

UPDATE questions SET 
  bonne_reponse = 'Le symbolisme',
  choix = '["Le Parnasse", "Le réalisme", "Le symbolisme", "Le Dadaïsme"]'::jsonb
WHERE enonce = 'Quel mouvement poétique de la fin du XIXe siècle cherche à suggérer plutôt qu''à décrire, en utilisant la musicalité des mots ?';

UPDATE questions SET 
  bonne_reponse = 'Il a révolutionné la technique',
  choix = '["Il a introduit le roman-fleuve en France", "Il a révolutionné la technique", "Il a créé le roman naturaliste fondé sur des enquêtes scientifiques", "Il a introduit le monologue intérieur dans le roman français"]'::jsonb
WHERE enonce = 'Quel est l''apport de Gustave Flaubert à la technique romanesque avec "Madame Bovary" (1857) ?';

UPDATE questions SET 
  bonne_reponse = 'Un mouvement littéraire qui remet en',
  choix = '["Un genre de romans d''aventures populaires", "Un mouvement littéraire qui remet en", "Un ensemble de romans autobiographiques de l''après-guerre", "Un mouvement qui cherche à rendre le roman plus accessible au grand public"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "Nouveau Roman" français des années 1950-1960 ?';

UPDATE questions SET 
  bonne_reponse = 'Charles Baudelaire',
  choix = '["Paul Verlaine", "Arthur Rimbaud", "Charles Baudelaire", "Stéphane Mallarmé"]'::jsonb
WHERE enonce = 'Quel poète français du XIXe siècle est l''auteur des "Fleurs du Mal" (1857), condamné pour immoralité ?';

UPDATE questions SET 
  bonne_reponse = 'Une poésie qui met la littérature au',
  choix = '["Une poésie qui célèbre la nature et les saisons", "Une poésie qui met la littérature au", "Une poésie exclusivement religieuse", "Une poésie qui respecte strictement les formes fixes comme le sonnet"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "poésie engagée" au XXe siècle et qui en sont les représentants français ?';

UPDATE questions SET 
  bonne_reponse = 'La révolution chinoise de 1927 comme',
  choix = '["L''aventure exotique en Asie sans enjeux politiques", "La révolution chinoise de 1927 comme", "Un roman autobiographique sur la vie de Malraux en Indochine", "La critique de la politique coloniale française en Asie"]'::jsonb
WHERE enonce = 'Quel est le thème central du roman "La Condition humaine" (1933) d''André Malraux ?';

UPDATE questions SET 
  bonne_reponse = 'Un mouvement culturel et littéraire né',
  choix = '["Un mouvement qui défend la suprématie culturelle africaine", "Un mouvement culturel et littéraire né", "Un mouvement exclusivement haïtien de revalorisation de la culture créole", "Un mouvement politique panafricaniste sans dimension littéraire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "Négritude" comme mouvement littéraire du XXe siècle ?';

UPDATE questions SET 
  bonne_reponse = 'À la recherche du temps perdu',
  choix = '["À la recherche du temps perdu", "Les Faux-Monnayeurs", "Le Grand Meaulnes", "Jean-Christophe"]'::jsonb
WHERE enonce = 'Quel roman de Marcel Proust (7 volumes, 1913-1927) explore la mémoire involontaire et le temps perdu à travers la vie de son narrateur dans la société bourgeoise et aristocratique française ?';

UPDATE questions SET 
  bonne_reponse = 'Le dadaïsme',
  choix = '["Le surréalisme", "Le dadaïsme", "L''existentialisme", "Le naturalisme"]'::jsonb
WHERE enonce = 'Quel courant littéraire du XXe siècle, né au lendemain de la Première Guerre mondiale, refuse toute logique et toute esthétique pour détruire les valeurs de la société bourgeoise ?';

UPDATE questions SET 
  bonne_reponse = 'L''étude scientifique du style littéraire',
  choix = '["L''étude des styles vestimentaires dans la littérature", "L''étude scientifique du style littéraire", "L''étude des figures de style uniquement", "L''étude de la grammaire normative"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "stylistique" comme discipline ?';

UPDATE questions SET 
  bonne_reponse = 'L''image de soi que l''orateur projette',
  choix = '["L''émotion provoquée chez l''auditeur", "L''image de soi que l''orateur projette", "L''argument logique et rationnel", "Le style littéraire utilisé par l''auteur"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"ethos" dans la rhétorique classique ?';

UPDATE questions SET 
  bonne_reponse = 'La coexistence de plusieurs voix',
  choix = '["Un texte écrit par plusieurs auteurs", "La coexistence de plusieurs voix", "Un texte qui utilise plusieurs langues", "Un texte avec plusieurs niveaux de narration"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "polyphonie" dans un texte littéraire (concept de Bakhtine) ?';

UPDATE questions SET 
  bonne_reponse = 'L''emploi d''un mot dans deux sens',
  choix = '["Une figure d''analogie entre deux éléments éloignés", "L''emploi d''un mot dans deux sens", "La répétition d''un même son dans une phrase", "L''accumulation de qualificatifs pour un même nom"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "syllepse de sens" (ou syllepse rhétorique) comme figure de style avancée ?';

UPDATE questions SET 
  bonne_reponse = 'Une anticipation dans le récit',
  choix = '["Une anticipation dans le récit", "Un retour en arrière dans le temps narratif", "Une pause descriptive qui arrête le cours de l''histoire", "Une ellipse qui supprime une période de l''histoire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "prolepse" comme figure de narration ?';

UPDATE questions SET 
  bonne_reponse = 'La récurrence de traits sémantiques',
  choix = '["La répétition d''un même mot dans un texte", "La récurrence de traits sémantiques", "La présence de synonymes dans un texte", "L''étude des temps verbaux dans un texte"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"isotopie" en analyse sémantique d''un texte ?';

UPDATE questions SET 
  bonne_reponse = 'La construction d''un verbe avec',
  choix = '["La répétition d''un mot en début de phrase", "La construction d''un verbe avec", "La comparaison entre deux objets très similaires", "L''utilisation de synonymes pour éviter les répétitions"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "zeugme" comme figure de style ?';

UPDATE questions SET 
  bonne_reponse = 'L''argument logique et rationnel qui',
  choix = '["L''appel aux émotions du public", "La crédibilité de l''orateur", "L''argument logique et rationnel qui", "Le style élaboré du discours"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "logos" dans la rhétorique aristotélicienne ?';

UPDATE questions SET 
  bonne_reponse = 'La diégèse est l''univers fictif de',
  choix = '["La diégèse est le style du narrateur ; l''extradiégèse est le style des personnages", "La diégèse est l''univers fictif de", "La diégèse est la partie descriptive du récit ; l''extradiégèse est la partie dialoguée", "La diégèse est le temps de la lecture ; l''extradiégèse est le temps de l''histoire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "diégèse" et l''"extradiégèse" dans la narratologie ?';

UPDATE questions SET 
  bonne_reponse = 'Un registre qui magnifie les actions',
  choix = '["Un registre qui exprime la mélancolie par des métaphores délicates", "Un registre qui magnifie les actions", "Un registre qui cherche à provoquer le rire par des jeux de mots", "Un registre qui dénonce les vices de la société par l''ironie"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "registre épique" et quels sont ses procédés caractéristiques ?';

UPDATE questions SET 
  bonne_reponse = 'La répétition d''un mot ou groupe de',
  choix = '["La répétition d''un mot ou groupe de", "La reprise d''un mot à la fin d''une phrase pour commencer la phrase suivante", "L''accumulation de synonymes pour intensifier un effet", "La suppression d''un mot sous-entendu dans la phrase"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"épanalepse" comme figure de style ?';

UPDATE questions SET 
  bonne_reponse = 'La parataxe juxtapose des propositions',
  choix = '["La parataxe est une figure de style ; l''hypotaxe est une faute de syntaxe", "La parataxe juxtapose des propositions", "La parataxe est utilisée en poésie ; l''hypotaxe dans la prose", "La parataxe et l''hypotaxe sont deux noms pour la même construction syntaxique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "parataxe" et l''"hypotaxe" en stylistique ?';

UPDATE questions SET 
  bonne_reponse = 'Un franchissement des frontières entre',
  choix = '["Une ellipse temporelle dans le récit", "Un franchissement des frontières entre", "Une comparaison entre deux récits différents", "La répétition d''un même épisode raconté deux fois"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "métalepse" en narratologie ?';

UPDATE questions SET 
  bonne_reponse = 'La cadence désigne le rythme des phrases',
  choix = '["La cadence désigne uniquement le rythme musical dans la poésie en vers", "La cadence désigne le rythme des phrases", "La cadence est uniquement l''étude des pauses dans un texte", "La cadence désigne la longueur totale du texte"]'::jsonb
WHERE enonce = 'Quel est le rôle de la "cadence" dans l''analyse stylistique d''un texte ?';

UPDATE questions SET 
  bonne_reponse = 'La disposition en miroir d''éléments de',
  choix = '["La répétition d''un mot en écho dans deux phrases successives", "La disposition en miroir d''éléments de", "L''opposition entre deux idées dans la même phrase", "L''accumulation de termes synonymes"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "chiasme" comme figure de style avancée ?';

UPDATE questions SET 
  bonne_reponse = 'Le transfert d''un qualificatif d''un',
  choix = '["Une répétition intensificatrice", "Le transfert d''un qualificatif d''un", "Une question sans réponse attendue", "Une gradation descendante de termes"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"hypallage" comme figure de style ?';

UPDATE questions SET 
  bonne_reponse = 'L''expression de l''attitude du locuteur',
  choix = '["L''utilisation des modes verbaux (subjonctif, conditionnel)", "L''expression de l''attitude du locuteur", "Le changement de registre de langue dans un texte", "L''organisation temporelle du discours"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "modalisation" dans l''énonciation et à quoi sert-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Une rupture de construction syntaxique',
  choix = '["Une rupture de construction syntaxique", "La répétition d''une même construction syntaxique dans plusieurs phrases successives", "L''omission volontaire d''un verbe dans une proposition", "L''inversion du sujet et du verbe à des fins stylistiques"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"anacoluthe" comme figure de style ou faute de style ?';

UPDATE questions SET 
  bonne_reponse = 'Aimé Césaire',
  choix = '["Léopold Sédar Senghor", "Frantz Fanon", "Aimé Césaire", "Édouard Glissant"]'::jsonb
WHERE enonce = 'Qui est l''auteur du "Cahier d''un retour au pays natal" (1939/1947), œuvre fondatrice de la Négritude ?';

UPDATE questions SET 
  bonne_reponse = 'Un mouvement qui affirme l''identité',
  choix = '["Un mouvement qui défend l''assimilation complète à la culture française", "Un mouvement qui affirme l''identité", "Un mouvement qui rejette l''écriture en français au profit du créole", "Un mouvement exclusivement politique sans dimension littéraire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "Créolité" comme mouvement littéraire et culturel antillais ?';

UPDATE questions SET 
  bonne_reponse = 'Une philosophie de la diversité',
  choix = '["Une théorie qui défend la pureté des cultures nationales", "Une philosophie de la diversité", "Une théorie linguistique sur les langues créoles", "Une théorie politique sur la décolonisation"]'::jsonb
WHERE enonce = 'Qu''est-ce que la théorie de la "Relation" développée par Édouard Glissant ?';

UPDATE questions SET 
  bonne_reponse = 'Texaco',
  choix = '["Solibo Magnifique", "Texaco", "Chronique des sept misères", "Biblique des derniers gestes"]'::jsonb
WHERE enonce = 'Quel roman de Patrick Chamoiseau a remporté le Prix Goncourt en 1992 et explore l''enfance créole martiniquaise ?';

UPDATE questions SET 
  bonne_reponse = 'Poète et homme d''État sénégalais',
  choix = '["Romancier haïtien du mouvement indigéniste", "Poète et homme d''État sénégalais", "Philosophe martiniquais théoricien de la Créolité", "Auteur camerounais du roman Une vie de boy"]'::jsonb
WHERE enonce = 'Qui est Léopold Sédar Senghor et quelle est sa contribution à la littérature francophone ?';

UPDATE questions SET 
  bonne_reponse = 'Une littérature qui explore les',
  choix = '["La littérature écrite dans les colonies avant l''indépendance", "Une littérature qui explore les", "La littérature des colons européens décrivant les pays colonisés", "Une littérature exclusivement politique sans valeur esthétique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la littérature "postcoloniale" et quels sont ses thèmes récurrents ?';

UPDATE questions SET 
  bonne_reponse = 'Ousmane Sembène',
  choix = '["Mongo Beti", "Cheikh Hamidou Kane", "Ousmane Sembène", "Ahmadou Kourouma"]'::jsonb
WHERE enonce = 'Qui a écrit "Les Bouts de bois de Dieu" (1960), roman sur la grève des cheminots Dakar-Niger de 1947-1948 ?';

UPDATE questions SET 
  bonne_reponse = 'Le processus imprévisible par lequel',
  choix = '["Le mélange biologique entre personnes de différentes origines", "Le processus imprévisible par lequel", "L''imitation de la culture européenne par les peuples colonisés", "La création d''une langue pidgin pour la communication interculturelle"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "Créolisation" comme processus culturel selon Glissant ?';

UPDATE questions SET 
  bonne_reponse = 'Les Soleils des indépendances',
  choix = '["Les Soleils des indépendances", "En attendant le vote des bêtes sauvages", "Monnè, outrages et défis", "Allah n''est pas obligé"]'::jsonb
WHERE enonce = 'Quel roman d''Ahmadou Kourouma (1970) dénonce les dérives des régimes politiques africains post-indépendance ?';

UPDATE questions SET 
  bonne_reponse = 'Une littérature qui témoigne des',
  choix = '["La littérature qui nie la Shoah", "Une littérature qui témoigne des", "Une littérature historique objective sur la Seconde Guerre mondiale", "Une littérature exclusivement autobiographique sans valeur littéraire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "littérature de la Shoah" ou "littérature de témoignage" et quels en sont les enjeux ?';

UPDATE questions SET 
  bonne_reponse = 'Psychiatre et penseur martiniquais',
  choix = '["Poète martiniquais fondateur de la Négritude", "Psychiatre et penseur martiniquais", "Romancier sénégalais du réalisme africain", "Philosophe guadeloupéen de la Créolité"]'::jsonb
WHERE enonce = 'Qui est Frantz Fanon et quelle est sa contribution à la pensée anticoloniale ?';

UPDATE questions SET 
  bonne_reponse = 'Elle enrichit le français par des',
  choix = '["Elle utilise le français standard sans innovation", "Elle enrichit le français par des", "Elle remplace le français par les langues locales", "Elle simplifie la langue française pour la rendre accessible"]'::jsonb
WHERE enonce = 'Quel est l''apport linguistique de la littérature francophone africaine et antillaise à la langue française ?';

UPDATE questions SET 
  bonne_reponse = 'Le déchirement entre tradition',
  choix = '["La vie quotidienne dans un village sénégalais traditionnel", "Le déchirement entre tradition", "La résistance armée contre le colonialisme français au Sénégal", "Les inégalités économiques dans l''Afrique post-coloniale"]'::jsonb
WHERE enonce = 'Qu''est-ce que le roman "L''Aventure ambiguë" (1961) de Cheikh Hamidou Kane explore comme thème central ?';

UPDATE questions SET 
  bonne_reponse = 'L''Indigénisme haïtien',
  choix = '["La Créolité", "Le Surréalisme haïtien", "L''Indigénisme haïtien", "Le Réalisme merveilleux"]'::jsonb
WHERE enonce = 'Quel est le mouvement littéraire haïtien des années 1920-1940, contemporain de la Négritude, qui valorise la culture et l''identité haïtiennes face à l''occupation américaine ?';

UPDATE questions SET 
  bonne_reponse = 'Gouverneurs de la rosée',
  choix = '["La Montagne ensorcelée", "Les Fantoches", "Gouverneurs de la rosée", "Bois d''ébène"]'::jsonb
WHERE enonce = 'Quel roman de Jacques Roumain (1944) est considéré comme le chef-d''œuvre de la littérature haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Une esthétique qui intègre',
  choix = '["Un style réaliste qui décrit minutieusement la réalité sans aucun élément fantastique", "Une esthétique qui intègre", "Un mouvement qui rejette la réalité au profit du rêve et de l''inconscient", "Un style de narration qui amplifie délibérément la réalité par l''hyperbole"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "réalisme merveilleux" dans la littérature caribéenne et latino-américaine ?';

UPDATE questions SET 
  bonne_reponse = 'La diaspora produit une littérature de',
  choix = '["La diaspora est un thème mineur de la littérature francophone", "La diaspora produit une littérature de", "La diaspora désigne uniquement les auteurs africains vivant en France", "La diaspora est un concept purement sociologique sans intérêt littéraire"]'::jsonb
WHERE enonce = 'Quelle est l''importance de la notion de "diaspora" dans la littérature francophone contemporaine ?';

UPDATE questions SET 
  bonne_reponse = 'La coexistence dans une société de deux',
  choix = '["La capacité de parler deux langues de façon équivalente", "La coexistence dans une société de deux", "La disparition progressive d''une langue dominée", "Le mélange de deux langues dans un même discours"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "diglossie" selon Charles Ferguson ?';

UPDATE questions SET 
  bonne_reponse = 'Le bilinguisme est la maîtrise de deux',
  choix = '["Ce sont des synonymes exacts", "Le bilinguisme est la maîtrise de deux", "Le bilinguisme est naturel et le multilinguisme est artificiel", "Le bilinguisme est individuel et le multilinguisme est uniquement collectif"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "bilinguisme" et en quoi diffère-t-il du "multilinguisme" ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des choix et mesures qu''un',
  choix = '["Les lois grammaticales officielles d''une langue", "L''ensemble des choix et mesures qu''un", "La censure des œuvres littéraires en langue étrangère", "Les règles d''orthographe imposées par l''Académie"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "politique linguistique" d''un État ?';

UPDATE questions SET 
  bonne_reponse = 'Le passage d''une langue à une autre (ou',
  choix = '["Une erreur de grammaire commise par des locuteurs bilingues", "Le passage d''une langue à une autre (ou", "La traduction simultanée d''un discours", "Le remplacement progressif d''une langue par une autre dans une société"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "code-switching" (ou alternance codique) en sociolinguistique ?';

UPDATE questions SET 
  bonne_reponse = 'Une langue complète',
  choix = '["Un dialecte simplifié d''une langue européenne", "Une langue complète", "Un argot utilisé par les populations défavorisées", "Un mélange non systématique de plusieurs langues sans grammaire propre"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "langue créole" du point de vue linguistique ?';

UPDATE questions SET 
  bonne_reponse = 'Le créole haïtien et le français sont',
  choix = '["Le créole n''a aucun statut officiel en Haïti", "Le créole est l''unique langue officielle d''Haïti", "Le créole haïtien et le français sont", "Le créole est reconnu comme patrimoine culturel mais pas comme langue officielle"]'::jsonb
WHERE enonce = 'Quel est le statut officiel du créole haïtien selon la Constitution haïtienne de 1987 ?';

UPDATE questions SET 
  bonne_reponse = 'La défense de l''authenticité et de la',
  choix = '["La défense de l''authenticité et de la", "La promotion de l''apprentissage des langues étrangères", "La simplification délibérée d''une langue pour la rendre accessible", "L''étude scientifique des langues sans jugement de valeur"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "purisme linguistique" et quels sont ses effets ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des interventions planifiées',
  choix = '["La traduction des textes officiels", "L''ensemble des interventions planifiées", "La censure des langues étrangères dans les médias", "L''étude historique de l''évolution d''une langue"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"aménagement linguistique" et quels exemples peut-on citer ?';

UPDATE questions SET 
  bonne_reponse = 'La variation de la langue selon le',
  choix = '["La qualité grammaticale d''un texte", "La variation de la langue selon le", "L''accent régional d''un locuteur", "Le niveau d''alphabétisation d''une population"]'::jsonb
WHERE enonce = 'Comment définit-on le "registre de langue" (ou niveau de langue) en sociolinguistique ?';

UPDATE questions SET 
  bonne_reponse = 'La discrimination ou la stigmatisation',
  choix = '["La peur irrationnelle des langues étrangères", "La discrimination ou la stigmatisation", "L''interdiction légale de parler certaines langues", "La peur de prendre la parole en public"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "glottophobie" comme forme de discrimination ?';

UPDATE questions SET 
  bonne_reponse = 'Elle est chargée de définir et de',
  choix = '["Elle gouverne directement la France", "Elle est chargée de définir et de", "Elle supervise l''enseignement du français dans les écoles", "Elle protège uniquement les droits d''auteur des écrivains français"]'::jsonb
WHERE enonce = 'Quel est le rôle de l''"Académie française" dans la politique linguistique française ?';

UPDATE questions SET 
  bonne_reponse = 'Les différences systématiques de',
  choix = '["Les erreurs commises par des locuteurs non natifs", "Les différences systématiques de", "Les changements d''une langue à travers le temps", "La différence entre une langue orale et sa forme écrite"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "variation dialectale" d''une langue ?';

UPDATE questions SET 
  bonne_reponse = 'L''emprunt est l''adoption d''un mot d''une',
  choix = '["Oui, l''emprunt lexical appauvrit toujours la langue qui emprunte", "L''emprunt est l''adoption d''un mot d''une", "L''emprunt lexical est une faute de langue à corriger", "L''emprunt lexical n''existe que dans les langues créoles"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"emprunt lexical" en linguistique et est-il un signe d''appauvrissement d''une langue ?';

UPDATE questions SET 
  bonne_reponse = 'Le spectre entre la variété créole la',
  choix = '["La disparition progressive du créole au profit du français", "Le spectre entre la variété créole la", "La transformation d''un créole en une langue standard", "Le mélange de deux créoles différents dans une même communauté"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "continuum créole" en linguistique et quel exemple peut-on citer ?';

UPDATE questions SET 
  bonne_reponse = 'Une approche qui étudie la relation',
  choix = '["L''étude des langues des peuples vivant en milieu naturel", "Une approche qui étudie la relation", "L''étude de l''impact de l''environnement sur l''évolution phonétique", "L''utilisation des langues pour promouvoir la protection de l''environnement"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"écolinguistique" ou "linguistique écologique" comme approche récente ?';

UPDATE questions SET 
  bonne_reponse = 'La norme prescriptive dit comment on',
  choix = '["Deux façons d''écrire la même chose", "La norme prescriptive dit comment on", "La norme prescriptive est scientifique ; la norme descriptive est subjective", "La norme prescriptive s''applique à l''écrit ; la norme descriptive à l''oral"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "norme prescriptive" et la "norme descriptive" en linguistique ?';

UPDATE questions SET 
  bonne_reponse = 'C''est la première langue apprise dans',
  choix = '["C''est la première langue apprise dans", "C''est la langue du pays de naissance, qui est toujours la première langue apprise", "C''est la langue nationale officielle du pays dans lequel on naît", "C''est uniquement une métaphore sans contenu linguistique précis"]'::jsonb
WHERE enonce = 'Qu''est-ce que le concept de "langue maternelle" et pourquoi est-il parfois critiqué ?';

UPDATE questions SET 
  bonne_reponse = 'Un courant qui cherche à identifier les',
  choix = '["Un courant qui analyse uniquement la structure externe des œuvres (nombre de chapitres, division en parties)", "Un courant qui cherche à identifier les", "Un courant qui analyse les structures sociales décrites dans les romans", "Un courant qui étudie l''architecture et l''organisation matérielle des textes manuscrits"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "structuralisme" comme courant de la critique littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'La thèse selon laquelle',
  choix = '["La mort biologique d''un auteur rend ses textes plus importants", "La thèse selon laquelle", "Un événement littéraire qui met fin à l''œuvre d''un auteur", "La disparition progressive des auteurs au profit des éditeurs"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "mort de l''auteur" selon Roland Barthes (1968) ?';

UPDATE questions SET 
  bonne_reponse = 'Une méthode qui montre que les textes',
  choix = '["Une destruction des textes littéraires", "Une méthode qui montre que les textes", "Une méthode de lecture simplifiée pour les étudiants", "La méthode qui reconstruit la biographie d''un auteur à partir de ses textes"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "déconstruction" comme méthode de lecture développée par Jacques Derrida ?';

UPDATE questions SET 
  bonne_reponse = 'La théorie et l''analyse systématique',
  choix = '["L''histoire de la littérature narrative depuis l''Antiquité", "La théorie et l''analyse systématique", "L''étude des narrateurs dans les romans du XIXe siècle uniquement", "La classification des genres littéraires narratifs"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "narratologie" comme discipline et quels en sont les fondateurs ?';

UPDATE questions SET 
  bonne_reponse = 'Une approche qui examine la',
  choix = '["Une critique qui analyse uniquement les œuvres écrites par des femmes", "Une approche qui examine la", "Une critique qui rejette toute littérature masculine", "Une approche uniquement sociologique sans dimension esthétique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "critique féministe" en littérature et quels sont ses objectifs ?';

UPDATE questions SET 
  bonne_reponse = 'Une approche qui analyse les textes',
  choix = '["Une critique qui cherche des idées marxistes dans les textes littéraires", "Une approche qui analyse les textes", "Une critique qui juge les œuvres selon leur utilité politique pour le prolétariat", "Une méthode d''analyse uniquement applicable aux romans réalistes du XIXe siècle"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "critique marxiste" ou "sociocritique" en littérature ?';

UPDATE questions SET 
  bonne_reponse = 'Le fait que tout texte est un tissu de',
  choix = '["La présence de plusieurs auteurs dans un même texte", "Le fait que tout texte est un tissu de", "La comparaison de plusieurs textes du même auteur", "Les notes de bas de page qui renvoient à d''autres textes"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"intertextualité" comme concept théorique (Kristeva/Barthes) ?';

UPDATE questions SET 
  bonne_reponse = 'La théorie selon laquelle le sens d''une',
  choix = '["L''accueil financier d''un livre lors de sa publication", "La théorie selon laquelle le sens d''une", "L''étude des critiques journalistiques d''un livre", "La façon dont un auteur reçoit les influences de ses prédécesseurs"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "réception" d''une œuvre littéraire et l''"esthétique de la réception" (Hans Robert Jauss) ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des œuvres considérées comme',
  choix = '["La liste officielle des livres publiés dans un pays", "L''ensemble des œuvres considérées comme", "Les règles de composition des textes littéraires", "Les récompenses littéraires qui consacrent les meilleurs auteurs"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "canon littéraire" et pourquoi est-il contesté ?';

UPDATE questions SET 
  bonne_reponse = 'Une méthode qui superpose les textes',
  choix = '["L''étude des états psychologiques des personnages dans les romans", "Une méthode qui superpose les textes", "L''application directe de la psychanalyse freudienne à l''auteur à partir de sa biographie", "L''étude des effets psychologiques de la lecture sur les lecteurs"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "psychocritique" comme méthode d''analyse littéraire (Charles Mauron) ?';

UPDATE questions SET 
  bonne_reponse = 'L''analyse de la littérature comme acte',
  choix = '["L''étude des aspects pratiques de la production et de la distribution des livres", "L''analyse de la littérature comme acte", "L''étude des effets économiques de la littérature", "L''analyse de l''utilité sociale de la littérature"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "pragmatique littéraire" ?';

UPDATE questions SET 
  bonne_reponse = 'L''engagement implicite de l''auteur',
  choix = '["Le contrat entre l''auteur et son éditeur pour la publication d''une biographie", "L''engagement implicite de l''auteur", "Les règles stylistiques propres au genre autobiographique", "La promesse de l''autobiographe de ne rien cacher de sa vie"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "pacte autobiographique" selon Philippe Lejeune ?';

UPDATE questions SET 
  bonne_reponse = 'Un courant qui déconstruit les',
  choix = '["Une théorie sur la sexualité dans la littérature érotique", "Un courant qui déconstruit les", "Une théorie qui défend la représentation des personnes LGBTQ+ dans la littérature", "Un mouvement exclusivement américain sans pertinence pour la littérature française"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "théorie queer" en études littéraires ?';

UPDATE questions SET 
  bonne_reponse = 'Un système de conventions et d''attentes',
  choix = '["Une classification rigide des œuvres qui détermine leur valeur", "Un système de conventions et d''attentes", "La distinction entre textes écrits par des hommes et des femmes", "La division entre textes anciens et modernes"]'::jsonb
WHERE enonce = 'Comment définit-on le "genre littéraire" et quelles sont ses fonctions ?';

UPDATE questions SET 
  bonne_reponse = 'Un courant qui examine les',
  choix = '["Une critique qui célèbre les littératures coloniales européennes", "Un courant qui examine les", "Une critique uniquement réservée aux auteurs des anciennes colonies", "Une approche purement politique sans dimension littéraire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la critique "postcoloniale" comme approche théorique (Said, Spivak, Bhabha) ?';

UPDATE questions SET 
  bonne_reponse = 'Le commentaire composé analyse le texte',
  choix = '["Ce sont deux noms pour la même méthode", "Le commentaire composé analyse le texte", "L''explication linéaire va du début à la fin ; le commentaire composé n''analyse que la fin du texte", "Le commentaire composé est réservé aux textes poétiques ; l''explication linéaire aux textes narratifs"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "commentaire composé" et en quoi diffère-t-il de l''explication linéaire ?';

UPDATE questions SET 
  bonne_reponse = 'En dégageant des problèmes ou aspects',
  choix = '["En résumant les différentes parties du texte", "En dégageant des problèmes ou aspects", "En énumérant toutes les figures de style du texte", "En suivant l''ordre chronologique des idées dans le texte"]'::jsonb
WHERE enonce = 'Comment formuler les "axes de lecture" d''un commentaire composé ?';

UPDATE questions SET 
  bonne_reponse = 'La problématique est la question',
  choix = '["Elles sont identiques", "La problématique est la question", "La problématique est au début ; la thèse est à la fin", "La problématique est pour la dissertation ; la thèse est pour le commentaire composé"]'::jsonb
WHERE enonce = 'Quelle est la différence entre la "thèse" et la "problématique" dans une dissertation littéraire avancée ?';

UPDATE questions SET 
  bonne_reponse = 'Un plan qui démontre une thèse sans la',
  choix = '["Un plan qui analyse uniquement des textes littéraires", "Un plan qui démontre une thèse sans la", "Un plan qui suit l''ordre chronologique des arguments", "Un plan uniquement pour les dissertations philosophiques"]'::jsonb
WHERE enonce = 'Quel est le "plan analytique" d''une dissertation par opposition au plan dialectique ?';

UPDATE questions SET 
  bonne_reponse = 'En citant un segment précis entre',
  choix = '["En résumant longuement l''extrait cité", "En citant un segment précis entre", "En reproduisant des paragraphes entiers du texte", "En évitant de citer le texte pour éviter la paraphrase"]'::jsonb
WHERE enonce = 'Comment citer un texte littéraire dans un commentaire ou une dissertation sans paraphraser ?';

UPDATE questions SET 
  bonne_reponse = 'En proposant une question ou une',
  choix = '["En résumant à nouveau le plan de la dissertation", "En proposant une question ou une", "En citant longuement un auteur", "En admettant que la problématique reste sans réponse"]'::jsonb
WHERE enonce = 'Comment rédiger une "ouverture" efficace en conclusion d''une dissertation ?';

UPDATE questions SET 
  bonne_reponse = 'La capacité à prendre du recul par',
  choix = '["L''absence totale de subjectivité dans l''analyse", "La capacité à prendre du recul par", "Le fait de ne jamais utiliser la première personne dans sa rédaction", "La référence constante à des théoriciens et critiques littéraires"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "distanciation critique" dans une dissertation littéraire de niveau avancé ?';

UPDATE questions SET 
  bonne_reponse = 'Chaque paragraphe développe une idée',
  choix = '["Un paragraphe ne doit contenir qu''une seule phrase", "Chaque paragraphe développe une idée", "Un paragraphe doit toujours se terminer par une citation", "Un paragraphe ne doit pas dépasser 5 lignes"]'::jsonb
WHERE enonce = 'Quelle est la règle du "micro-argument" dans la rédaction d''un paragraphe de développement avancé ?';

UPDATE questions SET 
  bonne_reponse = 'En analysant chaque exemple plutôt que',
  choix = '["En n''utilisant qu''un seul exemple par partie", "En analysant chaque exemple plutôt que", "En évitant complètement les exemples et en restant dans l''abstraction", "En utilisant uniquement des citations d''auteurs célèbres"]'::jsonb
WHERE enonce = 'Comment éviter le défaut de la "liste d''exemples" dans une dissertation de niveau avancé ?';

UPDATE questions SET 
  bonne_reponse = 'La progression du raisonnement qui fait',
  choix = '["L''utilisation de connecteurs logiques comme ''premièrement, deuxièmement''", "La progression du raisonnement qui fait", "Le fait que les parties aient la même longueur", "La présence de titres de parties bien formulés"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"articulation logique" du développement dans une dissertation et comment l''assurer ?';

UPDATE questions SET 
  bonne_reponse = 'En examinant les choix lexicaux (niveau',
  choix = '["En identifiant le genre littéraire et la période historique de l''œuvre", "En examinant les choix lexicaux (niveau", "En résumant la biographie de l''auteur", "En comptant le nombre de pages et de chapitres de l''œuvre"]'::jsonb
WHERE enonce = 'Comment analyser le "style" d''un auteur dans un commentaire ou une dissertation avancée ?';

UPDATE questions SET 
  bonne_reponse = 'La reconnaissance que les grands textes',
  choix = '["Une analyse où plusieurs personnes donnent leur avis", "La reconnaissance que les grands textes", "Une méthode qui applique plusieurs théories critiques différentes au même texte", "Une dissertation rédigée en plusieurs parties de longueurs différentes"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "interprétation plurielle" dans l''analyse littéraire avancée ?';

UPDATE questions SET 
  bonne_reponse = 'Mobiliser le contexte (historique',
  choix = '["Ne jamais mentionner l''histoire ou la biographie de l''auteur", "Mobiliser le contexte (historique", "Développer longuement la biographie de l''auteur avant d''analyser le texte", "Faire un cours d''histoire sur l''époque de l''œuvre analysée"]'::jsonb
WHERE enonce = 'Comment "contextualiser" un texte dans une analyse littéraire sans tomber dans le "hors-texte" ?';

UPDATE questions SET 
  bonne_reponse = 'Une problématique originale interroge',
  choix = '["Une problématique originale est celle que personne n''a jamais formulée", "Une problématique originale interroge", "Une problématique originale doit être la plus simple possible", "Une problématique originale cite toujours un théoricien littéraire"]'::jsonb
WHERE enonce = 'Quel est le rôle de la "problématique originale" dans une dissertation de niveau avancé ?';

UPDATE questions SET 
  bonne_reponse = 'En formulant des idées qui ne sont pas',
  choix = '["En choisissant des exemples rares et peu connus", "En formulant des idées qui ne sont pas", "En changeant la structure habituelle de la dissertation", "En utilisant un vocabulaire très technique et spécialisé"]'::jsonb
WHERE enonce = 'Comment construire un "développement non prévisible" dans une dissertation avancée ?';

UPDATE questions SET 
  bonne_reponse = 'XVIIe–XVIIIe siècle',
  choix = '["XVe siècle", "XVIIe–XVIIIe siècle", "XIXe siècle", "XXe siècle"]'::jsonb
WHERE enonce = 'En quelle période le créole haïtien a-t-il principalement émergé comme langue ?';

UPDATE questions SET 
  bonne_reponse = 'Le français',
  choix = '["L''espagnol", "Le français", "Le portugais", "L''anglais"]'::jsonb
WHERE enonce = 'Quelle langue a fourni la majeure partie du vocabulaire du créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Les langues gbe (fon, ewe)',
  choix = '["Les langues bantoues", "Les langues gbe (fon, ewe)", "Les langues nilotiques", "Les langues berbères"]'::jsonb
WHERE enonce = 'Quelle famille de langues africaines a le plus influencé la structure grammaticale du créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = '1987',
  choix = '["1957", "1971", "1987", "2010"]'::jsonb
WHERE enonce = 'En quelle année le créole haïtien a-t-il été reconnu comme langue officielle dans la Constitution d''Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Deux (le français et le créole)',
  choix = '["Une seule (le créole)", "Deux (le français et le créole)", "Trois (le français, le créole et l''anglais)", "Aucune langue officielle"]'::jsonb
WHERE enonce = 'Combien de langues officielles Haïti possède-t-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Les Taïnos (Arawaks)',
  choix = '["Les Aztèques", "Les Mayas", "Les Taïnos (Arawaks)", "Les Incas"]'::jsonb
WHERE enonce = 'Quel peuple autochtone d''Haïti a également contribué au vocabulaire du créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Les voyelles nasales',
  choix = '["Les tons musicaux", "Les voyelles nasales", "Les clics linguaux", "Les consonnes roulées"]'::jsonb
WHERE enonce = 'Quelle caractéristique phonologique héritée du français retrouve-t-on dans le créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'La langue lexificatrice',
  choix = '["La langue substrat", "La langue lexificatrice", "La langue pidgin", "La langue morte"]'::jsonb
WHERE enonce = 'Comment appelle-t-on la langue qui fournit l''essentiel du vocabulaire d''une langue créole ?';

UPDATE questions SET 
  bonne_reponse = 'Les langues africaines qui ont',
  choix = '["La langue officielle de l''État", "Les langues africaines qui ont", "Les emprunts modernes à l''anglais", "La langue des colons français"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "substrat linguistique" dans le contexte du créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Dans les plantations coloniales',
  choix = '["Lors de la colonisation espagnole", "Dans les plantations coloniales", "Lors de la Révolution haïtienne de 1804", "Lors de l''Occupation américaine (1915-1934)"]'::jsonb
WHERE enonce = 'Dans quel contexte historique précis le créole haïtien s''est-il développé ?';

UPDATE questions SET 
  bonne_reponse = 'Entre 10 et 12 millions',
  choix = '["Moins de 2 millions", "Entre 5 et 7 millions", "Entre 10 et 12 millions", "Plus de 50 millions"]'::jsonb
WHERE enonce = 'Quel est le nombre approximatif de locuteurs du créole haïtien dans le monde ?';

UPDATE questions SET 
  bonne_reponse = 'La phonologie',
  choix = '["La morphologie", "La syntaxe", "La phonologie", "La sémantique"]'::jsonb
WHERE enonce = 'Comment appelle-t-on le système des sons d''une langue ?';

UPDATE questions SET 
  bonne_reponse = 'Le créole n''a pas de genre grammatical',
  choix = '["Le créole a plus de genres que le français", "Le créole n''a pas de genre grammatical", "Le créole a trois genres : masculin, féminin et neutre", "Le créole utilise le genre uniquement pour les êtres animés"]'::jsonb
WHERE enonce = 'Quelle caractéristique distingue le créole haïtien du français en matière de genre grammatical ?';

UPDATE questions SET 
  bonne_reponse = 'Le créole de Port-au-Prince',
  choix = '["Le créole du Cap-Haïtien", "Le créole des Cayes", "Le créole de Port-au-Prince", "Le créole de Jacmel"]'::jsonb
WHERE enonce = 'Sur quel dialecte régional le créole haïtien standardisé est-il principalement basé ?';

UPDATE questions SET 
  bonne_reponse = 'L''Akademi Kreyòl Ayisyen (AKA)',
  choix = '["L''Académie française", "L''Akademi Kreyòl Ayisyen (AKA)", "L''Institut de Sauvegarde du Patrimoine National (ISPAN)", "L''UNESCO"]'::jsonb
WHERE enonce = 'Quel organisme officiel est chargé de normaliser la langue créole en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Elle est entièrement phonétique',
  choix = '["Elle est basée sur l''alphabet phonétique international (API)", "Elle est entièrement phonétique", "Elle reprend exactement l''orthographe française", "Elle utilise des tons marqués par des accents toniques"]'::jsonb
WHERE enonce = 'Quelle est la particularité de l''orthographe officielle du créole haïtien établie en 1979 ?';

UPDATE questions SET 
  bonne_reponse = 'Mayi',
  choix = '["Diri", "Mayi", "Pwa", "Bannann"]'::jsonb
WHERE enonce = 'Quel mot créole haïtien d''origine taïno désigne le maïs ?';

UPDATE questions SET 
  bonne_reponse = 'La créolisation',
  choix = '["La pidginisation", "La créolisation", "La décréolisation", "La diglossie"]'::jsonb
WHERE enonce = 'Quel phénomène linguistique décrit la transformation d''un pidgin en langue maternelle d''une communauté ?';

UPDATE questions SET 
  bonne_reponse = 'Ap',
  choix = '["Te", "Ap", "Va", "An"]'::jsonb
WHERE enonce = 'Quel marqueur verbal indique l''aspect progressif (être en train de) en créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'En ajoutant ''yo'' après le nom',
  choix = '["En ajoutant -s à la fin du nom", "En changeant l''article", "En ajoutant ''yo'' après le nom", "En redoublant le nom"]'::jsonb
WHERE enonce = 'Comment forme-t-on le pluriel des noms en créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Te',
  choix = '["Ap", "Va", "Te", "La"]'::jsonb
WHERE enonce = 'Quel marqueur verbal indique le passé en créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Sujet - Verbe - Objet (SVO)',
  choix = '["Verbe - Sujet - Objet", "Sujet - Verbe - Objet (SVO)", "Objet - Sujet - Verbe", "Sujet - Objet - Verbe"]'::jsonb
WHERE enonce = 'Quelle est la structure de base d''une phrase affirmative en créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Pa devant le verbe',
  choix = '["Ne...pas, comme en français", "Pa devant le verbe", "Non après le verbe", "Pwen à la fin de la phrase"]'::jsonb
WHERE enonce = 'Comment exprime-t-on la négation en créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'La',
  choix = '["A", "An", "La", "Nan"]'::jsonb
WHERE enonce = 'Quel article défini en créole haïtien s''utilise après un mot terminant par une consonne ?';

UPDATE questions SET 
  bonne_reponse = 'Mwen',
  choix = '["Ou", "Li", "Mwen", "Nou"]'::jsonb
WHERE enonce = 'Quel est le pronom personnel sujet de la 1ère personne du singulier en créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Avec ''va'' ou ''a''',
  choix = '["Avec ''te''", "Avec ''ap''", "Avec ''va'' ou ''a''", "Avec ''de''"]'::jsonb
WHERE enonce = 'Comment indique-t-on le futur en créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'La formation et la structure des mots',
  choix = '["La structure des phrases", "La formation et la structure des mots", "Les sons de la langue", "Le sens des mots en contexte"]'::jsonb
WHERE enonce = 'Qu''étudie la morphologie dans une langue ?';

UPDATE questions SET 
  bonne_reponse = 'En plaçant le possesseur après le',
  choix = '["Avec ''de'' entre possesseur et possédé", "En plaçant le possesseur après le", "Avec ''li'' pour toute possession", "Avec le suffixe -yo"]'::jsonb
WHERE enonce = 'En créole haïtien, comment exprime-t-on la possession ?';

UPDATE questions SET 
  bonne_reponse = 'Non',
  choix = '["Oui, avec des terminaisons variables comme en français", "Non", "Oui, mais seulement pour les 3 premières personnes", "Non, mais l''article du sujet change à la place"]'::jsonb
WHERE enonce = 'Le verbe créole haïtien se conjugue-t-il selon la personne, comme en français ?';

UPDATE questions SET 
  bonne_reponse = 'Pronom de 3e personne du pluriel ET',
  choix = '["Seulement pronom de 3e personne du pluriel", "Seulement marqueur du pluriel des noms", "Pronom de 3e personne du pluriel ET", "Marqueur du passé et du futur"]'::jsonb
WHERE enonce = 'Quelle est la double fonction grammaticale de "yo" en créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Nan',
  choix = '["Sou", "Nan", "Devan", "Anba"]'::jsonb
WHERE enonce = 'Quelle préposition créole haïtienne exprime la localisation "dans" ou "en" ?';

UPDATE questions SET 
  bonne_reponse = 'Ki jan',
  choix = '["Ki kote", "Ki jan", "Kilè", "Ki moun"]'::jsonb
WHERE enonce = 'Comment dit-on "comment" (question de manière) en créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Te + ap + verbe',
  choix = '["Jis te + verbe", "Te + ap + verbe", "Ap + te + verbe", "Va + ap + verbe"]'::jsonb
WHERE enonce = 'Comment forme-t-on le passé progressif en créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'La structure et l''ordre des mots dans',
  choix = '["La prononciation des sons", "La structure et l''ordre des mots dans", "Le sens des mots isolés", "L''écriture et l''orthographe"]'::jsonb
WHERE enonce = 'Qu''étudie la syntaxe dans une langue ?';

UPDATE questions SET 
  bonne_reponse = 'Ki moun ou ye ?',
  choix = '["Kisa ou ye ?", "Ki moun ou ye ?", "Ki jan ou ye ?", "Kilè ou ye ?"]'::jsonb
WHERE enonce = 'En créole haïtien, comment demande-t-on "Qui es-tu ?" ?';

UPDATE questions SET 
  bonne_reponse = 'Avec ''fini'' (déjà) devant le verbe',
  choix = '["Avec ''fini'' (déjà) devant le verbe", "Avec ''va'' après le verbe", "Avec ''an'' devant le verbe", "Avec le préfixe re-"]'::jsonb
WHERE enonce = 'Comment indique-t-on qu''une action est accomplie (résultat persistant) en créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'La constitution écrite n''a pas de',
  choix = '["La constitution est plus forte que les armes", "La constitution écrite n''a pas de", "Les lois doivent être protégées par l''armée", "La démocratie est supérieure à la dictature"]'::jsonb
WHERE enonce = 'Que signifie le proverbe créole haïtien "Konstitisyon se papye, bayonet se fè" ?';

UPDATE questions SET 
  bonne_reponse = 'Krik... Krak !',
  choix = '["Il était une fois...", "Krik... Krak !", "Pran sa, ban mwen sa", "Tim Tim... Bwa sèch !"]'::jsonb
WHERE enonce = 'Quelle est la formule traditionnelle qui ouvre un conte haïtien (kont) ?';

UPDATE questions SET 
  bonne_reponse = 'Une charade ou devinette',
  choix = '["Un conte populaire", "Une charade ou devinette", "Un proverbe", "Une chanson traditionnelle"]'::jsonb
WHERE enonce = 'Que signifie le mot "devinen" dans la littérature orale haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Au-delà des montagnes',
  choix = '["Les montagnes sont des obstacles insurmontables", "Au-delà des montagnes", "Les montagnes appartiennent à ceux qui les gravissent", "Il faut fuir les montagnes pour réussir"]'::jsonb
WHERE enonce = 'Que signifie le proverbe haïtien "Deye mòn gen mòn" ?';

UPDATE questions SET 
  bonne_reponse = 'Transmettre la sagesse collective',
  choix = '["Seulement divertir les enfants", "Transmettre la sagesse collective", "Servir uniquement dans les cérémonies religieuses", "Remplacer les lois écrites"]'::jsonb
WHERE enonce = 'Quel rôle social jouent les proverbes (pwovèb) dans la culture haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Le soir',
  choix = '["Le matin, avant de partir aux champs", "Le soir", "Pendant les marchés publics", "Dans les églises le dimanche"]'::jsonb
WHERE enonce = 'Dans quel contexte traditionnel les contes haïtiens (kont) étaient-ils principalement racontés ?';

UPDATE questions SET 
  bonne_reponse = 'Un gardien de la mémoire collective et',
  choix = '["Un plat de viande de porc", "Un musicien traditionnel haïtien", "Un gardien de la mémoire collective et", "Un type de proverbe court"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "griyo" ou griot dans la tradition orale haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Malice (Ti Malice)',
  choix = '["Bouki", "Malice (Ti Malice)", "Basile", "Zamba"]'::jsonb
WHERE enonce = 'Quel personnage trickster (rusé) est le héros récurrent des contes haïtiens, incarnant l''intelligence des opprimés ?';

UPDATE questions SET 
  bonne_reponse = 'Bouki',
  choix = '["Basile", "Zamba", "Bouki", "Figuier"]'::jsonb
WHERE enonce = 'Quel personnage naïf et souvent dupé est le partenaire de Ti Malice dans les contes haïtiens ?';

UPDATE questions SET 
  bonne_reponse = 'À plusieurs, le fardeau est léger',
  choix = '["Une main d''œuvre nombreuse est mal payée", "À plusieurs, le fardeau est léger", "Les mains ne mentent jamais", "Le travail manuel est le plus noble"]'::jsonb
WHERE enonce = 'Que signifie le proverbe haïtien "Men anpil, chay pa lou" ?';

UPDATE questions SET 
  bonne_reponse = 'La littérature orale est transmise de',
  choix = '["La littérature orale n''a aucune valeur artistique", "La littérature orale est transmise de", "La littérature écrite est toujours plus complexe", "La littérature orale n''existe qu''en créole"]'::jsonb
WHERE enonce = 'Quelle est la principale différence entre la littérature orale et la littérature écrite ?';

UPDATE questions SET 
  bonne_reponse = 'Ce qui se dit trouve toujours des',
  choix = '["Les vendeurs sont toujours malhonnêtes", "Ce qui se dit trouve toujours des", "Le commerce enrichit ceux qui savent écouter", "Les rumeurs ne sont que du vent"]'::jsonb
WHERE enonce = 'Que signifie le proverbe haïtien "Bouche vann, zorèy achte" ?';

UPDATE questions SET 
  bonne_reponse = 'Un système traditionnel d''entraide pour',
  choix = '["Une fête religieuse communautaire", "Un système traditionnel d''entraide pour", "Une institution bancaire coopérative", "Un rassemblement politique"]'::jsonb
WHERE enonce = 'Quel est l''équivalent haïtien du "konbit" dans la tradition du travail collectif ?';

UPDATE questions SET 
  bonne_reponse = 'Tim Tim ! Bwa sèch !',
  choix = '["Krik ! Krak !", "Tim Tim ! Bwa sèch !", "Ayen ayen ! Bagay la !", "Misye ! Madann !"]'::jsonb
WHERE enonce = 'Les devinettes haïtiennes (devinen) s''ouvrent généralement par quelle formule rituelle ?';

UPDATE questions SET 
  bonne_reponse = 'Des types humains ou forces sociales',
  choix = '["Des animaux réels des forêts haïtiennes", "Des types humains ou forces sociales", "Des dieux africains transformés", "Des ancêtres héroïques"]'::jsonb
WHERE enonce = 'Que représentent généralement les personnages animaux dans les contes haïtiens ?';

UPDATE questions SET 
  bonne_reponse = 'Ils transmettent les valeurs morales',
  choix = '["Ils enseignent uniquement la langue créole écrite", "Ils transmettent les valeurs morales", "Ils servent uniquement à divertir lors des fêtes", "Ils remplacent l''enseignement scolaire formel"]'::jsonb
WHERE enonce = 'Quel est le rôle éducatif des proverbes haïtiens dans la formation des jeunes ?';

UPDATE questions SET 
  bonne_reponse = 'Les faibles n''ont jamais raison face',
  choix = '["Les cafards sont plus forts que les poules", "Les faibles n''ont jamais raison face", "Les animaux vivent en harmonie dans la nature", "Il faut protéger les petits animaux"]'::jsonb
WHERE enonce = 'Que signifie le proverbe haïtien "Ravèt pa janm gen rezon devan poul" ?';

UPDATE questions SET 
  bonne_reponse = 'Les chants rituels (chante lwà)',
  choix = '["La peinture naïve", "Les chants rituels (chante lwà)", "La sculpture en bois", "La décoration des drapo (drapeaux) vodou"]'::jsonb
WHERE enonce = 'Quelle pratique artistique et sociale illustre le mieux la tradition de la littérature orale dans les cérémonies vodou haïtiennes ?';

UPDATE questions SET 
  bonne_reponse = 'Dezafi',
  choix = '["Mur à midi", "Gouverneurs de la rosée", "Dezafi", "Ultravocal"]'::jsonb
WHERE enonce = 'Quel est le titre du premier roman écrit entièrement en créole haïtien, publié en 1975 ?';

UPDATE questions SET 
  bonne_reponse = 'Frankétienne (Frank Étienne)',
  choix = '["Jacques Roumain", "René Depestre", "Frankétienne (Frank Étienne)", "Dany Laferrière"]'::jsonb
WHERE enonce = 'Qui est l''auteur du premier roman en créole haïtien "Dezafi" (1975) ?';

UPDATE questions SET 
  bonne_reponse = 'Un mouvement artistique utilisant des',
  choix = '["Un mouvement qui prône l''usage exclusif du créole dans la littérature", "Un mouvement artistique utilisant des", "Un mouvement politique de résistance à la dictature Duvalier", "Un style poétique inspiré des formes africaines traditionnelles"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "spiralisme" dans la littérature haïtienne dont Frankétienne est le représentant majeur ?';

UPDATE questions SET 
  bonne_reponse = 'Identifier les éléments stylistiques',
  choix = '["Résumer l''histoire racontée", "Identifier les éléments stylistiques", "Traduire le texte en français standard", "Compter les mots et les phrases"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''analyse textuelle d''un texte littéraire cherche principalement à faire ?';

UPDATE questions SET 
  bonne_reponse = 'Jacques Roumain',
  choix = '["Frankétienne", "Jacques Roumain", "René Depestre", "Marie Vieux-Chauvet"]'::jsonb
WHERE enonce = 'Quel grand écrivain haïtien a écrit "Gouverneurs de la rosée" (1944), roman en français sur la vie paysanne haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Un défi',
  choix = '["Une menace", "Un défi", "Un espoir", "Une prière"]'::jsonb
WHERE enonce = 'Quelle est la signification du titre "Dezafi" de Frankétienne ?';

UPDATE questions SET 
  bonne_reponse = 'Un procédé stylistique particulier qui',
  choix = '["Une illustration ou image dans le texte", "Un procédé stylistique particulier qui", "Un personnage secondaire du récit", "Un paragraphe de transition"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "figure de style" dans l''analyse d''un texte littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'Riche',
  choix = '["Simple et accessible à tous les niveaux de lecture", "Riche", "Proche du créole oral quotidien sans élaboration stylistique", "Mélangé de français pour faciliter la compréhension"]'::jsonb
WHERE enonce = 'Dans "Dezafi", le créole haïtien de Frankétienne est décrit comme quel type de langue littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'Un roman',
  choix = '["Un recueil de poèmes", "Un roman", "Une pièce de théâtre", "Un essai philosophique"]'::jsonb
WHERE enonce = 'Quel genre littéraire est "Dezafi" de Frankétienne ?';

UPDATE questions SET 
  bonne_reponse = 'La voix qui raconte l''histoire dans un',
  choix = '["L''auteur réel du texte", "La voix qui raconte l''histoire dans un", "Le personnage principal du roman", "Le lecteur qui interprète le texte"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "narrateur" dans un texte littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'L''oppression politique et la',
  choix = '["La beauté de la nature haïtienne", "L''oppression politique et la", "L''amour romantique impossible", "La modernisation économique d''Haïti"]'::jsonb
WHERE enonce = 'Quel thème central "Dezafi" de Frankétienne aborde-t-il à travers la métaphore du zombie ?';

UPDATE questions SET 
  bonne_reponse = 'Une figure de style qui identifie',
  choix = '["Une comparaison explicite utilisant ''comme'' ou ''tel''", "Une figure de style qui identifie", "Un retour en arrière dans la narration", "Une description détaillée d''un lieu"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "métaphore" dans l''analyse littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'La langue créole est le vecteur',
  choix = '["La langue créole est un obstacle au développement d''Haïti", "La langue créole est le vecteur", "La langue créole doit être remplacée par le français dans tous les domaines", "La langue créole n''a pas de valeur littéraire"]'::jsonb
WHERE enonce = 'Quel est le rôle de la langue créole dans l''identité culturelle haïtienne selon les écrivains créolistes ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des mots se rapportant à un',
  choix = '["L''ensemble du vocabulaire difficile d''un texte", "L''ensemble des mots se rapportant à un", "La liste des personnages du récit", "Les notes et références au bas de la page"]'::jsonb
WHERE enonce = 'En analyse de texte, qu''est-ce que le "champ lexical" ?';

UPDATE questions SET 
  bonne_reponse = 'Jean-Claude Fignolé',
  choix = '["Dany Laferrière", "Jean-Claude Fignolé", "Émile Ollivier", "Kettly Mars"]'::jsonb
WHERE enonce = 'Quel autre grand auteur haïtien contemporain de Frankétienne est connu pour ses romans écrits partiellement en créole et en français ?';

UPDATE questions SET 
  bonne_reponse = 'La coexistence de deux langues (créole',
  choix = '["Un trouble du langage", "La coexistence de deux langues (créole", "L''utilisation exclusive du créole dans l''éducation", "Une forme de traduction simultanée"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "diglossie" dans le contexte linguistique haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Les inégalités sociales',
  choix = '["La beauté perdue du paysage haïtien", "Les inégalités sociales", "L''influence négative de la diaspora haïtienne", "Le manque de développement économique"]'::jsonb
WHERE enonce = 'Que cherche à dénoncer la littérature haïtienne en créole de la période post-1986 ?';

UPDATE questions SET 
  bonne_reponse = 'Un récit où le narrateur-personnage',
  choix = '["Un texte écrit par l''auteur lui-même sous son vrai nom", "Un récit où le narrateur-personnage", "Un texte traduit littéralement du créole au français", "Un type de poème lyrique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "narration à la première personne" dans un texte littéraire ?';

UPDATE questions SET 
  bonne_reponse = 'Un texte qui vise à convaincre le',
  choix = '["Un texte qui raconte une histoire", "Un texte qui vise à convaincre le", "Un texte qui décrit un lieu ou une personne", "Un texte qui explique un phénomène scientifique"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "discours argumentatif" ?';

UPDATE questions SET 
  bonne_reponse = 'La position ou l''affirmation principale',
  choix = '["L''ensemble des exemples utilisés", "La position ou l''affirmation principale", "La conclusion finale du texte", "Les citations d''autres auteurs"]'::jsonb
WHERE enonce = 'Dans un texte argumentatif, qu''est-ce que la "thèse" ?';

UPDATE questions SET 
  bonne_reponse = 'Un argument est une raison générale qui',
  choix = '["Il n''y a aucune différence", "Un argument est une raison générale qui", "Un argument est toujours chiffré ; un exemple ne l''est jamais", "Un exemple est plus convaincant qu''un argument"]'::jsonb
WHERE enonce = 'Quelle est la différence entre un "argument" et un "exemple" dans une argumentation ?';

UPDATE questions SET 
  bonne_reponse = 'La position contraire à la thèse',
  choix = '["La répétition de la thèse principale", "La position contraire à la thèse", "La conclusion du débat", "Une figure de style poétique"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "antithèse" dans un débat ou texte argumentatif ?';

UPDATE questions SET 
  bonne_reponse = 'Mwen ta renmen di',
  choix = '["Kite m pale", "Mwen ta renmen di", "Bouch mwen ouvri", "Pale pou ou"]'::jsonb
WHERE enonce = 'Dans un débat formel en créole haïtien, quelle expression utilise-t-on pour prendre la parole poliment ?';

UPDATE questions SET 
  bonne_reponse = 'Un mot ou expression qui organise les',
  choix = '["Un mot qui désigne une chose concrète", "Un mot ou expression qui organise les", "Un nom propre de personne ou de lieu", "Un adjectif qualificatif"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "connecteur logique" dans un texte argumentatif ?';

UPDATE questions SET 
  bonne_reponse = 'Men / Sepandan',
  choix = '["Epitou", "Donk", "Men / Sepandan", "Poukisa"]'::jsonb
WHERE enonce = 'Comment dit-on "cependant" ou "mais" (pour marquer une opposition) en créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'L''art de bien s''exprimer et de',
  choix = '["L''art de la calligraphie créole", "L''art de bien s''exprimer et de", "L''étude des sons de la langue", "La grammaire normative du créole"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "rhétorique" en argumentation ?';

UPDATE questions SET 
  bonne_reponse = 'Démontrer qu''un argument de',
  choix = '["Accepter entièrement l''argument de l''adversaire", "Démontrer qu''un argument de", "Répéter l''argument pour mieux le comprendre", "Changer de sujet"]'::jsonb
WHERE enonce = 'Dans un débat, qu''est-ce que "réfuter un argument" signifie ?';

UPDATE questions SET 
  bonne_reponse = 'Un raisonnement qui semble valide mais',
  choix = '["Un argument particulièrement solide et irréfutable", "Un raisonnement qui semble valide mais", "Une conclusion provisoire", "Un exemple tiré de l''histoire haïtienne"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "sophisme" dans une argumentation ?';

UPDATE questions SET 
  bonne_reponse = '"Nan lide mwen..." (À mon avis...)',
  choix = '["\"Nan lide mwen...\" (À mon avis...)", "Bonjou tout moun", "Pwoblem nan se...", "Mwen paka dakò"]'::jsonb
WHERE enonce = 'Comment commence-t-on une argumentation structurée en créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Thèse - Antithèse - Synthèse',
  choix = '["Introduction - Développement - Conclusion", "Thèse - Antithèse - Synthèse", "Situation - Complication - Résolution", "Présentation - Arguments - Exemples - Fin"]'::jsonb
WHERE enonce = 'Quelle est la structure classique d''un discours argumentatif bien organisé ?';

UPDATE questions SET 
  bonne_reponse = 'La crédibilité et le caractère moral de',
  choix = '["L''appel aux émotions du public", "La crédibilité et le caractère moral de", "Les preuves logiques et factuelles avancées", "La conclusion persuasive du discours"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"ethos" dans la rhétorique classique (adapté aux débats en créole) ?';

UPDATE questions SET 
  bonne_reponse = 'La prolepse ou procatalepse',
  choix = '["La prolepse ou procatalepse", "L''anaphore", "La synecdoque", "L''hyperbole"]'::jsonb
WHERE enonce = 'Comment appelle-t-on la technique argumentative qui consiste à anticiper les objections de l''adversaire pour les réfuter d''avance ?';

UPDATE questions SET 
  bonne_reponse = 'Écouter avec attention',
  choix = '["Attendre silencieusement que l''adversaire finisse de parler", "Écouter avec attention", "Interrompre l''adversaire dès qu''on est en désaccord", "Prendre des notes sur tout ce qui est dit sans réfléchir"]'::jsonb
WHERE enonce = 'Dans un débat, que signifie "écouter activement" l''adversaire ?';

UPDATE questions SET 
  bonne_reponse = 'Convaincre fait appel à la raison et',
  choix = '["Il n''y a aucune différence", "Convaincre fait appel à la raison et", "Persuader est toujours malhonnête ; convaincre est toujours honnête", "Convaincre s''adresse à un groupe ; persuader s''adresse à un individu"]'::jsonb
WHERE enonce = 'Quelle est la différence entre "convaincre" et "persuader" dans un discours ?';

UPDATE questions SET 
  bonne_reponse = 'Donk / Se poutèt sa',
  choix = '["Men", "Epitou", "Donk / Se poutèt sa", "Malgre"]'::jsonb
WHERE enonce = 'Quel connecteur logique créole exprime la conséquence ou la conclusion ?';

UPDATE questions SET 
  bonne_reponse = 'Parce que l''exclusion des créolophones',
  choix = '["Le créole est plus facile à argumenter que le français", "Parce que l''exclusion des créolophones", "Parce que le créole est la seule langue d''Haïti", "Parce que le créole est plus précis que le français pour les questions politiques"]'::jsonb
WHERE enonce = 'Pourquoi l''argumentation en créole haïtien est-elle un enjeu politique et social important en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des décisions et mesures',
  choix = '["L''étude de la grammaire d''une langue officielle", "L''ensemble des décisions et mesures", "Une langue utilisée exclusivement dans la politique", "L''interdiction d''utiliser certaines langues"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une "politique linguistique" ?';

UPDATE questions SET 
  bonne_reponse = 'La situation où deux langues coexistent',
  choix = '["Un trouble de la parole", "La situation où deux langues coexistent", "L''utilisation alternée de deux langues dans la même phrase", "La politique d''enseignement bilingue"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "diglossie" dans le contexte sociolinguistique haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Réaliser une transition vers un',
  choix = '["Éliminer complètement le français du système éducatif", "Réaliser une transition vers un", "Imposer l''anglais comme langue d''enseignement", "Maintenir le statu quo avec le français comme seule langue d''instruction"]'::jsonb
WHERE enonce = 'Quel est le principal défi de la politique éducative haïtienne en matière linguistique ?';

UPDATE questions SET 
  bonne_reponse = 'L''alternance volontaire entre deux',
  choix = '["Une erreur grammaticale commise par des bilingues", "L''alternance volontaire entre deux", "Un type de traduction littérale du créole au français", "Un dialecte mixte français-créole"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "code-switching" (chanjman kòd) en sociolinguistique ?';

UPDATE questions SET 
  bonne_reponse = 'L''ONU et l''UNESCO',
  choix = '["La Banque Mondiale", "L''ONU et l''UNESCO", "L''Organisation des États Américains (OEA)", "L''OTAN"]'::jsonb
WHERE enonce = 'Quelle organisation internationale a reconnu le droit des langues autochtones et des langues régionales comme le créole haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'L''élimination progressive d''une langue',
  choix = '["La promotion et le soutien aux langues minoritaires", "L''élimination progressive d''une langue", "L''étude scientifique de la disparition des langues", "La traduction de textes sacrés en langues locales"]'::jsonb
WHERE enonce = 'Que signifie la "glottophagie" ou "linguicide" dans le contexte des politiques linguistiques mondiales ?';

UPDATE questions SET 
  bonne_reponse = 'Le créole est maintenu comme langue',
  choix = '["Le créole disparaît complètement dès la première génération d''immigrants", "Le créole est maintenu comme langue", "Le créole est interdit aux États-Unis", "Le créole est devenu une langue officielle dans certains États américains"]'::jsonb
WHERE enonce = 'Quelle est la situation du créole haïtien dans la diaspora haïtienne aux États-Unis ?';

UPDATE questions SET 
  bonne_reponse = 'Le processus d''établissement de règles',
  choix = '["L''interdiction des variantes et dialectes régionaux", "Le processus d''établissement de règles", "La traduction d''une langue vers une autre", "La simplification extrême d''une langue pour la rendre accessible"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "normalisation linguistique" d''une langue ?';

UPDATE questions SET 
  bonne_reponse = 'Parce que les recherches en',
  choix = '["Parce que le français est une langue trop difficile pour les enfants haïtiens", "Parce que les recherches en", "Parce que le créole est plus riche que le français", "Parce que cela est obligatoire selon les lois internationales"]'::jsonb
WHERE enonce = 'Pourquoi certains linguistes et éducateurs haïtiens militent-ils pour l''enseignement en créole dès l''école primaire ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des efforts pour relancer',
  choix = '["L''interdiction d''une langue dominante", "L''ensemble des efforts pour relancer", "La création d''une nouvelle orthographe simplifiée", "La traduction de textes religieux dans la langue concernée"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "revitalisation linguistique" d''une langue en danger ?';

UPDATE questions SET 
  bonne_reponse = 'Les médias en créole (radios',
  choix = '["Les médias n''ont aucun impact sur les langues", "Les médias en créole (radios", "Les médias haïtiens ne diffusent qu''en français", "Les médias internet ont fait disparaître le créole au profit de l''anglais"]'::jsonb
WHERE enonce = 'Quel rôle jouent les médias (radio, télévision, internet) dans la politique linguistique haïtienne actuelle ?';

UPDATE questions SET 
  bonne_reponse = 'Refuser à une personne l''accès à',
  choix = '["La politique linguistique n''a aucun lien avec les droits humains", "Refuser à une personne l''accès à", "Seules les langues officielles méritent une protection par les droits humains", "Les droits linguistiques ne s''appliquent qu''aux langues autochtones en danger"]'::jsonb
WHERE enonce = 'Quel est le lien entre la politique linguistique et les droits humains ?';

UPDATE questions SET 
  bonne_reponse = 'La valeur sociale positive accordée à',
  choix = '["La richesse littéraire d''une langue", "La valeur sociale positive accordée à", "Le nombre de locuteurs d''une langue dans le monde", "La complexité grammaticale d''une langue"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "prestige linguistique" et comment influence-t-il les comportements langagiers ?';

UPDATE questions SET 
  bonne_reponse = 'Il a mis en évidence l''urgence de',
  choix = '["Il a renforcé la domination du français dans les médias haïtiens", "Il a mis en évidence l''urgence de", "Il a conduit à l''abandon du créole au profit de l''anglais dans les ONG", "Il n''a eu aucun impact sur la politique linguistique"]'::jsonb
WHERE enonce = 'Quel impact a eu le tremblement de terre de 2010 sur la politique linguistique haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Le créole s''est adapté au numérique',
  choix = '["Le créole est en déclin sur internet car les jeunes préfèrent l''anglais", "Le créole s''est adapté au numérique", "Le créole ne s''écrit pas sur internet", "Le numérique a standardisé le créole en éliminant les variations"]'::jsonb
WHERE enonce = 'Comment le créole haïtien a-t-il évolué à l''ère numérique et des réseaux sociaux ?';

UPDATE questions SET 
  bonne_reponse = 'Ils ont milité pour la reconnaissance',
  choix = '["Ils ont toujours préféré écrire en français pour atteindre un public plus large", "Ils ont milité pour la reconnaissance", "Ils se sont opposés à l''usage du créole dans la littérature sérieuse", "Leur rôle a été minimal car la politique linguistique relève uniquement de l''État"]'::jsonb
WHERE enonce = 'Quel rôle les intellectuels et écrivains haïtiens ont-ils joué dans la valorisation politique du créole ?';

UPDATE questions SET 
  bonne_reponse = 'La capacité du créole à s''adapter aux',
  choix = '["L''abandon du créole pour les langues globales", "La capacité du créole à s''adapter aux", "L''uniformisation du créole sur le modèle du français international", "La disparition des dialectes régionaux du créole"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "glocalisation" linguistique dans le contexte du créole haïtien contemporain ?';

UPDATE questions SET 
  bonne_reponse = '4',
  choix = '["3","4","5","6"]'::jsonb
WHERE enonce = 'Quelle est la solution de l''équation 2x + 5 = 13 ?';

UPDATE questions SET 
  bonne_reponse = 'x = 8',
  choix = '["x = 6","x = 7","x = 8","x = 9"]'::jsonb
WHERE enonce = 'Résoudre : 3x - 7 = 2x + 1';

UPDATE questions SET 
  bonne_reponse = 'x > 4',
  choix = '["x > 1","x > 3","x > 4","x > 5"]'::jsonb
WHERE enonce = 'Quelle est l''ensemble solution de l''inéquation 2x - 3 > 5 ?';

UPDATE questions SET 
  bonne_reponse = 'x=5, y=2',
  choix = '["x=4, y=3","x=5, y=2","x=6, y=1","x=3, y=4"]'::jsonb
WHERE enonce = 'Résoudre le système : x + y = 7 et x - y = 3';

UPDATE questions SET 
  bonne_reponse = '(x-3)(x+3)',
  choix = '["(x-3)(x+3)","(x-3)²","(x+3)²","(x-9)(x+1)"]'::jsonb
WHERE enonce = 'Factoriser : x² - 9';

UPDATE questions SET 
  bonne_reponse = 'x = 5 ou x = -1',
  choix = '["x = 5 seulement","x = -1 seulement","x = 5 ou x = -1","x = 1 ou x = -5"]'::jsonb
WHERE enonce = 'Quelle est la valeur de x dans l''équation |2x - 4| = 6 ?';

UPDATE questions SET 
  bonne_reponse = 'x = 2 ou x = 3',
  choix = '["x = 2 ou x = 3","x = -2 ou x = -3","x = 1 ou x = 6","x = 2 ou x = -3"]'::jsonb
WHERE enonce = 'Résoudre : x² - 5x + 6 = 0';

UPDATE questions SET 
  bonne_reponse = '-b/a',
  choix = '["-b/a","b/a","c/a","-c/a"]'::jsonb
WHERE enonce = 'Quelle est la somme des solutions d''une équation ax² + bx + c = 0 ?';

UPDATE questions SET 
  bonne_reponse = '-2 < x < 2',
  choix = '["x < -2 ou x > 2","-2 < x < 2","x > 2","x < -2"]'::jsonb
WHERE enonce = 'Résoudre l''inéquation x² - 4 < 0';

UPDATE questions SET 
  bonne_reponse = '1',
  choix = '["1","7","17","25"]'::jsonb
WHERE enonce = 'Quel est le discriminant de 2x² - 3x + 1 = 0 ?';

UPDATE questions SET 
  bonne_reponse = 'x = 9',
  choix = '["x = 7","x = 8","x = 9","x = 10"]'::jsonb
WHERE enonce = 'Résoudre : 2(x+3) = 3(x-1)';

UPDATE questions SET 
  bonne_reponse = 'Trouver tous les réels qui vérifient',
  choix = '["Trouver les entiers solutions","Trouver tous les réels qui vérifient","Trouver les solutions entières positives","Simplifier l''équation"]'::jsonb
WHERE enonce = 'Que signifie résoudre une équation dans ℝ ?';

UPDATE questions SET 
  bonne_reponse = 'On exprime une variable en fonction de',
  choix = '["On additionne les équations","On exprime une variable en fonction de","On multiplie toutes les équations","On divise par le coefficient"]'::jsonb
WHERE enonce = 'Quelle méthode de résolution de système utilise la substitution ?';

UPDATE questions SET 
  bonne_reponse = '3',
  choix = '["5","3","-5","-3"]'::jsonb
WHERE enonce = 'Quelle est la pente d''une droite d''équation y = 3x - 5 ?';

UPDATE questions SET 
  bonne_reponse = '-1',
  choix = '["-1","0","1","2"]'::jsonb
WHERE enonce = 'Quelle est l''image de x = 2 par la fonction f(x) = x² - 3x + 1 ?';

UPDATE questions SET 
  bonne_reponse = 'f(-x) = f(x) pour tout x',
  choix = '["f(-x) = f(x) pour tout x","f(-x) = -f(x) pour tout x","f est croissante","f(0) = 0"]'::jsonb
WHERE enonce = 'Une fonction f est paire si et seulement si ?';

UPDATE questions SET 
  bonne_reponse = '(3, 2)',
  choix = '["(-3, 2)","(3, -2)","(3, 2)","(-3, -2)"]'::jsonb
WHERE enonce = 'Quel est le sommet de la parabole y = (x-3)² + 2 ?';

UPDATE questions SET 
  bonne_reponse = '2π',
  choix = '["π","2π","π/2","4π"]'::jsonb
WHERE enonce = 'Quelle est la période de la fonction sinus sin(x) ?';

UPDATE questions SET 
  bonne_reponse = 'Non, division par zéro',
  choix = '["Oui, f(0) = 0","Oui, f(0) = 1","Non, division par zéro","Non, logarithme négatif"]'::jsonb
WHERE enonce = 'La fonction f(x) = 1/x est-elle définie en x = 0 ?';

UPDATE questions SET 
  bonne_reponse = '(f(b)-f(a))/(b-a)',
  choix = '["La dérivée en a","(f(b)-f(a))/(b-a)","f(a) × f(b)","La valeur moyenne de f"]'::jsonb
WHERE enonce = 'Que représente le taux de variation moyen d''une fonction sur [a,b] ?';

UPDATE questions SET 
  bonne_reponse = 'f(x - 3)',
  choix = '["f(x) + 3","f(x) - 3","f(x + 3)","f(x - 3)"]'::jsonb
WHERE enonce = 'Quelle transformation déplace le graphe de f(x) de 3 unités vers la droite ?';

UPDATE questions SET 
  bonne_reponse = '(x-1)/2',
  choix = '["(x-1)/2","(x+1)/2","2x-1","x/2 + 1"]'::jsonb
WHERE enonce = 'Pour la fonction f(x) = 2x + 1, que vaut f⁻¹(x) ?';

UPDATE questions SET 
  bonne_reponse = 'x ≥ 4',
  choix = '["ℝ","x ≥ 0","x ≥ 4","x > 4"]'::jsonb
WHERE enonce = 'Quel est le domaine de définition de f(x) = √(x - 4) ?';

UPDATE questions SET 
  bonne_reponse = 'Pour tout x₁ < x₂ dans [a,b], f(x₁) < f',
  choix = '["f(a) > f(b)","Pour tout x₁ < x₂ dans [a,b], f(x₁) < f","f est positive","La dérivée est négative"]'::jsonb
WHERE enonce = 'Une fonction est croissante sur [a,b] si ?';

UPDATE questions SET 
  bonne_reponse = '[0, +∞[',
  choix = '["ℝ","ℝ⁺","[-1, 1]","[0, +∞["]'::jsonb
WHERE enonce = 'Quel est l''ensemble image de la fonction f(x) = x² sur ℝ ?';

UPDATE questions SET 
  bonne_reponse = 'Un x tel que f(x) = 0',
  choix = '["La valeur minimale de f","Un x tel que f(x) = 0","La dérivée de f","L''image de 0 par f"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un zéro (racine) d''une fonction f ?';

UPDATE questions SET 
  bonne_reponse = '5',
  choix = '["3","5","6","7"]'::jsonb
WHERE enonce = 'Quelle est la distance entre les points A(1,2) et B(4,6) ?';

UPDATE questions SET 
  bonne_reponse = 'opposé/hypothénuse',
  choix = '["adjacent/hypothénuse","opposé/adjacent","opposé/hypothénuse","hypothénuse/opposé"]'::jsonb
WHERE enonce = 'Dans un triangle rectangle, sin(α) est égal à ?';

UPDATE questions SET 
  bonne_reponse = '1/2',
  choix = '["√3/2","1/2","√2/2","1"]'::jsonb
WHERE enonce = 'Quelle est la valeur de cos(60°) ?';

UPDATE questions SET 
  bonne_reponse = '(x-2)²+(y-3)²=25',
  choix = '["(x-2)²+(y-3)²=5","(x-2)²+(y-3)²=25","(x+2)²+(y+3)²=25","x²+y²=25"]'::jsonb
WHERE enonce = 'Quelle est l''équation d''un cercle de centre O(2,3) et de rayon 5 ?';

UPDATE questions SET 
  bonne_reponse = '1',
  choix = '["0","1","√2","1/2"]'::jsonb
WHERE enonce = 'Que vaut tan(45°) ?';

UPDATE questions SET 
  bonne_reponse = 'sin²x + cos²x = 1',
  choix = '["sin²x + cos²x = 0","sin²x + cos²x = 1","sin²x - cos²x = 1","tan²x + 1 = sin²x"]'::jsonb
WHERE enonce = 'Quelle est l''identité trigonométrique fondamentale ?';

UPDATE questions SET 
  bonne_reponse = '-1/2',
  choix = '["-1/2","2","-2","1/2"]'::jsonb
WHERE enonce = 'Quelle est la pente d''une droite perpendiculaire à y = 2x + 1 ?';

UPDATE questions SET 
  bonne_reponse = '1/2',
  choix = '["√3/2","1/2","√2/2","1"]'::jsonb
WHERE enonce = 'Que vaut sin(30°) ?';

UPDATE questions SET 
  bonne_reponse = 'π',
  choix = '["π/2","π","2π","3π/2"]'::jsonb
WHERE enonce = 'Comment convertit-on 180° en radians ?';

UPDATE questions SET 
  bonne_reponse = 'ac + bd',
  choix = '["ac + bd","ad + bc","ac - bd","a/c + b/d"]'::jsonb
WHERE enonce = 'Quelle est la formule du produit scalaire de deux vecteurs u(a,b) et v(c,d) ?';

UPDATE questions SET 
  bonne_reponse = '0',
  choix = '["1","-1","0","Infini"]'::jsonb
WHERE enonce = 'Deux vecteurs sont perpendiculaires si leur produit scalaire est ?';

UPDATE questions SET 
  bonne_reponse = 'rθ',
  choix = '["θ/r","r/θ","rθ","πr²θ"]'::jsonb
WHERE enonce = 'Quelle formule donne la longueur de l''arc d''un cercle de rayon r pour un angle θ (en radians) ?';

UPDATE questions SET 
  bonne_reponse = '(3,5)',
  choix = '["(2,5)","(3,5)","(4,6)","(6,10)"]'::jsonb
WHERE enonce = 'Quel est le milieu du segment [AB] avec A(1,3) et B(5,7) ?';

UPDATE questions SET 
  bonne_reponse = '3x²',
  choix = '["x²","3x²","3x","2x³"]'::jsonb
WHERE enonce = 'Quelle est la dérivée de f(x) = x³ ?';

UPDATE questions SET 
  bonne_reponse = 'cos(x)',
  choix = '["-sin(x)","cos(x)","-cos(x)","sin(x)"]'::jsonb
WHERE enonce = 'Quelle est la dérivée de f(x) = sin(x) ?';

UPDATE questions SET 
  bonne_reponse = 'La pente de la tangente à la courbe en',
  choix = '["L''aire sous la courbe","La pente de la tangente à la courbe en","La valeur maximale","La concavité de la courbe"]'::jsonb
WHERE enonce = 'Que représente la dérivée f''(a) géométriquement ?';

UPDATE questions SET 
  bonne_reponse = 'eˣ',
  choix = '["x·eˣ","eˣ","eˣ⁻¹","ln(x)"]'::jsonb
WHERE enonce = 'Quelle est la dérivée de f(x) = eˣ ?';

UPDATE questions SET 
  bonne_reponse = 'Positif',
  choix = '["Négatif","Nul","Positif","Variable"]'::jsonb
WHERE enonce = 'Quel est le signe de f''(x) sur un intervalle où f est croissante ?';

UPDATE questions SET 
  bonne_reponse = '2',
  choix = '["1","2","4","6"]'::jsonb
WHERE enonce = 'Comment calcule-t-on ∫₀² x dx ?';

UPDATE questions SET 
  bonne_reponse = 'L''aire sous la courbe entre x=a et x=b',
  choix = '["La dérivée de f","L''aire sous la courbe entre x=a et x=b","La valeur moyenne de f","Le maximum de f"]'::jsonb
WHERE enonce = 'Que représente ∫ₐᵇ f(x) dx géométriquement pour f(x) ≥ 0 ?';

UPDATE questions SET 
  bonne_reponse = 'f(x)·g''(x) + f''(x)·g(x)',
  choix = '["f''(x)·g''(x)","f(x)·g''(x) + f''(x)·g(x)","f''(x)/g(x)","f(x)/g''(x)"]'::jsonb
WHERE enonce = 'Quelle est la dérivée du produit f(x)·g(x) ?';

UPDATE questions SET 
  bonne_reponse = 'x² + 3x + C',
  choix = '["x² + 3x + C","2x² + 3x + C","x² + 3 + C","2 + C"]'::jsonb
WHERE enonce = 'Quelle est la primitive de f(x) = 2x + 3 ?';

UPDATE questions SET 
  bonne_reponse = 'f''(x) = 0 (et changement de signe de f'')',
  choix = '["f''(x) est maximale","f''(x) = 0 (et changement de signe de f'')","f(x) = 0","f''(x) > 0"]'::jsonb
WHERE enonce = 'Un extremum local de f se trouve aux valeurs de x où ?';

UPDATE questions SET 
  bonne_reponse = 'f''(g(x))·g''(x)',
  choix = '["f''(x)·g(x)","f''(g(x))·g''(x)","f(g''(x))","f''(g''(x))"]'::jsonb
WHERE enonce = 'Quelle est la dérivée de la fonction composée f(g(x)) ?';

UPDATE questions SET 
  bonne_reponse = 'Théorème fondamental du calcul',
  choix = '["Théorème de Pythagore","Théorème fondamental du calcul","Théorème de Thalès","Théorème de Bayes"]'::jsonb
WHERE enonce = 'Quel théorème relie dérivée et intégrale ?';

UPDATE questions SET 
  bonne_reponse = '1',
  choix = '["0","1","∞","Indéterminé"]'::jsonb
WHERE enonce = 'Que vaut lim(x→0) sin(x)/x ?';

UPDATE questions SET 
  bonne_reponse = '3',
  choix = '["0","2","3","∞"]'::jsonb
WHERE enonce = 'Que vaut lim(x→+∞) (3x² + 2x) / x² ?';

UPDATE questions SET 
  bonne_reponse = '0/0',
  choix = '["0/0","∞/∞","0×∞","∞-∞"]'::jsonb
WHERE enonce = 'Quelle est la forme indéterminée de lim(x→0) x/x ?';

UPDATE questions SET 
  bonne_reponse = 'Test de d''Alembert (ratio)',
  choix = '["Test de la divergence","Test de d''Alembert (ratio)","Test de Cauchy","Test de comparaison"]'::jsonb
WHERE enonce = 'Quel test détermine la convergence d''une série en comparant avec une série géométrique ?';

UPDATE questions SET 
  bonne_reponse = '1/(1-r)',
  choix = '["1/(1+r)","1/(1-r)","r/(1-r)","1/r"]'::jsonb
WHERE enonce = 'Quelle est la somme de la série géométrique convergente Σ(r^n) pour |r| < 1 ?';

UPDATE questions SET 
  bonne_reponse = 'y = Ce^(kx)',
  choix = '["y = kx + C","y = Ce^(kx)","y = Cx + ke^x","y = C sin(kx)"]'::jsonb
WHERE enonce = 'Quelle est la solution générale de l''équation différentielle y'' = ky (k constante) ?';

UPDATE questions SET 
  bonne_reponse = 'L''approximation de f par une série de',
  choix = '["La valeur de f en a","L''approximation de f par une série de","La dérivée de f en a","La primitive de f"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un développement de Taylor d''une fonction f en a ?';

UPDATE questions SET 
  bonne_reponse = 'lim(x→a) f(x) = f(a)',
  choix = '["f''(a) existe","lim(x→a) f(x) = f(a)","f(a) = 0","f est dérivable en a"]'::jsonb
WHERE enonce = 'Que représente la continuité d''une fonction en un point a ?';

UPDATE questions SET 
  bonne_reponse = '1 + x',
  choix = '["1 + x","1 - x","x","e + x"]'::jsonb
WHERE enonce = 'Quel est le développement limité de eˣ au premier ordre en 0 ?';

UPDATE questions SET 
  bonne_reponse = 'Σ|aₙ| converge',
  choix = '["Σaₙ converge","Σ|aₙ| converge","aₙ → 0","La série alterne"]'::jsonb
WHERE enonce = 'Une série est absolument convergente si ?';

UPDATE questions SET 
  bonne_reponse = 'La limite du taux de variation en a',
  choix = '["f est continue en a","La limite du taux de variation en a","f(a) = 0","f est monotone au voisinage de a"]'::jsonb
WHERE enonce = 'Que signifie la dérivabilité d''une fonction en un point a ?';

UPDATE questions SET 
  bonne_reponse = 'aₙ → 0',
  choix = '["aₙ → 0","aₙ > 0","Σaₙ diverge","aₙ est décroissante"]'::jsonb
WHERE enonce = 'Quelle condition est nécessaire (mais pas suffisante) pour la convergence d''une série Σaₙ ?';

UPDATE questions SET 
  bonne_reponse = 'lim f/g = lim f''/g''',
  choix = '["lim f/g = lim f''/g","lim f/g = lim f''/g''","lim f/g = lim f × g''","lim f/g = (lim f)/(lim g)"]'::jsonb
WHERE enonce = 'Quelle est la formule de la règle de L''Hôpital pour les formes indéterminées 0/0 ?';

UPDATE questions SET 
  bonne_reponse = 'Équation linéaire du 1er ordre',
  choix = '["Équation du 2ème ordre","Équation linéaire du 1er ordre","Équation homogène","Équation de Bernoulli"]'::jsonb
WHERE enonce = 'Quel type d''équation différentielle est dy/dx + P(x)y = Q(x) ?';

UPDATE questions SET 
  bonne_reponse = 'f''(x)/f(x)',
  choix = '["1/f(x)","f''(x)/f(x)","f(x)/f''(x)","ln(f''(x))"]'::jsonb
WHERE enonce = 'Quelle est la règle pour dériver ln(f(x)) ?';

UPDATE questions SET 
  bonne_reponse = '0',
  choix = '["2","1","0","-1"]'::jsonb
WHERE enonce = 'Que vaut ∫₋₁¹ x dx ?';

UPDATE questions SET 
  bonne_reponse = 'Une matrice ayant autant de lignes que',
  choix = '["Une matrice avec une seule colonne","Une matrice ayant autant de lignes que","Une matrice de dimension 2×3","Une matrice diagonale"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une matrice carrée ?';

UPDATE questions SET 
  bonne_reponse = 'ad - bc',
  choix = '["ac + bd","ad - bc","ab - cd","a + d"]'::jsonb
WHERE enonce = 'Quel est le déterminant de la matrice 2×2 [[a,b],[c,d]] ?';

UPDATE questions SET 
  bonne_reponse = 'Un ensemble muni de l''addition et de la',
  choix = '["Un ensemble de vecteurs géométriques","Un ensemble muni de l''addition et de la","Un graphe","Une matrice diagonale"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un espace vectoriel ?';

UPDATE questions SET 
  bonne_reponse = 'Être libre (linéairement indépendant)',
  choix = '["Être orthogonal","Être libre (linéairement indépendant)","Avoir un déterminant non nul","Être de norme 1"]'::jsonb
WHERE enonce = 'Quelle propriété un ensemble de vecteurs doit-il satisfaire pour être une base ?';

UPDATE questions SET 
  bonne_reponse = 'Un scalaire λ tel que Av = λv pour un',
  choix = '["Le déterminant de A","Un scalaire λ tel que Av = λv pour un","La trace de A","Un coefficient de A"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une valeur propre d''une matrice A ?';

UPDATE questions SET 
  bonne_reponse = 'Chaque élément (AB)ᵢⱼ = somme des',
  choix = '["Élément par élément","Chaque élément (AB)ᵢⱼ = somme des","Addition terme à terme","Transposer B puis multiplier"]'::jsonb
WHERE enonce = 'Comment multiplier deux matrices A(m×n) et B(n×p) ?';

UPDATE questions SET 
  bonne_reponse = 'La matrice obtenue en échangeant lignes',
  choix = '["La matrice inverse","La matrice obtenue en échangeant lignes","Le déterminant","La trace"]'::jsonb
WHERE enonce = 'Qu''est-ce que la transposée d''une matrice A ?';

UPDATE questions SET 
  bonne_reponse = 'La dimension de l''espace image de',
  choix = '["Le nombre de lignes","Le nombre de colonnes de la matrice réduite","La dimension de l''espace image de","Le déterminant"]'::jsonb
WHERE enonce = 'Quel est le rang d''une matrice ?';

UPDATE questions SET 
  bonne_reponse = 'Son déterminant est non nul',
  choix = '["Sa trace est non nulle","Son déterminant est non nul","Elle est symétrique","Elle est diagonale"]'::jsonb
WHERE enonce = 'Quelle est la condition pour qu''une matrice carrée soit inversible ?';

UPDATE questions SET 
  bonne_reponse = 'L''écrire sous la forme PDP⁻¹ où D est',
  choix = '["La rendre triangulaire","L''écrire sous la forme PDP⁻¹ où D est","Calculer son déterminant","Trouver sa transposée"]'::jsonb
WHERE enonce = 'Qu''est-ce que la diagonalisation d''une matrice ?';

UPDATE questions SET 
  bonne_reponse = 'La somme de ses éléments diagonaux',
  choix = '["Le produit de ses éléments diagonaux","La somme de ses éléments diagonaux","Le déterminant","La somme de tous ses éléments"]'::jsonb
WHERE enonce = 'Quelle est la trace d''une matrice A ?';

UPDATE questions SET 
  bonne_reponse = 'Une application f: E→F telle que f(αu +',
  choix = '["Une fonction affine","Une application f: E→F telle que f(αu +","Une matrice carrée","Un isomorphisme"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une application linéaire ?';

UPDATE questions SET 
  bonne_reponse = 'L''élimination de Gauss-Jordan',
  choix = '["La méthode de Newton","L''élimination de Gauss-Jordan","La méthode des éléments finis","La décomposition QR"]'::jsonb
WHERE enonce = 'Quel outil résout un système linéaire Ax = b par réductions ?';

UPDATE questions SET 
  bonne_reponse = 'Un vecteur perpendiculaire au plan',
  choix = '["Un scalaire","Un vecteur perpendiculaire au plan","La somme des composantes","La projection de u sur v"]'::jsonb
WHERE enonce = 'Pour deux vecteurs u et v, qu''est-ce que leur produit vectoriel u × v donne ?';

UPDATE questions SET 
  bonne_reponse = 'Un procédé pour construire une base',
  choix = '["Une factorisation de matrices","Un procédé pour construire une base","Un algorithme de tri","Une méthode de résolution d''équations différentielles"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''orthonormalisation de Gram-Schmidt ?';

UPDATE questions SET 
  bonne_reponse = 'P(A ∩ B) / P(B)',
  choix = '["P(A) + P(B)","P(A ∩ B) / P(B)","P(A) × P(B)","P(A ∪ B) - P(B)"]'::jsonb
WHERE enonce = 'Quelle est la formule de la probabilité conditionnelle P(A|B) ?';

UPDATE questions SET 
  bonne_reponse = 'Théorème de Bayes',
  choix = '["Théorème de Pythagore","Théorème de Bayes","Théorème central limite","Loi des grands nombres"]'::jsonb
WHERE enonce = 'Quel théorème permet de "inverser" les probabilités conditionnelles ?';

UPDATE questions SET 
  bonne_reponse = 'Une variable avec une distribution en',
  choix = '["Une variable ne prenant que des valeurs entières","Une variable avec une distribution en","Une variable uniforme","Une variable de Poisson"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une variable aléatoire normale (gaussienne) ?';

UPDATE questions SET 
  bonne_reponse = 'La somme de variables aléatoires',
  choix = '["La somme de variables aléatoires","Les probabilités convergent vers 1","La moyenne empirique est toujours normale","Les variables indépendantes sont non corrélées"]'::jsonb
WHERE enonce = 'Que dit le théorème central limite ?';

UPDATE questions SET 
  bonne_reponse = 'La médiane',
  choix = '["La moyenne","La médiane","L''écart-type","La variance"]'::jsonb
WHERE enonce = 'Quelle mesure statistique est robuste aux valeurs extrêmes (outliers) ?';

UPDATE questions SET 
  bonne_reponse = 'Un intervalle qui capture le paramètre',
  choix = '["Un intervalle contenant 95% des données","Un intervalle qui capture le paramètre","Un intervalle de probabilité 0.95","Une borne d''erreur"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un intervalle de confiance à 95% ?';

UPDATE questions SET 
  bonne_reponse = 'E[X²] - (E[X])²',
  choix = '["E[X]","E[X²] - (E[X])²","E[X] × P(X)","(E[X])²"]'::jsonb
WHERE enonce = 'Quelle est la variance d''une variable aléatoire X ?';

UPDATE questions SET 
  bonne_reponse = 'Une mesure normalisée de leur',
  choix = '["Leur somme","Une mesure normalisée de leur","Leur différence de variance","La covariance brute"]'::jsonb
WHERE enonce = 'Qu''est-ce que la corrélation entre deux variables X et Y ?';

UPDATE questions SET 
  bonne_reponse = 'Test t de Student',
  choix = '["Test du chi-carré","Test t de Student","Test de Fisher","Test de Kolmogorov-Smirnov"]'::jsonb
WHERE enonce = 'Quel test statistique compare les moyennes de deux groupes indépendants ?';

UPDATE questions SET 
  bonne_reponse = 'La distribution du nombre d''événements',
  choix = '["Une distribution continue symétrique","La distribution du nombre d''événements","Une loi normale centrée","Une loi uniforme sur [0,1]"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une loi de Poisson ?';

UPDATE questions SET 
  bonne_reponse = 'σ = √Var(X)',
  choix = '["σ = Var(X)","σ = √Var(X)","Var(X) = σ","σ = Var(X)²"]'::jsonb
WHERE enonce = 'Quelle est la relation entre variance et écart-type ?';

UPDATE questions SET 
  bonne_reponse = 'La probabilité d''observer un résultat',
  choix = '["La probabilité que H₀ soit vraie","La probabilité d''observer un résultat","La puissance du test","L''erreur de type I"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une p-valeur en test d''hypothèse ?';

UPDATE questions SET 
  bonne_reponse = 'Binomiale',
  choix = '["Poisson","Normale","Binomiale","Géométrique"]'::jsonb
WHERE enonce = 'Quelle loi modélise le nombre de succès dans n essais indépendants avec probabilité p ?';

UPDATE questions SET 
  bonne_reponse = 'Hispaniola (Haïti/Quisqueya)',
  choix = '["Cuba", "Porto Rico", "Hispaniola (Haïti/Quisqueya)", "La Jamaïque"]'::jsonb
WHERE enonce = 'Sur quelle île Haïti est-elle située ?';

UPDATE questions SET 
  bonne_reponse = '27 750 km²',
  choix = '["10 000 km²", "18 000 km²", "27 750 km²", "45 000 km²"]'::jsonb
WHERE enonce = 'Quelle est la superficie approximative d''Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'La Selle (2 680 m) dans le Massif de la',
  choix = '["Le Pic Macaya (2 347 m) dans le Massif de la Hotte", "La Selle (2 680 m) dans le Massif de la", "Le Bonnet à l''Évêque (2 674 m) dans le Massif du Nord", "Le Pic Trois Rivières (2 100 m) dans la Chaîne des Matheux"]'::jsonb
WHERE enonce = 'Quel est le point culminant d''Haïti et dans quelle chaîne de montagnes se trouve-t-il ?';

UPDATE questions SET 
  bonne_reponse = 'Le Fleuve Artibonite',
  choix = '["La Rivière du Nord", "Le Fleuve Artibonite", "La Rivière Trois Rivières", "Le Grand Rivière du Nord"]'::jsonb
WHERE enonce = 'Quel est le fleuve le plus long d''Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Avril-juin et août-octobre',
  choix = '["Janvier-mars et juillet-septembre", "Avril-juin et août-octobre", "Février-avril et novembre-décembre", "Mai-juillet et octobre-novembre"]'::jsonb
WHERE enonce = 'Quelles sont les deux saisons de pluies en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Lac Azuei',
  choix = '["Lac Azuei", "Lac Miragoane", "Lac des Cayes", "Étang de Miragoâne"]'::jsonb
WHERE enonce = 'Comment s''appelle le principal lac d''eau saumâtre d''Haïti, situé dans la plaine du Cul-de-Sac ?';

UPDATE questions SET 
  bonne_reponse = 'Très montagneux',
  choix = '["Essentiellement plat avec quelques collines", "Très montagneux", "Principalement constitué de plateaux élevés", "Essentiellement côtier et bas"]'::jsonb
WHERE enonce = 'Quel type de relief caractérise principalement le territoire haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'La Chaîne des Matheux / Montagnes Noires',
  choix = '["Le Massif de la Selle", "Le Massif de la Hotte", "La Chaîne du Bonnet à l''Évêque", "La Chaîne des Matheux / Montagnes Noires"]'::jsonb
WHERE enonce = 'Quelle chaîne de montagnes sépare le Nord d''Haïti de la partie centrale du pays ?';

UPDATE questions SET 
  bonne_reponse = 'La Plaine de l''Artibonite',
  choix = '["La Plaine du Cul-de-Sac", "La Plaine de l''Artibonite", "La Plaine des Cayes", "La Plaine des Gonaïves"]'::jsonb
WHERE enonce = 'Quelle est la principale zone de production agricole de plaine en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'L''Océan Atlantique Nord',
  choix = '["La Mer des Caraïbes", "L''Océan Atlantique Nord", "Le Golfe du Mexique", "La Mer des Sargasses"]'::jsonb
WHERE enonce = 'Quelle mer borde la côte nord d''Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Parce qu''elle est située dans la',
  choix = '["Parce qu''elle est trop plate pour résister aux vents", "Parce qu''elle est située dans la", "Parce qu''elle n''a pas de montagnes pour bloquer les vents", "Parce que les ouragans ne touchent que les pays pauvres"]'::jsonb
WHERE enonce = 'Pourquoi Haïti est-elle particulièrement vulnérable aux ouragans ?';

UPDATE questions SET 
  bonne_reponse = 'La Péninsule du Cap Tiburon / du Sud',
  choix = '["La Péninsule du Nord", "La Péninsule de Saint-Nicolas (Tiburon)", "La Péninsule du Cap Tiburon / du Sud", "La Presqu''île de Jérémie"]'::jsonb
WHERE enonce = 'Comment s''appelle la péninsule la plus au sud d''Haïti, qui abrite le Massif de la Hotte ?';

UPDATE questions SET 
  bonne_reponse = 'Le vent humide est bloqué par les',
  choix = '["Un phénomène de réchauffement des océans qui crée des sécheresses", "Le vent humide est bloqué par les", "Une perturbation thermique des plaines côtières", "Un phénomène de brouillard dense dans les vallées"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''effet de Fœhn (ou effet de versant) et comment influence-t-il le climat haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Dans le département du Nord-Ouest',
  choix = '["Dans le département du Sud", "Dans le département du Nord-Ouest", "Dans le département de l''Ouest, près de Port-au-Prince", "Dans le département de l''Artibonite"]'::jsonb
WHERE enonce = 'Où se situe la Presqu''île du Nord-Ouest d''Haïti, connue pour ses conditions arides ?';

UPDATE questions SET 
  bonne_reponse = 'Les glissements de terrain et les',
  choix = '["Les éruptions volcaniques", "Les glissements de terrain et les", "Les tempêtes de sable", "Les avalanches de neige"]'::jsonb
WHERE enonce = 'Quel est le principal danger naturel lié au relief montagneux et à la déforestation en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Le département de l''Artibonite',
  choix = '["Le département de l''Ouest", "Le département de l''Artibonite", "Le département du Sud-Est", "Le département du Nord"]'::jsonb
WHERE enonce = 'Quel département haïtien possède la plus grande superficie ?';

UPDATE questions SET 
  bonne_reponse = '10',
  choix = '["8", "10", "12", "15"]'::jsonb
WHERE enonce = 'Combien de départements compte Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Le Lac de Péligre',
  choix = '["Le Lac Azuei", "Le Lac de Miragoane", "Le Lac de Péligre", "Le Lac des Cayes"]'::jsonb
WHERE enonce = 'Quel lac artificiel haïtien a été créé par le barrage de Péligre sur le fleuve Artibonite ?';

UPDATE questions SET 
  bonne_reponse = '11 millions',
  choix = '["3 millions", "6 millions", "11 millions", "20 millions"]'::jsonb
WHERE enonce = 'Quelle est la population approximative d''Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Port-au-Prince, département de l''Ouest',
  choix = '["Cap-Haïtien, département du Nord", "Port-au-Prince, département de l''Ouest", "Les Cayes, département du Sud", "Gonaïves, département de l''Artibonite"]'::jsonb
WHERE enonce = 'Quelle est la capitale d''Haïti et dans quel département se trouve-t-elle ?';

UPDATE questions SET 
  bonne_reponse = 'Cap-Haïtien',
  choix = '["Gonaïves", "Jacmel", "Cap-Haïtien", "Les Cayes"]'::jsonb
WHERE enonce = 'Quelle est la deuxième ville d''Haïti par sa taille et son importance historique ?';

UPDATE questions SET 
  bonne_reponse = 'L''agriculture',
  choix = '["L''industrie manufacturière", "Le secteur des services (secteur informel)", "L''agriculture", "Le tourisme"]'::jsonb
WHERE enonce = 'Quel secteur économique emploie la majorité de la population haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Le café',
  choix = '["Le coton", "La canne à sucre", "Le café", "La banane"]'::jsonb
WHERE enonce = 'Quelle culture d''exportation est historiquement la plus importante pour l''économie haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'L''industrie textile et de l''assemblage',
  choix = '["La production pétrolière", "L''industrie textile et de l''assemblage", "La production d''aluminium", "L''industrie minière"]'::jsonb
WHERE enonce = 'Quelle est la principale industrie moderne d''Haïti en termes d''emploi et d''exportation ?';

UPDATE questions SET 
  bonne_reponse = 'Environ 55-60 %',
  choix = '["Moins de 20 %", "Environ 35 %", "Environ 55-60 %", "Plus de 80 %"]'::jsonb
WHERE enonce = 'Quelle proportion de la population haïtienne vit en milieu rural ?';

UPDATE questions SET 
  bonne_reponse = 'Les Haïtiens vivant à l''étranger',
  choix = '["La population haïtienne des zones rurales", "Les Haïtiens vivant à l''étranger", "Les entrepreneurs haïtiens de Port-au-Prince", "Les paysans sans terres en Haïti"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "diaspora haïtienne" et quel rôle joue-t-elle dans l''économie nationale ?';

UPDATE questions SET 
  bonne_reponse = 'Haïti a le plus bas IDH des Amériques',
  choix = '["Haïti a l''IDH le plus élevé des Caraïbes", "Haïti a un IDH moyen comparable à la moyenne caribéenne", "Haïti a le plus bas IDH des Amériques", "Haïti a un IDH légèrement inférieur à la moyenne caribéenne"]'::jsonb
WHERE enonce = 'Quel est l''indicateur de développement humain (IDH) d''Haïti par rapport aux autres pays caribéens ?';

UPDATE questions SET 
  bonne_reponse = 'L''instabilité politique chronique',
  choix = '["Le manque de ressources naturelles", "L''instabilité politique chronique", "L''absence de main-d''œuvre qualifiée", "L''isolement géographique"]'::jsonb
WHERE enonce = 'Quel est le principal obstacle au développement économique d''Haïti selon les économistes ?';

UPDATE questions SET 
  bonne_reponse = 'Le bois et le charbon de bois',
  choix = '["Le gaz naturel", "L''hydroélectricité", "Le bois et le charbon de bois", "L''énergie solaire"]'::jsonb
WHERE enonce = 'Quelle est la principale source d''énergie domestique en Haïti, responsable en partie de la déforestation ?';

UPDATE questions SET 
  bonne_reponse = 'L''or, le cuivre et la bauxite',
  choix = '["Le pétrole et le gaz naturel offshore", "L''or, le cuivre et la bauxite", "Le diamant et le platine", "Le fer et l''acier"]'::jsonb
WHERE enonce = 'Quelles sont les principales ressources minières d''Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Il a provoqué la mort de plus de 200',
  choix = '["Il n''a eu aucun impact significatif sur la distribution de la population", "Il a provoqué la mort de plus de 200", "Il a entraîné une urbanisation accélérée de Port-au-Prince", "Il a amélioré les infrastructures de transport"]'::jsonb
WHERE enonce = 'Quel est l''impact du tremblement de terre de janvier 2010 sur la géographie humaine d''Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Un marché en plein air qui se tient à',
  choix = '["Un supermarché moderne à Port-au-Prince", "Un marché en plein air qui se tient à", "Un marché financier informel haïtien", "Un système de troc rural entre paysans"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "marché périodique" (mache) dans la géographie économique haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Plus de 65 %',
  choix = '["Moins de 10 %", "Environ 25 %", "Environ 50 %", "Plus de 65 %"]'::jsonb
WHERE enonce = 'Quel pourcentage de la population haïtienne n''a pas accès à l''électricité de réseau ?';

UPDATE questions SET 
  bonne_reponse = 'Des camionnettes ou autobus décorés',
  choix = '["Des bateaux de pêche artisanale sur les côtes haïtiennes", "Des camionnettes ou autobus décorés", "Des motocyclettes taxis dans les zones rurales", "Des routes nationales pavées reliant les départements"]'::jsonb
WHERE enonce = 'Quel est le rôle des "tap-tap" dans la géographie des transports en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Elle crée une macrocéphalie urbaine qui',
  choix = '["Elle favorise le développement équilibré de toutes les régions", "Elle crée une macrocéphalie urbaine qui", "Elle permet une meilleure gestion centralisée des ressources nationales", "Elle a peu d''impact sur les régions périphériques"]'::jsonb
WHERE enonce = 'Quel impact a la concentration de la population à Port-au-Prince sur le développement du pays ?';

UPDATE questions SET 
  bonne_reponse = 'La mangue Francisque',
  choix = '["La banane plantain", "La mangue Francisque", "La papaye", "L''ananas"]'::jsonb
WHERE enonce = 'Quel fruit tropical haïtien est une importante culture d''exportation depuis les années 1990 ?';

UPDATE questions SET 
  bonne_reponse = 'L''ensemble des îles de la mer des',
  choix = '["Seulement les grandes îles (Cuba, Haïti, Porto Rico, Jamaïque)", "L''ensemble des îles de la mer des", "L''Amérique centrale et le Mexique uniquement", "Seulement les anciennes colonies françaises et britanniques"]'::jsonb
WHERE enonce = 'Qu''est-ce que la région Caraïbe comprend géographiquement ?';

UPDATE questions SET 
  bonne_reponse = 'Cuba',
  choix = '["Hispaniola", "Cuba", "Porto Rico", "La Jamaïque"]'::jsonb
WHERE enonce = 'Quelle est la plus grande île des Caraïbes ?';

UPDATE questions SET 
  bonne_reponse = 'La Communauté caribéenne',
  choix = '["Une organisation militaire des Caraïbes", "La Communauté caribéenne", "Un traité commercial entre Haïti et les États-Unis", "L''organisation des pays producteurs de rhum"]'::jsonb
WHERE enonce = 'Qu''est-ce que la CARICOM ?';

UPDATE questions SET 
  bonne_reponse = 'Le Brésil',
  choix = '["Le Mexique", "L''Argentine", "Le Brésil", "La Colombie"]'::jsonb
WHERE enonce = 'Quel est le plus grand pays d''Amérique latine en superficie et en population ?';

UPDATE questions SET 
  bonne_reponse = 'L''Amazone',
  choix = '["Le Rio de la Plata", "L''Orénoque", "Le Parana", "L''Amazone"]'::jsonb
WHERE enonce = 'Quel est le plus grand fleuve du monde en volume d''eau, qui traverse l''Amérique du Sud ?';

UPDATE questions SET 
  bonne_reponse = 'Les Andes',
  choix = '["Les Andes", "La Sierra Madre", "Les Appalaches", "La Cordillère des Caraïbes"]'::jsonb
WHERE enonce = 'Dans quelle chaîne de montagnes se trouve le point culminant des Amériques, l''Aconcagua ?';

UPDATE questions SET 
  bonne_reponse = 'La étroite bande de terre reliant',
  choix = '["Un grand lac en Amérique centrale", "La étroite bande de terre reliant", "Une chaîne de montagnes entre le Costa Rica et la Colombie", "Un archipel dans la mer des Caraïbes"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''isthme de Panama et quel est son importance géographique ?';

UPDATE questions SET 
  bonne_reponse = 'L''arc insulaire qui s''étend de Porto',
  choix = '["L''ensemble des îles et pays caribéens de moins de 10 000 km²", "L''arc insulaire qui s''étend de Porto", "Les territoires ultramarins français des Caraïbes seulement", "Les îles situées au sud de Cuba et au nord d''Haïti"]'::jsonb
WHERE enonce = 'Quelles sont les Petites Antilles et comment sont-elles organisées géographiquement ?';

UPDATE questions SET 
  bonne_reponse = 'La vulnérabilité aux cyclones et à la',
  choix = '["L''aridité et le manque d''eau", "La vulnérabilité aux cyclones et à la", "La pollution de l''air industriel", "La désertification des terres agricoles"]'::jsonb
WHERE enonce = 'Quel est le principal problème environnemental commun à la majorité des pays caribéens ?';

UPDATE questions SET 
  bonne_reponse = 'Le tourisme international et les',
  choix = '["L''agriculture vivrière", "L''extraction pétrolière et minière", "Le tourisme international et les", "L''industrie lourde"]'::jsonb
WHERE enonce = 'Quelle est l''économie dominante des petites îles caribéennes comme la Barbade, la Jamaïque ou Saint-Martin ?';

UPDATE questions SET 
  bonne_reponse = 'Le Canal du Vent (Windward Passage) et',
  choix = '["Le Détroit de Gibraltar", "Le Canal du Vent (Windward Passage) et", "Le Détroit de Drake", "Le Canal de Yucatan"]'::jsonb
WHERE enonce = 'Quel détroit sépare Cuba et Haïti des États-Unis (Floride) ?';

UPDATE questions SET 
  bonne_reponse = 'Le Brésil',
  choix = '["L''Uruguay", "Le Paraguay", "L''Argentine", "Le Brésil"]'::jsonb
WHERE enonce = 'Quel pays d''Amérique latine est le seul dont la langue officielle est le portugais ?';

UPDATE questions SET 
  bonne_reponse = 'Le plus grand écosystème de forêt',
  choix = '["La plus grande étendue désertique du monde", "Le plus grand écosystème de forêt", "La principale source mondiale d''eau douce souterraine", "La zone avec la plus grande biodiversité marine au monde"]'::jsonb
WHERE enonce = 'Qu''est-ce que le bassin amazonien représente sur le plan écologique mondial ?';

UPDATE questions SET 
  bonne_reponse = 'El Niño (ENSO)',
  choix = '["La Nina", "El Niño (ENSO)", "L''Alizé", "Le Gulf Stream"]'::jsonb
WHERE enonce = 'Comment s''appelle le phénomène océanique qui affecte périodiquement les côtes du Pacifique sud-américain et perturbe les précipitations en Amérique latine et dans les Caraïbes ?';

UPDATE questions SET 
  bonne_reponse = 'L''anglais (dominant) et le français',
  choix = '["Le français et l''espagnol", "L''anglais et le néerlandais", "L''anglais (dominant) et le français", "Le créole et l''anglais"]'::jsonb
WHERE enonce = 'Quelles sont les deux principales langues officielles des pays membres de la CARICOM ?';

UPDATE questions SET 
  bonne_reponse = 'Il contrôle le passage maritime entre',
  choix = '["Il fournit de l''eau potable à tous les pays caribéens", "Il contrôle le passage maritime entre", "Il génère des ressources hydrauliques pour l''irrigation en Amérique centrale", "Il est une frontière naturelle entre le nord et le sud des Amériques"]'::jsonb
WHERE enonce = 'Quel est l''enjeu géopolitique principal du Canal de Panama pour les Caraïbes ?';

UPDATE questions SET 
  bonne_reponse = 'Les deux pays partagent la même île',
  choix = '["Les deux pays ont un niveau de développement identique malgré leur histoire commune", "L''économie dominicaine est basée sur le pétrole, l''haïtienne sur le café", "Les deux pays partagent la même île", "Les frontières géographiques ont empêché tout échange économique entre les deux pays"]'::jsonb
WHERE enonce = 'Comment la relation géographique entre Haïti et la République Dominicaine illustre-t-elle des contrastes de développement ?';

UPDATE questions SET 
  bonne_reponse = 'L''espagnol',
  choix = '["Le portugais", "Le créole anglais", "L''espagnol", "Le quechua"]'::jsonb
WHERE enonce = 'Quelle est la principale langue de l''Amérique centrale continentale (Guatemala, Honduras, Nicaragua, Costa Rica, El Salvador, Panama) ?';

UPDATE questions SET 
  bonne_reponse = 'Le processus d''intensification des',
  choix = '["La colonisation progressive des pays pauvres par les pays riches", "Le processus d''intensification des", "L''uniformisation complète des cultures mondiales", "La domination militaire des États-Unis sur le monde"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "mondialisation" en géographie ?';

UPDATE questions SET 
  bonne_reponse = 'L''étude des relations entre les États',
  choix = '["L''étude des ressources naturelles mondiales", "L''étude des relations entre les États", "L''étude de la distribution géographique des populations", "La gestion des frontières internationales par des organismes internationaux"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "géopolitique" en tant que discipline ?';

UPDATE questions SET 
  bonne_reponse = 'Le cœur continental eurasien dont le',
  choix = '["Un pays côtier dominant le commerce maritime", "Le cœur continental eurasien dont le", "Un petit pays situé entre deux grandes puissances", "Une zone géographique riche en ressources pétrolières"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "État pivot" ou "heartland" dans la théorie géopolitique de Mackinder ?';

UPDATE questions SET 
  bonne_reponse = 'Les firmes multinationales (FMN)',
  choix = '["Seulement les organisations régionales comme l''UE et la CARICOM", "Les firmes multinationales (FMN)", "Seulement les banques centrales nationales", "Les partis politiques internationaux"]'::jsonb
WHERE enonce = 'Quels sont les principaux acteurs de la mondialisation économique au-delà des États ?';

UPDATE questions SET 
  bonne_reponse = 'Un groupe informel de grandes économies',
  choix = '["Un bloc militaire occidental regroupant le Brésil, la Russie, l''Inde, la Chine et l''Afrique du Sud", "Un groupe informel de grandes économies", "Une organisation économique rivale de l''OCDE réservée aux pays pauvres", "Un traité de libre-échange entre les pays du Sud"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un "BRICS" en géopolitique mondiale ?';

UPDATE questions SET 
  bonne_reponse = 'L''écart de développement économique et',
  choix = '["La différence climatique entre l''hémisphère nord et l''hémisphère sud", "L''écart de développement économique et", "Un conflit politique entre les pays européens et africains", "La distribution des ressources naturelles entre les deux hémisphères"]'::jsonb
WHERE enonce = 'Qu''est-ce que les "Nord-Sud" et les "inégalités mondiales de développement" désignent en géographie ?';

UPDATE questions SET 
  bonne_reponse = 'Un ensemble de prescriptions',
  choix = '["Un accord de paix entre les États-Unis et l''Amérique latine", "Un ensemble de prescriptions", "Un traité d''intégration économique des Amériques", "Une déclaration sur les droits de l''homme signée à Washington"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "Consensus de Washington" et comment a-t-il influencé les pays en développement comme Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Ce sont des points de passage obligés',
  choix = '["Ils servent uniquement à la pêche industrielle", "Ce sont des points de passage obligés", "Ils sont des frontières naturelles entre des États en guerre", "Leur importance est purement touristique"]'::jsonb
WHERE enonce = 'Quel est l''enjeu géopolitique des détroits maritimes comme le Détroit d''Ormuz ou le Canal de Suez ?';

UPDATE questions SET 
  bonne_reponse = 'L''inégalité d''accès aux technologies de',
  choix = '["La distinction entre l''internet fixe et l''internet mobile", "L''inégalité d''accès aux technologies de", "La différence de vitesse internet entre les pays du Nord et du Sud", "La domination des entreprises américaines dans le domaine du numérique"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "fracture numérique" dans le contexte de la mondialisation ?';

UPDATE questions SET 
  bonne_reponse = 'La prédominance des États-Unis dans les',
  choix = '["La domination militaire des États-Unis sur l''Europe uniquement", "La prédominance des États-Unis dans les", "Le contrôle américain de toutes les organisations internationales", "La supériorité technologique américaine dans le domaine spatial"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''"hégémonie américaine" dans le contexte de l''ordre mondial post-1945 ?';

UPDATE questions SET 
  bonne_reponse = 'Elles accordent à un État des droits',
  choix = '["Elles servent uniquement à protéger les espèces marines en voie d''extinction", "Elles accordent à un État des droits", "Elles définissent les eaux où la navigation de plaisance est interdite", "Elles sont des zones de libre-échange maritime"]'::jsonb
WHERE enonce = 'Quel rôle jouent les "zones économiques exclusives" (ZEE) dans les rivalités géopolitiques marines ?';

UPDATE questions SET 
  bonne_reponse = 'Les disparités spatiales de',
  choix = '["La distribution des richesses naturelles entre les continents", "Les disparités spatiales de", "La différence de superficie entre les grands et les petits États", "La localisation des conflits armés dans le monde"]'::jsonb
WHERE enonce = 'Qu''est-ce que la "géographie des inégalités" mesure à l''échelle mondiale ?';

UPDATE questions SET 
  bonne_reponse = 'Il crée de nouvelles tensions sur les',
  choix = '["Il n''a pas d''impact sur les relations entre États", "Il crée de nouvelles tensions sur les", "Il conduit à une coopération internationale harmonieuse", "Il avantage uniquement les pays du nord en leur donnant de nouvelles terres agricoles"]'::jsonb
WHERE enonce = 'Comment le changement climatique remodèle-t-il la géopolitique mondiale au XXIe siècle ?';

UPDATE questions SET 
  bonne_reponse = 'La capacité d''un acteur à influencer le',
  choix = '["La puissance militaire non-nucléaire d''un État", "La capacité d''un acteur à influencer le", "La force économique d''un pays mesurée par son PIB", "La diplomatie secrète menée hors des canaux officiels"]'::jsonb
WHERE enonce = 'Qu''est-ce que le "soft power" dans la géopolitique contemporaine ?';

UPDATE questions SET 
  bonne_reponse = 'L''Afrique sub-saharienne',
  choix = '["L''Amérique latine", "L''Asie du Sud-Est", "L''Afrique sub-saharienne", "L''Europe de l''Est"]'::jsonb
WHERE enonce = 'Quel continent est le plus concerné par la problématique du développement et de la pauvreté dans la géopolitique mondiale contemporaine ?';

UPDATE questions SET 
  bonne_reponse = 'Un vaste projet d''infrastructure (routes',
  choix = '["Une politique de préservation des routes commerciales médiévales", "Un vaste projet d''infrastructure (routes", "Un accord de libre-échange entre la Chine et l''Asie centrale", "Un projet culturel de promotion de la civilisation chinoise"]'::jsonb
WHERE enonce = 'Qu''est-ce que les "nouvelles routes de la soie" (Belt and Road Initiative) de la Chine ?';

UPDATE questions SET 
  bonne_reponse = 'Un forum de coopération internationale',
  choix = '["Un gouvernement mondial supranational qui impose ses décisions aux États", "Un forum de coopération internationale", "Une organisation militaire comme l''OTAN", "Une banque de développement pour les pays pauvres"]'::jsonb
WHERE enonce = 'Quel est le rôle de l''Organisation des Nations Unies (ONU) dans l''ordre géopolitique mondial ?';

UPDATE questions SET 
  bonne_reponse = 'Les migrations suivent principalement',
  choix = '["Les migrations sont aléatoires et ne suivent aucune logique géographique", "Les migrations suivent principalement", "Les migrations mondiales se font principalement entre pays du même niveau de développement", "Les migrations sont surtout motivées par des facteurs culturels et religieux, non économiques"]'::jsonb
WHERE enonce = 'Comment les flux migratoires mondiaux illustrent-ils les inégalités géographiques mondiales ?';

UPDATE questions SET 
  bonne_reponse = 'Le paiement de l''indemnité de 150',
  choix = '["La signature du Traité de Ryswick", "Le paiement de l''indemnité de 150", "La création de la première constitution haïtienne", "L''intégration d''Haïti dans l''Organisation des États Américains"]'::jsonb
WHERE enonce = 'Quel événement géopolitique majeur d''Haïti a marqué son isolement international au XIXe siècle ?';

UPDATE questions SET 
  bonne_reponse = 'Parce qu''elle a violé la souveraineté',
  choix = '["Parce qu''elle a apporté la démocratie à Haïti", "Parce qu''elle a violé la souveraineté", "Parce qu''elle a créé l''armée haïtienne", "Parce qu''elle a résolu tous les problèmes économiques d''Haïti"]'::jsonb
WHERE enonce = 'Pourquoi l''Occupation américaine d''Haïti (1915-1934) reste-t-elle un enjeu géopolitique sensible dans les relations haïtiano-américaines ?';

UPDATE questions SET 
  bonne_reponse = 'La question des migrations haïtiennes',
  choix = '["La rivalité pour le contrôle de la mer des Caraïbes", "La question des migrations haïtiennes", "Le contrôle des ressources minières de l''île d''Hispaniola", "Les différends sur la frontière maritime"]'::jsonb
WHERE enonce = 'Quel est le principal enjeu géopolitique des relations entre Haïti et la République Dominicaine ?';

UPDATE questions SET 
  bonne_reponse = 'La Mission des Nations Unies pour la',
  choix = '["Une organisation économique régionale fondée en 2004 par Haïti", "La Mission des Nations Unies pour la", "Un programme d''aide humanitaire américain", "Une alliance militaire haïtiano-caribéenne"]'::jsonb
WHERE enonce = 'Qu''est-ce que le MINUSTAH et quel rôle a-t-il joué en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'La proximité géographique (à 800 km de',
  choix = '["Haïti est trop éloignée pour intéresser les États-Unis géopolitiquement", "La proximité géographique (à 800 km de", "Les États-Unis considèrent Haïti comme un allié stratégique militaire majeur", "La position d''Haïti n''a aucune pertinence pour la politique américaine dans la région"]'::jsonb
WHERE enonce = 'Comment la position géographique d''Haïti dans les Caraïbes influence-t-elle ses relations avec les États-Unis ?';

UPDATE questions SET 
  bonne_reponse = 'La montée en puissance des gangs armés',
  choix = '["Les gangs ont favorisé la stabilisation d''Haïti", "La montée en puissance des gangs armés", "La crise des gangs est purement interne et sans impact international", "Les gangs ont facilité le dialogue politique entre les factions haïtiennes"]'::jsonb
WHERE enonce = 'Quel est l''impact géopolitique de la crise des gangs en Haïti sur les relations internationales depuis 2021 ?';

UPDATE questions SET 
  bonne_reponse = 'L''aide internationale (ONG',
  choix = '["L''aide internationale est mineure et sans impact sur la politique haïtienne", "L''aide internationale (ONG", "L''aide internationale est uniquement militaire", "L''aide internationale a résolu définitivement les problèmes d''Haïti"]'::jsonb
WHERE enonce = 'Quel est le rôle de l''aide internationale dans la géopolitique haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'La déforestation massive (moins de 2 %',
  choix = '["La montée des eaux dans les zones côtières uniquement", "La déforestation massive (moins de 2 %", "La pollution industrielle des villes", "La surpêche dans les eaux territoriales haïtiennes"]'::jsonb
WHERE enonce = 'Quel défi environnemental menace la géopolitique interne d''Haïti en accentuant les inégalités et les migrations internes ?';

UPDATE questions SET 
  bonne_reponse = 'Il a plongé Haïti dans un vide',
  choix = '["Il a entraîné des élections ordonnées et une transition pacifique", "Il a plongé Haïti dans un vide", "Il a conduit à une intervention américaine directe", "Il a eu peu d''impact sur la situation politique haïtienne"]'::jsonb
WHERE enonce = 'Comment l''assassinat du président Jovenel Moïse en juillet 2021 a-t-il reconfiguré la géopolitique haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Le Kenya',
  choix = '["Le Nigeria", "Le Kenya", "L''Afrique du Sud", "Le Rwanda"]'::jsonb
WHERE enonce = 'Quel pays d''Afrique a été mandaté par l''ONU pour diriger la Mission Multinationale de Soutien à la Sécurité en Haïti en 2024 ?';

UPDATE questions SET 
  bonne_reponse = 'La diaspora haïtienne aux États-Unis',
  choix = '["La diaspora n''a aucune influence politique dans les pays d''accueil", "La diaspora haïtienne aux États-Unis", "La diaspora haïtienne est trop petite pour avoir un impact politique", "La diaspora haïtienne est uniquement économique, sans dimension politique"]'::jsonb
WHERE enonce = 'Quel est le poids géopolitique de la diaspora haïtienne dans les pays d''accueil ?';

UPDATE questions SET 
  bonne_reponse = 'Parce que ses institutions étatiques',
  choix = '["Parce qu''elle n''a pas de constitution ni de lois", "Parce que ses institutions étatiques", "Parce qu''elle est trop petite géographiquement pour être un État viable", "Parce qu''elle manque de ressources naturelles"]'::jsonb
WHERE enonce = 'Pourquoi Haïti est-elle considérée comme un "État fragile" dans la terminologie géopolitique internationale ?';

UPDATE questions SET 
  bonne_reponse = 'L''Organisation Mondiale du Commerce',
  choix = '["La Convention de Genève sur les droits des réfugiés", "L''Organisation Mondiale du Commerce", "Le Traité de Rome sur la Cour Pénale Internationale", "La Convention des Nations Unies sur le Droit de la Mer (UNCLOS)"]'::jsonb
WHERE enonce = 'Quel instrument juridique international régit les relations entre États en matière de commerce et comment affecte-t-il Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Malgré des milliards de dollars promis',
  choix = '["La reconstruction s''est faite efficacement grâce à une coordination internationale exemplaire", "Malgré des milliards de dollars promis", "La reconstruction a été entièrement financée par la diaspora haïtienne", "Le séisme de 2010 n''a pas généré d''aide internationale significative"]'::jsonb
WHERE enonce = 'Comment la question de la reconstruction post-séisme de 2010 illustre les paradoxes de l''aide internationale en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Haïti est utilisée comme point de',
  choix = '["Haïti n''est pas touchée par le trafic de drogues", "Haïti est utilisée comme point de", "Le trafic de drogues est entièrement contrôlé par l''État haïtien", "Haïti est un pays producteur de cocaïne"]'::jsonb
WHERE enonce = 'Quel est l''impact du trafic de drogues sur la géopolitique d''Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Le Caribbean Basin Initiative (CBI)',
  choix = '["L''ALENA (NAFTA)", "L''accord HOPE/HELP Act", "Le CAFTA-DR", "Le Caribbean Basin Initiative (CBI)"]'::jsonb
WHERE enonce = 'Quel accord régional donne à Haïti des préférences commerciales pour ses exportations textiles vers les États-Unis ?';

UPDATE questions SET 
  bonne_reponse = 'La construction d''un mur frontalier par',
  choix = '["La RD a réclamé des territoires haïtiens supplémentaires", "La construction d''un mur frontalier par", "La frontière a été ouverte totalement entre les deux pays", "La RD et Haïti ont signé un accord de fusion politique"]'::jsonb
WHERE enonce = 'Comment la question de la frontière Haïti-République Dominicaine est-elle devenue un enjeu géopolitique majeur depuis 2023 ?';

UPDATE questions SET 
  bonne_reponse = 'Acheminer l''oxygène et les nutriments',
  choix = '["Digérer les aliments","Acheminer l''oxygène et les nutriments","Réguler la température","Produire des hormones"]'::jsonb
WHERE enonce = 'Quel est le rôle principal du système cardiovasculaire lors de l''effort physique ?';

UPDATE questions SET 
  bonne_reponse = 'Approximativement 220 - âge (en années)',
  choix = '["200 battements/min pour tous","Approximativement 220 - âge (en années)","180 battements/min pour tous","La fréquence au repos"]'::jsonb
WHERE enonce = 'Qu''est-ce que la fréquence cardiaque maximale théorique (FCmax) ?';

UPDATE questions SET 
  bonne_reponse = 'La consommation maximale d''oxygène',
  choix = '["La force musculaire maximale","La consommation maximale d''oxygène","La fréquence cardiaque","La flexibilité"]'::jsonb
WHERE enonce = 'Qu''est-ce que la VO2 max mesure ?';

UPDATE questions SET 
  bonne_reponse = 'Fibres rouges lentes (type I)',
  choix = '["Fibres blanches rapides (type II)","Fibres rouges lentes (type I)","Fibres mixtes","Fibres tendineuses"]'::jsonb
WHERE enonce = 'Quel type de fibre musculaire est spécialisé dans les efforts de longue durée (endurance) ?';

UPDATE questions SET 
  bonne_reponse = 'Production d''énergie sans oxygène avec',
  choix = '["Production d''énergie avec oxygène","Production d''énergie sans oxygène avec","Récupération musculaire","Métabolisme des lipides"]'::jsonb
WHERE enonce = 'Qu''est-ce que la filière anaérobie lactique dans le sport ?';

UPDATE questions SET 
  bonne_reponse = 'Augmenter la température musculaire',
  choix = '["Réduire la fréquence cardiaque","Augmenter la température musculaire","Augmenter la fatigue","Réduire l''apport sanguin aux muscles"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''échauffement permet d''accomplir physiologiquement ?';

UPDATE questions SET 
  bonne_reponse = 'Un déchet métabolique produit lors des',
  choix = '["Un carburant musculaire","Un déchet métabolique produit lors des","Une hormone","Un nutriment anti-fatigue"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''acide lactique et quel est son rôle dans la fatigue musculaire ?';

UPDATE questions SET 
  bonne_reponse = 'La déshydratation',
  choix = '["L''augmentation de la force","La déshydratation","L''hypertrophie musculaire","La fatigue nerveuse"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''hydratation optimale pendant l''effort physique prévient ?';

UPDATE questions SET 
  bonne_reponse = 'Après un effort',
  choix = '["S''entraîner sans récupération","Après un effort","Le surmenage physique","L''entraînement croisé"]'::jsonb
WHERE enonce = 'Qu''est-ce que le principe de surcompensation dans l''entraînement sportif ?';

UPDATE questions SET 
  bonne_reponse = 'Glucides',
  choix = '["Lipides","Protéines","Glucides","Vitamines"]'::jsonb
WHERE enonce = 'Quel macronutriment est la principale source d''énergie lors d''efforts d''intensité modérée à élevée ?';

UPDATE questions SET 
  bonne_reponse = 'L''intensité à laquelle la production de',
  choix = '["La VO2 max","L''intensité à laquelle la production de","La fréquence cardiaque maximale","Le seuil de douleur"]'::jsonb
WHERE enonce = 'Qu''est-ce que le seuil anaérobie (ou seuil lactique) ?';

UPDATE questions SET 
  bonne_reponse = 'La capacité du corps à percevoir sa',
  choix = '["La vision périphérique","La capacité du corps à percevoir sa","La coordination avec les partenaires","La résistance à la douleur"]'::jsonb
WHERE enonce = 'Qu''est-ce que la proprioception en EPS ?';

UPDATE questions SET 
  bonne_reponse = 'Hypertrophie du ventricule gauche et',
  choix = '["Réduction du cœur","Hypertrophie du ventricule gauche et","Augmentation permanente de la FC","Aucun effet"]'::jsonb
WHERE enonce = 'Quel est l''effet de l''entraînement aérobie régulier sur le cœur ?';

UPDATE questions SET 
  bonne_reponse = 'La transpiration évaporative est le',
  choix = '["Le corps se refroidit sans effort","La transpiration évaporative est le","Le corps s''adapte en réduisant l''effort","La chaleur améliore la performance"]'::jsonb
WHERE enonce = 'Qu''est-ce que la thermorégulation lors de l''effort physique en chaleur tropicale ?';

UPDATE questions SET 
  bonne_reponse = '11',
  choix = '["9","10","11","12"]'::jsonb
WHERE enonce = 'Combien de joueurs compose une équipe de football sur le terrain ?';

UPDATE questions SET 
  bonne_reponse = 'Un attaquant est hors-jeu s''il est plus',
  choix = '["Un joueur offensif ne peut pas dépasser la ligne médiane","Un attaquant est hors-jeu s''il est plus","Un joueur ne peut pas revenir en défense","Toute faute en dehors du terrain"]'::jsonb
WHERE enonce = 'Qu''est-ce que la règle du hors-jeu au football ?';

UPDATE questions SET 
  bonne_reponse = '5',
  choix = '["4","5","6","7"]'::jsonb
WHERE enonce = 'Combien de joueurs compose une équipe de basket-ball sur le terrain ?';

UPDATE questions SET 
  bonne_reponse = 'L''équipe en attaque doit tirer au',
  choix = '["La durée d''un quart-temps","L''équipe en attaque doit tirer au","La durée du temps mort","Le nombre de secondes pour dribbler"]'::jsonb
WHERE enonce = 'Qu''est-ce que la règle des 24 secondes au basket-ball ?';

UPDATE questions SET 
  bonne_reponse = 'Un coup de pied de récupération botté',
  choix = '["Un but marqué dans un angle","Un coup de pied de récupération botté","Un hors-jeu","Un coup franc"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un corner au football ?';

UPDATE questions SET 
  bonne_reponse = 'Un dispositif collectif qui harcèle',
  choix = '["Un système défensif passif","Un dispositif collectif qui harcèle","Un système offensif","Un signal d''arbitre"]'::jsonb
WHERE enonce = 'Qu''est-ce que la zone de presse (pressing) en sports collectifs ?';

UPDATE questions SET 
  bonne_reponse = 'Le mouvement de rotation sur un pied',
  choix = '["Le joueur gardien de but","Le mouvement de rotation sur un pied","La ligne centrale","Un tir à trois points"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un pivot au basket-ball ?';

UPDATE questions SET 
  bonne_reponse = 'Faire tomber le ballon au sol adverse',
  choix = '["Toucher le sol avec le ballon","Faire tomber le ballon au sol adverse","Garder le ballon longtemps","Marquer uniquement au service"]'::jsonb
WHERE enonce = 'Qu''est-ce que le volley-ball permet dans sa règle fondamentale ?';

UPDATE questions SET 
  bonne_reponse = 'Une action défensive où un joueur fait',
  choix = '["Une faute","Une action défensive où un joueur fait","Un signal d''arbitre","Un rebond offensif"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''écran (ou pick) au basket-ball ?';

UPDATE questions SET 
  bonne_reponse = 'Exploiter rapidement le déséquilibre',
  choix = '["Défendre lentement","Exploiter rapidement le déséquilibre","Conserver le ballon","Faire des fautes tactiques"]'::jsonb
WHERE enonce = 'Quel est l''objectif tactique du jeu en contre-attaque en sports collectifs ?';

UPDATE questions SET 
  bonne_reponse = 'Une manche du match gagnée à 25 points',
  choix = '["Un service","Une manche du match gagnée à 25 points","Un filet","Un coup de pied"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un set au volley-ball ?';

UPDATE questions SET 
  bonne_reponse = 'Un outil essentiel de coordination',
  choix = '["Un aspect secondaire","Un outil essentiel de coordination","La communication avec l''arbitre","Les signaux de l''entraîneur uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que la communication verbale et non verbale dans les sports collectifs ?';

UPDATE questions SET 
  bonne_reponse = 'Le seul joueur autorisé à jouer le',
  choix = '["Identique aux joueurs de champ","Le seul joueur autorisé à jouer le","Le capitaine obligatoire","Un attaquant supplémentaire"]'::jsonb
WHERE enonce = 'Quel est le rôle du gardien de but au football par rapport au champ ?';

UPDATE questions SET 
  bonne_reponse = 'Une lésion ligamentaire traitée par le',
  choix = '["Une fracture osseuse","Une lésion ligamentaire traitée par le","Une contusion musculaire","Une luxation"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''une entorse et comment la traiter en premiers secours ?';

UPDATE questions SET 
  bonne_reponse = 'Aiguë = survient soudainement (choc',
  choix = '["Aucune","Aiguë = survient soudainement (choc","L''aiguë est toujours plus grave","La chronique ne se traite pas"]'::jsonb
WHERE enonce = 'Quelle est la différence entre blessure aiguë et blessure chronique en sport ?';

UPDATE questions SET 
  bonne_reponse = 'L''usage de substances ou méthodes',
  choix = '["L''entraînement intensif","L''usage de substances ou méthodes","Un type de nutrition","Un régime d''entraînement"]'::jsonb
WHERE enonce = 'Qu''est-ce que le dopage et pourquoi est-il interdit ?';

UPDATE questions SET 
  bonne_reponse = 'Fragilisation des tendons',
  choix = '["Aucun danger","Fragilisation des tendons","Amélioration osseuse","Renforcement ligamentaire"]'::jsonb
WHERE enonce = 'Quels sont les dangers des corticoïdes utilisés comme dopants ?';

UPDATE questions SET 
  bonne_reponse = 'L''activité physique conçue pour les',
  choix = '["Le sport de haut niveau","L''activité physique conçue pour les","L''entraînement des jeunes","Le sport scolaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''activité physique adaptée (APA) ?';

UPDATE questions SET 
  bonne_reponse = 'Augmentation du risque de maladies',
  choix = '["Bénéfique pour les articulations","Augmentation du risque de maladies","Aucun effet","Renforcement osseux"]'::jsonb
WHERE enonce = 'Quel est l''effet de la sédentarité sur la santé à long terme ?';

UPDATE questions SET 
  bonne_reponse = 'Une déchirure partielle ou totale de',
  choix = '["Une fracture","Une déchirure partielle ou totale de","Une entorse","Un hématome"]'::jsonb
WHERE enonce = 'Qu''est-ce qu''un claquage musculaire ?';

UPDATE questions SET 
  bonne_reponse = 'Respecter des charges d''entraînement',
  choix = '["Augmenter l''intensité","Respecter des charges d''entraînement","Éviter tout sport","Spécialisation précoce"]'::jsonb
WHERE enonce = 'Comment prévenir les blessures sportives liées à la croissance chez les adolescents ?';

UPDATE questions SET 
  bonne_reponse = 'Augmenter les charges de travail',
  choix = '["Augmenter brutalement les charges","Augmenter les charges de travail","S''entraîner à intensité constante","Réduire progressivement le travail"]'::jsonb
WHERE enonce = 'Qu''est-ce que le principe de progressivité en entraînement sportif ?';

UPDATE questions SET 
  bonne_reponse = 'Effectuer un effort léger (footing lent',
  choix = '["Dormir immédiatement","Effectuer un effort léger (footing lent","Prendre un bain glacé","Ne rien faire pendant 24h"]'::jsonb
WHERE enonce = 'Qu''est-ce que le récupération active après l''effort ?';

UPDATE questions SET 
  bonne_reponse = 'Technique d''immobilisation partielle et',
  choix = '["Pour toute douleur","Technique d''immobilisation partielle et","Pour les fractures uniquement","Pour améliorer la performance"]'::jsonb
WHERE enonce = 'Qu''est-ce que la technique du bandage compressif et quand l''utiliser ?';

UPDATE questions SET 
  bonne_reponse = 'Réduction du stress',
  choix = '["Aucun bénéfice prouvé","Réduction du stress","Augmentation de l''agressivité","Diminution de la concentration"]'::jsonb
WHERE enonce = 'Quels sont les bénéfices psychologiques reconnus de l''activité physique régulière ?';

UPDATE questions SET 
  bonne_reponse = 'L''adaptation du matériel',
  choix = '["La nutrition sportive","L''adaptation du matériel","Le massage sportif","L''arbitrage sportif"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''ergonomie sportive et son rôle en prévention ?';

UPDATE questions SET 
  bonne_reponse = 'La Constitution de la République d''Haïti',
  choix = '["Le Code Civil","La Constitution de la République d''Haïti","Le Code Pénal","La Déclaration des droits de 1804"]'::jsonb
WHERE enonce = 'Quel texte fondamental définit les droits et libertés des citoyens haïtiens ?';

UPDATE questions SET 
  bonne_reponse = '18 ans',
  choix = '["16 ans","18 ans","21 ans","25 ans"]'::jsonb
WHERE enonce = 'À quel âge le citoyen haïtien acquiert-il le droit de vote ?';

UPDATE questions SET 
  bonne_reponse = 'Elle peut être d''origine (naissance de',
  choix = '["Elle ne peut s''acquérir","Elle peut être d''origine (naissance de","Elle est réservée aux natifs du sol","Elle est automatique pour tout résident"]'::jsonb
WHERE enonce = 'Qu''est-ce que la nationalité haïtienne selon la Constitution ?';

UPDATE questions SET 
  bonne_reponse = 'Participer aux élections et à la vie',
  choix = '["Payer des impôts","Participer aux élections et à la vie","Rejoindre un parti","Servir dans l''armée"]'::jsonb
WHERE enonce = 'Quel est le devoir civique le plus fondamental du citoyen dans une démocratie ?';

UPDATE questions SET 
  bonne_reponse = 'Le pouvoir est divisé entre exécutif',
  choix = '["Le pouvoir est concentré au présidentiel","Le pouvoir est divisé entre exécutif","Le pouvoir appartient au Parlement seul","Le pouvoir est régional"]'::jsonb
WHERE enonce = 'Qu''est-ce que le principe de séparation des pouvoirs en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Tous les citoyens sont soumis aux mêmes',
  choix = '["Les lois sont différentes selon le statut social","Tous les citoyens sont soumis aux mêmes","Les riches sont traités différemment","La loi ne s''applique qu''aux pauvres"]'::jsonb
WHERE enonce = 'Qu''est-ce que l''égalité devant la loi signifie en droit haïtien ?';

UPDATE questions SET 
  bonne_reponse = 'Le droit d''exprimer ses opinions',
  choix = '["Une liberté absolue sans limite","Le droit d''exprimer ses opinions","Un droit réservé aux médias","Un droit conditionnel à l''approbation gouvernementale"]'::jsonb
WHERE enonce = 'Qu''est-ce que la liberté d''expression et ses limites ?';

UPDATE questions SET 
  bonne_reponse = 'Toute personne est considérée innocente',
  choix = '["L''accusé est coupable jusqu''à preuve du contraire","Toute personne est considérée innocente","L''innocence doit être prouvée","La police décide de la culpabilité"]'::jsonb
WHERE enonce = 'Qu''est-ce que la présomption d''innocence dans le système judiciaire ?';

UPDATE questions SET 
  bonne_reponse = 'L''obligation de réparer les dommages',
  choix = '["L''obligation de servir dans l''armée","L''obligation de réparer les dommages","Le paiement des impôts","Le service militaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la responsabilité civile du citoyen ?';

UPDATE questions SET 
  bonne_reponse = 'Un droit fondamental de tout enfant',
  choix = '["Un droit optionnel","Un droit fondamental de tout enfant","Un droit réservé aux garçons","Un droit des parents uniquement"]'::jsonb
WHERE enonce = 'Qu''est-ce que le droit à l''éducation consacré par la Constitution haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Une participation volontaire à',
  choix = '["Un devoir légal pénible","Une participation volontaire à","Un service militaire","Une activité rémunérée"]'::jsonb
WHERE enonce = 'Qu''est-ce que le service communautaire comme expression de la citoyenneté active ?';

UPDATE questions SET 
  bonne_reponse = 'La neutralité de l''État par rapport à',
  choix = '["L''État catholique","La neutralité de l''État par rapport à","L''interdiction des religions","L''État vodou"]'::jsonb
WHERE enonce = 'Qu''est-ce que la laïcité de l''État et son importance en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Rapprocher les décisions du citoyen en',
  choix = '["Concentrer le pouvoir à Port-au-Prince","Rapprocher les décisions du citoyen en","Supprimer les mairies","Privatiser les services publics"]'::jsonb
WHERE enonce = 'Qu''est-ce que la décentralisation en Haïti vise à accomplir ?';

UPDATE questions SET 
  bonne_reponse = 'L''ONU',
  choix = '["L''OEA","L''ONU","L''UNICEF","La Cour Pénale Internationale"]'::jsonb
WHERE enonce = 'Quel organisme international proclame les droits fondamentaux de l''homme ?';

UPDATE questions SET 
  bonne_reponse = 'L''obligation morale de se souvenir de',
  choix = '["Oublier le passé pour avancer","L''obligation morale de se souvenir de","La mémoire sélective","L''étude exclusive de l''antiquité"]'::jsonb
WHERE enonce = 'Qu''est-ce que le devoir de mémoire dans la citoyenneté haïtienne ?';

UPDATE questions SET 
  bonne_reponse = 'Au suffrage universel direct à deux',
  choix = '["Par le Parlement","Au suffrage universel direct à deux","Par le Premier Ministre","Par le Conseil des Ministres"]'::jsonb
WHERE enonce = 'Comment le Président de la République d''Haïti est-il élu ?';

UPDATE questions SET 
  bonne_reponse = '5 ans non consécutivement renouvelables',
  choix = '["4 ans renouvelables","5 ans non consécutivement renouvelables","7 ans","6 ans"]'::jsonb
WHERE enonce = 'Quelle est la durée du mandat présidentiel en Haïti selon la Constitution de 1987 ?';

UPDATE questions SET 
  bonne_reponse = 'Deux chambres',
  choix = '["Une seule chambre","Deux chambres","Trois chambres","Le Parlement est unicaméral"]'::jsonb
WHERE enonce = 'Quelle est la composition du Parlement haïtien (Assemblée Nationale) ?';

UPDATE questions SET 
  bonne_reponse = 'L''institution responsable de',
  choix = '["Un tribunal","L''institution responsable de","Le Ministère de l''Intérieur","Une commission parlementaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que le Conseil Electoral Permanent (CEP) en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Superviser la magistrature',
  choix = '["Faire les lois","Superviser la magistrature","Exécuter les lois","Organiser les élections"]'::jsonb
WHERE enonce = 'Quel est le rôle du Conseil Supérieur du Pouvoir Judiciaire (CSPJ) ?';

UPDATE questions SET 
  bonne_reponse = 'La juridiction suprême administrative',
  choix = '["Un tribunal pénale","La juridiction suprême administrative","Le Parlement financier","La Banque centrale"]'::jsonb
WHERE enonce = 'Qu''est-ce que la Cour Supérieure des Comptes et du Contentieux Administratif (CSC/CA) ?';

UPDATE questions SET 
  bonne_reponse = 'Chef du gouvernement',
  choix = '["Dirigeant suprême de l''État","Chef du gouvernement","Un conseiller du Président","Un membre du Sénat"]'::jsonb
WHERE enonce = 'Quel est le rôle du Premier Ministre en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'La corruption et l''enrichissement',
  choix = '["Le manque de compétences","La corruption et l''enrichissement","L''évasion fiscale privée","L''immigration clandestine"]'::jsonb
WHERE enonce = 'Qu''est-ce que la déclaration de patrimoine des fonctionnaires haïtiens vise à combattre ?';

UPDATE questions SET 
  bonne_reponse = 'L''unité administrative de base dirigée',
  choix = '["Un département","L''unité administrative de base dirigée","Une section communale","Un arrondissement"]'::jsonb
WHERE enonce = 'Qu''est-ce que la collectivité territoriale de la commune en Haïti ?';

UPDATE questions SET 
  bonne_reponse = 'Surveiller le gouvernement',
  choix = '["Aucun rôle officiel","Surveiller le gouvernement","Remplacer le gouvernement","Administrer les élections"]'::jsonb
WHERE enonce = 'Quel est le rôle de la société civile dans la gouvernance démocratique ?';

UPDATE questions SET 
  bonne_reponse = 'Le plan financier de l''État définissant',
  choix = '["Un document comptable interne","Le plan financier de l''État définissant","Un emprunt international","Le budget du Président"]'::jsonb
WHERE enonce = 'Qu''est-ce que le budget national représente comme outil de gouvernance ?';

UPDATE questions SET 
  bonne_reponse = 'L''obligation pour les dirigeants de',
  choix = '["L''élection des dirigeants","L''obligation pour les dirigeants de","L''audit interne","Le contrôle budgétaire"]'::jsonb
WHERE enonce = 'Qu''est-ce que la redevabilité (accountability) dans la gouvernance publique ?';

UPDATE questions SET 
  bonne_reponse = 'Le Parlement (Assemblée Nationale)',
  choix = '["La Cour Suprême","Le Parlement (Assemblée Nationale)","Le Conseil Electoral","Le Conseil des Ministres"]'::jsonb
WHERE enonce = 'Quel organe constitutionnel haïtien peut destituer le Président par la procédure d''impeachment ?';

UPDATE questions SET 
  bonne_reponse = 'Une gouvernance de proximité confrontée',
  choix = '["Un système fonctionnel","Une gouvernance de proximité confrontée","Un modèle de décentralisation réussi","Un système purement rural"]'::jsonb
WHERE enonce = 'Qu''est-ce que la gouvernance locale en Haïti et ses défis ?';

COMMIT;
