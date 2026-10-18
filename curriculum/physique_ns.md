# Physique (matiere_id 9) — Secondaire NS1 à NS4

**Statut : proposition, en attente de validation par l'utilisateur (2026-10-18).**

## Sources

1. **Programme officiel 2024** : `Programmes de l'enseignement secondaire — Physique` (MENFP, version définitive du 24 juillet 2024), fichier `Donnees/Programme de Physique_MENFP.pdf` (pp. 25-198). 27 unités d'apprentissage (UA) en 4 thèmes : A Matière, environnement et espace · B Forces, mouvement et travail · C Électricité et magnétisme · D Optique et ondes. Référence notée `A1`, `B3`…
   - Répartition retenue = tableau « Progression » p. 196 et liste p. 197-198 : **NS1** A1, B1, C1, D1 · **NS2** A2, B2, C2, D2 · **NS3** A3, A4, B3, B4, B5 (MP), C3, C4 (MP), D3 · **NS4** A5, A6, B6 (MP), B7 (MP), C5 (MP), C6 (MP), D4, D5. L'en-tête de la fiche B5 (p. 107) dit « Secondaire 4 », mais le tableau de progression et la liste p. 197 la placent en NS3 : on suit le tableau (même arbitrage qu'en Chimie).
   - Séries SES et LLA : physique intégrée aux thèmes transversaux du programme de SVT (NS3 : A Muscle, sport et énergie · B Ressources géologiques, énergies et matériaux · D Atmosphère et changements climatiques ; NS4 : A Vision, lumière et couleur · B Du Big-Bang à la vie sur Terre · C Hygiène, médicaments et santé · D L'eau). Les parties physique sont intégrées ci-dessous (lumière, optique, couleur, spectre : 4.1 ; énergie : 3.1 ; histoire de l'électricité, tension, courant, résistance, loi d'Ohm, courants alternatif et continu : 4.4). Les parties biologie, géologie et chimie restent dans leurs matières.
2. **Manuel « Physique — Secondaire II »** de Jean Robert Altidor (3ᵉ éd.), plan fourni par l'utilisateur (`Programm Menfp/Physique NS2.pdf`, 12 pages scannées : programme officiel de 2ᵉ année + table des matières). 15 chapitres : 1 Exploration de l'espace · 2 Forces et mouvements (travail, énergie, puissance, rendement) · 3 Chaleur et température · 4 Dilatation des solides · 5 Dilatation des liquides · 6 Compressibilité et dilatation des gaz · 7 Calorimétrie · 8 Changements d'état · 9 Courants électriques, électrolyse · 10 Résistance, loi de Joule · 11 Générateurs et récepteurs · 12 Réflexion et réfraction · 13 Dioptre plan, lames à faces parallèles · 14 Prisme · 15 Lentilles minces. Référence notée `Alt. ch.N`. **Ce manuel suit l'ancien programme de 2ᵉ année**, plus calculatoire et plus étendu que celui de 2024 (gaz parfaits, dilatation quantitative, calorimétrie, électrolyse, loi de Joule, optique géométrique).
3. **Anciennes questions de la base** : 162 questions de Physique (seed `c2b421e`), réparties en 11 chapitres : Mécanique : mouvements et forces (26) · Énergie, travail et puissance (25) · Électricité et magnétisme (24) · Optique et ondes (24) · Grandeurs et mesures physiques NS1 (10) · Cinématique NS1 (9) · Dynamique NS2 (10) · Électricité NS2 (9) · Optique NS3 (9) · Thermodynamique NS3 (7) · Physique nucléaire et moderne NS4 (9). À reclasser selon le découpage ci-dessous, chapitre par chapitre.
4. **Recherches sans résultat exploitable** : sommaires des manuels F.I.C./Editha et Henri Deschamps (aucune page de sommaire de physique haïtienne trouvée en ligne), programmes 2015 de physique du Nouveau Secondaire (introuvables sur haiti-now.org, contrairement à la chimie), sujets de bac de physique. Le découpage s'appuie donc sur le programme 2024 et le manuel Altidor. Si l'utilisateur a d'autres manuels (Secondaire I, III, IV), leurs plans permettraient de vérifier NS1, NS3 et NS4.

## Règles d'organisation

- NS1 et NS2 : tronc commun. NS3 et NS4 : l'application ne gère pas les séries → **union** MP + SVT (+ parties physique SES/LLA).
- **Union du programme 2024 et du manuel Altidor** : une notion enseignée ou examinée doit être dans la banque. Le programme 2024 place en NS3 des notions (travail, énergie, puissance, loi de Joule, lois d'Ohm des dipôles, loi de Snell-Descartes) que le manuel place en NS2 : elles forment des **chapitres communs NS2 + NS3** (🔁).
- Une notion présente à plusieurs niveaux forme un **chapitre commun** (🔁), relié à chaque niveau par `chapitre_niveaux`. Il est décrit dans le tableau de son niveau le plus bas ; les niveaux suivants le rappellent par une ligne « — ».
- **Recoupements avec les autres matières** : règle habituelle — un terme déjà défini dans un chapitre **validé** n'est pas redéfini. Points concernés : Chimie (états de la matière et changements d'état, masse volumique, grandeurs SI et verrerie, gaz parfaits et volume molaire, électrolytes, piles) ; Géologie (Big Bang et « Terre singulière », effet de serre, énergies renouvelables, atmosphère : arc-en-ciel, mirages) ; Biologie (anatomie de l'œil). La Physique garde l'angle physique : mesures, lois, formules, grandeurs, appareils.

---

## NS1 — UA A1, B1, C1, D1

| # | Chapitre | Niveaux | Réf. | Contenu à couvrir |
|---|---|---|---|---|
| 1 | Grandeurs, mesures et états de la matière | NS1 | A1 ; base | Grandeurs, unités SI, instruments, conversions, incertitude *(ajout hors programme, à confirmer)* ; matière, états (solide, liquide, gaz, plasma, intermédiaires) ; masse, volume, masse volumique, densité ; propriétés physiques des métaux |
| 2 | 🔁 Big Bang, système solaire et exploration de l'espace | NS1 + NS2 | A1 ; Alt. ch.1 | Big Bang, expansion, nucléosynthèse ; Soleil, planètes, satellites, étoiles, météorites, galaxies ; échelles de grandeur, parallaxe, année-lumière, tailles ; télescopes, sondes, missions |
| 3 | 🔁 Gravitation universelle, poids et masse | NS1 + NS2 | B1 ; B2 ; Alt. ch.1.2 | Loi de la gravitation ; mouvement des planètes et satellites ; poids, masse, P = m·g, différences, poids sur d'autres astres |
| 4 | Mouvement, trajectoire, vitesse et accélération | NS1 | B1 | Trajectoires et types de mouvements ; vitesse moyenne et instantanée ; accélération ; graphiques vitesse-temps |
| 5 | 🔁 Force, interaction et effets d'une force | NS1 + NS2 | B1 ; B2 ; Alt. ch.2.1 | Types de forces ; effets ; dynamomètre, newton ; vecteur force ; somme vectorielle ; actions de contact et à distance |
| 6 | 🔁 La pression : solides, liquides et atmosphère | NS1 + NS2 | B1 ; Alt. ch.6 | p = F/S, pascal ; hydrostatique, vases communicants, Pascal ; pression atmosphérique, baromètre, manomètre ; pression des gaz |
| 7 | La poussée d'Archimède et la flottaison | NS1 | B1 | Principe, paramètres, applications, conditions de flottaison |
| 8 | Électrisation et charges électriques | NS1 | C1 | Frottement, contact, influence ; charges ; atome et ion |
| 9 | 🔁 Conducteurs, isolants et circuit électrique | NS1 + NS2 | C1 ; C2 | Conducteurs, isolants ; circuit, générateur, récepteur, dipôles ; symboles ; courant continu et alternatif |
| 10 | 🔁 Résistance électrique et loi d'Ohm | NS1 + NS2 | C1 ; C2 ; Alt. ch.10 | Résistor, code des couleurs ; loi d'Ohm ; caractéristique ; facteurs de la résistance |
| 11 | Puissance électrique et sécurité des installations | NS1 | C1 | Plaque signalétique, P = U·I ; fusible, disjoncteur, prise de terre ; incendies ; économies d'énergie |
| 12 | Propagation rectiligne de la lumière, ombres et éclipses | NS1 | D1 | Sources ; milieux transparent, translucide, opaque ; ombre, pénombre ; éclipses ; chambre noire |
| 13 | 🔁 Réflexion de la lumière et miroir plan | NS1 + NS2 | D1 ; Alt. ch.12 | Lois de la réflexion ; retour inverse ; image dans un miroir plan ; champ ; miroir tournant, périscope, rétroviseur |
| 14 | 🔁 Le son et la transmission de l'information | NS1 + NS4 | D1 ; D5 | Onde sonore, vitesse, fréquence, amplitude ; hauteur, timbre, intensité ; écho ; oreille ; pollution sonore ; signaux sonore, lumineux, radio ; Wi-Fi, fibre optique |

## NS2 — UA A2, B2, C2, D2 + manuel Altidor

| # | Chapitre | Niveaux | Réf. | Contenu à couvrir |
|---|---|---|---|---|
| 1 | Température, thermomètres et dilatation | NS2 | A2 ; Alt. ch.3, 4, 5 | Chaleur, température, équilibre thermique ; thermomètres, échelles Celsius, Kelvin, Fahrenheit ; dilatation linéaire et cubique des solides ; coefficients ; masse volumique ; dilatation apparente et absolue des liquides ; eau anormale ; applications |
| 2 | Les gaz : lois et gaz parfaits | NS2 | A2 ; Alt. ch.6 | Grandeurs d'un gaz ; Boyle-Mariotte ; Dalton ; Gay-Lussac ; Charles ; température absolue ; gaz parfaits, constante R ; montgolfière |
| 3 | Chaleur : propagation, calorimétrie et changements d'état | NS2 | A2 ; Alt. ch.7, 8 | Conduction, convection, rayonnement ; thermos ; calorimètre ; capacité calorifique, chaleur massique ; Q = m·c·Δθ ; fusion, solidification, surfusion ; vaporisation, vapeur saturante ; liquéfaction, point critique, point triple ; chaleurs latentes ; courbes |
| 4 | Équilibre d'un solide : deux ou trois forces, moment et couple | NS2 | B2 | Réaction du support, tension d'un fil, diagrammes de corps libre ; équilibre à trois forces ; moment, couple |
| 5 | 🔁 Inertie, action-réaction, chute libre et quantité de mouvement | NS2 + NS3 | B2 ; B3 ; B5 | Principe d'inertie et contraposée ; référentiel inertiel ; action-réaction ; chute libre, lancer vertical ; quantité de mouvement, système isolé, pseudo-isolé, conservation |
| 6 | 🔁 Travail, puissance, rendement et formes d'énergie | NS2 + NS3 | Alt. ch.2 ; B4 ; A3 ; SES/LLA 3.1 | Travail d'une force constante, moteur/résistant, rotation ; puissance, watt ; rendement ; formes d'énergie ; sources, renouvelables et non ; transformation, conservation |
| 7 | 🔁 Courant électrique, tension, lois de Kirchhoff et électrolyse | NS2 + NS3 | C2 ; C3 ; Alt. ch.9 | Nature, effets, sens du courant ; intensité ; loi des nœuds ; d.d.p., voltmètre ; lois des branches et des mailles ; électrolyte, électrodes, électrolyse, loi de Faraday |
| 8 | 🔁 Associations de résistors, rhéostats et effet Joule | NS2 + NS3 | Alt. ch.10 ; C3 | Série, dérivation, résistance équivalente ; rhéostat, potentiomètre ; loi de Joule ; énergie, puissance, rendement d'un appareil de chauffage |
| 9 | 🔁 Diodes, générateurs, récepteurs et loi de Pouillet | NS2 + NS3 | C2 ; C3 ; Alt. ch.11 | Diode à jonction, polarisation, Zener, DEL, redressement ; générateur, f.é.m., résistance interne ; récepteur, f.c.é.m. ; lois d'Ohm ; bilan, rendement ; Pouillet ; associations de générateurs |
| 10 | 🔁 Vitesse de la lumière, réfraction, dioptre plan, lames et prisme | NS2 + NS3 | D2 ; D3 ; Alt. ch.12, 13, 14 | Mesures de la vitesse de la lumière ; indice ; Snell-Descartes ; réflexion totale ; fibre optique, mirages, héliothermique ; dioptre plan, lame à faces parallèles ; prisme, dispersion de la lumière blanche |
| 11 | Les lentilles minces et l'œil | NS2 | D2 ; Alt. ch.15 ; SES/LLA 4.1 | Lentilles convergente/divergente ; foyers, vergence ; construction de l'image ; conjugaison, grandissement ; œil, accommodation ; myopie, hypermétropie, presbytie, astigmatisme |
| 12 | 🔁 Lumières colorées, filtres et synthèse des couleurs | NS2 + NS3 | D2 ; D3 ; SES/LLA 4.1 | Lumière blanche, monochromatique, polychromatique ; diffusion, transmission, absorption ; filtres ; couleurs primaires, RVB ; synthèse additive et soustractive |
| 13 | 🔁 Aimants et champ magnétique | NS2 + NS3 + NS4 | C2 ; C4 ; C5 | Aimants, pôles ; champ magnétique, lignes, spectres ; boussole, champ terrestre ; champs d'un fil, d'une spire, d'un solénoïde |
| — | 🔁 Big Bang et espace · 🔁 Gravitation · 🔁 Force · 🔁 Pression · 🔁 Circuit · 🔁 Résistance et Ohm · 🔁 Réflexion | | | voir NS1 |

## NS3 — union MP + SVT (A3, A4, B3, B4, B5, C3, C4, D3) + SES/LLA

| # | Chapitre | Niveaux | Réf. | Contenu à couvrir |
|---|---|---|---|---|
| 1 | Énergies cinétique, potentielle et mécanique | NS3 | A3 ; A4 ; B4 | Énergie cinétique (translation, rotation, moment d'inertie, théorème) ; énergie potentielle de pesanteur et élastique ; énergie mécanique, conservation ; chute libre |
| 2 | Les machines simples | NS3 | B4 | Levier, poulie, plan incliné, treuil ; conservation du travail ; rendement |
| 3 | Référentiels, repérage et vecteur vitesse | NS3 | B3 | Repère, référentiels terrestre, géocentrique, héliocentrique ; relativité ; GPS ; apogée, périgée ; vecteur vitesse ; chronophotographie ; variation de vitesse |
| 4 | Cinématique du point | NS3 | B5 | Point mobile ; MRU, MRUV, sinusoïdal ; mouvements circulaires ; translation et rotation du solide |
| 5 | Les lois de Newton et leurs applications | NS3 | B5 | Système, centre d'inertie, forces intérieures/extérieures, système isolé ; référentiel galiléen ; théorème du centre d'inertie ; Huygens ; plan incliné, projectile, pendule conique, virage, satellite |
| 6 | Piles et accumulateurs | NS3 | C3 ; SES/LLA 4.4 | Volta, Leclanché, Daniell ; accumulateur ; recyclage |
| 7 | Les condensateurs | NS3 | C4 | Charge, décharge ; capacité ; condensateur plan ; fuite ; tension de service ; associations |
| 8 | Induction électromagnétique et courant alternatif | NS3 | C4 | Flux, weber ; courant induit ; loi de Lenz ; auto-induction ; alternateur ; f.é.m. alternative ; valeurs efficaces ; redressement ; barrage de Péligre |
| 9 | 🔁 Les ondes mécaniques | NS3 + NS4 | D3 ; D4 | Onde, perturbation ; transversale, longitudinale, de torsion ; célérité ; onde périodique, sinusoïdale ; longueur d'onde ; interférences ; ondes stationnaires ; sonar |
| 10 | Ondes électromagnétiques, spectres et lumière | NS3 | D3 ; D2 ; SES/LLA 4.1 | Domaines des ondes EM, UV-visible-IR ; λ, f, c ; spectres continu, de raies, d'émission, d'absorption ; spectroscope ; spectre d'une étoile |
| 11 | La dualité onde-corpuscule de la lumière | NS3 | D3 | Diffraction ; photon ; effet photoélectrique ; énergie d'un photon |
| 12 | Les instruments d'optique | NS3 | D3 | Loupe, microscope, lunette astronomique ; trajet des rayons ; incertitude |
| — | 🔁 Inertie et chute libre · 🔁 Travail et puissance · 🔁 Formes d'énergie · 🔁 Courant, tension, Kirchhoff · 🔁 Résistors et Joule · 🔁 Générateurs et Pouillet · 🔁 Réfraction · 🔁 Lumières colorées · 🔁 Aimants | | | voir NS2 |

## NS4 — MP + SVT (A5, A6, B6, B7, C5, C6, D4, D5) + SES/LLA

| # | Chapitre | Niveaux | Réf. | Contenu à couvrir |
|---|---|---|---|---|
| 1 | Radioactivité et demi-vie | NS4 | A5 | Émissions α, β, γ ; transmutation ; équations ; lois de conservation ; décroissance, constante radioactive, demi-vie ; spontanées et provoquées |
| 2 | Fission et fusion nucléaires | NS4 | A5 | Fission, fusion ; énergie libérée ; centrale ; Soleil ; risques |
| 3 | Sources d'énergie, climat et transition énergétique | NS4 | A6 | Fossiles, nucléaires, renouvelables ; extraction et transformation ; gaz à effet de serre ; politiques énergétiques ; transition |
| 4 | Oscillations et oscillateurs mécaniques | NS4 | B6 | Phénomène périodique ; période, fréquence, amplitude ; oscillatoire, vibratoire ; amortissement ; Fresnel ; pendule élastique, simple, pesant |
| 5 | Interactions fondamentales, gravitation et pesanteur | NS4 | B7 | Quatre interactions ; champ de gravitation et de pesanteur ; variation de g ; lignes de champ ; gravimétrie |
| 6 | Charges, loi de Coulomb et champ électrique | NS4 | B7 ; SES/LLA 4.4 | Charge élémentaire ; influence électrostatique ; Coulomb ; champ électrique ; équipotentielle |
| 7 | Force de Laplace et force de Lorentz | NS4 | C5 | Loi de Laplace ; main droite ; Lorentz ; particule chargée |
| 8 | Courant alternatif, circuits LC et RLC | NS4 | C5 ; C6 | Dipôles en CC et CA ; réactance, impédance ; oscillations LC ; énergies ; RLC, amortissement ; résonance ; puissance |
| 9 | Acoustique appliquée | NS4 | D5 | Intensité acoustique, sonomètre ; réflexion, réfraction, absorption, interférence acoustiques ; sonar ; échographie |
| 10 | Histoire de l'électricité et de l'électronique | NS4 | SES/LLA 4.4 | Foudre, influx nerveux ; Volta ; lampe à incandescence ; transistor ; AC/DC |
| — | 🔁 Le son · 🔁 Ondes mécaniques · 🔁 Aimants | | | voir NS1 / NS3 / NS2 |

---

## Bilan

- **49 chapitres** : NS1 14 · NS2 13 · NS3 12 · NS4 10 (dont 14 communs 🔁).
- Anciennes questions (162) : Mécanique → NS1 ch.3-5, NS2 ch.4-5 ; Énergie → NS2 ch.6, NS3 ch.1 ; Électricité → NS1 ch.8-11, NS2 ch.7-9 ; Optique → NS1 ch.12-13, NS2 ch.10-12 ; Thermodynamique → NS2 ch.1-3 ; Nucléaire → NS4 ch.1-2.

## Points à trancher

1. **Recoupements avec Chimie, Géologie, Biologie** : une notion est définie dans la première matière qui la valide.
2. **NS1 ch.1** inclut grandeurs et mesures, absentes des unités du programme : à garder ?
3. **Manuel Altidor plus étendu que le programme 2024** : on prend l'union.
4. **Calculs** : formules et unités, plus quelques calculs courts à un pas.
5. **Unité B5** placée en NS3 (tableau de progression) malgré l'en-tête « Secondaire 4 ».
