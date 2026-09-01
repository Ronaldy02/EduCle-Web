<template>
  <div class="page fade-in">

    <!-- Niveau / XP -->
    <div v-if="niveau" class="niveau-card card">
      <div class="niveau-top">
        <span class="rang-badge" :style="{ background: niveau.rang_couleur + '22', color: niveau.rang_couleur }">
          {{ niveau.rang_emoji }} {{ niveau.rang_nom }}
        </span>
        <span class="niveau-num">Niveau {{ niveau.niveau }}</span>
      </div>
      <div class="xp-bar-wrap">
        <div class="xp-bar" :style="{ width: (niveau.progression * 100) + '%', background: niveau.rang_couleur }"></div>
      </div>
      <p class="xp-label">{{ niveau.xp_dans_niveau }} / {{ niveau.xp_pour_suivant }} XP · 🪙 {{ niveau.pieces_total }}</p>
    </div>

    <!-- Hero banner -->
    <div class="hero-banner">
      <span class="hero-badge">SANS COMPTE REQUIS</span>
      <h2 class="hero-titre">Prêt à réviser ?</h2>
      <p class="hero-sous">Choisis ta matière et ton chapitre pour démarrer un quiz adapté.</p>
    </div>

    <!-- Titre + barre de recherche -->
    <div class="section-header">
      <h2 class="section-title">Thématiques</h2>
    </div>
    <div class="search-wrap">
      <span class="search-icon">🔍</span>
      <input
        v-model="recherche"
        class="search-input"
        type="text"
        placeholder="Rechercher une matière…"
      />
    </div>

    <!-- Filtre par niveau scolaire -->
    <div class="filtres">
      <button
        v-for="niv in niveaux"
        :key="niv"
        class="filtre-btn"
        :class="{ active: niveauActif === niv }"
        @click="filtrer(niv)"
      >{{ niv }}</button>
    </div>

    <!-- Grille des matières -->
    <div v-if="chargement" class="loading">Chargement…</div>
    <div v-else-if="matieresFiltrées.length === 0 && recherche" class="vide">
      Aucune matière ne correspond à « {{ recherche }} ».
    </div>
    <div v-else class="matieres-grid">
      <div
        v-for="mat in matieresFiltrées"
        :key="mat.id"
        class="matiere-card"
        @click="choisirMatiere(mat)"
      >
        <span class="matiere-emoji">{{ emojiPour(mat.nom) }}</span>
        <span class="matiere-nom" :style="{ color: couleurPour(mat.nom) }">{{ mat.nom }}</span>
      </div>
    </div>

    <!-- Modal choix chapitre -->
    <div v-if="matiereSelectionnee" class="modal-overlay" @click.self="matiereSelectionnee = null">
      <div class="modal card">
        <div class="modal-header">
          <span class="modal-emoji">{{ emojiPour(matiereSelectionnee.nom) }}</span>
          <h3>{{ matiereSelectionnee.nom }}</h3>
        </div>
        <div class="chapitres-list">
          <div v-for="chap in chapitres" :key="chap.id" class="chapitre-row">
            <button class="chapitre-btn" @click="choisirChapitre(chap)">{{ chap.titre }}</button>
            <button class="cartes-btn" @click="voirCartes(chap)" title="Cartes mentales">📚</button>
          </div>
          <button class="chapitre-btn chapitre-tout" @click="choisirChapitre({ id: -1, titre: 'Tous les chapitres' })">
            ✨ Tous les chapitres
          </button>
        </div>
        <div class="modal-modes">
          <label>Mode</label>
          <select v-model="modeNom">
            <option v-for="m in modes" :key="m">{{ m }}</option>
          </select>
          <label>Questions</label>
          <select v-model.number="nbQuestions">
            <option v-for="n in [5, 10, 15, 20]" :key="n">{{ n }}</option>
          </select>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { getMatieres, getNiveaux, getMatiere, getNiveau } from '../api/client.js'
import { useQuizStore } from '../stores/quiz.js'

const router = useRouter()
const quiz = useQuizStore()

const niveaux = ref([])
const niveauActif = ref(null)
const matieres = ref([])
const chargement = ref(true)
const niveau = ref(null)
const recherche = ref('')

const matiereSelectionnee = ref(null)
const chapitres = ref([])
const modeNom = ref('Révision')
const nbQuestions = ref(10)
const modes = ['Révision', 'Rush', 'Bombardement']

