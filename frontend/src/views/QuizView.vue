<template>
  <!-- Chargement / envoi -->
  <div v-if="chargement || envoi" class="qz-loading">
    <p>{{ chargement ? 'Préparation du quiz…' : 'Calcul du résultat…' }}</p>
  </div>

  <!-- Quiz en cours -->
  <div v-else-if="question" class="qz-shell">

    <!-- ── Header ───────────────────────────────────────────────── -->
    <header class="qz-header">
      <div class="qz-header-inner">
        <!-- Logo + contexte + badge mode -->
        <div class="qz-header-left">
          <span class="qz-logo">EduClé</span>
          <div class="qz-sep"></div>
          <span class="qz-context">{{ matNom }} <span class="qz-dot">•</span> {{ chapNom }}</span>
          <span class="qz-mode-badge" :style="modeBadgeStyle">{{ modeNom }}</span>
        </div>
        <!-- Score + Série -->
        <div class="qz-header-right">
          <div class="qz-score-block">
            <span class="qz-score-label">Score</span>
            <span class="qz-score-val">{{ scoreLocal }}</span>
          </div>
          <transition name="serie-pop">
            <div v-if="serie >= 3" class="qz-serie-pill">
              🔥 <span>Série : {{ serie }}</span>
            </div>
          </transition>
        </div>
      </div>
      <!-- Barre de progression pleine largeur -->
      <div class="qz-progress-track">
        <div class="qz-progress-fill" :style="{ width: (indexCourant / total * 100) + '%', background: modeCouleur }"></div>
      </div>
    </header>

    <!-- ── Main ─────────────────────────────────────────────────── -->
    <main class="qz-main">

      <!-- Aside : Timer + Bonus -->
      <aside class="qz-aside">

        <!-- Timer par question (Rush / Révision) -->
        <div v-if="modeNom !== 'Bombardement' && tempsMax"
          class="qz-timer-card"
          :class="{ 'qz-timer-urgent': tempsRestant <= seuilCritique }">
          <span class="qz-timer-label">Temps Restant</span>
          <div class="qz-timer-val">{{ String(tempsRestant).padStart(2, '0') }}</div>
          <span class="qz-timer-unit">secondes</span>
        </div>

        <!-- Timer global Bombardement -->
        <div v-else-if="modeNom === 'Bombardement'"
          class="qz-timer-card"
          :class="{ 'qz-timer-urgent': tempsGlobal <= 10 }">
          <span class="qz-timer-label">Temps Restant</span>
          <div class="qz-timer-val">{{ String(tempsGlobal).padStart(2, '0') }}</div>
          <span class="qz-timer-unit">secondes</span>
          <div class="qz-timer-bar-wrap">
            <div class="qz-timer-bar" :style="{ width: (tempsGlobal / 60 * 100) + '%' }"></div>
          </div>
        </div>

        <!-- Bonus -->
        <div class="qz-bonus-card">
          <div class="qz-bonus-title">Bonus Disponibles</div>
          <div class="qz-bonus-list">
            <button class="qz-bonus-btn" @click="utiliserBonus('elimination')" :disabled="bonusUtilises.elimination">
              <span class="qz-bonus-icon">🧹</span>
              <span class="qz-bonus-name">Élimination</span>
              <span class="qz-bonus-cout">50 🪙</span>
            </button>
            <button class="qz-bonus-btn" @click="utiliserBonus('cinqCinq')" :disabled="bonusUtilises.cinqCinq">
              <span class="qz-bonus-icon">½</span>
              <span class="qz-bonus-name">50/50</span>
              <span class="qz-bonus-cout">100 🪙</span>
            </button>
            <button class="qz-bonus-btn" @click="utiliserBonus('indice')" :disabled="bonusUtilises.indice">
              <span class="qz-bonus-icon">💡</span>
              <span class="qz-bonus-name">Indice</span>
              <span class="qz-bonus-cout">75 🪙</span>
            </button>
            <button class="qz-bonus-btn" @click="utiliserBonus('plusTemps')" :disabled="modeNom === 'Bombardement'">
              <span class="qz-bonus-icon">⏱️</span>
              <span class="qz-bonus-name">+Temps</span>
              <span class="qz-bonus-cout">150 🪙</span>
            </button>
          </div>
        </div>
      </aside>

      <!-- Centre : Question + Réponses -->
      <div class="qz-center">

        <!-- Nav question -->
        <div class="qz-question-nav">
          <span class="qz-question-num">Question {{ indexCourant + 1 }} sur {{ total }}</span>
          <button class="qz-passer-btn" :disabled="reponduIndex !== null" @click="passer">
            Passer
            <span class="material-symbols-outlined" style="font-size:18px;vertical-align:middle">skip_next</span>
          </button>
        </div>

        <!-- Carte question -->
        <div class="qz-question-card" :class="{ shake: animShake, pulse: animPulse }">
          <div class="qz-question-dots" aria-hidden="true"></div>
          <h1 class="qz-question-text">{{ question.enonce }}</h1>
        </div>

        <!-- Grille de réponses -->
        <div class="qz-choix-grid">
          <button
            v-for="(choix, i) in choixVisibles"
            :key="i"
            class="qz-choix-btn"
            :class="[etatChoix(i), { 'qz-choix-elimine': elimines.includes(i) }]"
            :disabled="reponduIndex !== null || elimines.includes(i)"
            @click="repondre(i)">
            <div class="qz-lettre" :class="etatChoix(i)">{{ lettres[i] }}</div>
            <span class="qz-choix-texte">{{ choix }}</span>
            <div class="qz-kbd">{{ i + 1 }}</div>
          </button>
        </div>

        <!-- Explication (mode Révision) -->
        <transition name="expl-slide">
          <div v-if="showExplication" class="qz-explication">
            <div class="qz-expl-header">
              <span class="qz-expl-icon">💡</span>
              <span class="qz-expl-titre">Explication</span>
            </div>
            <p class="qz-expl-texte">{{ question.explication }}</p>
            <button class="qz-suivant-btn" @click="suivant">Suivant →</button>
          </div>
        </transition>

        <!-- Indice -->
        <transition name="expl-slide">
          <div v-if="showIndice && question.explication" class="qz-indice">
            <span class="qz-expl-icon">💡</span>
            <p class="qz-expl-texte">{{ question.explication }}</p>
          </div>
        </transition>
      </div>

    </main>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'
