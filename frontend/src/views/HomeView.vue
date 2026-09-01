<template>
  <div class="home-wrap fade-in">
    <div class="home-inner">

      <!-- ─── Hero bento grid ─────────────────────────────────── -->
      <div class="bento-grid">

        <!-- Carte principale bleue -->
        <div class="hero-card">
          <div class="hero-deco-1"></div>
          <div class="hero-deco-2"></div>
          <div class="hero-content">
            <h2 class="hero-titre">Prêt à réviser ?</h2>
            <p class="hero-sous">Continue ton apprentissage et débloque de nouvelles récompenses aujourd'hui.</p>
          </div>
          <div class="hero-actions">
            <button class="hero-btn hero-btn-primary" @click="ouvrirJouerTout">
              <span class="material-symbols-outlined filled">play_arrow</span>
              Jouer — Tout
            </button>
            <button class="hero-btn hero-btn-ghost" @click="jouerAleatoire">
              <span class="material-symbols-outlined">shuffle</span>
              Jouer — Aléatoire
            </button>
          </div>
        </div>

        <!-- Carte Reprendre -->
        <div class="reprendre-card">
          <div class="reprendre-top">
            <div class="reprendre-label">
              <span class="material-symbols-outlined">history</span>
              Reprendre
            </div>
            <template v-if="dernierJeu">
              <div class="reprendre-matiere">
                <div class="reprendre-icon" :style="{ background: iconBgPour(dernierJeu.matNom), color: iconColorPour(dernierJeu.matNom) }">
                  <span class="material-symbols-outlined filled">{{ iconPour(dernierJeu.matNom) }}</span>
                </div>
                <div>
                  <p class="reprendre-mat-nom">{{ dernierJeu.matNom }}</p>
                  <p class="reprendre-chap">{{ dernierJeu.chapTitre }}</p>
                </div>
              </div>
            </template>
            <template v-else>
              <p class="reprendre-vide">Lance un premier quiz pour le retrouver ici.</p>
            </template>
          </div>
          <button v-if="dernierJeu" class="reprendre-btn" @click="rejouer">
            <span class="material-symbols-outlined">replay</span>
            Rejouer
          </button>
        </div>
      </div>

      <!-- ─── Section thématiques ────────────────────────────── -->
      <div class="section-header">
        <div>
          <h2 class="section-titre">Thématiques</h2>
          <p class="section-sous">Choisis ta matière et ton chapitre pour démarrer un quiz adapté.</p>
        </div>
        <div class="search-wrap">
          <span class="material-symbols-outlined search-icon">search</span>
          <input v-model="recherche" type="text" placeholder="Rechercher une matière…" class="search-input" />
        </div>
      </div>

      <!-- Filtres niveau -->
      <div class="filtres">
        <button v-for="niv in niveaux" :key="niv"
          class="filtre-btn" :class="{ active: niveauActif === niv }"
          @click="filtrer(niv)">{{ niv }}</button>
      </div>

      <!-- Grille matières -->
      <div v-if="chargement" class="loading">Chargement…</div>
      <div v-else-if="matieresFiltrées.length === 0 && recherche" class="vide">
        Aucune matière ne correspond à « {{ recherche }} ».
      </div>
      <div v-else class="matieres-grid">
        <div v-for="mat in matieresFiltrées" :key="mat.id"
          class="mat-card" @click="choisirMatiere(mat)">
          <div class="mat-icon-wrap" :style="{ background: iconBgPour(mat.nom) }">
            <span class="material-symbols-outlined filled mat-icon" :style="{ color: iconColorPour(mat.nom) }">
              {{ iconPour(mat.nom) }}
            </span>
          </div>
          <p class="mat-nom" :style="{ color: iconColorPour(mat.nom) }">{{ mat.nom }}</p>
        </div>
      </div>

    </div><!-- /home-inner -->

    <!-- ─── Modal chapitre ─────────────────────────────────── -->
    <div v-if="matiereSelectionnee" class="modal-overlay" @click.self="matiereSelectionnee = null">
      <div class="modal card">
        <div class="modal-header">
          <div class="mat-icon-wrap-sm" :style="{ background: iconBgPour(matiereSelectionnee.nom) }">
            <span class="material-symbols-outlined filled" :style="{ color: iconColorPour(matiereSelectionnee.nom) }">
              {{ iconPour(matiereSelectionnee.nom) }}
            </span>
          </div>
          <h3 class="modal-titre">{{ matiereSelectionnee.nom }}</h3>
        </div>
        <div class="chapitres-list">
          <div v-for="chap in chapitres" :key="chap.id" class="chapitre-row">
            <button class="chapitre-btn" @click="choisirChapitre(chap)">{{ chap.titre }}</button>
            <button class="cartes-btn" @click="voirCartes(chap)" title="Cartes mentales">
              <span class="material-symbols-outlined">style</span>
            </button>
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
          <select v-model.number="nbQuestions" :disabled="modeNom === 'Bombardement'">
            <option v-for="n in [5, 10, 15, 20]" :key="n">{{ n }}</option>
          </select>
        </div>
      </div>
    </div>

    <!-- ─── Modal Jouer Tout ──────────────────────────────── -->
    <div v-if="showJouerTout" class="modal-overlay" @click.self="showJouerTout = false">
      <div class="modal card">
        <h3 class="modal-titre">Jouer — Toutes matières</h3>
        <p style="font-size:0.85rem;color:var(--text-muted);margin-bottom:1rem">Un quiz mixte à travers toutes les matières.</p>
        <div class="modal-modes">
          <label>Mode</label>
          <select v-model="modeNom">
            <option v-for="m in modes" :key="m">{{ m }}</option>
          </select>
          <label>Questions</label>
          <select v-model.number="nbQuestions" :disabled="modeNom === 'Bombardement'">
            <option v-for="n in [5, 10, 15, 20]" :key="n">{{ n }}</option>
          </select>
        </div>
        <button class="btn-primary" style="margin-top:1rem;width:100%" @click="lancerJouerTout">
          <span class="material-symbols-outlined filled">play_arrow</span> Lancer
        </button>
      </div>
    </div>

  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { getMatieres, getNiveaux, getMatiere } from '../api/client.js'
