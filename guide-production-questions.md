---
name: guide-production-questions
description: Méthode complète pour couvrir une matière EduClé chapitre par chapitre — inventaire, rédaction, validation par l'utilisateur, enregistrement, import Supabase. À lire avant de produire des questions dans n'importe quelle matière.
---

# Couvrir une matière et préparer ses questions

Ce guide décrit la méthode suivie pour la Biologie (NS1 à NS2-NS3, 18 chapitres validés en octobre 2026). Elle s'applique à toutes les matières.

Les règles de format sont dans [regles-creation-questions.md](regles-creation-questions.md). Ce guide ne les répète pas toutes : il dit **comment travailler**.

---

## 1. Les sources à consulter avant de commencer

| Quoi | Où |
|---|---|
| Découpage officiel en chapitres (MENFP), par niveau et par matière | `curriculum/<matiere>_ns.md` (ex. [curriculum/biologie_geologie_ns.md](curriculum/biologie_geologie_ns.md)) |
| Règles de format des questions | [regles-creation-questions.md](regles-creation-questions.md) |
| Chapitres déjà validés | `curriculum/questions/<matiere>/<niveau>_chNN_<sujet>.json` |
| Anciennes questions de la base, avant corrections | `git show c2b421e:lib/services/database_helper.dart`. Le commit 2bf37aa a retiré le seed du fichier actuel ; le lire avec [scripts/questions/parse_all.py](scripts/questions/parse_all.py). |
| Outils | [scripts/questions/](scripts/questions/) |

**Où vivent les données :**
- L'application n'est pas encore installée sur les téléphones. Seule la version web existe, et elle lit Supabase.
- Une question n'existe pour les élèves qu'une fois importée dans Supabase (table `questions`, liée à `chapitres`).

---

## 2. Le déroulé, chapitre par chapitre

On traite **un seul chapitre à la fois**, dans l'ordre du programme. Si un chapitre sert de base à un autre, on le traite d'abord : par exemple « Molécules biologiques » avant « Métabolisme ».

### Étape 0 — Construire le plan des chapitres de la matière

1. Lire le **programme officiel MENFP** de la matière, dans `Projet Quiz Educatif/Donnees/`.
2. Lire le **plan de manuel** fourni par l'utilisateur, s'il y en a un, dans `OneDrive/Documents/Programm Menfp/`. Ce sont des scans : pdftoppm n'est pas installé, il faut rendre les pages en PNG avec PyMuPDF (`import fitz`), puis lire les images.
3. **Chercher d'autres manuels scolaires haïtiens de la matière**, pour voir comment les enseignants découpent réellement le programme en chapitres. Trois pistes :
   - les sommaires des collections F.I.C. / Editha, Hachette-Deschamps, Henri Deschamps, etc. ;
   - les pages « manuels » des écoles (ex. islghaiti.org) ;
   - les sujets d'examens officiels (bac haïtien).

   Faire la recherche sur le web et citer les sources consultées dans le fichier du découpage.
4. Proposer le découpage NS1–NS4 dans `curriculum/<matiere>_ns.md`, sur le modèle de `biologie_geologie_ns.md` et `mathematiques_ns.md` :
   - prendre l'union du programme 2024 et des manuels ;
   - en NS3/NS4, prendre l'union des séries ;
   - faire des chapitres communs pour les notions présentes à plusieurs niveaux.
5. Afficher ce découpage **dans le chat** pour validation.
6. Une fois le découpage validé, créer les chapitres en base par une migration (table `chapitres` et liaison `chapitre_niveaux`, sur le modèle de la migration 004).

### Étape 1 — Inventaire du chapitre

1. Lire la ligne du chapitre dans `curriculum/<matiere>_ns.md`, colonne « Contenu à couvrir ».
2. Lister **tous les termes techniques** du chapitre :
   - ceux du programme ;
   - ceux qui sortent naturellement des notions, des explications et des schémas classiques du chapitre.