import { useRouter } from 'vue-router'
import { useQuizStore } from '../stores/quiz.js'

const router    = useRouter()
const quizStore = useQuizStore()

const lettres   = ['A', 'B', 'C', 'D']
const chargement = ref(true)
const envoi      = ref(false)

const indexCourant    = ref(0)
const reponduIndex    = ref(null)
const bonneIndex      = ref(null)
const showExplication = ref(false)
const showIndice      = ref(false)
const animShake  = ref(false)
const animPulse  = ref(false)
const animPalier = ref(false)

const serie       = ref(0)
const scoreLocal  = ref(0)
const _PALIERS    = [5, 10, 15, 20]

// Bonus
const bonusUtilises = ref({ elimination: false, cinqCinq: false, indice: false })
const elimines      = ref([])  // indices de choix éliminés par bonus

// Chrono par question
const tempsRestant = ref(0)
let timerInterval  = null

// Chrono global Bombardement
const tempsGlobal = ref(60)
let timerGlobal   = null

const modeNom  = computed(() => quizStore.modeNom)
const total    = computed(() => quizStore.questions.length)
const question = computed(() => quizStore.questions[indexCourant.value] ?? null)
const matNom   = computed(() => quizStore.matNom ?? '')
const chapNom  = computed(() => quizStore.chapNom ?? '')

const tempsMax = computed(() => {
  if (modeNom.value === 'Rush')     return 10
  if (modeNom.value === 'Révision') return 20
  return 0
})
const seuilCritique = computed(() => modeNom.value === 'Rush' ? 3 : 5)

const MODES_META = {
  'Rush':         { color: '#f2705a', badge: 'Rush Mode' },
  'Révision':     { color: '#2f6fed', badge: 'Révision' },
  'Bombardement': { color: '#1e2a52', badge: 'Bombardement' },
}
const modeCouleur   = computed(() => MODES_META[modeNom.value]?.color ?? '#2f6fed')
const modeBadgeStyle = computed(() => ({
  background: modeCouleur.value,
  color: '#fff',
}))

// Choix visibles (tous, sauf éliminés masqués : on les grise)
const choixVisibles = computed(() => question.value?.choix ?? [])