const EMOJIS = {
  'mathématiques': '🧮', 'mathematiques': '🧮',
  'communication française': '📖', 'communication francaise': '📖',
  'français': '📖', 'francais': '📖',
  'communication créole': '🗣️', 'communication creole': '🗣️',
  'biologie': '🧬',
  'géologie': '🪨', 'geologie': '🪨',
  'sciences sociales': '🗺️',
  "histoire d'haïti": '📜', "histoire d'haiti": '📜',
  'histoire universelle': '🌍',
  'littérature haïtienne': '🪶', 'litterature haitienne': '🪶',
  'littérature universelle': '📚', 'litterature universelle': '📚',
  'chimie': '⚗️',
  'physique': '⚛️',
  'connaissances générales': '💡', 'connaissances generales': '💡',
  'culture générale': '💡', 'culture generale': '💡',
  'eps': '🏃', 'éducation physique et sportive': '🏃',
  'eea': '🎨', 'éducation esthétique et artistique': '🎨',
  'etap': '🛠️', 'éducation à la technologie et aux activités productives': '🛠️',
  'ec': '⚖️', 'éducation à la citoyenneté': '⚖️',
  'svt': '🔬',
  'astronomie': '🔭',
  'espagnol': '🌎',
  'anglais': '🇬🇧',
  'informatique': '💻',
  'économie': '📊',
  'philosophie': '🧐',
}

const COULEURS = {
  'mathématiques': '#2F6FED', 'mathematiques': '#2F6FED',
  'communication française': '#1E3A8A', 'communication francaise': '#1E3A8A',
  'français': '#1E3A8A', 'francais': '#1E3A8A',
  'communication créole': '#5E35B1', 'communication creole': '#5E35B1',
  'biologie': '#2E7D32',
  'géologie': '#795548', 'geologie': '#795548',
  'sciences sociales': '#1565C0',
  "histoire d'haïti": '#7B241C', "histoire d'haiti": '#7B241C',
  'histoire universelle': '#5E35B1',
  'littérature haïtienne': '#8E24AA', 'litterature haitienne': '#8E24AA',
  'littérature universelle': '#6A1B9A', 'litterature universelle': '#6A1B9A',
  'chimie': '#6A1B9A',
  'physique': '#5E35B1',
  'connaissances générales': '#B45309', 'connaissances generales': '#B45309',
  'culture générale': '#B45309', 'culture generale': '#B45309',
  'eps': '#EF6C00', 'éducation physique et sportive': '#EF6C00',
  'eea': '#2E7D32', 'éducation esthétique et artistique': '#2E7D32',
  'etap': '#455A64', 'éducation à la technologie et aux activités productives': '#455A64',
  'ec': '#00695C', 'éducation à la citoyenneté': '#00695C',
  'svt': '#00695C',
  'astronomie': '#283593',
  'espagnol': '#D32F2F',
  'anglais': '#37474F',
  'informatique': '#1565C0',
  'économie': '#2E7D32',
  'philosophie': '#4A148C',
}

function emojiPour(nom) {
  return EMOJIS[nom.toLowerCase().trim()] ?? '📚'
}
function couleurPour(nom) {
  return COULEURS[nom.toLowerCase().trim()] ?? '#2F6FED'
}

const matieresFiltrées = computed(() =>
  recherche.value.trim()
    ? matieres.value.filter(m => m.nom.toLowerCase().includes(recherche.value.toLowerCase()))
    : matieres.value
)

onMounted(async () => {
  const [niv, nivList] = await Promise.all([getNiveau(), getNiveaux()])
  niveau.value = niv
  niveaux.value = nivList
  niveauActif.value = nivList[0] ?? null
  await filtrer(niveauActif.value)
  chargement.value = false
})

async function filtrer(niv) {
  niveauActif.value = niv
  chargement.value = true
  matieres.value = await getMatieres(niv)
  chargement.value = false
}

async function choisirMatiere(mat) {
  const detail = await getMatiere(mat.id)
  matiereSelectionnee.value = mat
  chapitres.value = detail.chapitres
}

function voirCartes(chap) {
  const mat = matiereSelectionnee.value
  matiereSelectionnee.value = null
  router.push({
    name: 'cartes',
    params: { matiereId: mat.id, chapitreId: chap.id },
    query: { matiere: mat.nom },
  })
}

async function choisirChapitre(chap) {
  quiz.configurer({
    chapitreId: chap.id === -1 ? matiereSelectionnee.value.id * -1 : chap.id,
    matiereId: matiereSelectionnee.value.id,
    modeNom: modeNom.value,
    nbQuestions: nbQuestions.value,
  })
  matiereSelectionnee.value = null
  router.push('/quiz')
}
</script>

<style scoped>
/* ── Niveau XP ──────────────────────────────────────────────────── */
.niveau-card { margin-bottom: 1rem; padding: 1rem 1.25rem; }
.niveau-top { display: flex; align-items: center; justify-content: space-between; margin-bottom: 0.6rem; }
.rang-badge { font-weight: 700; padding: 0.2rem 0.65rem; border-radius: 99px; font-size: 0.82rem; }
.niveau-num { font-weight: 700; font-size: 0.82rem; color: var(--text-muted); }
.xp-bar-wrap { height: 5px; background: var(--border); border-radius: 99px; overflow: hidden; }
.xp-bar { height: 100%; border-radius: 99px; transition: width 0.4s ease; }
.xp-label { margin-top: 0.4rem; font-size: 0.75rem; color: var(--text-muted); }