3. Retirer de la liste :
   - **les termes déjà définis dans un chapitre validé**. Pour les trouver, chercher dans les `bonne_reponse` de tous les JSON de la matière. Exemple : le plasma, défini en NS1 ch.4, n'est pas repris en NS2 ch.3.
   - **les termes cités en passant** qui relèvent d'un autre chapitre (ex. « artère » au chapitre du rein).
4. Chercher les **questions de l'ancienne base** qui portent sur ce chapitre (mots-clés sur l'énoncé et la réponse). Ne pas reprendre celles déjà utilisées dans un JSON validé : les identifiants `Q….` sont dans les JSON.

Il n'y a **jamais de nombre cible**. On s'arrête quand toutes les notions sont couvertes. Selon les chapitres, cela a donné 17, 28, 34… jusqu'à 67 questions.

### Étape 2 — Récupérer les définitions au Larousse

```bash
bash scripts/questions/larousse.sh <dossier_vide> tabac nicotine "acide lactique" …
```

- Garder **le sens qui correspond au chapitre** (ex. « plaquette », sens 4 médecine).
- **Pas d'article, ou pas le bon sens** (ex. emphysème, AVC, stroma, sédentarité) : écrire la définition à partir du programme et l'indiquer dans la source : « Programme 2.1 (pas de définition au Larousse en ligne) ».
- Le navigateur intégré est bloqué sur larousse.fr. Utiliser `curl -L` : le site répond par une redirection 301.

### Étape 3 — Rédiger les questions

**Le format préféré : la définition.** L'énoncé est la définition, la réponse est le terme. Ce sont les questions que l'utilisateur valide presque toujours. Il faut en faire la grande majorité du chapitre.

**Règles à vérifier une par une :**
- **Aucun mot de la même famille que la réponse dans l'énoncé** : c'est la cause n° 1 des reformulations. Exemples :

  | Réponse | Mot interdit dans l'énoncé | Correction |
  |---|---|---|
  | bronchite | « bronches » | « conduits qui relient la trachée aux poumons » |
  | tabagisme | « tabac » | « cigarettes, cigares ou pipe » |
  | tachycardie | « cardiaque » | « du cœur » |
  | amyloplaste | « plaste », « amidon » | « organite », « réserve glucidique » |
  | facteur limitant | « limite » | « freine » |
  | monomère | « polymère » | « macromolécule » |

  Penser aussi aux racines savantes : glyco-/gluco-, cardio-, -lyse, -plaste.
- **Reformuler en français simple** plutôt que copier le Larousse mot pour mot. Couper les parenthèses et les détails encyclopédiques.
- **Questions de connaissance** :
  - toujours une vraie question terminée par « ? », jamais « … : » ;
  - seulement des **faits nets du programme**.
- **Réponses** : 4 choix, de 1 à 6 mots. Les distracteurs sont plausibles, de la même catégorie grammaticale et de longueur proche.
- **Explication** : une ou deux phrases qui apportent quelque chose de plus. Exemples : synonyme, exemple local (Haïti), lieu dans la cellule. Ne jamais répéter l'énoncé.
- **Difficulté** : F/M/D, sans quota. Ne pas inventer des questions difficiles pour équilibrer.

**Ce que l'utilisateur rejette régulièrement (à éviter) :**
- les questions de sens de variation à réponse évidente : « Que devient la fréquence cardiaque à l'effort ? » → « Elle augmente » ;
- les « pourquoi » mécanistes : pourquoi l'air entre dans les poumons, pourquoi le cœur bat plus vite ;
- les chiffres peu classiques : surface des alvéoles, 7 000 substances dans la fumée, débit 5 → 20 L/min, « 220 − âge » ;
- les calculs, les « pourquoi un adolescent… », la répartition des repas ;
- **les deux questions d'un même bilan** : « que consomme la respiration ? » et « que produit-elle ? » ont été rejetées ensemble ;
- les doublons d'une question déjà validée dans un autre chapitre.

