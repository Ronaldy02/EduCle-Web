<template>
  <div class="home-wrap fade-in">
    <div class="home-inner">

      <!-- ─── Hero bento grid ─────────────────────────────────── -->
      <div class="bento-grid">
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

        <div class="reprendre-card">
          <div class="reprendre-top">
            <div class="reprendre-label">
              <span class="material-symbols-outlined">history</span>
              Reprendre
            </div>
            <template v-if="dernierJeu">
              <div class="reprendre-matiere">
                <div class="reprendre-icon">
                  <img v-if="imagePour(dernierJeu.matNom)" :src="imagePour(dernierJeu.matNom)" class="reprendre-img" :alt="dernierJeu.matNom" />
                  <span v-else class="material-symbols-outlined filled" :style="{ color: iconColorPour(dernierJeu.matNom) }">{{ iconPour(dernierJeu.matNom) }}</span>
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
          <p class="section-sous">Choisis ta matière pour démarrer un quiz adapté.</p>
        </div>
        <div class="search-wrap">
          <span class="material-symbols-outlined search-icon">search</span>
          <input v-model="recherche" type="text" placeholder="Rechercher une matière…" class="search-input" />
        </div>
      </div>

      <div class="filtres">
        <button v-for="niv in niveaux" :key="niv"
          class="filtre-btn" :class="{ active: niveauActif === niv }"
          @click="filtrer(niv)">{{ niv }}</button>
      </div>

      <div v-if="chargement" class="loading">Chargement…</div>
      <div v-else-if="matieresFiltrées.length === 0 && recherche" class="vide">
        Aucune matière ne correspond à « {{ recherche }} ».
      </div>
      <div v-else class="matieres-grid">
        <div v-for="mat in matieresFiltrées" :key="mat.id"
          class="mat-card" @click="choisirMatiere(mat)">
          <div v-if="imagePour(mat.nom)" class="mat-img-wrap">
            <img :src="imagePour(mat.nom)" :alt="mat.nom" class="mat-img" />
          </div>
          <div v-else class="mat-icon-wrap" :style="{ background: iconBgPour(mat.nom) }">
            <span class="material-symbols-outlined filled mat-icon" :style="{ color: iconColorPour(mat.nom) }">
              {{ iconPour(mat.nom) }}
            </span>
          </div>
          <p class="mat-nom" :style="{ color: iconColorPour(mat.nom) }">{{ mat.nom }}</p>
        </div>
      </div>

    </div>

    <!-- ═══════════════════════════════════════════════════════════
         ÉTAPE 1 — Sélection chapitre
    ═══════════════════════════════════════════════════════════ -->
    <transition name="modal-fade">
      <div v-if="etape === 'chapitre'" class="modal-bg" @click.self="fermer">
        <div class="sel-modal">

          <!-- Header -->
          <div class="sel-header">
            <div class="sel-header-left">
              <div class="sel-mat-thumb">
                <img v-if="imagePour(mat.nom)" :src="imagePour(mat.nom)" :alt="mat.nom" class="sel-mat-img" />
                <span v-else class="material-symbols-outlined filled" :style="{ color: iconColorPour(mat.nom), fontSize: '20px' }">{{ iconPour(mat.nom) }}</span>
              </div>
              <div>
                <div class="sel-mat-nom">{{ mat.nom }}</div>
                <button class="sel-retour-lien" @click="fermer">← Retour à l'accueil</button>
              </div>
            </div>
            <button class="sel-close" @click="fermer">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><path d="M18 6 6 18"/><path d="M6 6l12 12"/></svg>
            </button>
          </div>

          <!-- Corps scrollable -->
          <div class="sel-body">
            <div class="sel-section-label">Chapitre</div>

            <!-- Tout -->
            <button class="sel-tout" :class="{ active: chapitreChoisi?.id === -1 }" @click="selChap({ id: -1, titre: 'Tous les chapitres' })">
              <div class="sel-tout-left">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#2f6fed" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7" rx="1.5"/><rect x="14" y="3" width="7" height="7" rx="1.5"/><rect x="3" y="14" width="7" height="7" rx="1.5"/><rect x="14" y="14" width="7" height="7" rx="1.5"/></svg>
                <span class="sel-tout-label">Tout — tous les chapitres</span>
              </div>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#2f6fed" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><path d="M9 6l6 6-6 6"/></svg>
            </button>

            <!-- Chapitres -->
            <div class="sel-chapitres">
              <button v-for="chap in chapitres" :key="chap.id"
                class="chap-row" :class="{ active: chapitreChoisi?.id === chap.id }"
                @click="selChap(chap)">
                <div class="chap-row-inner">
                  <div class="chap-row-top">
                    <span class="chap-titre">{{ chap.titre }}</span>
                    <span class="chap-pct" :style="{ color: pctColor(chapStats[chap.id] ?? 0) }">
                      {{ chapStats[chap.id] ?? 0 }}%
                    </span>
                  </div>
                  <div class="chap-bar-wrap">
                    <div class="chap-bar" :style="{ width: (chapStats[chap.id] ?? 0) + '%', background: pctColor(chapStats[chap.id] ?? 0) }"></div>
                  </div>
                </div>
              </button>
            </div>
          </div>

          <!-- Pied -->
          <div class="sel-footer">
            <button class="sel-continuer" :disabled="!chapitreChoisi" @click="allerAuMode">Continuer</button>
          </div>

        </div>
      </div>
    </transition>

    <!-- ═══════════════════════════════════════════════════════════
         ÉTAPE 2 — Mode de jeu
    ═══════════════════════════════════════════════════════════ -->
    <transition name="modal-fade">
      <div v-if="etape === 'mode'" class="modal-bg" @click.self="fermer">
        <div class="mode-modal">

          <!-- Header -->
          <div class="mode-header">
            <button class="mode-retour" @click="etape = 'chapitre'">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><path d="M15 18l-6-6 6-6"/></svg>
              Retour
            </button>
            <div class="mode-header-logo">
              <div class="mode-logo-sq">E</div>
              <span class="mode-logo-txt">EduClé</span>
            </div>
            <button class="sel-close" @click="fermer">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><path d="M18 6 6 18"/><path d="M6 6l12 12"/></svg>
            </button>
          </div>

          <!-- Corps scrollable -->
          <div class="mode-body">
            <!-- Fil d'Ariane -->
            <div class="mode-breadcrumb">
              <div class="mode-bc-icon" :style="{ background: iconBgPour(mat.nom) }">
                <img v-if="imagePour(mat.nom)" :src="imagePour(mat.nom)" :alt="mat.nom" class="mode-bc-img" />
                <span v-else class="material-symbols-outlined filled" :style="{ color: iconColorPour(mat.nom), fontSize: '15px' }">{{ iconPour(mat.nom) }}</span>
              </div>
              <span class="mode-bc-text">{{ mat.nom }} · {{ chapitreChoisi?.titre }}</span>
            </div>

            <h2 class="mode-titre">Choisis ton mode de jeu</h2>

            <!-- Cartes de mode -->
            <div class="mode-liste">
              <button v-for="m in MODES" :key="m.key"
                class="mode-card" :class="{ active: modeNom === m.label }"
                :style="modeNom === m.label ? { borderLeftColor: m.color, background: m.bg } : {}"
                @click="modeNom = m.label">
                <div class="mode-card-icon" :style="{ background: modeNom === m.label ? '#fff' : m.bg }">
                  {{ m.icon }}
                </div>
                <div class="mode-card-body">
                  <div class="mode-card-top">
                    <span class="mode-card-label">{{ m.label }}</span>
                    <span class="mode-card-timing" :style="{ color: m.color, background: modeNom === m.label ? '#fff' : m.bg }">{{ m.timing }}</span>
                  </div>
                  <p class="mode-card-desc">{{ m.desc }}</p>
                </div>
                <div class="mode-radio" :style="modeNom === m.label
                  ? { borderColor: m.color, background: m.color, boxShadow: 'inset 0 0 0 3.5px #fff' }
                  : { borderColor: '#d8dbe2' }">
                </div>
              </button>
            </div>

            <!-- Nombre de questions -->
            <div class="mode-nb-card">
              <template v-if="modeNom !== 'Bombardement'">
                <div class="mode-nb-title">Nombre de questions</div>
                <div class="mode-nb-options">
                  <button v-for="n in [5, 10, 15, 20]" :key="n"
                    class="mode-nb-btn" :class="{ active: nbQuestions === n }"
                    @click="nbQuestions = n">{{ n }}</button>
                </div>
              </template>
              <template v-else>
                <div class="mode-nb-fixed">
                  <span class="mode-nb-fixed-icon">⏱</span>
                  <div>
                    <div class="mode-nb-fixed-label">30 questions fixes</div>
                    <div class="mode-nb-fixed-sub">Déterminé par la conception du mode Bombardement.</div>
                  </div>
                </div>
              </template>
            </div>
          </div>

          <!-- Pied fixe -->
          <div class="mode-footer">
            <span class="mode-summary">{{ modeNom }} · {{ modeNom === 'Bombardement' ? '30 questions' : nbQuestions + ' questions' }}</span>
            <button class="mode-demarrer" @click="demarrer">
              Démarrer le quiz
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.6" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14"/><path d="M13 6l6 6-6 6"/></svg>
            </button>
          </div>

        </div>
      </div>
    </transition>

    <!-- ─── Modal Jouer Tout ──────────────────────────────────── -->
    <transition name="modal-fade">
      <div v-if="showJouerTout" class="modal-bg" @click.self="showJouerTout = false">
        <div class="mode-modal">
          <div class="mode-header">
            <div class="mode-header-logo">
              <div class="mode-logo-sq">E</div>
              <span class="mode-logo-txt">EduClé</span>
            </div>
            <button class="sel-close" @click="showJouerTout = false">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><path d="M18 6 6 18"/><path d="M6 6l12 12"/></svg>
            </button>
          </div>
          <div class="mode-body">
            <div class="mode-bc-text" style="margin-bottom:0.5rem;font-weight:700;font-size:0.85rem;color:var(--text-muted)">Toutes les matières · Quiz mixte</div>
            <h2 class="mode-titre">Choisis ton mode de jeu</h2>
            <div class="mode-liste">
              <button v-for="m in MODES" :key="m.key"
                class="mode-card" :class="{ active: modeNom === m.label }"
                :style="modeNom === m.label ? { borderLeftColor: m.color, background: m.bg } : {}"
                @click="modeNom = m.label">
                <div class="mode-card-icon" :style="{ background: modeNom === m.label ? '#fff' : m.bg }">{{ m.icon }}</div>
                <div class="mode-card-body">
                  <div class="mode-card-top">
                    <span class="mode-card-label">{{ m.label }}</span>
                    <span class="mode-card-timing" :style="{ color: m.color, background: modeNom === m.label ? '#fff' : m.bg }">{{ m.timing }}</span>
                  </div>
                  <p class="mode-card-desc">{{ m.desc }}</p>
                </div>
                <div class="mode-radio" :style="modeNom === m.label
                  ? { borderColor: m.color, background: m.color, boxShadow: 'inset 0 0 0 3.5px #fff' }
                  : { borderColor: '#d8dbe2' }"></div>
              </button>
            </div>
            <div class="mode-nb-card">
              <template v-if="modeNom !== 'Bombardement'">
                <div class="mode-nb-title">Nombre de questions</div>
                <div class="mode-nb-options">
                  <button v-for="n in [5, 10, 15, 20]" :key="n"
                    class="mode-nb-btn" :class="{ active: nbQuestions === n }"
                    @click="nbQuestions = n">{{ n }}</button>
                </div>
              </template>
              <template v-else>
                <div class="mode-nb-fixed">
                  <span class="mode-nb-fixed-icon">⏱</span>
                  <div>
                    <div class="mode-nb-fixed-label">30 questions fixes</div>
                    <div class="mode-nb-fixed-sub">Déterminé par la conception du mode Bombardement.</div>
                  </div>
                </div>
              </template>
            </div>
          </div>
          <div class="mode-footer">
            <span class="mode-summary">{{ modeNom }} · {{ modeNom === 'Bombardement' ? '30 questions' : nbQuestions + ' questions' }}</span>
            <button class="mode-demarrer" @click="lancerJouerTout">
              Démarrer le quiz
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.6" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14"/><path d="M13 6l6 6-6 6"/></svg>
            </button>
          </div>
        </div>
      </div>
    </transition>

  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { getMatieres, getNiveaux, getMatiere, getStats } from '../api/client.js'