import { useQuizStore } from '../stores/quiz.js'

const router = useRouter()
const quiz = useQuizStore()

const niveaux = ref([])
const niveauActif = ref(null)
const matieres = ref([])
const chargement = ref(true)
const recherche = ref('')
const showJouerTout = ref(false)

const matiereSelectionnee = ref(null)
const chapitres = ref([])
const modeNom = ref('Révision')
const nbQuestions = ref(10)
const modes = ['Révision', 'Rush', 'Bombardement']

// ── Dernier jeu (localStorage) ──────────────────────────────────
const LS_KEY = 'educle_dernier_jeu'
const dernierJeu = ref(JSON.parse(localStorage.getItem(LS_KEY) || 'null'))

function sauvegarderDernierJeu(matNom, chapTitre, matId, chapId) {
  const data = { matNom, chapTitre, matId, chapId, modeNom: modeNom.value, nbQuestions: nbQuestions.value }
  localStorage.setItem(LS_KEY, JSON.stringify(data))
  dernierJeu.value = data
}

function rejouer() {
  if (!dernierJeu.value) return
  const d = dernierJeu.value
  quiz.configurer({ chapitreId: d.chapId, matiereId: d.matId, modeNom: d.modeNom, nbQuestions: d.nbQuestions })
  router.push('/quiz')
}

