<template>
  <div class="page fade-in">
    <div v-if="!res" class="loading">Chargement…</div>
    <template v-else>

      <!-- ── Overlay niveau / rang ────────────────────────────────────────── -->
      <transition name="overlay-fade">
        <div v-if="showOverlay" class="overlay" @click="dismissOverlay">
          <!-- Particules -->
          <span v-for="i in 16" :key="i" class="particle" :style="particleStyle(i)"></span>

          <div class="overlay-card" @click.stop>
            <!-- Niveau supérieur -->
            <div class="overlay-niveau-label">NIVEAU SUPÉRIEUR !</div>
            <div class="overlay-niveau-num">{{ res.niveau_apres }}</div>

            <!-- Rang (si changement) -->
            <template v-if="rangUp">
              <div class="overlay-rang-transition">
                <span class="overlay-rang-avant" :style="{ color: rangAvant.couleur }">
                  {{ rangAvant.emoji }} {{ rangAvant.nom }}
                </span>
                <span class="overlay-arrow">→</span>
                <span class="overlay-rang-apres" :style="{ color: rangApres.couleur }">
                  {{ rangApres.emoji }} {{ rangApres.nom }}
                </span>
              </div>
              <div class="overlay-rang-glow" :style="{ '--glow': rangApres.couleur }"></div>
            </template>

            <button class="overlay-btn" @click="dismissOverlay">Continuer →</button>
          </div>
        </div>
      </transition>

      <!-- Score principal -->
      <div class="card score-card" :class="{ parfait: res.score === res.total }">
        <div class="score-big">{{ res.score }} / {{ res.total }}</div>
        <div class="score-pct">{{ pct }}%</div>
        <p class="score-mode">Mode : {{ res.mode_nom }}</p>
        <div class="gains">
          <span>+{{ res.xp_gagne }} XP</span>
          <span>+{{ res.pieces_gagnees }} 🪙</span>
          <span v-if="res.serie_max >= 5" class="gains-serie">
            🔥 Série ×{{ res.serie_max }} +{{ res.serie_bonus }} 🪙
          </span>
        </div>
      </div>

      <!-- Barre XP après -->
      <div class="card xp-recap">
        <div class="xp-bar-wrap">
          <div class="xp-bar" :style="{ width: (progression * 100) + '%' }"></div>
        </div>
        <p class="xp-label">{{ xpDans }} / {{ xpSuivant }} XP  · Niveau {{ res.niveau_apres }}</p>
      </div>

      <!-- Liste des questions -->
      <h3 class="section-title">Détail</h3>
      <div class="questions-list">
        <div
          v-for="q in res.questions"
          :key="q.question_id"
          class="q-item card"
          :class="{ correct: q.correcte, incorrect: !q.correcte }"
        >
          <div class="q-header">
            <span class="q-icon">{{ q.correcte ? '✓' : '✗' }}</span>
            <span class="q-enonce">{{ q.enonce }}</span>
          </div>
          <p class="q-bonne">Bonne réponse : <strong>{{ q.bonne_reponse }}</strong></p>
          <p v-if="!q.correcte && q.reponse_donnee" class="q-donnee">
            Ta réponse : {{ q.reponse_donnee }}
          </p>
          <p class="q-explication">{{ q.explication }}</p>
          <p v-if="q.xp_gagne > 0" class="q-xp">+{{ q.xp_gagne }} XP</p>
        </div>
      </div>

      <div class="actions">
        <button class="btn-primary" @click="rejouer">Rejouer</button>
        <button class="btn-secondary" @click="accueil">Accueil</button>
      </div>
    </template>
  </div>
</template>

<script setup>
import { computed, ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useQuizStore } from '../stores/quiz.js'
import { niveauDepuisXp, progressionNiveau, xpPourNiveau, rangDepuisNiveau, RANGS } from '../utils/niveau.js'

const router = useRouter()
const quizStore = useQuizStore()
const res = computed(() => quizStore.resultat)

const pct = computed(() => res.value ? Math.round(res.value.score / res.value.total * 100) : 0)

