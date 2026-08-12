<template>
  <div class="page fade-in">
    <!-- Chargement -->
    <div v-if="chargement" class="loading-full">
      <p>Préparation du quiz…</p>
    </div>

    <!-- Quiz terminé localement → en attente du résultat -->
    <div v-else-if="envoi" class="loading-full">
      <p>Calcul du résultat…</p>
    </div>

    <!-- Quiz en cours -->
    <template v-else-if="question">
      <!-- Barre de progression -->
      <div class="progress-bar-wrap">
        <div class="progress-bar" :style="{ width: (indexCourant / total * 100) + '%' }"></div>
      </div>
      <div class="progress-label">{{ indexCourant + 1 }} / {{ total }}  ·  {{ modeNom }}</div>

      <!-- Chronomètre (Rush / Révision) -->
      <div v-if="tempsMax" class="timer" :class="{ critique: tempsRestant <= seuilCritique }">
        ⏱ {{ tempsRestant }}s
      </div>

      <!-- Énoncé -->
      <div class="card enonce" :class="{ shake: animShake, pulse: animPulse }">
        <p>{{ question.enonce }}</p>
      </div>

      <!-- Choix -->
      <div class="choix-list">
        <button
          v-for="(choix, i) in question.choix"
          :key="i"
          class="choix-btn"
          :class="etatChoix(i)"
          :disabled="reponduIndex !== null"
          @click="repondre(i)"
        >
          <span class="lettre">{{ lettres[i] }}</span>
          <span>{{ choix }}</span>
        </button>
      </div>

      <!-- Explication (Révision après bonne réponse) -->
      <div v-if="showExplication" class="explication card fade-in">
        <p class="explication-titre">💡 Explication</p>
        <p>{{ question.explication }}</p>
        <button class="btn-primary suivant-btn" @click="suivant">Suivant →</button>
      </div>
    </template>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'
import { useRouter } from 'vue-router'
import { useQuizStore } from '../stores/quiz.js'

const router = useRouter()
const quizStore = useQuizStore()

const lettres = ['A', 'B', 'C', 'D']
const chargement = ref(true)
const envoi = ref(false)

const indexCourant = ref(0)
const reponduIndex = ref(null)    // indice du choix sélectionné
const bonneIndex   = ref(null)    // indice de la bonne réponse
const showExplication = ref(false)
const animShake = ref(false)
const animPulse = ref(false)

// Chrono
const tempsRestant = ref(0)
let timerInterval = null

const modeNom = computed(() => quizStore.modeNom)
const total   = computed(() => quizStore.questions.length)
const question = computed(() => quizStore.questions[indexCourant.value] ?? null)

// Durée par question selon le mode
const tempsMax = computed(() => {
  if (modeNom.value === 'Rush') return 10
  if (modeNom.value === 'Révision') return 20
  return 0  // Bombardement : pas de chrono par question
})

const seuilCritique = computed(() => modeNom.value === 'Rush' ? 3 : 5)

onMounted(async () => {
  if (!quizStore.chapitreId) {
    router.replace('/')
    return
  }
  await quizStore.demarrer()
  chargement.value = false
  demarrerChrono()
  // Raccourcis clavier 1/2/3/4
  window.addEventListener('keydown', onKey)
})

onBeforeUnmount(() => {
  clearInterval(timerInterval)
  window.removeEventListener('keydown', onKey)
})

function onKey(e) {
  if (reponduIndex.value !== null) return
  const map = { '1': 0, '2': 1, '3': 2, '4': 3 }
  if (map[e.key] !== undefined) repondre(map[e.key])
}

function demarrerChrono() {
  clearInterval(timerInterval)
  if (!tempsMax.value) return
  tempsRestant.value = tempsMax.value
  timerInterval = setInterval(() => {
    tempsRestant.value--
    if (tempsRestant.value <= 0) {
      clearInterval(timerInterval)
      repondre(null)  // temps écoulé
    }
  }, 1000)
}