onMounted(async () => {
  if (!quizStore.chapitreId) { router.replace('/'); return }
  await quizStore.demarrer()
  chargement.value = false
  if (modeNom.value === 'Bombardement') demarrerChronoGlobal()
  else demarrerChrono()
  window.addEventListener('keydown', onKey)
})

onBeforeUnmount(() => {
  clearInterval(timerInterval)
  clearInterval(timerGlobal)
  window.removeEventListener('keydown', onKey)
})

function onKey(e) {
  if (reponduIndex.value !== null) return
  const map = { '1': 0, '2': 1, '3': 2, '4': 3 }
  if (map[e.key] !== undefined && !elimines.value.includes(map[e.key])) repondre(map[e.key])
}

function demarrerChronoGlobal() {
  tempsGlobal.value = 60
  timerGlobal = setInterval(() => {
    tempsGlobal.value--
    if (tempsGlobal.value <= 0) { clearInterval(timerGlobal); finirQuiz() }
  }, 1000)
}

function demarrerChrono() {
  clearInterval(timerInterval)
  if (!tempsMax.value) return
  tempsRestant.value = tempsMax.value
  timerInterval = setInterval(() => {
    tempsRestant.value--
    if (tempsRestant.value <= 0) { clearInterval(timerInterval); repondre(null) }
  }, 1000)
}

function repondre(choixIndex) {
  if (reponduIndex.value !== null) return
  clearInterval(timerInterval)
  showIndice.value = false

  const q        = question.value
  const bonneRep = q.bonne_reponse
  const bonneIdx = q.choix.indexOf(bonneRep)

  reponduIndex.value = choixIndex
  bonneIndex.value   = bonneIdx

  const correcte    = choixIndex !== null && q.choix[choixIndex] === bonneRep
  const reponseTexte = choixIndex !== null ? q.choix[choixIndex] : ''

  quizStore.enregistrerReponse(q.id, reponseTexte, tempsRestant.value)

  if (correcte) {
    serie.value++
    const bonus = Math.floor(serie.value / 3) * 5
    scoreLocal.value += 20 + bonus
    if (_PALIERS.includes(serie.value)) {
      animPalier.value = true
      setTimeout(() => { animPalier.value = false }, 800)
    }
    animPulse.value = true
    setTimeout(() => { animPulse.value = false }, 500)
  } else {
    serie.value = 0
    animShake.value = true
    setTimeout(() => { animShake.value = false }, 480)
  }

  if (modeNom.value === 'Bombardement') {
    setTimeout(suivant, 350)
    return
  }

  if (modeNom.value === 'Révision') {
    showExplication.value = true
  } else {
    setTimeout(suivant, correcte ? 1000 : 1400)
  }
}

function passer() {
  if (reponduIndex.value !== null) return
  repondre(null)
}

function suivant() {
  showExplication.value = false
  showIndice.value      = false
  reponduIndex.value    = null
  bonneIndex.value      = null
  elimines.value        = []
  bonusUtilises.value   = { elimination: false, cinqCinq: false, indice: false }

  if (indexCourant.value + 1 >= total.value) {
    finirQuiz()
  } else {
    indexCourant.value++
    if (modeNom.value !== 'Bombardement') demarrerChrono()
  }
}

async function finirQuiz() {
  clearInterval(timerGlobal)
  envoi.value = true
  await quizStore.terminer()
  router.replace('/resultat')
}

function etatChoix(i) {
  if (reponduIndex.value === null) return ''
  if (i === bonneIndex.value)     return 'correct'
  if (i === reponduIndex.value)   return 'incorrect'
  return 'neutre'
}