// ── Icon / couleur par matière ───────────────────────────────────
const MAT_MAP = {
  'mathématiques':                   { icon: 'calculate',     bg: '#DBEAFE', color: '#1D4ED8' },
  'communication française':         { icon: 'book_2',        bg: '#EDE9FE', color: '#7C3AED' },
  'communication créole':            { icon: 'record_voice_over', bg: '#EDE9FE', color: '#6D28D9' },
  'éducation à la citoyenneté':      { icon: 'balance',       bg: '#CCFBF1', color: '#0D9488' },
  'éducation esthétique et artistique': { icon: 'palette',    bg: '#FFEDD5', color: '#C2410C' },
  'éducation physique et sportive':  { icon: 'directions_run',bg: '#FEF3C7', color: '#B45309' },
  'éducation à la technologie et aux activités productives': { icon: 'build', bg: '#D1FAE5', color: '#059669' },
  'biologie':                        { icon: 'biotech',       bg: '#CCFBF1', color: '#065F46' },
  'géologie':                        { icon: 'terrain',       bg: '#FEF3C7', color: '#92400E' },
  'sciences sociales':               { icon: 'groups',        bg: '#FEF3C7', color: '#D97706' },
  "histoire d'haïti":                { icon: 'account_balance', bg: '#FEE2E2', color: '#B91C1C' },
  'histoire universelle':            { icon: 'public',        bg: '#DCFCE7', color: '#15803D' },
  'économie':                        { icon: 'bar_chart',     bg: '#DCFCE7', color: '#16A34A' },
  'philosophie':                     { icon: 'psychology',    bg: '#FEF3C7', color: '#B45309' },
  'informatique':                    { icon: 'computer',      bg: '#DBEAFE', color: '#2563EB' },
  'littérature haïtienne':           { icon: 'auto_stories',  bg: '#FCE7F3', color: '#9D174D' },
  'littérature universelle':         { icon: 'auto_stories',  bg: '#EDE9FE', color: '#6B21A8' },
  'chimie':                          { icon: 'science',       bg: '#EDE9FE', color: '#7C3AED' },
  'physique':                        { icon: 'bolt',          bg: '#DBEAFE', color: '#1D4ED8' },
  'connaissances générales':         { icon: 'lightbulb',     bg: '#FEF3C7', color: '#D97706' },
  'culture générale':                { icon: 'lightbulb',     bg: '#FEF3C7', color: '#D97706' },
  'svt':                             { icon: 'biotech',       bg: '#CCFBF1', color: '#047857' },
  'astronomie':                      { icon: 'stars',         bg: '#DBEAFE', color: '#1E40AF' },
  'espagnol':                        { icon: 'translate',     bg: '#FEE2E2', color: '#DC2626' },
  'anglais':                         { icon: 'translate',     bg: '#E0E7FF', color: '#4338CA' },
  'français':                        { icon: 'book_2',        bg: '#EDE9FE', color: '#7C3AED' },
}

function _lookup(nom) {
  const key = nom.toLowerCase().trim()
  return MAT_MAP[key]
    ?? MAT_MAP[key.replace(/[éèê]/g,'e').replace(/[àâ]/g,'a').replace(/[ûù]/g,'u').replace(/î/g,'i').replace(/ô/g,'o')]
    ?? { icon: 'menu_book', bg: '#DBEAFE', color: '#2563EB' }
}

function iconPour(nom) { return _lookup(nom).icon }
function iconBgPour(nom) { return _lookup(nom).bg }
function iconColorPour(nom) { return _lookup(nom).color }

// ── Données ──────────────────────────────────────────────────────
const matieresFiltrées = computed(() =>
  recherche.value.trim()
    ? matieres.value.filter(m => m.nom.toLowerCase().includes(recherche.value.toLowerCase()))
    : matieres.value
)