**Questions de l'ancienne base (`Q….`) :**
- **Les réécrire au format définition dès que c'est possible.** Exemple : « Qu'est-ce que la dénaturation ? » devient la définition, et la réponse devient « La dénaturation ». C'est la consigne permanente « même changement que Q1714 ».
- Corriger les énoncés terminés par « : ».
- Corriger les réponses trop longues ou qui répètent l'énoncé. Exemple : « tuberculose » → « La bactérie Mycobacterium tuberculosis ».
- Si l'équation ou la formule dépasse 6 mots, demander les produits ou les réactifs, et mettre l'équation dans l'explication.

### Étape 4 — Validation par l'utilisateur (obligatoire)

L'utilisateur valide **chaque question**.

1. Construire le chapitre avec [scripts/questions/chapitre.py](scripts/questions/chapitre.py). Il produit `chNN_Q.json` et `chNN_widget.html`.

   ```python
   import sys; sys.path.insert(0, "scripts/questions")
   from chapitre import Chapitre
   c = Chapitre("B19", "Biologie", "NS3 ch.1 (Les muscles : types, structure et propriétés)", base_dart="dh_corrige.dart")
   c.groupe("Les types de muscles")
   c.new(1, "F", "Définition…", ["Le bon terme", "Faux 1", "Faux 2", "Faux 3"], "Explication.", "Larousse : mot (sens 2)", "D")
   c.base(1573, en="Nouvel énoncé…", ch=[…], ex="…", src="Base Q1573 (modifiée) — Larousse : …", typ="D")
   c.ecrire("ch19")
   ```

   - Les identifiants des nouvelles questions suivent la forme `B<n° de chapitre>-<n°>`. Garder une numérotation par dizaines pour chaque groupe.
   - `ecrire()` vérifie trois choses : 4 choix distincts, pas plus de 6 mots par réponse, « ? » à la fin des questions de connaissance.
2. Afficher le widget avec `show_widget`, en collant le contenu de `chNN_widget.html`. Chaque carte a trois boutons : Valider, À modifier, Rejeter. Le bouton d'envoi renvoie un message de la forme :
   `Validation <Matière> <niveau> ch.N (<titre>) — Validées (n) : … · Rejetées (n) : … · À modifier (n) : id → consigne ; …`
   **Comment afficher le widget, pas à pas :**
   - Appeler d'abord, sans le dire à l'utilisateur, l'outil `read_me` du module visualize (`mcp__visualize__read_me`, modules `["interactive"]`). Il est obligatoire avant le premier `show_widget` de la session.
   - Lire `chNN_widget.html`, puis appeler `mcp__visualize__show_widget` :
     - `title` = un identifiant en snake_case, par exemple `validation_physique_ns1_ch1_mesures` ;
     - `widget_code` = le contenu **complet** du fichier, collé tel quel, sans `<html>`, `<head>` ni `<body>` ;
     - `loading_messages` = un message court.
   - Le widget affiche, pour chaque question, son identifiant et les badges suivants :
     - la difficulté ;
     - le type (Définition ou Connaissance) ;
     - « Déjà en base » pour les questions `Q….` ;
     - la source.

     On y voit ensuite l'énoncé, les 4 choix (la bonne réponse en vert), l'explication et les trois boutons. Le bouton « Valider les non traitées » permet à l'utilisateur de tout accepter d'un coup.
   - **Ne jamais répéter les questions en texte** sous le widget : il les affiche déjà.
   - Quand l'utilisateur clique sur « Envoyer », son message arrive dans la conversation sous la forme `Validation … — Validées (n) : … · Rejetées (n) : … · À modifier (n) : …`. C'est ce message qu'on traite ensuite (étape 5).
   - **Tout ce qui demande une décision de l'utilisateur s'affiche dans le chat** : le découpage en chapitres, les questions, les points à trancher. Ne jamais le laisser seulement dans un fichier. Pour le **découpage en chapitres**, un tableau Markdown dans la réponse suffit, ou un widget du même style avec Valider / À modifier / Rejeter par chapitre.
   - **Revalidation** : pour les questions « À modifier », réafficher un petit widget avec ces seules questions réécrites. Utiliser le même gabarit, avec un préfixe de message « Revalidation … ».