/* ── Hero banner ────────────────────────────────────────────────── */
.hero-banner {
  background: linear-gradient(135deg, #101B33, #1F3A66);
  border-radius: 18px;
  padding: 1.25rem 1.5rem;
  margin-bottom: 1.25rem;
}
.hero-badge {
  display: inline-block;
  background: rgba(255,255,255,0.12);
  color: #93C5FD;
  font-size: 0.7rem;
  font-weight: 700;
  letter-spacing: 0.06em;
  padding: 0.2rem 0.6rem;
  border-radius: 99px;
  margin-bottom: 0.6rem;
}
.hero-titre {
  color: #fff;
  font-size: 1.35rem;
  font-weight: 800;
  margin-bottom: 0.35rem;
  line-height: 1.2;
}
.hero-sous {
  color: rgba(255,255,255,0.65);
  font-size: 0.82rem;
  line-height: 1.45;
}

/* ── Barre recherche ────────────────────────────────────────────── */
.section-header { margin-bottom: 0.75rem; }
.section-title { font-size: 1.05rem; font-weight: 800; }

.search-wrap {
  display: flex; align-items: center; gap: 0.5rem;
  background: var(--surface); border: 1px solid var(--border);
  border-radius: var(--radius); padding: 0.5rem 0.9rem;
  margin-bottom: 0.75rem;
}
.search-icon { font-size: 0.9rem; opacity: 0.5; }
.search-input {
  border: none; outline: none; background: transparent;
  font-family: inherit; font-size: 0.88rem; width: 100%; color: var(--text);
}

/* ── Filtres niveau ─────────────────────────────────────────────── */
.filtres { display: flex; gap: 0.5rem; flex-wrap: wrap; margin-bottom: 1rem; }
.filtre-btn {
  padding: 0.35rem 0.85rem; border-radius: 99px;
  background: var(--border); font-weight: 600; font-size: 0.82rem;
  color: var(--text-muted); border: none; cursor: pointer;
  transition: background 0.15s, color 0.15s;
}
.filtre-btn.active { background: var(--primary); color: white; }

/* ── Grille matières ────────────────────────────────────────────── */
.loading { text-align: center; color: var(--text-muted); padding: 2rem; }
.vide { text-align: center; color: var(--text-muted); padding: 2rem; font-style: italic; }

.matieres-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0.65rem;
}

.matiere-card {
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  gap: 0.45rem; padding: 0.9rem 0.5rem;
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 14px; cursor: pointer;
  transition: box-shadow 0.15s, border-color 0.15s;
  min-height: 88px;
}
.matiere-card:hover {
  box-shadow: 0 4px 16px rgba(0,0,0,0.1);
  border-color: #C7D4F0;
}
.matiere-emoji { font-size: 1.75rem; line-height: 1; }
.matiere-nom {
  font-size: 0.72rem; font-weight: 800; text-align: center;
  line-height: 1.25; max-width: 100%;
  display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
}

/* ── Modal ──────────────────────────────────────────────────────── */
.modal-overlay {
  position: fixed; inset: 0; background: rgba(0,0,0,0.45);
  display: flex; align-items: center; justify-content: center; z-index: 100;
}
.modal { width: min(480px, 94vw); max-height: 85dvh; overflow-y: auto; }
.modal-header { display: flex; align-items: center; gap: 0.6rem; margin-bottom: 1rem; }
.modal-emoji { font-size: 1.4rem; }
.modal h3 { font-size: 1.05rem; font-weight: 800; }
.chapitres-list { display: flex; flex-direction: column; gap: 0.4rem; margin-bottom: 1rem; }
.chapitre-row { display: flex; gap: 0.4rem; }
.chapitre-btn {
  flex: 1; background: var(--bg); border: 1px solid var(--border);
  padding: 0.6rem 1rem; text-align: left; border-radius: 10px;
  font-weight: 600; font-size: 0.88rem; cursor: pointer;
  transition: background 0.12s;
}
.chapitre-btn:hover { background: var(--primary-light-solid); }
.chapitre-tout { color: var(--primary); border-color: var(--primary); }
.cartes-btn {
  background: var(--bg); border: 1px solid var(--border);
  border-radius: 10px; padding: 0.6rem 0.75rem;
  font-size: 1rem; cursor: pointer; flex-shrink: 0;
  transition: background 0.12s;
}
.cartes-btn:hover { background: var(--primary-light-solid); }

.modal-modes { display: flex; align-items: center; gap: 0.75rem; flex-wrap: wrap; margin-top: 0.5rem; }
.modal-modes label { font-size: 0.82rem; font-weight: 700; }
.modal-modes select {
  padding: 0.4rem 0.6rem; border-radius: 8px;
  border: 1px solid var(--border); font-family: inherit; font-size: 0.85rem;
  background: var(--bg); color: var(--text);
}
</style>