onMounted(async () => {
  const nivList = await getNiveaux()
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
  router.push({ name: 'cartes', params: { matiereId: mat.id, chapitreId: chap.id }, query: { matiere: mat.nom } })
}

function choisirChapitre(chap) {
  const mat = matiereSelectionnee.value
  const chapId = chap.id === -1 ? mat.id * -1 : chap.id
  sauvegarderDernierJeu(mat.nom, chap.titre, mat.id, chapId)
  quiz.configurer({ chapitreId: chapId, matiereId: mat.id, modeNom: modeNom.value, nbQuestions: nbQuestions.value })
  matiereSelectionnee.value = null
  router.push('/quiz')
}

// Jouer tout
function ouvrirJouerTout() { showJouerTout.value = true }

function lancerJouerTout() {
  if (!matieres.value.length) return
  const mat = matieres.value[Math.floor(Math.random() * matieres.value.length)]
  const chapId = mat.id * -1
  quiz.configurer({ chapitreId: chapId, matiereId: mat.id, modeNom: modeNom.value, nbQuestions: nbQuestions.value })
  showJouerTout.value = false
  router.push('/quiz')
}

// Jouer aléatoire
async function jouerAleatoire() {
  if (!matieres.value.length) return
  const mat = matieres.value[Math.floor(Math.random() * matieres.value.length)]
  const detail = await getMatiere(mat.id)
  if (!detail.chapitres.length) return
  const chap = detail.chapitres[Math.floor(Math.random() * detail.chapitres.length)]
  sauvegarderDernierJeu(mat.nom, chap.titre, mat.id, chap.id)
  quiz.configurer({ chapitreId: chap.id, matiereId: mat.id, modeNom: modeNom.value, nbQuestions: nbQuestions.value })
  router.push('/quiz')
}
</script>

<style scoped>
.home-wrap { min-height: calc(100dvh - 64px); background: var(--bg); }
.home-inner { max-width: 1024px; margin: 0 auto; padding: 1.5rem 1.25rem 4rem; }

/* ── Bento hero ────────────────────────────────────────────────── */
.bento-grid { display: grid; grid-template-columns: 1fr; gap: 0.85rem; margin-bottom: 2rem; }
@media (min-width: 640px) { .bento-grid { grid-template-columns: 2fr 1fr; } }

.hero-card {
  background: linear-gradient(135deg, #0058BE, #1A7AEF);
  border-radius: 18px; padding: 1.5rem;
  position: relative; overflow: hidden;
  display: flex; flex-direction: column; justify-content: space-between;
  min-height: 220px;
}
.hero-deco-1 { position: absolute; bottom: -30px; right: -30px; width: 200px; height: 200px; background: rgba(255,255,255,0.08); border-radius: 50%; pointer-events: none; }
.hero-deco-2 { position: absolute; top: 20px; left: 20px; width: 80px; height: 80px; background: rgba(255,255,255,0.05); border-radius: 50%; pointer-events: none; }

.hero-content { position: relative; z-index: 1; margin-bottom: 1.25rem; }
.hero-titre { font-size: 1.75rem; font-weight: 800; color: #fff; line-height: 1.15; margin-bottom: 0.5rem; }
.hero-sous { font-size: 0.9rem; color: rgba(255,255,255,0.7); line-height: 1.5; max-width: 400px; }

.hero-actions { display: flex; flex-wrap: wrap; gap: 0.6rem; position: relative; z-index: 1; }
.hero-btn {
  display: flex; align-items: center; gap: 0.4rem;
  padding: 0.6rem 1.1rem; border-radius: 10px;
  font-weight: 700; font-size: 0.875rem; cursor: pointer;
  transition: all 0.15s; border: none;
}
.hero-btn-primary { background: #fff; color: var(--primary); }
.hero-btn-primary:hover { background: #f0f3ff; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
.hero-btn-ghost { background: rgba(255,255,255,0.18); color: #fff; border: 1px solid rgba(255,255,255,0.3); }
.hero-btn-ghost:hover { background: rgba(255,255,255,0.28); }

/* Reprendre card */
.reprendre-card {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 18px; padding: 1.25rem;
  display: flex; flex-direction: column; justify-content: space-between;
  min-height: 160px;
}
.reprendre-top { flex: 1; }
.reprendre-label {
  display: flex; align-items: center; gap: 0.35rem;
  font-size: 0.72rem; font-weight: 700; color: var(--text-muted);
  text-transform: uppercase; letter-spacing: 0.06em; margin-bottom: 0.85rem;
}
.reprendre-matiere { display: flex; align-items: center; gap: 0.75rem; margin-bottom: 0.75rem; }
.reprendre-icon {
  width: 44px; height: 44px; border-radius: 12px;
  display: flex; align-items: center; justify-content: center; flex-shrink: 0;
}
.reprendre-mat-nom { font-weight: 700; font-size: 0.95rem; line-height: 1.2; }
.reprendre-chap { font-size: 0.8rem; color: var(--text-muted); margin-top: 0.1rem; }
.reprendre-vide { font-size: 0.82rem; color: var(--text-muted); font-style: italic; }
.reprendre-btn {
  display: flex; align-items: center; justify-content: center; gap: 0.4rem;
  width: 100%; padding: 0.55rem;
  background: var(--surface-low); color: var(--primary);
  border: 1px solid var(--border); border-radius: 8px;
  font-weight: 700; font-size: 0.875rem; cursor: pointer;
  transition: background 0.12s;
}
.reprendre-btn:hover { background: var(--primary-light-solid); }

/* ── Section header ────────────────────────────────────────────── */
.section-header { display: flex; flex-direction: column; gap: 0.75rem; margin-bottom: 0.85rem; }
@media (min-width: 640px) { .section-header { flex-direction: row; align-items: flex-end; justify-content: space-between; } }
.section-titre { font-size: 1.15rem; font-weight: 800; }
.section-sous { font-size: 0.85rem; color: var(--text-muted); margin-top: 0.2rem; }

.search-wrap {
  display: flex; align-items: center; gap: 0.4rem;
  background: var(--surface); border: 1px solid var(--border);
  border-radius: var(--radius); padding: 0.5rem 0.9rem;
  min-width: 220px;
}
.search-icon { font-size: 18px; color: var(--text-muted); }
.search-input { border: none; outline: none; background: transparent; font-family: inherit; font-size: 0.875rem; width: 100%; color: var(--text); }

/* ── Filtres ───────────────────────────────────────────────────── */
.filtres { display: flex; gap: 0.4rem; flex-wrap: wrap; margin-bottom: 1rem; }
.filtre-btn { padding: 0.3rem 0.8rem; border-radius: 99px; background: var(--border); font-weight: 600; font-size: 0.8rem; color: var(--text-muted); border: none; cursor: pointer; transition: background 0.15s, color 0.15s; }
.filtre-btn.active { background: var(--primary); color: white; }

.loading { text-align: center; color: var(--text-muted); padding: 3rem; }
.vide { text-align: center; color: var(--text-muted); padding: 2rem; font-style: italic; }

/* ── Grille matières ───────────────────────────────────────────── */
.matieres-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 0.65rem; padding-bottom: 2rem; }
@media (min-width: 640px) { .matieres-grid { grid-template-columns: repeat(3, 1fr); } }
@media (min-width: 900px)  { .matieres-grid { grid-template-columns: repeat(4, 1fr); } }

.mat-card {
  display: flex; flex-direction: column; align-items: center; text-align: center;
  padding: 1rem 0.75rem; gap: 0.6rem;
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 14px; cursor: pointer;
  transition: box-shadow 0.15s, transform 0.15s;
}
.mat-card:hover { box-shadow: 0 6px 20px rgba(0,0,0,0.1); transform: translateY(-2px); }

.mat-icon-wrap {
  width: 60px; height: 60px; border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  transition: transform 0.15s;
}
.mat-card:hover .mat-icon-wrap { transform: scale(1.08); }
.mat-icon { font-size: 28px !important; }

.mat-nom {
  font-size: 0.82rem; font-weight: 800; line-height: 1.25;
  display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
}

/* ── Modal ─────────────────────────────────────────────────────── */
.modal-overlay { position: fixed; inset: 0; background: rgba(0,0,0,0.45); display: flex; align-items: center; justify-content: center; z-index: 100; }
.modal { width: min(480px, 94vw); max-height: 85dvh; overflow-y: auto; }
.modal-header { display: flex; align-items: center; gap: 0.65rem; margin-bottom: 1rem; }
.mat-icon-wrap-sm { width: 40px; height: 40px; border-radius: 10px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
.modal-titre { font-size: 1.05rem; font-weight: 800; }
.chapitres-list { display: flex; flex-direction: column; gap: 0.4rem; margin-bottom: 1rem; }
.chapitre-row { display: flex; gap: 0.4rem; }
.chapitre-btn {
  flex: 1; background: var(--bg); border: 1px solid var(--border);
  padding: 0.6rem 1rem; text-align: left; border-radius: 10px;
  font-weight: 600; font-size: 0.875rem; cursor: pointer; transition: background 0.12s;
}
.chapitre-btn:hover { background: var(--primary-light-solid); }
.chapitre-tout { color: var(--primary); border-color: var(--primary); }
.cartes-btn { background: var(--bg); border: 1px solid var(--border); border-radius: 10px; padding: 0.6rem 0.75rem; cursor: pointer; flex-shrink: 0; transition: background 0.12s; display: flex; align-items: center; }
.cartes-btn:hover { background: var(--primary-light-solid); }
.modal-modes { display: flex; align-items: center; gap: 0.75rem; flex-wrap: wrap; margin-top: 0.5rem; }
.modal-modes label { font-size: 0.82rem; font-weight: 700; }
.modal-modes select { padding: 0.4rem 0.6rem; border-radius: 8px; border: 1px solid var(--border); font-family: inherit; font-size: 0.85rem; background: var(--bg); color: var(--text); }
</style>
