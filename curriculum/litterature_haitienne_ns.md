# Littérature haïtienne (matière 23, composante de M06) — Secondaire NS1 à NS3

> **Statut : plan validé par l'utilisateur le 2026-10-18** (points à trancher : Coicou en NS1, théâtre commun NS1+NS2, Laleau/Roumer/Brierre en NS3, chapitre Prix gardé ; **œuvres en créole incluses ici**). Prévoir un grand nombre de questions pour certains chapitres (couverture complète, sans cible fixe).
> Pas de NS4 (la Littérature est remplacée par la Philosophie). La Littérature universelle (matière 20) a sa propre session.

## Sources

1. **Programme officiel** : le programme de Communication française du MENFP (`Donnees/Programme de Communication Française_MENFP.pdf`) ne contient **pas de programme de littérature haïtienne** : il ne cite des œuvres haïtiennes que comme **propositions de lecture** (J. Roumain *La Montagne ensorcelée*, D. Laferrière *L'odeur du café*, L. Trouillot *Thérèse en mille morceaux* et *Antoine des Gommiers*, C. Brouard « Nous », G. Sylvain « Les Vagabonds », R. Philoctète *Caraïbes*, E. Vilaire *Le Flibustier*, J. Price-Mars *Le mythe de l'Orphée noir*…). Ces titres sont donc à couvrir.
2. **Questionnaire de l'utilisateur** `Litterature.pdf` (8 pages scannées, 110 + 18 + 50 + 37 questions) : **source de contenu seulement**. Il sert à repérer les auteurs et œuvres attendus (Janvier, Firmin, Vilaire, Sylvain, Hibbert, Price-Mars, Roumain, Brouard, Frankétienne, Philoctète, Languichatte, Laferrière, Gary Victor, Trouillot, Valérie Lacroix, Lahens, Danticat, Mars, Vastey, Lhérisson, Coicou, Marcelin, Ardouin). **Il contient des erreurs, à ne pas reprendre** : *Bois d'ébène* est de Jacques Roumain, pas de René Depestre (Q76, Q104) ; etc. Chaque fait sera revérifié.
3. **Périodisation** (concordante dans les trois sources) :
   - Université de Mostaganem, mémoire sur *Passages* d'Émile Ollivier, chap. I (« Haïti, histoire, langues, littérature ») — [e-biblio.univ-mosta.dz](https://e-biblio.univ-mosta.dz/bitstreams/c2f3346b-1563-4e7b-932b-f0ae621b3de6/download) : pionniers (1804-1836), École de 1836, École patriotique (1860-1898), La Ronde (1898-1915), indigénisme (1915-1946), surréalisme et littérature contemporaine.
   - [Wikipédia — Littérature haïtienne](https://fr.wikipedia.org/wiki/Litt%C3%A9rature_ha%C3%AFtienne) : mêmes étapes + réalisme social (1945-1990), spiralisme, diaspora.
   - [Larousse — Haïti (littérature)](https://www.larousse.fr/encyclopedie/litterature/Ha%C3%AFti/173800) : coloniale, romantisme (1836), La Ronde, occupation américaine, exil sous Duvalier, spiralisme, écriture « du dehors ».
   - [Universalis — Poètes haïtiens](https://www.universalis.fr/encyclopedie/poetes-haitiens/) (École de 1836, La Ronde 1898-1915) ; [SISMO/INHA — revues](https://sismo.inha.fr/s/en/item/7204) (*La Revue indigène*, *La Nouvelle Ronde*).
4. **Manuels** : *Histoire de la littérature haïtienne illustrée par les textes* (Raphaël Berrou et Pradel Pompilus, Éditions Caraïbes, 1975-1977) et Léon-François Hoffmann, *Littérature d'Haïti* (EDICEF/AUPELF, 1995) sont les ouvrages de référence ; leur **sommaire détaillé n'est pas disponible en ligne** (catalogues : [folio.caval.edu.au](https://folio.caval.edu.au/Record/c000144442)). Aucun sommaire d'un manuel F.I.C. / Deschamps de littérature haïtienne du secondaire trouvé en ligne. Le découpage ci-dessous est donc l'**union des périodisations** ci-dessus, avec les titres du questionnaire.
5. **Ancienne base** : 42 questions « Littérature Haïtienne » du seed Dart (3 chapitres « (NS1) », « (NS2) », « (NS3) ») + suppléments `scripts/supplements/v2_supp_23_litterature_haitienne.sql`. **Erreurs repérées dans ces anciennes questions** : *L'Énigme du retour* a reçu le Médicis en **2009** (le supplément dit 2011 pour *L'Art de perdre*, qui n'existe pas dans l'œuvre de Laferrière) ; les chapitres sont mal placés par rapport à la progression validée (Roumain en NS1, négritude en NS2). Elles seront réécrites ou rejetées chapitre par chapitre.
6. **Base de production** (diagnostic 028, 2026-10-18) : **0 chapitre et 0 question pour la matière 23** ; tout est à créer.

## Règles d'organisation

- Progression validée : NS1 = débuts → École de 1836 → romantisme patriotique ; NS2 = La Ronde ; NS3 = indigénisme → XXe siècle → contemporain. **Jacques Roumain = NS3 ; Etzer Vilaire = NS2.**
- Les 4 blocs (A notions, B périodes et mouvements, C auteurs, D œuvres) sont répartis : chaque chapitre « période » contient auteurs et œuvres ; les chapitres « auteur majeur » approfondissent ; les chapitres de notions et de prix regroupent le transversal.
- Format « résumé → œuvre » : surtout pour les romans et pièces majeurs (*Stella*, *Mimola*, *Gouverneurs de la rosée*, *Compère Général Soleil*…).
- **Œuvres en créole** (*Choucoune*, *Cric ? Crac !*, *Dézafi*, *Antigòn*, lodyans de Maurice Sixto…) : **incluses dans la Littérature haïtienne** (décision du 2026-10-18), du point de vue de l'histoire littéraire (auteur, date, genre, place dans le mouvement). Le Kreyòl les traite sous l'angle de la langue ; éviter seulement les doublons exacts d'énoncé.
- 🔁 = chapitre commun à plusieurs niveaux (table `chapitre_niveaux`).
- Dates et titres sont à vérifier un par un à la rédaction (les sources divergent, ex. fondation de *La Ronde* : 1895 selon Wikipédia, 1898 selon Larousse/Universalis).

---

## NS1 — Des débuts au romantisme patriotique

| # | Chapitre | Niveaux | Bloc | Contenu à couvrir |
|---|---|---|---|---|
| 1 | Introduction à la littérature haïtienne | NS1 | A | Définition ; langues d'expression (français, créole) ; oral / écrit ; genres pratiqués en Haïti ; périodisation d'ensemble ; littérature coloniale de Saint-Domingue (Moreau de Saint-Méry, Hilliard d'Auberteuil) ; premier groupe d'écrivains après 1804 ; notions : pseudo-classicisme, romantisme, patriotisme littéraire |
| 2 | Les débuts de la littérature haïtienne (1804-1836) | NS1 | B, C, D | Contexte de l'indépendance ; Acte de l'indépendance (Boisrond-Tonnerre) ; Pierre Fligneau *L'Haïtien expatrié* (1804) ; Antoine Dupré (*Hymne à la liberté*) ; Juste Chanlatte ; Baron de Vastey *Le Système colonial dévoilé* (1814) ; Milscent et *L'Abeille haytienne* (1817) ; presse et pamphlets ; poésie de circonstance, pseudo-classique |
| 3 | L'École de 1836 : contexte et poètes | NS1 | B, C, D | Cénacle de 1836, journaux *Le Républicain* et *L'Union* ; frères Nau (Ignace et Émile) ; Ignace Nau (*Odelette*, poèmes) ; Coriolan Ardouin (*Reliques d'un poète haïtien*) ; Beauvais Lespinasse ; Charles Séguy-Villevaleix ; thèmes (amour, mélancolie, nature, « soyons nous-mêmes ») ; influence du romantisme français |
| 4 | L'École de 1836 : histoire et roman | NS1 | C, D | Thomas Madiou *Histoire d'Haïti* (1847-1848) ; Beaubrun Ardouin ; Saint-Rémy ; Émile Nau *Histoire des caciques d'Haïti* ; Émeric Bergeaud *Stella* (premier roman haïtien, allégorie de l'indépendance, résumé → œuvre) |
| 5 | Le romantisme patriotique (1860-1898) : poésie | NS1 | B, C, D | Oswald Durand (*Rires et pleurs*, poète national), Tertullien Guilbaud, Massillon Coicou (*Poésies nationales*), Alcibiade Fleury-Battier ; thèmes patriotiques, défense de la race noire ; revue *Jeune Haïti* (1895-1898, Seymour Pradel et Justin Lhérisson) |
| 6 | Le romantisme patriotique (1860-1898) : roman et essais | NS1 | B, C, D | Demesvar Delorme (*Le Damné*, *Les Théoriciens au pouvoir*), Amédée Brun ; Louis-Joseph Janvier (*L'Égalité des races*, 1884) ; Anténor Firmin (*De l'égalité des races humaines*, 1885, réponse à Gobineau) ; Hannibal Price (*De la réhabilitation de la race noire par la République d'Haïti*, date à vérifier : 1889 ou 1900) ; Benito Sylvain |
| 7 | 🔁 Le théâtre haïtien (1804-1915) | NS1 + NS2 | B, C, D | Fligneau, Dupré, théâtre d'actualité ; Oswald Durand (*Ogé* ou *Le préjugé de couleur* à vérifier) ; Massillon Coicou (*L'Empereur Dessalines*, exécuté en 1908) ; Etzer Vilaire (*Le Flibustier*) ; formes (drame historique, comédie) |

## NS2 — La Ronde (1898-1915)

| # | Chapitre | Niveaux | Bloc | Contenu à couvrir |
|---|---|---|---|---|
| 1 | La Ronde : contexte, revue et esprit de l'école | NS2 | B, C | Fondation de la revue *La Ronde* (Pétion Gérome ; Dantès Bellegarde) ; Haïti au début du XXe siècle ; ouverture sur le monde, rejet du « patriotisme à tout prix », débat sur l'imitation de la France ; Charles Moravia (traducteur de Heine) ; Dantès Bellegarde (essayiste) ; Damoclès Vieux (*L'Âme captive*, 1913) ; liens avec parnasse et symbolisme |
| 2 | Les poètes de La Ronde | NS2 | C, D | Georges Sylvain (*Confidences et mélancolies*, 1901 ; « Les Vagabonds » ; poèmes en français) ; Edmond Laforest (*Poèmes mélancoliques*, suicide 1915) ; Ida Faubert ; Duraciné Vaval (*Stances haïtiennes*, 1912) ; Charles Moravia ; thèmes (mélancolie, exil, mort) |
| 3 | Etzer Vilaire | NS2 | C, D | Biographie (né en 1872) ; *Les Dix Hommes noirs* ; *Poèmes de la mort* ; *Le Flibustier* ; poète de la pensée, de la mort, de la patrie ; place dans La Ronde |
| 4 | Romanciers et humoristes de la Ronde | NS2 | C, D | Frédéric Marcelin (*Thémistocle Épaminondas Labasterre*, 1901) ; Justin Lhérisson (*La Famille des Pitite-Caille*, *Zoune chez sa Ninnaine*, 1906 ; paroles de *La Dessalinienne*, 1903) ; Fernand Hibbert (*Les Thazar*, *Séna*, satire) ; Antoine Innocent (*Mimola*, 1906) ; résumé → œuvre |
| 5 | La pensée et l'histoire au début du XXe siècle | NS2 | C | Dantès Bellegarde ; Duraciné Vaval (*Histoire de la littérature haïtienne ou l'âme noire*, 1933 à vérifier) ; Dr Dorsainvil ; Frédéric Marcelin essayiste ; Hannibal Price, Firmin (rappel) ; occupation de 1915 comme tournant |

## NS3 — Indigénisme, XXe siècle et contemporain

| # | Chapitre | Niveaux | Bloc | Contenu à couvrir |
|---|---|---|---|---|
| 1 | L'occupation américaine et la naissance de l'indigénisme (1915-1934) | NS3 | B | Occupation américaine (1915-1934) ; Ligue de la jeunesse haïtienne ; revues (*La Nouvelle Ronde*, *La Trouée*, *La Revue indigène*, 1927) ; mouvement indigéniste : principes, groupe, appel à l'Afrique et au peuple |
| 2 | Jean Price-Mars | NS3 | C, D | Biographie (1876-1969, médecin, ethnologue, diplomate) ; *La Vocation de l'élite* (1919) ; *Ainsi parla l'Oncle* (1928) ; *Le mythe de l'Orphée noir* ; vodou, folklore, « bovarysme collectif » ; précurseur de la négritude |
| 3 | Les poètes de l'indigénisme | NS3 | C, D | Émile Roumer (*Poèmes d'Haïti et de France*, « Marabout de mon cœur ») ; Carl Brouard (*Écrit sur du ruban rose*, « Nous », *Les Griots*) ; Léon Laleau (*Le Choc*, « Trahison ») ; Jean Brierre ; Roussan Camille ; Clément Magloire-Saint-Aude (surréalisme) |
| 4 | Jacques Roumain | NS3 | C, D | Biographie (1907-1944) ; Parti communiste haïtien (1934), Bureau d'ethnologie ; *La Montagne ensorcelée* (1931) ; *Gouverneurs de la rosée* (1944) : intrigue, personnages (Manuel, Annaïse, Délira, Bienaimé), thèmes ; *Bois-d'ébène* (1945) ; résumé → œuvre |
| 5 | Le roman paysan et le roman social | NS3 | B, D | Jean-Baptiste Cinéas ; frères Marcelin (*Canapé-Vert*, 1944 ; *La Bête de Musseau*, *Le Crayon de Dieu*) ; Stephen Alexis (*Le Nègre masqué*, 1933) ; Roumain ; Marie-Thérèse Colimon ; caractéristiques du roman paysan |
| 6 | Réalisme social et réalisme merveilleux (1945-1960) | NS3 | B, C, D | Revue *La Ruche* (1945) ; René Depestre (*Étincelles*, *Minerai noir*, *Le Mât de cocagne*, *Hadriana dans tous mes rêves*) ; Jacques Stéphen Alexis (*Compère Général Soleil*, 1955 ; *Les Arbres musiciens* ; *L'Espace d'un cillement* ; manifeste du réalisme merveilleux) ; lien avec la négritude (Senghor, Césaire, Damas) |
| 7 | Littérature sous les Duvalier (1957-1986) et exil | NS3 | B, C, D | Marie Vieux-Chauvet (*Fille d'Haïti*, *La Danse sur le volcan*, *Amour, colère et folie*, *Les Rapaces*) ; groupe Haïti littéraire (Anthony Phelps, Davertige, Philoctète, Legagneur…) ; Roger Dorsinville ; Magloire-Saint-Aude ; Jean Métellus ; écriture « du dedans » et « du dehors » ; censure et exil |
| 8 | Le spiralisme et ses prolongements | NS3 | B, C, D | Frankétienne (Franck Étienne ; *Mûr à crever*, 1968 ; *Ultravocal* ; *Les Affres d'un défi* ; *Métamorphoses*) ; René Philoctète (*Le Peuple des terres mêlées*, *Caraïbes*) ; Jean-Claude Fignolé (*Les Possédés de la pleine lune*) ; esthétique de la spirale ; pluréalisme (Gérard Dougé) ; *Dézafi* → Kreyòl |
| 9 | La diaspora : Canada, États-Unis, France | NS3 | B, C, D | Émile Ollivier (*Mère-Solitude*, *Passages*) ; Dany Laferrière (*Comment faire l'amour avec un nègre sans se fatiguer*, *L'odeur du café*, *Pays sans chapeau*, *L'Énigme du retour*, Académie française 2013) ; Edwidge Danticat (*Breath, Eyes, Memory*, *Krik? Krak!*, *The Farming of Bones*) ; Marie-Célie Agnant ; Rodney Saint-Éloi ; Stanley Péan ; Jean-Claude Charles ; Louis-Philippe Dalembert |
| 10 | La littérature haïtienne contemporaine | NS3 | B, C, D | Lyonel Trouillot (*Rue des Pas-Perdus*, *Thérèse en mille morceaux*, *Bicentenaire*, *La belle amour humaine*) ; Gary Victor (*Dossiers interdits*) ; Yanick Lahens (*Dans la maison du père*, *La Couleur de l'aube*, *Bain de lune*) ; Kettly Mars (*Saisons sauvages*) ; Valérie Lacroix (*Tifi en Haïti*) ; Makenzy Orcel, James Noël ; écrits sur le séisme du 12 janvier 2010 |
| 11 | Prix et distinctions des écrivains haïtiens | NS3 | C | Prix + année + œuvre : Renaudot 1988 (Depestre), Médicis 2009 (Laferrière), Femina 2014 (Lahens), Académie française 2013 (Laferrière), prix Henri Deschamps, prix Carbet, prix Jacques Roumain, etc. — **à vérifier un par un** |
| 12 | Courants et notions de la littérature haïtienne du XXe siècle | NS3 | A | Indigénisme, négritude, noirisme, réalisme social, réalisme merveilleux, spiralisme, pluréalisme, littérature de l'exil, écriture du dedans / du dehors, roman paysan ; synthèse chronologique XIXe-XXIe (auteur → mouvement → œuvre) |

---

## Décisions de l'utilisateur (2026-10-18)

1. Massillon Coicou : **NS1**. 2. Œuvres en créole : **incluses en Littérature haïtienne** (réponse « non » à l'exclusion). 3. Théâtre commun NS1+NS2 : **gardé**. 4. Laleau, Roumer, Brierre : **NS3**. 5. Chapitre Prix et distinctions : **gardé**.