import { useQuizStore } from '../stores/quiz.js'

const router = useRouter()
const quiz = useQuizStore()

const niveaux    = ref([])
const niveauActif = ref(null)
const matieres   = ref([])
const chargement = ref(true)
const recherche  = ref('')

// Étapes : null | 'chapitre' | 'mode'
const etape         = ref(null)
const mat           = ref(null)       // matière sélectionnée
const chapitres     = ref([])
const chapitreChoisi = ref(null)
const chapStats     = ref({})         // { chapId: pct 0-100 }

const modeNom      = ref('Révision')
const nbQuestions  = ref(10)
const showJouerTout = ref(false)

const MODES = [
  { key: 'rush',        label: 'Rush',        icon: '⚡', timing: '10 s / question', color: '#f2705a', bg: '#fdeee9',
    desc: 'Aucune correction pendant la partie — elle arrive entièrement à la fin. Rapidité pure.' },
  { key: 'revision',   label: 'Révision',     icon: '✓', timing: '20 s / question', color: '#2f6fed', bg: '#e9f0fe',
    desc: 'Correction immédiate après chaque réponse, avec explication pédagogique.' },
  { key: 'bombardement', label: 'Bombardement', icon: '⏱', timing: '1 min au total',  color: '#1e2a52', bg: '#e7e9f2',
    desc: 'Réponds à un maximum de questions avant la fin du temps, sous pression.' },
]