3. En dessous du widget, résumer en quelques lignes :
   - les questions de base reprises ou modifiées ;
   - les termes écartés comme doublons ;
   - les définitions écrites sans le Larousse.

### Étape 5 — Enregistrer puis importer

L'utilisateur a autorisé une fois pour toutes : commit, push, simulation et application des migrations, sans redemander.

1. **Questions « À modifier »** :
   - les réécrire selon la consigne ;
   - les mettre dans un fichier `modifs.json` (`{"B10-28": {"enonce": …, "choix": […], "explication": …}}`) ;
   - passer ce fichier à `--modifs`. Elles reçoivent alors `statut: "à revalider"`.
   - Montrer ensuite un **petit widget de revalidation**, puis les importer avec la liste d'identifiants (voir l'étape 3 de cette liste).
2. **Enregistrer le JSON validé** :

   ```bash
   python scripts/questions/chapitre.py enregistrer ch19_Q.json curriculum/questions/biologie/ns3_ch01_muscles.json \
     --matiere-id 11 --matiere Biologie --chapitre "Les muscles : types, structure et propriétés" \
     --niveaux NS3 --unite 3.1 --rejetees "B19-04,Q1600"
   ```

   - `--chapitre` doit être **le titre exact** de la ligne dans la table `chapitres`. La simulation affiche `chapitre_trouve = 1` si c'est le cas.
   - **Chapitre sur plusieurs niveaux** : nommer les groupes « NS2 — … » / « NS3 — … » et ajouter `--niveau-par-groupe`. Chaque question reçoit alors son `v4_niveau`.
3. **Générer la migration**. Les numéros se suivent dans `scripts/migrations/` du dépôt web ; la dernière utilisée est 020.

   ```bash
   python scripts/questions/gen_chap.py <chapitre.json> 021_import_<matiere>_<niveau>_<sujet>.sql [ids,…]
   ```

   - Les questions de base sont déplacées et mises à jour : elles sont retrouvées par leur ancien énoncé.
   - Les nouvelles questions sont insérées si elles sont absentes. Le script est idempotent.
   - Les questions de base rejetées sont supprimées, ainsi que les lignes qui en dépendent.
4. **Simuler, puis appliquer** :

   ```bash
   bash scripts/questions/run_sql.sh 021_….sql simulation "feat(db): import …"
   bash scripts/questions/run_sql.sh 021_….sql appliquer  "feat(db): import …"
   ```

   - En simulation, la transaction se termine par ROLLBACK.
   - Vérifier les compteurs : `chapitre_trouve` = 1, puis questions déplacées, questions insérées, questions supprimées, `total_chapitre`.
   - Le script publie le fichier sur `main` du dépôt EduCle-Web par un **worktree temporaire**. Ne jamais faire de checkout dans le dossier web partagé : Vercel déploie `main`, et ce dossier est sur une autre branche de travail.
5. **Commiter et pousser le JSON** dans le dépôt Mobile (branche `master`), avec le message `feat(content): <Matière> <niveau> ch.N <titre> (n validées)`.

Puis passer au chapitre suivant.

---

## 3. Format du JSON d'un chapitre validé

```json
{
  "matiere_id": 11, "matiere": "Biologie", "chapitre": "Le système respiratoire",
  "niveaux": ["NS2"], "unite_programme": "2.1", "statut": "validé par l'utilisateur 2026-10-14",
  "rejetees": ["B12-33"], "base_rejetees_a_supprimer": [{"id": "Q1606", "enonce": "…"}],
  "questions": [{
    "id": "B12-01", "niveau": "NS2 (facultatif)", "enonce": "…", "choix": ["bonne", "…", "…", "…"],
    "bonne_reponse": "bonne", "explication": "…", "niveau_complexite": "Facile|Moyen|Difficile",
    "source": "Larousse : respiration (sens 2)", "ancien_enonce": "(questions Q… seulement)", "statut": "(à revalider)"
  }]
}
```