function utiliserBonus(type) {
  if (reponduIndex.value !== null) return
  const q = question.value
  if (!q) return

  if (type === 'elimination') {
    if (bonusUtilises.value.elimination) return
    bonusUtilises.value.elimination = true
    const bonneIdx = q.choix.indexOf(q.bonne_reponse)
    const mauvais  = [0, 1, 2, 3].filter(i => i !== bonneIdx && !elimines.value.includes(i))
    if (mauvais.length > 0) elimines.value.push(mauvais[Math.floor(Math.random() * mauvais.length)])
    if (mauvais.length > 1) elimines.value.push(mauvais.filter(i => !elimines.value.includes(i))[0])

  } else if (type === 'cinqCinq') {
    if (bonusUtilises.value.cinqCinq) return
    bonusUtilises.value.cinqCinq = true
    const bonneIdx = q.choix.indexOf(q.bonne_reponse)
    const mauvais  = [0, 1, 2, 3].filter(i => i !== bonneIdx)
    // Garder un mauvais, éliminer les deux autres
    const garder = mauvais[Math.floor(Math.random() * mauvais.length)]
    elimines.value = mauvais.filter(i => i !== garder)

  } else if (type === 'indice') {
    if (bonusUtilises.value.indice) return
    bonusUtilises.value.indice = true
    showIndice.value = true

  } else if (type === 'plusTemps') {
    if (modeNom.value !== 'Bombardement') {
      clearInterval(timerInterval)
      tempsRestant.value = Math.min(tempsRestant.value + 10, tempsMax.value)
      demarrerChrono()
    } else {
      tempsGlobal.value = Math.min(tempsGlobal.value + 15, 60)
    }
  }
}
</script>