const progression = computed(() => res.value ? progressionNiveau(res.value.xp_total) : 0)
const nAp = computed(() => res.value ? res.value.niveau_apres : 1)
const xpDans = computed(() => res.value ? res.value.xp_total - xpPourNiveau(nAp.value) : 0)
const xpSuivant = computed(() => res.value ? xpPourNiveau(nAp.value + 1) - xpPourNiveau(nAp.value) : 100)

const rangAvant = computed(() => res.value ? RANGS[rangDepuisNiveau(res.value.niveau_avant)] : null)
const rangApres = computed(() => res.value ? RANGS[rangDepuisNiveau(res.value.niveau_apres)] : null)
const rangUp = computed(() =>
  res.value && rangDepuisNiveau(res.value.niveau_avant) !== rangDepuisNiveau(res.value.niveau_apres)
)

// Overlay
const showOverlay = ref(false)
let dismissTimer = null

onMounted(() => {
  if (res.value && res.value.niveau_apres > res.value.niveau_avant) {
    showOverlay.value = true
    dismissTimer = setTimeout(dismissOverlay, 4000)
  }
})

function dismissOverlay() {
  clearTimeout(dismissTimer)
  showOverlay.value = false
}

// Génère un style aléatoire mais déterministe pour chaque particule
function particleStyle(i) {
  const angle = (i / 16) * 360
  const dist = 120 + (i % 3) * 40
  const size = 6 + (i % 4) * 4
  const hue = (i * 22) % 360
  const delay = (i * 0.07).toFixed(2)
  return {
    '--angle': angle + 'deg',
    '--dist': dist + 'px',
    '--size': size + 'px',
    '--hue': hue,
    '--delay': delay + 's',
  }
}

function rejouer() {
  quizStore.reset()
  router.push('/')
}

function accueil() {
  quizStore.reset()
  router.push('/')
}
</script>

<style scoped>
.loading { text-align: center; color: var(--text-muted); padding: 2rem; }

/* ── Overlay ──────────────────────────────────────────────────────────────── */
.overlay {
  position: fixed; inset: 0; z-index: 200;
  background: rgba(0, 0, 0, 0.75);
  display: flex; align-items: center; justify-content: center;
  backdrop-filter: blur(4px);
}

.overlay-card {
  background: var(--surface); border-radius: 20px;
  padding: 2.5rem 2rem; text-align: center;
  width: min(360px, 92vw);
  animation: card-pop 0.5s cubic-bezier(0.34, 1.56, 0.64, 1) both;
  position: relative; overflow: hidden;
}

@keyframes card-pop {
  from { transform: scale(0.6); opacity: 0; }
  to   { transform: scale(1);   opacity: 1; }
}

.overlay-niveau-label {
  font-size: 0.75rem; font-weight: 900; letter-spacing: 0.12em;
  color: var(--text-muted); text-transform: uppercase; margin-bottom: 0.5rem;
}

.overlay-niveau-num {
  font-size: 5rem; font-weight: 900; line-height: 1;
  color: var(--primary);
  animation: num-pulse 0.6s 0.4s cubic-bezier(0.34, 1.56, 0.64, 1) both;
}

@keyframes num-pulse {
  from { transform: scale(0.5); opacity: 0; }
  to   { transform: scale(1);   opacity: 1; }
}

.overlay-rang-transition {
  display: flex; align-items: center; justify-content: center;
  gap: 0.75rem; margin: 1rem 0 0.5rem; flex-wrap: wrap;
  font-weight: 800; font-size: 1rem;
  animation: fade-up 0.4s 0.7s both;
}

.overlay-rang-avant { opacity: 0.55; }
.overlay-arrow { color: var(--text-muted); font-size: 1.2rem; }
.overlay-rang-apres {
  font-size: 1.15rem;
  animation: rang-glow 1.5s 1s ease-in-out infinite alternate;
}

@keyframes rang-glow {
  from { text-shadow: none; }
  to   { text-shadow: 0 0 16px currentColor; }
}