---

## 4. Pièges rencontrés

- **Les heredocs Bash** contenant beaucoup de Python avec apostrophes cassent (« unexpected EOF »). Écrire les scripts avec l'outil Write.
- **L'export de données de production** (contenu des questions) a été bloqué. Ne pas contourner : se limiter à des diagnostics qui ne renvoient que des comptes.
- **Les anciennes questions de base n'ont jamais été retrouvées dans Supabase** (0 déplacée à chaque import). Elles sont donc insérées comme nouvelles, ce qui est sans conséquence.
- **Les fichiers de suppléments ne sont presque pas en production** (14 sur 1 331). Les corriger ne change rien pour les élèves.
- **Le workflow `db-migration.yml`** contient encore une étape d'export Bio/Géo laissée par erreur. Elle est à retirer.

---

## 5. État d'avancement (Biologie, au 2026-10-17)

| Niveau | Chapitres validés et importés |
|---|---|
| NS1 | ch.1 à ch.11 |
| NS2 | ch.1 Système respiratoire, ch.2 Tabac et maladies respiratoires, ch.3 Cœur et circulation, ch.4 Adaptation à l'effort, ch.5 Maladies cardiovasculaires, ch.6 Molécules biologiques |
| NS2-NS3 | ch.7 Métabolisme : photosynthèse et respiration cellulaire |

**Suite :**
- NS2 « Conservation de la biodiversité » : les questions de base Q1719 et Q1720 y vont.
- Puis NS3, NS4 et la Géologie. Q1609 (cycle de l'eau) va en Géologie.

**Questions de base pas encore placées :**
- Une quarantaine sur la cellule et la division cellulaire : Q1522–Q1546 et Q1621–Q1648. Il reste à vérifier si elles avaient été écartées volontairement en NS1 ch.5–7.
- Q1606 et Q1705, sur la classification.

---

## 6. Travailler quand l'utilisateur est absent (économie de crédits)

**Consigne du 2026-10-18 :** seules 4 matières sont actives (Biologie, Littérature haïtienne, Physique, Français), et jamais plus de 4 sessions en même temps. Les autres matières sont en suspens.

Le widget de validation exige l'utilisateur, mais la préparation n'en a pas besoin. En son absence, une session **prépare plusieurs chapitres à l'avance** au lieu d'attendre :
1. Elle construit les chapitres suivants avec `chapitre.py` et laisse dans le dossier de travail `chNN_Q.json` et `chNN_widget.html`.
2. Elle écrit un fichier `curriculum/questions/<matiere>/A_VALIDER.md`, qui liste les chapitres prêts, avec leur nombre de questions et les points à signaler.
3. **Elle n'importe jamais rien en base avant la validation** : pas de migration, pas de `statut: validé`.
4. Elle s'arrête quand 3 chapitres sont en attente. Elle ne devance pas davantage : si l'utilisateur rejette beaucoup de questions, tout le travail d'avance serait perdu.
5. À son retour, l'utilisateur voit les widgets l'un après l'autre. Après chaque validation, la session enregistre, simule et applique la migration, puis passe au chapitre suivant déjà préparé.

**Pour ne pas gaspiller les crédits :**
- Ne pas relire en entier les gros fichiers déjà lus ; chercher avec grep ou lire des extraits.
- Ne pas ré-afficher un widget déjà affiché.
- Pas de recherche web inutile : une fois le plan des chapitres validé, la recherche de manuels n'est plus nécessaire.
- Une session sans rien à faire (en attente de validation, travail d'avance terminé) **s'arrête** au lieu de boucler ou d'interroger les autres sessions.
- Pas de messages entre sessions pour de simples accusés de réception.
