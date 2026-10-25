# Physique — chapitres prêts, en attente de validation

Préparés le 2026-10-20. Rien n'est importé en base : ni migration, ni `statut: validé`.
Fichiers dans `_prepare/` : `ns1_chNN_Q.json` (questions), `ns1_chNN_widget.html` (widget de validation), `build_chNN.py` (script de construction ; il lit l'ancien seed `git show c2b421e:lib/services/database_helper.dart` copié dans `dh_old.dart`, non versionné).

| # | Chapitre (titre exact en base) | Niveaux | État |
|---|---|---|---|
| 1 | Grandeurs, mesures et états de la matière | NS1 | validé et importé (migration 041, 44 questions) |
| 2 | Big Bang, système solaire et exploration de l'espace | NS1 + NS2 | validé et importé (42 + 37 de supplément = 79 questions) |
| 3 | Gravitation universelle, poids et masse | NS1 + NS2 | **prêt, widget affiché : 35 questions (dont base Q1214, Q1218, Q1226, Q1235, Q1238), en attente de validation** |
| 4 | Mouvement, trajectoire, vitesse et accélération | NS1 | **prêt : 35 questions (dont base Q1213, Q1219, Q1225, Q1323, Q1328), pas encore affiché** |

## Points à signaler

**Ch.1**
- PN1_01-46 (état intermédiaire, « une pâte ») : exemples à valider, le programme ne les cite pas.
- Définitions sans sens physique au Larousse en ligne (grandeur, unité, masse, masse volumique, Système international) : écrites à partir du programme A1.
- Recoupement Chimie : atome, molécule, états de la matière, masse volumique, densité. Définis ici en premier.
- Calculs courts : conversions, ρ = m/V.

**Ch.2**
- Pas de question sur la zone habitable ni sur l'origine de la vie : recoupement avec la Géologie (« La Terre, une planète singulière »).
- Recoupement Géologie : Big Bang, nucléosynthèse (SES/LLA 4.2).
- Faits d'histoire de l'exploration (Spoutnik 1957, Gagarine 1961, Apollo 11 en 1969) et nombre d'exoplanètes : à valider.
- Questions de connaissance (pas de définition) pour les termes absents du Larousse : parallaxe, unité astronomique, sonde spatiale, Voie lactée.

**Ch.3**
- Q1214 et Q1235 passées de m/s² à N/kg pour g.
- Poids défini comme force (Larousse : poids, sens 2, précisé).
- Pas de question sur la chute libre ni sur la force en général : réservées aux chapitres NS2 (inertie, chute libre) et NS1 ch.5 (force).

## Pas encore commencé
NS1 ch.5 à ch.14, puis NS2, NS3, NS4. Trois chapitres d'avance suffisent : on s'arrête ici.