.overlay-rang-glow {
  height: 3px; border-radius: 99px; margin: 0 auto 1rem;
  width: 60%; background: var(--glow);
  animation: glow-bar 1.5s 1s ease-in-out infinite alternate;
  opacity: 0.7;
}

@keyframes glow-bar {
  from { box-shadow: none; }
  to   { box-shadow: 0 0 12px var(--glow); }
}

@keyframes fade-up {
  from { opacity: 0; transform: translateY(12px); }
  to   { opacity: 1; transform: translateY(0); }
}

.overlay-btn {
  margin-top: 1.5rem; width: 100%;
  background: var(--primary); color: white;
  font-weight: 800; font-size: 1rem; padding: 0.75rem;
  border-radius: var(--radius); border: none; cursor: pointer;
  animation: fade-up 0.4s 0.9s both;
  transition: opacity 0.15s;
}
.overlay-btn:hover { opacity: 0.85; }

/* Particules */
.particle {
  position: absolute; left: 50%; top: 50%;
  width: var(--size); height: var(--size);
  border-radius: 50%;
  background: hsl(var(--hue), 80%, 60%);
  animation: particle-burst 0.9s var(--delay) cubic-bezier(0.25, 0.46, 0.45, 0.94) both;
  pointer-events: none;
}

@keyframes particle-burst {
  0%   { transform: translate(-50%, -50%) rotate(var(--angle)) translateX(0)   scale(1); opacity: 1; }
  80%  { opacity: 1; }
  100% { transform: translate(-50%, -50%) rotate(var(--angle)) translateX(var(--dist)) scale(0); opacity: 0; }
}

.overlay-fade-enter-active { transition: opacity 0.3s; }
.overlay-fade-leave-active { transition: opacity 0.4s; }
.overlay-fade-enter-from,
.overlay-fade-leave-to     { opacity: 0; }

/* ── Reste de la page ────────────────────────────────────────────────────── */
.score-card { text-align: center; margin-bottom: 1rem; padding: 2rem; }
.score-card.parfait { border: 2px solid #F59E0B; box-shadow: 0 0 24px rgba(245,158,11,0.2); }
.score-big { font-size: 3rem; font-weight: 900; color: var(--primary); }
.score-pct { font-size: 1.5rem; font-weight: 700; color: var(--text-muted); }
.score-mode { color: var(--text-muted); margin-top: 0.5rem; }
.gains { display: flex; justify-content: center; gap: 1.5rem; margin-top: 1rem; flex-wrap: wrap; }
.gains span { font-weight: 800; font-size: 1.1rem; color: var(--success); }
.gains-serie { color: #B45309 !important; }

.xp-recap { margin-bottom: 1.5rem; }
.xp-bar-wrap { height: 8px; background: var(--border); border-radius: 99px; overflow: hidden; margin-bottom: 0.5rem; }
.xp-bar { height: 100%; background: var(--primary); border-radius: 99px; transition: width 0.6s ease; }
.xp-label { font-size: 0.82rem; color: var(--text-muted); }

.section-title { font-weight: 800; font-size: 1rem; margin-bottom: 0.75rem; }

.questions-list { display: flex; flex-direction: column; gap: 0.75rem; margin-bottom: 1.5rem; }
.q-item { padding: 1rem; }
.q-item.correct { border-left: 4px solid var(--success); }
.q-item.incorrect { border-left: 4px solid var(--danger); }
.q-header { display: flex; gap: 0.6rem; align-items: flex-start; margin-bottom: 0.4rem; }
.q-icon { font-weight: 900; font-size: 1rem; flex-shrink: 0; }
.q-enonce { font-weight: 600; font-size: 0.9rem; }
.q-bonne, .q-donnee, .q-explication, .q-xp { font-size: 0.85rem; color: var(--text-muted); margin-top: 0.2rem; }
.q-explication { font-style: italic; }
.q-xp { color: var(--success); font-weight: 700; }

.actions { display: flex; gap: 0.75rem; }
.actions button { flex: 1; }
</style>
