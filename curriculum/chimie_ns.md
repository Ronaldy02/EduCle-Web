# Chimie (matiere_id 10) — Secondaire NS1 à NS4

**Statut : proposition, en attente de validation par l'utilisateur (2026-10-17).**

## Sources

1. **Programme officiel 2024** : `Programmes de l'enseignement secondaire — Chimie` (MENFP, version définitive du 24 juillet 2024), fichier `Donnees/Programme de Chimie_MENFPpdf.pdf`. 16 unités d'apprentissage (UA) en 4 thèmes : A Structure et propriétés de la matière, B Réactions acido-basiques, C Oxydoréduction, D Chimie organique. Référence notée `A1`, `B3`…
   - Répartition retenue = tableau « Progression » p. 102, qui concorde avec les en-têtes des fiches d'unités : **NS1** A1, A2, B1, D1 · **NS2** A3, A4, B2, D2 · **NS3** C1, C2 (SVT + MP), B3, D3 (SVT seulement) · **NS4** C3, C4 (SVT + MP), B4, D4 (SVT seulement). Le tableau compétences × unités p. 40 donne une autre répartition (A3 et B1 en NS1, A4 en NS3…) ; il est contredit par les fiches et par la p. 102.
   - Séries SES et LLA : la chimie y est intégrée aux thèmes transversaux du programme de SVT (3.2 Ressources géologiques, énergies et matériaux ; 3.4 Atmosphère ; 4.3 Hygiène, médicaments et santé). Ces thèmes sont déjà répartis en Géologie, Biologie et Physique (voir `biologie_geologie_ns.md`) : **aucun chapitre de Chimie** n'en est tiré.
