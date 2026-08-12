# EduClé — Version Web

Quiz éducatif adaptatif pour élèves haïtiens — version web indépendante.

**Stack :**
- Backend : Python · FastAPI · SQLAlchemy · PostgreSQL · Alembic
- Frontend : Vue 3 · Vite · Pinia · Vue Router · Axios

---

## Installation rapide

### Prérequis
- Python 3.11+
- Node.js 18+
- PostgreSQL 14+

---

### 1. Backend

```bash
cd backend

# Créer et activer l'environnement virtuel
python -m venv .venv
# Windows :
.venv\Scripts\activate
# Mac/Linux :
source .venv/bin/activate

# Installer les dépendances
pip install -r requirements.txt

# Configurer la base de données
cp .env.example .env
# → Éditer .env avec tes identifiants PostgreSQL
```

**Créer la base de données PostgreSQL :**
```sql
CREATE DATABASE educle;
CREATE USER educle_user WITH PASSWORD 'motdepasse';
GRANT ALL PRIVILEGES ON DATABASE educle TO educle_user;
```

**Lancer les migrations :**
```bash
alembic upgrade head
```

**Peupler la base de données :**
```bash
# Option A : depuis le fichier SQLite de l'appli mobile
python seed.py C:\chemin\vers\educle.db

# Option B : données d'exemple (pour tester)
python seed.py
```

**Démarrer le serveur FastAPI :**
```bash
uvicorn main:app --reload
```
→ API disponible sur http://localhost:8000  
→ Documentation Swagger : http://localhost:8000/docs

---

### 2. Frontend

```bash
cd frontend
npm install
npm run dev
```
→ Application disponible sur http://localhost:5173

---

## Architecture

```
version-web-personnel/
├── backend/
│   ├── main.py              # Point d'entrée FastAPI
│   ├── config.py            # Variables d'environnement
│   ├── database.py          # Connexion SQLAlchemy
│   ├── models/              # Modèles ORM (tables PostgreSQL)
│   │   ├── matiere.py       # Matière, Chapitre, CarteMentale
│   │   ├── question.py      # Question, StatistiqueQuestion
│   │   ├── user.py          # UserPreferences (XP, pièces)
│   │   ├── score.py         # Historique des scores
│   │   └── realisation.py   # Achievements
│   ├── schemas/             # Schémas Pydantic (validation I/O)
│   ├── routers/             # Endpoints REST
│   │   ├── matieres.py      # GET /matieres, GET /chapitres
│   │   ├── quiz.py          # POST /quiz/demarrer + /terminer
│   │   ├── user.py          # GET/PATCH /user/profil + /niveau
│   │   └── realisations.py  # GET /realisations
│   ├── services/
│   │   ├── niveau.py        # XP → niveau → rang (miroir de niveau.dart)
│   │   └── adaptive_selector.py  # Sélection adaptative des questions
│   ├── alembic/             # Migrations de base de données
│   └── seed.py              # Script de peuplement initial
│
└── frontend/
    └── src/
        ├── api/client.js    # Appels Axios vers le backend
        ├── stores/          # État global Pinia
        │   ├── quiz.js      # État du quiz en cours
        │   └── user.js      # Profil et niveau
        ├── views/           # Pages Vue
        │   ├── HomeView.vue     # Sélection matière/chapitre/mode
        │   ├── QuizView.vue     # Déroulement du quiz
        │   ├── ResultatView.vue # Résultat et récap
        │   ├── ProfilView.vue   # Niveau, rang, réalisations
        │   └── ScoresView.vue   # Historique des scores
        └── utils/niveau.js  # XP/niveau/rang (miroir JS)
```

## Flux principal

```
HomeView → choisit matière + chapitre + mode
         → QuizStore.configurer()
         → /quiz (QuizView)

QuizView → POST /quiz/demarrer (sélection adaptative)
         → affiche questions une par une
         → chrono + feedback visuel (shake/pulse)
         → POST /quiz/terminer
         → /resultat (ResultatView)

ResultatView → affiche score, XP gagné, niveau up
             → détail question par question avec explication
```

## Déploiement en ligne

**Architecture :**
- 🌐 **Netlify** → frontend Vue 3 (site statique, gratuit, CDN mondial)
- ⚙️ **Render.com** → backend FastAPI + PostgreSQL (gratuit)

---

### Étape 1 — Pousser sur GitHub

```bash
cd version-web-personnel
git init
git add .
git commit -m "Initial commit EduClé Web"
# Créer un dépôt sur github.com, puis :
git remote add origin https://github.com/ton-compte/educle-web.git
git push -u origin main
```

---

### Étape 2 — Backend sur Render.com

1. Créer un compte sur [render.com](https://render.com)
2. **New → Blueprint** → connecter le dépôt GitHub
3. Render lit `render.yaml` et crée :
   - `educle-db` : PostgreSQL
   - `educle-api` : backend FastAPI (Docker)
4. Cliquer **Apply** et attendre ~3 minutes
5. Copier l'URL du backend : `https://educle-api.onrender.com` (visible dans le dashboard)

**Peupler la base depuis le SQLite mobile :**
```bash
# Récupérer DATABASE_URL : dashboard Render → educle-db → Connection String
cd backend
DATABASE_URL="postgresql://educle_user:xxx@xxx/educle" python seed.py chemin/vers/educle.db
```

---

### Étape 3 — Frontend sur Netlify

1. Créer un compte sur [netlify.com](https://netlify.com)
2. **Add new site → Import an existing project** → connecter le dépôt GitHub
3. Réglages du build :
   - **Base directory** : `frontend`
   - **Build command** : `npm install && npm run build` *(pré-rempli via `netlify.toml`)*
   - **Publish directory** : `dist`
4. Ajouter la variable d'environnement :
   - Clé : `VITE_API_URL`
   - Valeur : `https://educle-api.onrender.com` (URL Render de l'étape 2)
5. Cliquer **Deploy** — Netlify attribue une URL du type `https://educle.netlify.app`

---

### Étape 4 — Mettre à jour le CORS

Dans le dashboard Render → `educle-api` → **Environment** :
```
CORS_ORIGINS = https://educle.netlify.app
```
Sauvegarder → le service redémarre automatiquement.

---

### Domaine personnalisé (optionnel)

Sur Netlify : **Domain settings → Add custom domain** → suivre les instructions DNS.  
Le certificat HTTPS est généré automatiquement.

> **Note plan gratuit Render :** le service se suspend après 15 min d'inactivité (redémarre en ~30s à la prochaine requête). Acceptable pour un projet en test. Pour un usage continu, Render Starter = $7/mois.

---

## Correspondance mobile ↔ web

| Mobile (Flutter/Dart)          | Web (Python/Vue)                      |
|-------------------------------|---------------------------------------|
| `NiveauHelper`                | `services/niveau.py` + `utils/niveau.js` |
| `AdaptiveSelector`            | `services/adaptive_selector.py`       |
| `QuizController`              | `routers/quiz.py` + `stores/quiz.js`  |
| `DatabaseHelper`              | `models/` + `database.py`             |
| `ResultatScreen`              | `ResultatView.vue`                    |
| `quiz_screen.dart`            | `QuizView.vue`                        |