const LS_KEY = 'educle_dernier_jeu'
const dernierJeu = ref(JSON.parse(localStorage.getItem(LS_KEY) || 'null'))

function sauvegarder(matNom, chapTitre, matId, chapId) {
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

function pctColor(pct) {
  if (pct < 40) return '#e0453f'
  if (pct <= 75) return '#e0a233'
  return '#2fa84f'
}

// ── Images & icônes ──────────────────────────────────────────────
const MAT_IMAGES = {
  'mathématiques':                                              '/matieres/Maths.jpg',
  'communication française':                                    '/matieres/comm_francaise.webp',
  'communication créole':                                       '/matieres/Creole.webp',
  'éducation à la citoyenneté':                                 '/matieres/citoyennete.webp',
  'éducation esthétique et artistique':                         '/matieres/artist_palette_3d.png',
  'éducation physique et sportive':                             '/matieres/eps.jpg',
  'éducation à la technologie et aux activités productives':    '/matieres/etap.jpg',
  'biologie':                                                   '/matieres/biologie.jpg',
  'géologie':                                                   '/matieres/geologie.jpg',
  'sciences sociales':                                          '/matieres/Geographie.jpg',
  "histoire d'haïti":                                           '/matieres/Histoire_Haiti.webp',
  'histoire universelle':                                       '/matieres/Histoire_Uni.jpg',
  'économie':                                                   '/matieres/economie.webp',
  'philosophie':                                                '/matieres/philosophie.jpg',
  'informatique':                                               '/matieres/informatique.jpg',
  'littérature haïtienne':                                      '/matieres/Litterature_Haiti.webp',
  'littérature universelle':                                    '/matieres/Litterature_Uni.jpg',
  'chimie':                                                     '/matieres/chimie.webp',
  'physique':                                                   '/matieres/physique.jpg',
  'culture générale':                                           '/matieres/Culture_gen.webp',
}

function imagePour(nom) {
  return MAT_IMAGES[nom.toLowerCase().trim()] ?? MAT_IMAGES[nom.trim()] ?? null
}

const MAT_MAP = {
  'mathématiques':                   { icon: 'calculate',       bg: '#DBEAFE', color: '#1D4ED8' },
  'communication française':         { icon: 'book_2',          bg: '#EDE9FE', color: '#7C3AED' },
  'communication créole':            { icon: 'record_voice_over',bg: '#EDE9FE', color: '#6D28D9' },
  'éducation à la citoyenneté':      { icon: 'balance',         bg: '#CCFBF1', color: '#0D9488' },
  'éducation esthétique et artistique': { icon: 'palette',      bg: '#FFEDD5', color: '#C2410C' },
  'éducation physique et sportive':  { icon: 'directions_run',  bg: '#FEF3C7', color: '#B45309' },
  'éducation à la technologie et aux activités productives': { icon: 'build', bg: '#D1FAE5', color: '#059669' },
  'biologie':                        { icon: 'biotech',         bg: '#CCFBF1', color: '#065F46' },
  'géologie':                        { icon: 'terrain',         bg: '#FEF3C7', color: '#92400E' },
  'sciences sociales':               { icon: 'groups',          bg: '#FEF3C7', color: '#D97706' },
  "histoire d'haïti":                { icon: 'account_balance', bg: '#FEE2E2', color: '#B91C1C' },
  'histoire universelle':            { icon: 'public',          bg: '#DCFCE7', color: '#15803D' },
  'économie':                        { icon: 'bar_chart',       bg: '#DCFCE7', color: '#16A34A' },
  'philosophie':                     { icon: 'psychology',      bg: '#FEF3C7', color: '#B45309' },
  'informatique':                    { icon: 'computer',        bg: '#DBEAFE', color: '#2563EB' },
  'littérature haïtienne':           { icon: 'auto_stories',    bg: '#FCE7F3', color: '#9D174D' },
  'littérature universelle':         { icon: 'auto_stories',    bg: '#EDE9FE', color: '#6B21A8' },
  'chimie':                          { icon: 'science',         bg: '#EDE9FE', color: '#7C3AED' },
  'physique':                        { icon: 'bolt',            bg: '#DBEAFE', color: '#1D4ED8' },
  'culture générale':                { icon: 'lightbulb',       bg: '#FEF3C7', color: '#D97706' },
  'connaissances générales':         { icon: 'lightbulb',       bg: '#FEF3C7', color: '#D97706' },
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

// ── Filtres & données ────────────────────────────────────────────
const matieresFiltrées = computed(() =>
  recherche.value.trim()
    ? matieres.value.filter(m => m.nom.toLowerCase().includes(recherche.value.toLowerCase()))
    : matieres.value
)

onMounted(async () => {
  const [nivList] = await Promise.all([getNiveaux(), chargerStats()])
  niveaux.value = nivList
  niveauActif.value = nivList[0] ?? null
  await filtrer(niveauActif.value)
  chargement.value = false
})

async function chargerStats() {
  try {
    const stats = await getStats()
    const map = {}
    for (const mat of stats.matieres) {
      for (const chap of mat.chapitres) {
        map[chap.id] = Math.round(chap.reussite * 100)
      }
    }
    chapStats.value = map
  } catch {}
}

async function filtrer(niv) {
  niveauActif.value = niv
  chargement.value = true
  matieres.value = await getMatieres(niv)
  chargement.value = false
}

// ── Flux sélection ───────────────────────────────────────────────
async function choisirMatiere(m) {
  mat.value = m
  chapitreChoisi.value = null
  const detail = await getMatiere(m.id)
  chapitres.value = detail.chapitres
  etape.value = 'chapitre'
}

function selChap(chap) {
  chapitreChoisi.value = chap
}

function allerAuMode() {
  if (!chapitreChoisi.value) return
  etape.value = 'mode'
}

function fermer() {
  etape.value = null
  chapitreChoisi.value = null
}

function demarrer() {
  const m = mat.value
  const chap = chapitreChoisi.value
  const chapId = chap.id === -1 ? m.id * -1 : chap.id
  sauvegarder(m.nom, chap.titre, m.id, chapId)
  quiz.configurer({ chapitreId: chapId, matiereId: m.id, modeNom: modeNom.value, nbQuestions: nbQuestions.value, matNom: m.nom, chapNom: chap.titre })
  fermer()
  router.push('/quiz')
}

// ── Jouer tout ───────────────────────────────────────────────────
function ouvrirJouerTout() { showJouerTout.value = true }

function lancerJouerTout() {
  if (!matieres.value.length) return
  const m = matieres.value[Math.floor(Math.random() * matieres.value.length)]
  quiz.configurer({ chapitreId: m.id * -1, matiereId: m.id, modeNom: modeNom.value, nbQuestions: nbQuestions.value, matNom: m.nom, chapNom: 'Tous les chapitres' })
  showJouerTout.value = false
  router.push('/quiz')
}

async function jouerAleatoire() {
  if (!matieres.value.length) return
  const m = matieres.value[Math.floor(Math.random() * matieres.value.length)]
  const detail = await getMatiere(m.id)
  if (!detail.chapitres.length) return
  const chap = detail.chapitres[Math.floor(Math.random() * detail.chapitres.length)]
  sauvegarder(m.nom, chap.titre, m.id, chap.id)
  quiz.configurer({ chapitreId: chap.id, matiereId: m.id, modeNom: modeNom.value, nbQuestions: nbQuestions.value, matNom: m.nom, chapNom: chap.titre })
  router.push('/quiz')
}
</script>

<style scoped>
.home-wrap { min-height: calc(100dvh - 64px); background: var(--bg); }
.home-inner { max-width: 1024px; margin: 0 auto; padding: 1.5rem 1.25rem 4rem; }

/* ── Bento hero ─────────────────────────────────────────────── */
.bento-grid { display: grid; grid-template-columns: 1fr; gap: 0.85rem; margin-bottom: 2rem; }
@media (min-width: 640px) { .bento-grid { grid-template-columns: 2fr 1fr; } }

.hero-card {
  background: linear-gradient(135deg, #0058BE, #1A7AEF);
  border-radius: 18px; padding: 1.5rem;
  position: relative; overflow: hidden;
  display: flex; flex-direction: column; justify-content: space-between; min-height: 220px;
}
.hero-deco-1 { position: absolute; bottom: -30px; right: -30px; width: 200px; height: 200px; background: rgba(255,255,255,0.08); border-radius: 50%; pointer-events: none; }
.hero-deco-2 { position: absolute; top: 20px; left: 20px; width: 80px; height: 80px; background: rgba(255,255,255,0.05); border-radius: 50%; pointer-events: none; }
.hero-content { position: relative; z-index: 1; margin-bottom: 1.25rem; }
.hero-titre { font-size: 1.75rem; font-weight: 800; color: #fff; line-height: 1.15; margin-bottom: 0.5rem; }
.hero-sous { font-size: 0.9rem; color: rgba(255,255,255,0.7); line-height: 1.5; max-width: 400px; }
.hero-actions { display: flex; flex-wrap: wrap; gap: 0.6rem; position: relative; z-index: 1; }
.hero-btn { display: flex; align-items: center; gap: 0.4rem; padding: 0.6rem 1.1rem; border-radius: 10px; font-weight: 700; font-size: 0.875rem; cursor: pointer; transition: all 0.15s; border: none; }
.hero-btn-primary { background: #fff; color: var(--primary); }
.hero-btn-primary:hover { background: #f0f3ff; }
.hero-btn-ghost { background: rgba(255,255,255,0.18); color: #fff; border: 1px solid rgba(255,255,255,0.3); }
.hero-btn-ghost:hover { background: rgba(255,255,255,0.28); }

.reprendre-card { background: var(--surface); border: 1px solid var(--border); border-radius: 18px; padding: 1.25rem; display: flex; flex-direction: column; justify-content: space-between; min-height: 160px; }
.reprendre-top { flex: 1; }
.reprendre-label { display: flex; align-items: center; gap: 0.35rem; font-size: 0.72rem; font-weight: 700; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.06em; margin-bottom: 0.85rem; }
.reprendre-matiere { display: flex; align-items: center; gap: 0.75rem; margin-bottom: 0.75rem; }
.reprendre-icon { width: 44px; height: 44px; border-radius: 12px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; overflow: hidden; }
.reprendre-img { width: 100%; height: 100%; object-fit: cover; }
.reprendre-mat-nom { font-weight: 700; font-size: 0.95rem; line-height: 1.2; }
.reprendre-chap { font-size: 0.8rem; color: var(--text-muted); margin-top: 0.1rem; }
.reprendre-vide { font-size: 0.82rem; color: var(--text-muted); font-style: italic; }
.reprendre-btn { display: flex; align-items: center; justify-content: center; gap: 0.4rem; width: 100%; padding: 0.55rem; background: var(--surface-low); color: var(--primary); border: 1px solid var(--border); border-radius: 8px; font-weight: 700; font-size: 0.875rem; cursor: pointer; transition: background 0.12s; }
.reprendre-btn:hover { background: var(--primary-light-solid); }

/* ── Section header ─────────────────────────────────────────── */
.section-header { display: flex; flex-direction: column; gap: 0.75rem; margin-bottom: 0.85rem; }
@media (min-width: 640px) { .section-header { flex-direction: row; align-items: flex-end; justify-content: space-between; } }
.section-titre { font-size: 1.15rem; font-weight: 800; }
.section-sous { font-size: 0.85rem; color: var(--text-muted); margin-top: 0.2rem; }
.search-wrap { display: flex; align-items: center; gap: 0.4rem; background: var(--surface); border: 1px solid var(--border); border-radius: var(--radius); padding: 0.5rem 0.9rem; min-width: 220px; }
.search-icon { font-size: 18px; color: var(--text-muted); }
.search-input { border: none; outline: none; background: transparent; font-family: inherit; font-size: 0.875rem; width: 100%; color: var(--text); }
.filtres { display: flex; gap: 0.4rem; flex-wrap: wrap; margin-bottom: 1rem; }
.filtre-btn { padding: 0.3rem 0.8rem; border-radius: 99px; background: var(--border); font-weight: 600; font-size: 0.8rem; color: var(--text-muted); border: none; cursor: pointer; transition: background 0.15s, color 0.15s; }
.filtre-btn.active { background: var(--primary); color: white; }
.loading { text-align: center; color: var(--text-muted); padding: 3rem; }
.vide { text-align: center; color: var(--text-muted); padding: 2rem; font-style: italic; }

/* ── Grille matières ─────────────────────────────────────────── */
.matieres-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 0.65rem; padding-bottom: 2rem; }
@media (min-width: 640px) { .matieres-grid { grid-template-columns: repeat(3, 1fr); } }
@media (min-width: 900px)  { .matieres-grid { grid-template-columns: repeat(4, 1fr); } }
.mat-card { display: flex; flex-direction: column; align-items: center; text-align: center; padding: 1rem 0.75rem; gap: 0.6rem; background: var(--surface); border: 1px solid var(--border); border-radius: 14px; cursor: pointer; transition: box-shadow 0.15s, transform 0.15s; }
.mat-card:hover { box-shadow: 0 6px 20px rgba(0,0,0,0.1); transform: translateY(-2px); }
.mat-img-wrap { width: 56px; height: 56px; border-radius: 12px; overflow: hidden; transition: transform 0.15s; }
.mat-card:hover .mat-img-wrap { transform: scale(1.08); }
.mat-img { width: 100%; height: 100%; object-fit: cover; display: block; }
.mat-icon-wrap { width: 56px; height: 56px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: transform 0.15s; }
.mat-card:hover .mat-icon-wrap { transform: scale(1.08); }
.mat-icon { font-size: 28px !important; }
.mat-nom { font-size: 0.82rem; font-weight: 800; line-height: 1.25; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }

/* ── Overlay commun ─────────────────────────────────────────── */
.modal-bg {
  position: fixed; inset: 0; background: rgba(20,24,35,0.5);
  display: flex; align-items: center; justify-content: center;
  padding: 1.5rem; z-index: 100;
  backdrop-filter: blur(3px);
}
.modal-fade-enter-active, .modal-fade-leave-active { transition: opacity 0.18s; }
.modal-fade-enter-from, .modal-fade-leave-to { opacity: 0; }

.sel-close {
  width: 32px; height: 32px; border-radius: 50%;
  border: none; background: #f1f2f5; cursor: pointer;
  display: flex; align-items: center; justify-content: center;
  color: #5b6270; flex-shrink: 0;
  transition: background 0.12s;
}
.sel-close:hover { background: #e3e5ea; }

/* ── Modal Sélection chapitre ───────────────────────────────── */
.sel-modal {
  background: #fff; border-radius: 24px;
  width: 100%; max-width: 600px; max-height: 88dvh;
  display: flex; flex-direction: column;
  box-shadow: 0 24px 60px rgba(0,0,0,0.25);
  overflow: hidden;
}
.sel-header {
  flex-shrink: 0; display: flex; align-items: center; justify-content: space-between;
  padding: 1.25rem 1.5rem; border-bottom: 1px solid #ececf0;
}
.sel-header-left { display: flex; align-items: center; gap: 0.75rem; }
.sel-mat-thumb {
  width: 38px; height: 38px; border-radius: 11px;
  background: #e9f0fe; overflow: hidden; flex-shrink: 0;
  display: flex; align-items: center; justify-content: center;
}
.sel-mat-img { width: 100%; height: 100%; object-fit: cover; }
.sel-mat-nom { font-size: 1.05rem; font-weight: 800; color: #1a1d24; }
.sel-retour-lien { font-size: 0.8rem; font-weight: 700; color: #2f6fed; background: none; border: none; cursor: pointer; padding: 0; }
.sel-retour-lien:hover { text-decoration: underline; }

.sel-body { flex: 1; overflow-y: auto; padding: 1.1rem 1.5rem; }
.sel-section-label { color: #9aa1ad; font-size: 0.72rem; font-weight: 800; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 0.65rem; }

.sel-tout {
  width: 100%; display: flex; align-items: center; justify-content: space-between;
  padding: 0.85rem 1rem; border-radius: 12px; cursor: pointer;
  border: 2px solid #e3e5ea; background: #fff;
  margin-bottom: 0.4rem; transition: border-color 0.12s, background 0.12s;
}
.sel-tout.active { border-color: #2f6fed; background: #e9f0fe; }
.sel-tout:hover:not(.active) { border-color: #b3c8f8; }
.sel-tout-left { display: flex; align-items: center; gap: 0.75rem; }
.sel-tout-label { font-weight: 800; font-size: 0.95rem; color: #1e2a52; }

.sel-chapitres { display: flex; flex-direction: column; gap: 0.5rem; margin: 0.85rem 0 0.5rem; }
.chap-row {
  width: 100%; text-align: left; display: flex; align-items: center;
  padding: 0.75rem 0.9rem; border-radius: 12px; cursor: pointer;
  border: 2px solid #ececf0; background: #fff;
  transition: border-color 0.12s, background 0.12s;
}
.chap-row.active { border-color: #2f6fed; background: #f8faff; }
.chap-row:hover:not(.active) { border-color: #c7d8fc; }
.chap-row-inner { flex: 1; min-width: 0; }
.chap-row-top { display: flex; align-items: center; justify-content: space-between; gap: 0.75rem; margin-bottom: 0.4rem; }
.chap-titre { font-weight: 700; font-size: 0.9rem; color: #1a1d24; }
.chap-pct { font-weight: 800; font-size: 0.78rem; flex-shrink: 0; }
.chap-bar-wrap { height: 5px; background: #ececf0; border-radius: 99px; overflow: hidden; }
.chap-bar { height: 100%; border-radius: 99px; transition: width 0.3s; }

.sel-footer {
  flex-shrink: 0; padding: 1rem 1.5rem; border-top: 1px solid #ececf0;
}
.sel-continuer {
  width: 100%; background: #2f6fed; color: #fff;
  border: none; border-radius: 13px; padding: 0.9rem;
  font-size: 1rem; font-weight: 800; cursor: pointer;
  transition: background 0.15s;
}
.sel-continuer:hover:not(:disabled) { background: #1d4fc4; }
.sel-continuer:disabled { opacity: 0.4; cursor: not-allowed; }

/* ── Modal Mode de jeu ───────────────────────────────────────── */
.mode-modal {
  background: #fff; border-radius: 24px;
  width: 100%; max-width: 680px; max-height: 92dvh;
  display: flex; flex-direction: column;
  box-shadow: 0 24px 60px rgba(0,0,0,0.25);
  overflow: hidden;
}
.mode-header {
  flex-shrink: 0; display: flex; align-items: center; justify-content: space-between;
  padding: 1.1rem 1.5rem; border-bottom: 1px solid #ececf0;
}
.mode-retour {
  display: flex; align-items: center; gap: 0.4rem;
  background: none; border: none; cursor: pointer;
  font-weight: 700; font-size: 0.88rem; color: #4a4f5a;
  padding: 0;
}
.mode-retour:hover { color: #1a1d24; }
.mode-header-logo { display: flex; align-items: center; gap: 0.5rem; }
.mode-logo-sq { width: 34px; height: 34px; border-radius: 9px; background: #2f6fed; color: #fff; font-weight: 800; font-size: 17px; display: flex; align-items: center; justify-content: center; }
.mode-logo-txt { font-size: 1.1rem; font-weight: 800; letter-spacing: -0.01em; }

.mode-body { flex: 1; overflow-y: auto; padding: 1.25rem 1.5rem 1rem; }
.mode-breadcrumb { display: flex; align-items: center; gap: 0.65rem; margin-bottom: 0.65rem; }
.mode-bc-icon { width: 30px; height: 30px; border-radius: 9px; overflow: hidden; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
.mode-bc-img { width: 100%; height: 100%; object-fit: cover; }
.mode-bc-text { font-weight: 700; font-size: 0.85rem; color: #6a707c; }
.mode-titre { font-size: 1.5rem; font-weight: 800; margin: 0 0 1.25rem; letter-spacing: -0.015em; color: #1a1d24; }

.mode-liste { display: flex; flex-direction: column; gap: 0.75rem; margin-bottom: 1rem; }
.mode-card {
  width: 100%; text-align: left; display: flex; align-items: center; gap: 1.25rem;
  border: none; cursor: pointer; border-radius: 16px; padding: 1.1rem 1.25rem;
  border-left: 5px solid transparent; background: #fff;
  box-shadow: 0 1px 3px rgba(0,0,0,0.06);
  transition: background 0.12s, border-left-color 0.12s;
}
.mode-card:hover:not(.active) { background: #f8f9fb; }
.mode-card-icon { flex-shrink: 0; width: 50px; height: 50px; border-radius: 14px; display: flex; align-items: center; justify-content: center; font-size: 22px; transition: background 0.12s; }
.mode-card-body { flex: 1; min-width: 0; }
.mode-card-top { display: flex; align-items: center; gap: 0.65rem; margin-bottom: 0.3rem; }
.mode-card-label { font-size: 1.1rem; font-weight: 800; color: #1a1d24; }
.mode-card-timing { font-size: 0.72rem; font-weight: 700; padding: 0.2rem 0.55rem; border-radius: 99px; }
.mode-card-desc { margin: 0; color: #6a707c; font-size: 0.83rem; line-height: 1.5; }
.mode-radio { flex-shrink: 0; width: 20px; height: 20px; border-radius: 50%; border: 2.5px solid #d8dbe2; transition: all 0.12s; }

.mode-nb-card { background: #fff; border: 1px solid #ececf0; border-radius: 18px; padding: 1.1rem 1.25rem; margin-bottom: 0.5rem; }
.mode-nb-title { font-weight: 800; font-size: 0.9rem; margin-bottom: 0.85rem; color: #1a1d24; }
.mode-nb-options { display: flex; gap: 0.5rem; }
.mode-nb-btn { flex: 1; text-align: center; border-radius: 11px; padding: 0.75rem; font-weight: 800; font-size: 0.95rem; cursor: pointer; border: 2px solid #e3e5ea; background: #fff; color: #4a4f5a; transition: all 0.12s; }
.mode-nb-btn.active { border-color: #2f6fed; background: #e9f0fe; color: #2f6fed; }
.mode-nb-btn:hover:not(.active) { border-color: #c0cbea; }
.mode-nb-fixed { display: flex; align-items: center; gap: 0.75rem; }
.mode-nb-fixed-icon { width: 34px; height: 34px; border-radius: 10px; background: #e7e9f2; color: #1e2a52; display: flex; align-items: center; justify-content: center; font-size: 15px; flex-shrink: 0; }
.mode-nb-fixed-label { font-weight: 800; font-size: 0.875rem; color: #1a1d24; }
.mode-nb-fixed-sub { color: #6a707c; font-size: 0.78rem; margin-top: 1px; }

.mode-footer {
  flex-shrink: 0; padding: 1rem 1.5rem; border-top: 1px solid #ececf0;
  display: flex; justify-content: center; align-items: center; gap: 1.25rem;
  background: #fff;
}
.mode-summary { color: #6a707c; font-size: 0.85rem; font-weight: 700; }
.mode-demarrer {
  background: #2f6fed; color: #fff; border: none; border-radius: 13px;
  padding: 0.9rem 1.75rem; font-size: 0.95rem; font-weight: 800;
  cursor: pointer; display: flex; align-items: center; gap: 0.5rem;
  transition: background 0.15s;
}
.mode-demarrer:hover { background: #1d4fc4; }
</style>