function repondre(choixIndex) {
  if (reponduIndex.value !== null) return
  clearInterval(timerInterval)

  const q = question.value
  const bonneReponse = q.bonne_reponse
  const bonneIdx = q.choix.indexOf(bonneReponse)

  reponduIndex.value = choixIndex
  bonneIndex.value   = bonneIdx

  const correcte = choixIndex !== null && q.choix[choixIndex] === bonneReponse
  const reponseTexte = choixIndex !== null ? q.choix[choixIndex] : ''

  quizStore.enregistrerReponse(q.id, reponseTexte, tempsRestant.value)

  if (correcte) {
    animPulse.value = true
    setTimeout(() => { animPulse.value = false }, 500)
    if (modeNom.value === 'Révision') {
      showExplication.value = true
    } else {
      setTimeout(suivant, 1000)
    }
  } else {
    animShake.value = true
    setTimeout(() => { animShake.value = false }, 480)
    if (modeNom.value === 'Révision') {
      showExplication.value = true
    } else {
      setTimeout(suivant, 1400)
    }
  }
}

function suivant() {
  showExplication.value = false
  reponduIndex.value    = null
  bonneIndex.value      = null

  if (indexCourant.value + 1 >= total.value) {
    finirQuiz()
  } else {
    indexCourant.value++
    demarrerChrono()
  }
}

async function finirQuiz() {
  envoi.value = true
  await quizStore.terminer()
  router.replace('/resultat')
}

function etatChoix(i) {
  if (reponduIndex.value === null) return ''
  if (i === bonneIndex.value) return 'correct'
  if (i === reponduIndex.value) return 'incorrect'
  return 'neutre'
}
</script>

<style scoped>
.loading-full { display: flex; justify-content: center; padding: 4rem; color: var(--text-muted); font-weight: 600; }

.progress-bar-wrap { height: 5px; background: var(--border); border-radius: 99px; overflow: hidden; margin-bottom: 0.4rem; }
.progress-bar { height: 100%; background: var(--primary); border-radius: 99px; transition: width 0.3s; }
.progress-label { font-size: 0.8rem; color: var(--text-muted); font-weight: 600; margin-bottom: 1rem; }

.timer {
  display: inline-block; padding: 0.35rem 0.9rem;
  border-radius: 99px; background: var(--bg); border: 2px solid var(--border);
  font-weight: 800; font-size: 1rem; margin-bottom: 1rem; transition: color 0.3s, border-color 0.3s;
}
.timer.critique { color: #DC2626; border-color: #DC2626; }

.enonce { font-size: 1.05rem; font-weight: 600; line-height: 1.5; margin-bottom: 1rem; }

.choix-list { display: flex; flex-direction: column; gap: 0.5rem; margin-bottom: 1rem; }
.choix-btn {
  display: flex; align-items: center; gap: 0.75rem;
  background: var(--surface); border: 2px solid var(--border);
  padding: 0.75rem 1rem; border-radius: var(--radius);
  text-align: left; font-weight: 600; font-size: 0.95rem;
  transition: border-color 0.2s, background 0.2s;
}
.choix-btn:hover:not(:disabled) { border-color: var(--primary); background: var(--primary-light); }
.choix-btn.correct  { border-color: var(--success); background: #D1FAE5; }
.choix-btn.incorrect{ border-color: var(--danger);  background: #FEE2E2; }
.choix-btn.neutre   { opacity: 0.5; }
.lettre {
  display: inline-flex; align-items: center; justify-content: center;
  width: 28px; height: 28px; border-radius: 6px;
  background: var(--border); font-weight: 800; font-size: 0.85rem; flex-shrink: 0;
}

.explication { border-left: 4px solid var(--primary); }
.explication-titre { font-weight: 800; color: var(--primary); margin-bottom: 0.5rem; }
.suivant-btn { margin-top: 1rem; width: 100%; }
</style>