<style scoped>
/* ── Loading ─────────────────────────────────────────────────── */
.qz-loading { display: flex; align-items: center; justify-content: center; min-height: 100dvh; font-weight: 600; color: #6b7280; font-size: 1rem; }

/* ── Shell ───────────────────────────────────────────────────── */
.qz-shell { display: flex; flex-direction: column; min-height: 100dvh; background: #f9f9ff; }

/* ── Header ──────────────────────────────────────────────────── */
.qz-header {
  background: #fff; box-shadow: 0 1px 4px rgba(0,0,0,0.06);
  position: sticky; top: 0; z-index: 50;
}
.qz-header-inner {
  max-width: 1280px; margin: 0 auto;
  padding: 0 1.25rem; height: 64px;
  display: flex; align-items: center; justify-content: space-between;
}
.qz-header-left  { display: flex; align-items: center; gap: 0.6rem; overflow: hidden; }
.qz-header-right { display: flex; align-items: center; gap: 0.75rem; flex-shrink: 0; }

.qz-logo { font-size: 1.35rem; font-weight: 800; color: #0058be; letter-spacing: -0.01em; white-space: nowrap; }
.qz-sep  { width: 1px; height: 24px; background: #c2c6d6; flex-shrink: 0; display: none; }
@media (min-width: 640px) { .qz-sep { display: block; } }

.qz-context { font-size: 0.875rem; font-weight: 500; color: #151c27; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display: none; }
@media (min-width: 640px) { .qz-context { display: block; } }
.qz-dot { color: #727785; margin: 0 0.15rem; }

.qz-mode-badge {
  font-size: 0.65rem; font-weight: 700; padding: 0.2rem 0.6rem;
  border-radius: 99px; text-transform: uppercase; letter-spacing: 0.05em;
  flex-shrink: 0; white-space: nowrap;
}

.qz-score-block { display: flex; flex-direction: column; align-items: flex-end; }
.qz-score-label { font-size: 0.68rem; font-weight: 600; color: #727785; letter-spacing: 0.04em; line-height: 1; }
.qz-score-val   { font-size: 1.1rem; font-weight: 800; color: #0058be; line-height: 1.1; }

.qz-serie-pill {
  display: flex; align-items: center; gap: 0.3rem;
  background: #fff8e1; border: 1.5px solid #ffe082;
  border-radius: 99px; padding: 0.3rem 0.75rem;
  font-size: 0.8rem; font-weight: 700; color: #ff8f00;
}

.qz-progress-track { width: 100%; height: 4px; background: #dce2f3; }
.qz-progress-fill  { height: 100%; transition: width 0.4s ease; }

/* ── Main layout ─────────────────────────────────────────────── */
.qz-main {
  flex: 1; display: flex; flex-direction: column; gap: 1.25rem;
  max-width: 1280px; margin: 0 auto; width: 100%;
  padding: 1.25rem;
}
@media (min-width: 1024px) {
  .qz-main { flex-direction: row; align-items: flex-start; }
}

/* ── Aside ───────────────────────────────────────────────────── */
.qz-aside { display: flex; gap: 1rem; flex-shrink: 0; }
@media (min-width: 640px) and (max-width: 1023px) { .qz-aside { flex-direction: row; } }
@media (min-width: 1024px) { .qz-aside { flex-direction: column; width: 240px; } }

/* Timer card */
.qz-timer-card {
  flex: 1; display: flex; flex-direction: column; align-items: center;
  padding: 1rem; background: #fff; border: 1.5px solid #c2c6d6;
  border-radius: 12px; box-shadow: 0 1px 4px rgba(0,0,0,0.05);
  transition: all 0.3s;
}
.qz-timer-label { font-size: 0.72rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; color: #424754; margin-bottom: 0.25rem; }
.qz-timer-val   { font-size: 3rem; font-weight: 800; line-height: 1; font-variant-numeric: tabular-nums; color: #151c27; }
.qz-timer-unit  { font-size: 0.72rem; color: #727785; margin-top: 0.15rem; }
.qz-timer-bar-wrap { width: 100%; height: 5px; background: #dce2f3; border-radius: 99px; overflow: hidden; margin-top: 0.75rem; }
.qz-timer-bar   { height: 100%; background: #0058be; border-radius: 99px; transition: width 1s linear; }

@keyframes pulse-red {
  0%   { transform: scale(1); box-shadow: 0 0 0 0 rgba(186,26,26,0.4); }
  50%  { transform: scale(1.04); box-shadow: 0 0 0 10px rgba(186,26,26,0); }
  100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(186,26,26,0); }
}
.qz-timer-urgent {
  animation: pulse-red 1s infinite;
  color: #ba1a1a !important;
  border-color: #ffdad6 !important;
  background: #ffdad6 !important;
}
.qz-timer-urgent .qz-timer-val { color: #ba1a1a; }

/* Bonus card */
.qz-bonus-card {
  flex: 1; background: #fff; border: 1.5px solid #c2c6d6;
  border-radius: 12px; padding: 0.85rem;
  box-shadow: 0 1px 4px rgba(0,0,0,0.05);
}
.qz-bonus-title { font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.06em; color: #424754; margin-bottom: 0.65rem; }
.qz-bonus-list  { display: flex; gap: 0.4rem; overflow-x: auto; }
@media (min-width: 1024px) { .qz-bonus-list { flex-direction: column; overflow-x: unset; } }
.qz-bonus-btn {
  display: flex; align-items: center; justify-content: space-between;
  padding: 0.5rem 0.65rem; background: #e7eefe; border: none;
  border-radius: 8px; cursor: pointer; min-width: 130px; gap: 0.4rem;
  transition: background 0.12s; flex-shrink: 0;
}
.qz-bonus-btn:hover:not(:disabled) { background: #dce2f3; }
.qz-bonus-btn:disabled { opacity: 0.4; cursor: not-allowed; }
.qz-bonus-icon { font-size: 18px; flex-shrink: 0; }
.qz-bonus-name { font-size: 0.82rem; font-weight: 600; color: #151c27; flex: 1; text-align: left; }
.qz-bonus-cout { font-size: 0.72rem; font-weight: 700; color: #6b38d4; white-space: nowrap; flex-shrink: 0; }

/* ── Centre ──────────────────────────────────────────────────── */
.qz-center { flex: 1; display: flex; flex-direction: column; min-width: 0; }

.qz-question-nav {
  display: flex; align-items: center; justify-content: space-between;
  margin-bottom: 0.85rem;
}
.qz-question-num { font-size: 0.875rem; font-weight: 600; color: #424754; }
.qz-passer-btn {
  display: flex; align-items: center; gap: 0.2rem;
  font-size: 0.875rem; font-weight: 600; color: #727785;
  background: none; border: none; cursor: pointer; padding: 0;
  transition: color 0.12s;
}
.qz-passer-btn:hover:not(:disabled) { color: #151c27; }
.qz-passer-btn:disabled { opacity: 0.4; cursor: not-allowed; }

/* Question card */
.qz-question-card {
  width: 100%; background: #fff;
  border: 2.5px solid #d8e2ff; border-radius: 16px;
  padding: 2rem 1.5rem; margin-bottom: 1.25rem;
  text-align: center; position: relative; overflow: hidden;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}
.qz-question-dots {
  position: absolute; inset: 0; opacity: 0.08; pointer-events: none;
  background-image: radial-gradient(circle at center, #0058be 1.5px, transparent 1.5px);
  background-size: 22px 22px;
}
.qz-question-text {
  font-size: clamp(1.2rem, 3vw, 2rem); font-weight: 700;
  color: #151c27; line-height: 1.35; position: relative; z-index: 1;
}

/* Grille de réponses */
.qz-choix-grid {
  display: grid; grid-template-columns: 1fr; gap: 0.75rem; margin-bottom: 1rem;
}
@media (min-width: 640px) { .qz-choix-grid { grid-template-columns: repeat(2, 1fr); } }

.qz-choix-btn {
  display: flex; align-items: center; gap: 0.85rem;
  background: #fff; border: 2px solid #c2c6d6;
  border-radius: 14px; padding: 1rem 1.1rem;
  text-align: left; cursor: pointer;
  transition: border-color 0.15s, background 0.15s, transform 0.12s;
  box-shadow: 0 1px 3px rgba(0,0,0,0.04);
}
.qz-choix-btn:hover:not(:disabled) {
  border-color: #0058be; background: #d8e2ff; transform: translateY(-2px);
}
.qz-choix-btn.correct  { border-color: #006c49; background: #6ffbbe33; }
.qz-choix-btn.incorrect{ border-color: #ba1a1a; background: #ffdad6; }
.qz-choix-btn.neutre   { opacity: 0.45; }
.qz-choix-btn.qz-choix-elimine { opacity: 0.25; cursor: not-allowed; }

.qz-lettre {
  width: 44px; height: 44px; border-radius: 10px; flex-shrink: 0;
  background: #dce2f3; color: #424754;
  display: flex; align-items: center; justify-content: center;
  font-size: 1.1rem; font-weight: 700;
  transition: background 0.15s, color 0.15s;
}
.qz-choix-btn:hover:not(:disabled) .qz-lettre { background: #0058be; color: #fff; }
.qz-lettre.correct   { background: #006c49; color: #fff; }
.qz-lettre.incorrect { background: #ba1a1a; color: #fff; }

.qz-choix-texte { flex: 1; font-size: 1.05rem; font-weight: 600; color: #151c27; line-height: 1.3; }

.qz-kbd {
  display: none; align-items: center; justify-content: center;
  padding: 0.2rem 0.45rem; border-radius: 6px;
  background: #dce2f3; font-size: 0.72rem; font-weight: 600; color: #727785;
  flex-shrink: 0;
}
@media (min-width: 768px) { .qz-kbd { display: flex; } }

/* Explication */
.qz-explication {
  background: #fff; border: 2px solid #0058be; border-left-width: 5px;
  border-radius: 14px; padding: 1.1rem 1.25rem;
  margin-top: 0.5rem;
}
.qz-expl-header { display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.5rem; }
.qz-expl-icon   { font-size: 1.2rem; }
.qz-expl-titre  { font-weight: 800; font-size: 0.95rem; color: #0058be; }
.qz-expl-texte  { font-size: 0.9rem; color: #424754; line-height: 1.55; margin-bottom: 0; }

.qz-indice {
  background: #fff8e1; border: 1.5px solid #ffe082; border-radius: 14px;
  padding: 0.9rem 1.1rem; margin-top: 0.5rem;
  display: flex; align-items: flex-start; gap: 0.6rem;
}

.qz-suivant-btn {
  display: block; width: 100%; margin-top: 0.9rem;
  background: #0058be; color: #fff; border: none;
  border-radius: 12px; padding: 0.85rem;
  font-weight: 700; font-size: 0.95rem; cursor: pointer;
  transition: background 0.15s;
}
.qz-suivant-btn:hover { background: #004295; }

/* Transitions */
.serie-pop-enter-active { animation: palier-flash 0.5s ease; }
.serie-pop-leave-active { transition: opacity 0.2s, transform 0.2s; }
.serie-pop-leave-to     { opacity: 0; transform: scale(0.8); }

@keyframes palier-flash {
  0%   { transform: scale(1); }
  30%  { transform: scale(1.3); }
  60%  { transform: scale(1.1); }
  100% { transform: scale(1); }
}

.expl-slide-enter-active { transition: opacity 0.25s, transform 0.25s; }
.expl-slide-enter-from   { opacity: 0; transform: translateY(10px); }
.expl-slide-leave-active { transition: opacity 0.15s; }
.expl-slide-leave-to     { opacity: 0; }
</style>