2. **Manuel MENFP « Chimie — Module I »** (Direction de l'Enseignement Secondaire, nov. 2016, 56 p., Secondaire 1), en ligne : `s992d950009f3de07.jimcontent.com/download/version/0/module/15921849824/name/04-+CHIMIE.pdf`. 10 chapitres : introduction à la chimie ; matière et énergie ; substances pures et mélanges ; propriétés de la matière ; notions de mesure (SI) ; unité de quantité de matière (mole, formules, nomenclature, hydracides) ; réaction chimique ; réactivité des matériaux (air, acides, bases) ; théorie atomique ; nombres quantiques. Référence notée `Mod.I ch.N`.
3. **Programmes pédagogiques opérationnels 2015** (MENFP / DES, Nouveau Secondaire) : programme de Secondaire 1 et programme-cadre en tableaux synoptiques de toutes les séries (SVT, SMP, SES, STMS, STDR…), sur haiti-now.org (`2015-chemistry-secondary-school-curriculum-year-1.pdf` et `…-year-2.pdf`). Ils ajoutent : masse volumique, gaz parfaits, eau potable et traitement, composition de l'air, combustions, enthalpie (exo/endothermique), courant électrique dans les solutions, électrolyses (HCl, soude, NaCl fondu et aqueux), effets inductif et mésomère, réactifs nucléophiles et électrophiles, alcools détaillés, amines et amides, polymères (polymérisation, polycondensation), saponification. Référence notée `PPO 2015`.
4. Recherches sans résultat exploitable : sommaires F.I.C./Editha et Henri Deschamps, islghaiti.org (seulement des manuels de maths), sujets du bac de chimie en ligne. Programmes détaillés 2015 de 3e et 4e année repérés sur mit-ayiti.net et haitidocs.org, non consultés.

## Règles d'organisation

- NS1 et NS2 : tronc commun. NS3 et NS4 : l'application ne gère pas les séries → **union** SVT + MP (SES/LLA : voir ci-dessus).
- **Union du programme 2024, du manuel Module I et des programmes 2015** : une notion enseignée ou examinée doit être dans la banque.
- Une notion présente à plusieurs niveaux forme un **chapitre commun** (🔁), relié à chaque niveau par `chapitre_niveaux`. Il est décrit dans le tableau de son niveau le plus bas ; les niveaux suivants le rappellent par une ligne « — ».
- **Recoupement Biologie** : « Structure et fonction des molécules biologiques » (NS2) et « Métabolisme » (NS2-NS3) ont déjà défini, entre autres : macromolécule, polymère, monomère, diholoside, polysaccharide, glycérol, acide gras insaturé, liaison peptidique, groupes NH₂/COOH, structures primaire et secondaire, dénaturation, nucléotide, catalyseur, site actif, fermentation, glycolyse. Ces termes **ne sont pas redéfinis** en Chimie ; les chapitres tirés de D4 portent sur les formules, les groupes, les réactions et les tests chimiques.

---

## NS1 — UA A1, A2, B1, D1

| # | Chapitre | Niveaux | Réf. | Contenu à couvrir |
|---|---|---|---|---|
| 1 | Introduction à la chimie et démarche scientifique | NS1 | Mod.I ch.1 ; PPO 2015 S1 | Définition et origine du mot chimie ; histoire (alchimie, Lavoisier, Dalton, Mendeleïev) ; branches (minérale, organique, analytique, biochimie, chimie physique) ; domaines d'application ; démarche expérimentale OHERIC |
| 2 | 🔁 Sécurité, matériel et mesures au laboratoire | NS1 + NS2 + NS3 + NS4 | A1 ; B1 ; B2 ; B3 ; B4 ; C1 ; C4 ; Mod.I ch.5 | Consignes de sécurité ; pictogrammes (corrosif, inflammable, toxique, comburant…) ; verrerie (bécher, erlenmeyer, éprouvette graduée, pipette jaugée, burette, fiole jaugée, ampoule à décanter, réfrigérant) ; balance, thermomètre, pH-mètre, potentiomètre ; grandeurs et unités SI, préfixes ; précision, incertitude ; rapport d'expérience |
| 3 | La matière, ses états et ses changements d'état | NS1 | A1 ; Mod.I ch.2, ch.4 ; PPO 2015 | Matière ; états solide, liquide, gazeux (propriétés, modèle microscopique) ; masse volumique, densité ; fusion, solidification, vaporisation, ébullition, évaporation, liquéfaction, condensation, sublimation ; palier de température ; température de fusion ou d'ébullition, critère de pureté ; chaleur et température ; phénomène physique / chimique ; propriétés physiques et chimiques |
| 4 | Corps purs, mélanges et éléments chimiques | NS1 | A1 ; Mod.I ch.3 ; PPO 2015 | Corps pur simple et composé ; élément chimique ; mélange homogène et hétérogène ; miscibilité ; alliage ; matière naturelle, synthétique, hybride |
| 5 | 🔁 Techniques de séparation et de purification | NS1 + NS3 | A1 ; D3 ; Mod.I ch.3 ; PPO 2015 | Décantation, filtration (filtrat, résidu), centrifugation, évaporation, cristallisation, distillation simple et fractionnée (distillat), extraction par solvant, chromatographie (CCM, rapport frontal), recristallisation ; raffinage du pétrole ; eau potable et traitement (chloration, osmose inverse) |
| 6 | Structure de l'atome, isotopes et ions | NS1 | A2 ; Mod.I ch.9 ; PPO 2015 S1 | Modèles de Dalton, Thomson, Rutherford, Bohr ; noyau, proton, neutron, électron, nucléon ; numéro atomique Z, nombre de masse A, notation ᴬ_Z X ; isotopes ; masse atomique ; ion, cation, anion |
| 7 | 🔁 Configuration électronique et nombres quantiques | NS1 + NS2 | A2 ; Mod.I ch.10 ; PPO 2015 S2 | Couches K, L, M ; niveaux d'énergie ; électrons de valence ; sous-couches s, p, d, f ; orbitale ; nombres quantiques n, l, m, s ; principe de Pauli, règle de Hund, règle de Klechkowski ; schéma de Lewis des atomes ; règles du duet et de l'octet |
| 8 | 🔁 Le tableau périodique et les propriétés périodiques | NS1 + NS2 | A2 ; PPO 2015 S1-S2 | Mendeleïev ; symboles et noms des éléments ; périodes, groupes ; familles (alcalins, alcalino-terreux, halogènes, gaz nobles, métaux de transition) ; métaux, non-métaux, métalloïdes ; valence ; électronégativité, rayon atomique, énergie d'ionisation, affinité électronique, caractère métallique ; réactivité selon la position |
| 9 | 🔁 La quantité de matière : la mole | NS1 + NS2 | A1 ; A4 ; Mod.I ch.6 ; PPO 2015 | Mole, nombre d'Avogadro ; masse molaire atomique et moléculaire ; volume molaire ; n = m/M, n = V/Vm ; loi des gaz parfaits ; composition centésimale ; formule brute, empirique, moléculaire |
| 10 | 🔁 Les solutions : dissolution, concentration et dilution | NS1 + NS2 + NS3 | A1 ; B1 ; B2 ; B3 ; PPO 2015 | Soluté, solvant, solution aqueuse ; dissolution ; solution saturée, solubilité ; concentration massique et molaire (molarité), pourcentage massique, fraction molaire, normalité ; préparation d'une solution ; dilution, facteur de dilution, solution mère et fille |
| 11 | 🔁 Formules et nomenclature des composés inorganiques | NS1 + NS2 | B1 ; Mod.I ch.6 ; PPO 2015 S1 | Valence et écriture des formules ; ions polyatomiques ; oxydes, hydroxydes, hydracides, oxacides, sels (-ure, -ate, -ite) ; noms et formules des acides, bases et sels courants |
| 12 | 🔁 Acides, bases et pH | NS1 + NS2 | B1 ; B2 ; Mod.I ch.8 ; PPO 2015 | Caractères des acides et des bases ; antagonisme ; pH, échelle de 0 à 14 ; solution acide, basique, neutre ; papier pH, pH-mètre ; produits acides et basiques courants (vinaigre, citron, savon, eau de Javel, soude) ; action des acides et des bases sur les métaux et le calcaire |
| 13 | 🔁 Indicateurs colorés, neutralisation et dosage acido-basique | NS1 + NS2 + NS3 + NS4 | B1 ; B2 ; B3 ; B4 | Indicateur coloré, zone de virage (phénolphtaléine, hélianthine, BBT) ; neutralisation ; dosage (titrage), solution titrante, équivalence ; dosage colorimétrique et pH-métrique ; étalonnage ; étapes d'un dosage |
| 14 | 🔁 Les solutions tampons | NS1 + NS2 + NS3 + NS4 | B1 ; B2 ; B3 ; B4 | Définition, préparation (acétique/acétate, ammoniac/ammonium), pH d'un tampon ; rôle au laboratoire et dans le corps (sang) |
| 15 | Introduction à la chimie organique | NS1 | D1 ; PPO 2015 | Chimie organique, composé organique ; histoire (Wöhler, urée) ; carbone tétravalent ; chaînes linéaires, ramifiées, cycliques ; formules brute, développée, semi-développée ; classes de substances organiques ; substances naturelles et de synthèse |
| 16 | 🔁 Les hydrocarbures : nomenclature et propriétés | NS1 + NS2 | D1 ; D2 ; PPO 2015 | Alcanes, alcènes, alcynes, cycloalcanes, benzène et aromatiques ; formules générales ; nomenclature officielle ; températures de fusion et d'ébullition ; combustion, substitution, addition ; pétrole, gaz naturel, propane, butane |
| 17 | 🔁 L'isomérie | NS1 + NS2 + NS3 | D1 ; D3 ; PPO 2015 | Isomères ; isomérie de chaîne, de position, de fonction ; stéréo-isomérie Z/E ; chiralité, carbone asymétrique, énantiomères |

## NS2 — UA A3, A4, B2, D2

| # | Chapitre | Niveaux | Réf. | Contenu à couvrir |
|---|---|---|---|---|
| 1 | Les liaisons chimiques | NS2 | A3 ; PPO 2015 | Structure de Lewis des molécules ; doublet liant et non liant ; liaison ionique, covalente (simple, double, triple), covalente polarisée, métallique ; électronégativité et type de liaison ; composé ionique et moléculaire |
| 2 | Géométrie et polarité des molécules | NS2 | A3 ; PPO 2015 | Théorie VSEPR ; géométries linéaire, trigonale plane, tétraédrique, pyramidale, coudée ; angles de liaison (H₂O, CH₄, CO₂, NH₃, SO₂) ; molécule polaire et apolaire ; moment dipolaire |
| 3 | Forces intermoléculaires et propriétés des substances | NS2 | A3 ; PPO 2015 | Forces de Van der Waals (London, dipôle-dipôle) ; liaison hydrogène ; effets sur fusion, ébullition, solubilité, conductivité |
| 4 | 🔁 La réaction chimique et son équation | NS1 + NS2 | A4 ; Mod.I ch.7, ch.8 ; PPO 2015 | Réactifs, produits ; équation-bilan ; coefficients stœchiométriques ; équilibrage ; lois de Lavoisier et de Proust ; états (s), (l), (g), (aq) ; indices d'une réaction ; types : synthèse, décomposition, combustion, déplacement, précipitation, neutralisation ; composition de l'air ; action de l'air sur les matériaux |
| 5 | 🔁 Stœchiométrie et bilan de matière | NS1 + NS2 | A4 ; Mod.I ch.7 | Proportions stœchiométriques ; réactif limitant et en excès ; rendement ; calculs de masses, de quantités et de volumes |
| 6 | Combustions et énergie des réactions | NS2 | PPO 2015 S2 | Combustible, comburant ; combustion complète et incomplète (CO) ; réaction exothermique, endothermique ; enthalpie de réaction ΔH |
| 7 | 🔁 Électrolytes et force des acides et des bases | NS2 + NS4 | B2 ; B4 ; PPO 2015 | Électrolyte fort, faible, non-électrolyte ; conduction par les ions ; théorie de Brønsted-Lowry ; couple acide/base ; acide fort et faible, base forte et faible ; Ka, Kb, pKa ; HCl, acide acétique, soude, ammoniac |
| 8 | 🔁 Alcools, aldéhydes et cétones | NS2 + NS3 | D2 ; PPO 2015 | Groupe fonctionnel ; hydroxyle, carbonyle ; classes d'alcools ; polyols ; nomenclature ; propriétés physiques ; préparation (fermentation, hydratation des alcènes) |
| 9 | 🔁 Acides carboxyliques et esters | NS2 + NS3 | D2 ; PPO 2015 | Groupe carboxyle ; nomenclature ; propriétés acides ; esters, nomenclature ; estérification et hydrolyse (lentes, limitées) ; arômes et parfums |
| 10 | Amines et amides | NS2 | PPO 2015 (SVT, STMS) | Groupe amino ; amines primaires, secondaires, tertiaires ; amides ; nomenclature ; caractère basique des amines |
| 11 | 🔁 Réactions caractéristiques des fonctions organiques | NS2 + NS3 + NS4 | D2 ; D3 ; C4 ; PPO 2015 | Oxydation ménagée des alcools (dichromate, permanganate) ; action du sodium ; déshydratation ; tests des aldéhydes (liqueur de Fehling, réactif de Tollens, réactif de Schiff, DNPH) ; action des acides carboxyliques sur les métaux, les bases, les carbonates |
| — | 🔁 Configuration électronique · 🔁 Tableau périodique · 🔁 La mole · 🔁 Les solutions · 🔁 Nomenclature inorganique · 🔁 Acides, bases et pH · 🔁 Indicateurs et dosage · 🔁 Tampons · 🔁 Hydrocarbures · 🔁 Isomérie · 🔁 Sécurité au laboratoire | | | voir NS1 |

## NS3 — union SVT + MP (C1, C2, B3, D3)

| # | Chapitre | Niveaux | Réf. | Contenu à couvrir |
|---|---|---|---|---|
| 1 | L'oxydoréduction : définitions et principes | NS3 | C1 ; PPO 2015 | Oxydation, réduction ; oxydant, réducteur ; couple redox ; demi-équation électronique ; nombre d'oxydation ; équation-bilan ; oxydants et réducteurs courants (eau de Javel, eau oxygénée, permanganate) ; réactions naturelles (rouille) ; action des acides sur les métaux |
| 2 | 🔁 Potentiels standard et prévision des réactions redox | NS3 + NS4 | C1 ; C2 ; C3 ; PPO 2015 | Potentiel normal (standard) ; électrode standard à hydrogène ; classification électrochimique ; pouvoir oxydant et réducteur ; règle du gamma ; réaction spontanée et non spontanée ; équations en milieu acide et basique ; influence du pH |
| 3 | 🔁 Les piles électrochimiques | NS3 + NS4 | C2 ; C3 ; PPO 2015 | Électrochimie ; pile galvanique (Daniell) ; électrodes, anode, cathode, pont salin ; force électromotrice ; énergie chimique → électrique ; piles commerciales (saline, alcaline, lithium), accumulateurs |
| 4 | 🔁 Les dosages d'oxydoréduction | NS3 + NS4 | C2 ; C4 | Titrage redox ; permanganatométrie, iodométrie ; équivalence ; dosage potentiométrique |
| 5 | Acides et bases de Lewis | NS3 | B3 | Acide de Lewis (accepteur de doublet), base de Lewis (donneur de doublet) ; exemples |
| 6 | 🔁 Les sels en solution : hydrolyse et caractère acido-basique | NS3 + NS4 | B3 ; B4 ; PPO 2015 | Sel ; hydrolyse ; sels acides, basiques, neutres (NH₄Cl, Na₂CO₃, NaCl, FeCl₃) ; sels de la vie courante |
| 7 | 🔁 Solubilité, précipitation et identification des ions | NS3 + NS4 | B3 ; B4 ; PPO 2015 | Sel très soluble, peu soluble ; produit de solubilité Ks ; précipité, réaction de précipitation ; tests d'ions (Cu²⁺, Fe²⁺, Fe³⁺, Zn²⁺, Al³⁺, NH₄⁺, Cl⁻, SO₄²⁻) |
| 8 | Effets électroniques et mécanismes réactionnels | NS3 | D3 ; PPO 2015 | Effet inductif, effet mésomère ; réactif nucléophile, électrophile ; substitution, addition, élimination ; intermédiaires (carbocation, radical) |
| 9 | Synthèse organique et caractérisation des composés | NS3 | D3 | Planification d'une synthèse ; chauffage à reflux ; rendement ; caractérisation (température de fusion, spectroscopie infrarouge, RMN) |
| 10 | 🔁 Les polymères | NS2 + NS3 | PPO 2015 (STMS, STDR) ; A3 (activité) | Polymérisation (polyaddition), polycondensation ; motif ; polyéthylène, PVC, PET, nylon, caoutchouc ; plastiques et biodégradabilité ; usages |
| — | 🔁 Séparation et purification · 🔁 Solutions · 🔁 Indicateurs et dosage · 🔁 Tampons · 🔁 Isomérie · 🔁 Alcools, aldéhydes et cétones · 🔁 Acides carboxyliques et esters · 🔁 Réactions des fonctions · 🔁 Sécurité au laboratoire | | | voir NS1 / NS2 |

## NS4 — union SVT + MP (C3, C4, B4, D4)

| # | Chapitre | Niveaux | Réf. | Contenu à couvrir |
|---|---|---|---|---|
| 1 | L'électrolyse | NS4 | C3 ; PPO 2015 | Électrolyse, électrolyseur ; anode, cathode ; électrolyse de l'eau (volumes 2 : 1), de HCl, de la soude, de NaCl fondu et aqueux ; réactions aux électrodes ; quantités de matière formées (loi de Faraday) |
| 2 | Applications de l'oxydoréduction : métallurgie, galvanoplastie, corrosion | NS4 | C3 ; C4 ; PPO 2015 | Affinage des métaux ; production de l'aluminium ; galvanoplastie (chromage, argenture, zingage) ; corrosion, rouille ; protection (peinture, galvanisation, anode sacrificielle) ; eau de Javel ; oxydoréduction dans la vie courante et le vivant |
| 3 | Applications des réactions acido-basiques | NS4 | B4 | Usages domestiques (vinaigre, citron, antiacides, détartrage) et industriels ; chaulage des sols ; pluies acides et déversements ; importance de l'étalonnage |
| 4 | Les glucides : structure et propriétés chimiques | NS4 | D4 | Oses (aldoses, cétoses), glucose, fructose ; formules ; liaison glycosidique ; amidon, cellulose (aspect chimique) ; tests (Fehling, Benedict, Lugol) |
| 5 | Les lipides, savons et détergents | NS4 | D4 ; PPO 2015 | Acides gras saturés et insaturés (formules) ; triglycérides ; saponification ; savon (partie hydrophile et hydrophobe), détergents ; test au Soudan III |
| 6 | Acides aminés et protéines : approche chimique | NS4 | D4 ; PPO 2015 | Formule générale d'un acide aminé ; caractère amphotère, zwitterion ; condensation et hydrolyse ; polycondensation ; test du biuret |
| — | 🔁 Sécurité · 🔁 Indicateurs et dosage · 🔁 Tampons · 🔁 Électrolytes et force des acides · 🔁 Potentiels redox · 🔁 Piles · 🔁 Dosages redox · 🔁 Sels · 🔁 Précipitation · 🔁 Réactions des fonctions | | | voir NS1 à NS3 |

**Total : 44 chapitres** (NS1 17, NS2 11, NS3 10, NS4 6), dont 23 communs à plusieurs niveaux.

---

## Points à trancher

1. **Cinétique et équilibre chimique** (vitesse de réaction, facteurs cinétiques, catalyseur, énergie d'activation, réaction réversible, Le Chatelier) : absents du programme 2024 et des tableaux 2015, mais présents dans l'ancienne base (≈ 8 questions). Proposition : un chapitre 🔁 NS3 + NS4 « Vitesse de réaction et équilibre chimique ».
2. **Recoupements avec la Physique** : états de la matière et masse volumique (Physique NS1), modèles de l'atome (Physique), radioactivité (Physique NS4). Proposition : garder en Chimie les chapitres NS1 #3 et #6 ; la radioactivité reste en Physique.
3. **Anciens chapitres en base** (ids 37–40, 118 questions au 2026-10-17) : les garder jusqu'à ce que toutes leurs questions soient replacées, puis les supprimer, comme pour la Biologie.

## Réaffectation de l'ancienne base (147 questions du seed `c2b421e`)

| Ancien chapitre | Questions | Destination principale |
|---|---|---|
| Structure de la matière et tableau périodique (+ version NS1) | 25 + 10 | NS1 #6, #7, #8, #9, #11 ; NS2 #1 |
| Liaisons chimiques et propriétés des composés (NS1) | 9 | NS2 #1, #2, #3 |
| Réactions chimiques et équations | 25 | NS2 #4, #5, #6 ; NS3 #1 ; NS4 #1, #2 ; point 1 |
| Réactions chimiques et stœchiométrie (NS2) | 10 | NS2 #4, #5, #7 ; NS1 #12 ; point 1 |
| Acides, bases et pH | 24 | NS1 #12, #13, #14 ; NS2 #7 ; NS4 #3 |
| Chimie organique et chimie de la vie (+ version NS3) | 24 + 10 | NS1 #15, #16, #17 ; NS2 #8, #9 ; NS3 #8, #10 ; NS4 #4–#6 (questions déjà couvertes en Biologie écartées) |
| Électrochimie et applications (NS4) | 10 | NS3 #3 ; NS4 #1, #2 (photovoltaïque et spectroscopie : hors chimie ou NS3 #9) |
