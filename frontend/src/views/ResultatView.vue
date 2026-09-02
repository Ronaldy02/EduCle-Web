<template>
  <div class="rt-shell">

    <div v-if="!res" class="rt-loading">Chargement…</div>
    <main v-else class="rt-main">

      <!-- ── Overlay niveau supérieur ──────────────────────────────── -->
      <transition name="overlay-fade">
        <div v-if="showOverlay" class="overlay" @click="dismissOverlay">
          <span v-for="i in 16" :key="i" class="particle" :style="particleStyle(i)"></span>
          <div class="overlay-card" @click.stop>
            <div class="overlay-niveau-label">NIVEAU SUPÉRIEUR !</div>
            <div class="overlay-niveau-num">{{ res.niveau_apres }}</div>
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

      <!-- ── En-tête ────────────────────────────────────────────────── -->
      <header class="rt-header">
        <div class="rt-breadcrumb-pill">
          <span class="material-symbols-outlined" style="font-size:18px;color:#22d3ee">calculate</span>
          <span>{{ matChap }}</span>
        </div>
        <h1 class="rt-title">{{ scoreLabel }}</h1>
        <p class="rt-subtitle">{{ scoreSubtitle }}</p>
      </header>

      <!-- ── Anneau de score ────────────────────────────────────────── -->
      <div class="rt-ring-wrap">
        <svg class="rt-ring-svg" viewBox="0 0 120 120">
          <circle cx="60" cy="60" r="50" fill="transparent" stroke="#E3E6EC" stroke-width="8"/>
          <circle class="ring-arc" cx="60" cy="60" r="50" fill="transparent"
            stroke="#2F6FED" stroke-width="8" stroke-linecap="round"
            stroke-dasharray="314"
            :stroke-dashoffset="314 - (pct / 100) * 314"/>
        </svg>
        <div class="rt-ring-inner">
          <span class="rt-ring-score">{{ res.score }}/{{ res.total }}</span>
          <span class="rt-ring-label">Score final</span>
        </div>
      </div>

      <!-- ── Récompenses ─────────────────────────────────────────────── -->
      <div class="rt-rewards">
        <div class="rt-reward rt-reward-xp">
          <div class="rt-reward-icon">
            <span class="material-symbols-outlined" style="font-size:26px;color:#2F6FED">star</span>
          </div>
          <div>
            <p class="rt-reward-val">+{{ res.xp_gagne }} XP</p>
            <p class="rt-reward-sub">Expérience</p>
          </div>
        </div>
        <div class="rt-reward rt-reward-coins">
          <div class="rt-reward-icon">
            <span class="material-symbols-outlined" style="font-size:26px;color:#D97706">monetization_on</span>
          </div>
          <div>
            <p class="rt-reward-val">+{{ res.pieces_gagnees }} 🪙</p>
            <p class="rt-reward-sub">Pièces</p>
          </div>
        </div>
        <div v-if="res.serie_max >= 5" class="rt-reward rt-reward-serie" style="grid-column:1/-1">
          <div class="rt-reward-icon">
            <span class="material-symbols-outlined" style="font-size:26px;color:#DC2626">local_fire_department</span>
          </div>
          <div>
            <p class="rt-reward-val">Série ×{{ res.serie_max }} · +{{ res.serie_bonus }} 🪙</p>
            <p class="rt-reward-sub">Bonus enchaînement</p>
          </div>
        </div>
      </div>

      <!-- ── Barre XP ────────────────────────────────────────────────── -->
      <div class="rt-xp-card">
        <div class="rt-xp-head">
          <div>
            <p class="rt-xp-cap">Progression</p>
            <p class="rt-xp-niveau">Niveau {{ res.niveau_apres }}</p>
          </div>
          <span class="rt-xp-chiffres">{{ xpDans }} / {{ xpSuivant }} XP</span>
        </div>
        <div class="rt-xp-bar-wrap">
          <div class="rt-xp-bar" :style="{ width: (progression * 100) + '%' }">
            <div class="rt-xp-bar-glow"></div>
          </div>
        </div>
      </div>

      <!-- ── Actions ────────────────────────────────────────────────── -->
      <div class="rt-actions">
        <button class="rt-btn rt-btn-primary" @click="rejouer">
          <span class="material-symbols-outlined">replay</span>
          Rejouer
        </button>
        <button class="rt-btn rt-btn-glass" @click="voirDetail = !voirDetail">
          <span class="material-symbols-outlined">{{ voirDetail ? 'expand_less' : 'visibility' }}</span>
          {{ voirDetail ? 'Masquer' : 'Revoir les questions' }}
        </button>
        <button class="rt-btn rt-btn-glass" @click="accueil">
          <span class="material-symbols-outlined">home</span>
          Accueil
        </button>
      </div>

      <!-- ── Détail questions (expandable) ─────────────────────────── -->
      <transition name="detail-slide">
        <div v-if="voirDetail" class="rt-questions">
          <h3 class="rt-q-titre">Détail des réponses</h3>
          <div v-for="q in res.questions" :key="q.question_id"
            class="rt-q-item" :class="q.correcte ? 'rt-q-ok' : 'rt-q-ko'">
            <div class="rt-q-header">
              <span class="rt-q-badge">{{ q.correcte ? '✓' : '✗' }}</span>
              <span class="rt-q-enonce">{{ q.enonce }}</span>
            </div>
            <p class="rt-q-bonne">Bonne réponse : <strong>{{ q.bonne_reponse }}</strong></p>
            <p v-if="!q.correcte && q.reponse_donnee" class="rt-q-donnee">
              Ta réponse : {{ q.reponse_donnee }}
            </p>
            <p v-if="q.explication" class="rt-q-expl">{{ q.explication }}</p>
            <p v-if="q.xp_gagne > 0" class="rt-q-xp">+{{ q.xp_gagne }} XP</p>
          </div>
        </div>
      </transition>

    </main>
  </div>
</template>

<script setup>
import { computed, ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useQuizStore } from '../stores/quiz.js'
import { progressionNiveau, xpPourNiveau, rangDepuisNiveau, RANGS } from '../utils/niveau.js'

const router    = useRouter()
const quizStore = useQuizStore()
const res       = computed(() => quizStore.resultat)
const voirDetail = ref(false)

const pct = computed(() => res.value ? Math.round(res.value.score / res.value.total * 100) : 0)

const matChap = computed(() => {
  const m = quizStore.matNom
  const c = quizStore.chapNom
  if (m && c) return `${m} · ${c}`
  if (m) return m
  return res.value?.mode_nom ?? ''
})

const scoreLabel = computed(() => {
  const p = pct.value
  if (p === 100) return 'Parfait !'
  if (p >= 80)  return 'Excellent !'
  if (p >= 60)  return 'Très bien !'
  if (p >= 40)  return 'Bien !'
  return 'Continue !'
})

const scoreSubtitle = computed(() => {
  const p = pct.value
  if (p === 100) return 'Score parfait ! Tu maîtrises ce chapitre.'
  if (p >= 80)  return 'Tu as complété le défi avec brio.'
  if (p >= 60)  return 'Beau travail, continue sur ta lancée.'
  if (p >= 40)  return 'Tu progresses, persévère !'
  return 'Chaque erreur est une leçon. Réessaie !'
})

const nAp       = computed(() => res.value?.niveau_apres ?? 1)
const progression = computed(() => res.value ? progressionNiveau(res.value.xp_total) : 0)
const xpDans    = computed(() => res.value ? res.value.xp_total - xpPourNiveau(nAp.value) : 0)
const xpSuivant = computed(() => res.value ? xpPourNiveau(nAp.value + 1) - xpPourNiveau(nAp.value) : 100)

const rangAvant = computed(() => res.value ? RANGS[rangDepuisNiveau(res.value.niveau_avant)] : null)
const rangApres = computed(() => res.value ? RANGS[rangDepuisNiveau(res.value.niveau_apres)] : null)
const rangUp    = computed(() =>
  res.value && rangDepuisNiveau(res.value.niveau_avant) !== rangDepuisNiveau(res.value.niveau_apres)
)

// Overlay niveau supérieur
const showOverlay = ref(false)
let dismissTimer = null
onMounted(() => {
  if (res.value?.niveau_apres > res.value?.niveau_avant) {
    showOverlay.value = true
    dismissTimer = setTimeout(dismissOverlay, 4000)
  }
})
function dismissOverlay() { clearTimeout(dismissTimer); showOverlay.value = false }

function particleStyle(i) {
  return {
    '--angle': (i / 16 * 360) + 'deg',
    '--dist':  (120 + (i % 3) * 40) + 'px',
    '--size':  (6 + (i % 4) * 4) + 'px',
    '--hue':   (i * 22) % 360,
    '--delay': (i * 0.07).toFixed(2) + 's',
  }
}

function rejouer() { quizStore.reset(); router.push('/') }
function accueil()  { quizStore.reset(); router.push('/') }
</script>

<style scoped>
/* ── Shell ───────────────────────────────────────────────────────── */
.rt-shell {
  min-height: calc(100dvh - 64px);
  background: var(--bg);
  color: var(--text);
}

.rt-loading {
  display: flex; align-items: center; justify-content: center;
  height: 60dvh; color: var(--text-muted);
}

.rt-main {
  max-width: 44rem; margin: 0 auto;
  padding: 2rem 1.25rem 4rem;
  display: flex; flex-direction: column; align-items: center; gap: 1.5rem;
}

/* ── Header ──────────────────────────────────────────────────────── */
.rt-header { text-align: center; width: 100%; max-width: 36rem; }

.rt-breadcrumb-pill {
  display: inline-flex; align-items: center; gap: 0.4rem;
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 999px; padding: 0.35rem 0.9rem;
  font-size: 0.75rem; font-weight: 700; letter-spacing: 0.05em;
  color: var(--text-muted); margin-bottom: 0.75rem;
  text-transform: uppercase;
}
.rt-breadcrumb-pill .material-symbols-outlined { color: var(--primary) !important; }

.rt-title {
  font-size: clamp(2rem, 7vw, 3rem);
  font-weight: 800; line-height: 1.1; letter-spacing: -0.02em;
  color: var(--text);
}
.rt-subtitle { font-size: 0.95rem; color: var(--text-muted); margin-top: 0.35rem; }

/* ── Score ring ──────────────────────────────────────────────────── */
.rt-ring-wrap {
  position: relative; display: flex;
  align-items: center; justify-content: center;
}
.rt-ring-svg {
  width: clamp(10rem, 40vw, 14rem); height: clamp(10rem, 40vw, 14rem);
  filter: drop-shadow(0 4px 16px rgba(0,88,190,0.15));
}
.ring-arc {
  transform: rotate(-90deg); transform-origin: 50% 50%;
  transition: stroke-dashoffset 1.5s cubic-bezier(0.22, 1, 0.36, 1);
}
.rt-ring-inner {
  position: absolute;
  display: flex; flex-direction: column; align-items: center;
}
.rt-ring-score {
  font-size: clamp(1.8rem, 6vw, 2.5rem);
  font-weight: 800; color: var(--text); line-height: 1;
}
.rt-ring-label {
  font-size: 0.65rem; font-weight: 700; letter-spacing: 0.1em;
  text-transform: uppercase; color: var(--text-muted); margin-top: 0.25rem;
}

/* ── Récompenses ─────────────────────────────────────────────────── */
.rt-rewards {
  display: grid; grid-template-columns: 1fr 1fr;
  gap: 0.75rem; width: 100%; max-width: 36rem;
}
.rt-reward {
  display: flex; align-items: center; gap: 0.85rem;
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 14px; padding: 1rem 1.1rem;
  transition: transform 0.15s;
}
.rt-reward:hover { transform: translateY(-2px); }
.rt-reward-icon {
  width: 48px; height: 48px; flex-shrink: 0;
  border-radius: 50%; border: 1.5px solid var(--border);
  display: flex; align-items: center; justify-content: center;
  background: var(--bg);
}
.rt-reward-xp   .rt-reward-icon { border-color: rgba(0,88,190,0.25); background: rgba(0,88,190,0.06); }
.rt-reward-coins .rt-reward-icon { border-color: rgba(217,119,6,0.25); background: rgba(217,119,6,0.06); }
.rt-reward-serie .rt-reward-icon { border-color: rgba(220,38,38,0.25); background: rgba(220,38,38,0.06); }
.rt-reward-val  { font-size: 1.05rem; font-weight: 800; color: var(--text); }
.rt-reward-sub  {
  font-size: 0.7rem; font-weight: 700; text-transform: uppercase;
  letter-spacing: 0.06em; color: var(--text-muted); margin-top: 0.1rem;
}

/* ── XP card ─────────────────────────────────────────────────────── */
.rt-xp-card {
  width: 100%; max-width: 36rem;
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 16px; padding: 1.1rem 1.25rem;
}
.rt-xp-head {
  display: flex; justify-content: space-between; align-items: flex-end;
  margin-bottom: 0.75rem;
}
.rt-xp-cap {
  font-size: 0.68rem; font-weight: 700; text-transform: uppercase;
  letter-spacing: 0.07em; color: var(--primary);
}
.rt-xp-niveau { font-size: 1.1rem; font-weight: 800; color: var(--text); }
.rt-xp-chiffres { font-size: 0.82rem; font-weight: 600; color: var(--text-muted); }
.rt-xp-bar-wrap {
  height: 8px; background: var(--border);
  border-radius: 99px; overflow: hidden;
}
.rt-xp-bar {
  height: 100%; border-radius: 99px;
  background: var(--primary);
  position: relative; transition: width 0.8s cubic-bezier(0.22,1,0.36,1);
}
.rt-xp-bar-glow {
  position: absolute; inset: 0;
  background: rgba(255,255,255,0.3);
  animation: xp-pulse 2s ease-in-out infinite;
}
@keyframes xp-pulse { 0%,100%{opacity:0.2} 50%{opacity:0.5} }

/* ── Actions ─────────────────────────────────────────────────────── */
.rt-actions {
  display: flex; flex-wrap: wrap; gap: 0.65rem;
  width: 100%; max-width: 36rem;
}
.rt-btn {
  flex: 1; min-width: 9rem; height: 46px; border-radius: 999px;
  font-size: 0.875rem; font-weight: 700; display: flex;
  align-items: center; justify-content: center; gap: 0.4rem;
  cursor: pointer; border: none; transition: all 0.14s;
  font-family: inherit;
}
.rt-btn .material-symbols-outlined { font-size: 20px; }
.rt-btn-primary {
  background: var(--primary); color: #fff;
}
.rt-btn-primary:hover { opacity: 0.88; transform: translateY(-1px); }
.rt-btn-glass {
  background: var(--surface); color: var(--text);
  border: 1.5px solid var(--border);
}
.rt-btn-glass:hover { background: var(--primary-light-solid); border-color: var(--primary); color: var(--primary); }

/* ── Détail questions ─────────────────────────────────────────────── */
.rt-questions { width: 100%; max-width: 36rem; }
.rt-q-titre {
  font-size: 0.72rem; font-weight: 800; text-transform: uppercase;
  letter-spacing: 0.07em; color: var(--text-muted);
  margin-bottom: 0.75rem;
}
.rt-q-item {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 12px; padding: 0.9rem 1rem;
  margin-bottom: 0.6rem; border-left-width: 3px;
}
.rt-q-ok { border-left-color: #16a34a; }
.rt-q-ko { border-left-color: #dc2626; }
.rt-q-header { display: flex; gap: 0.6rem; align-items: flex-start; margin-bottom: 0.4rem; }
.rt-q-badge { font-weight: 900; font-size: 0.95rem; flex-shrink: 0; line-height: 1.4; }
.rt-q-ok .rt-q-badge { color: #16a34a; }
.rt-q-ko .rt-q-badge { color: #dc2626; }
.rt-q-enonce { font-weight: 600; font-size: 0.875rem; color: var(--text); }
.rt-q-bonne, .rt-q-donnee, .rt-q-expl, .rt-q-xp {
  font-size: 0.8rem; color: var(--text-muted); margin-top: 0.2rem;
}
.rt-q-xp { color: #16a34a; font-weight: 700; }
.rt-q-expl { font-style: italic; }

.detail-slide-enter-active { transition: opacity 0.25s, transform 0.25s; }
.detail-slide-enter-from   { opacity: 0; transform: translateY(-8px); }
.detail-slide-leave-active { transition: opacity 0.2s; }
.detail-slide-leave-to     { opacity: 0; }

/* ── Overlay niveau supérieur ───────────────────────────────────── */
.overlay {
  position: fixed; inset: 0; z-index: 200;
  background: rgba(0,0,0,0.8);
  display: flex; align-items: center; justify-content: center;
  backdrop-filter: blur(6px);
}
.overlay-card {
  background: rgba(15,23,42,0.95);
  border: 1px solid rgba(255,255,255,0.15);
  border-radius: 20px; padding: 2.5rem 2rem; text-align: center;
  width: min(360px, 92vw);
  animation: card-pop 0.5s cubic-bezier(0.34,1.56,0.64,1) both;
  position: relative; overflow: hidden;
}
@keyframes card-pop {
  from { transform: scale(0.6); opacity: 0; }
  to   { transform: scale(1); opacity: 1; }
}
.overlay-niveau-label {
  font-size: 0.72rem; font-weight: 900; letter-spacing: 0.12em;
  color: #64748b; text-transform: uppercase; margin-bottom: 0.5rem;
}
.overlay-niveau-num {
  font-size: 5rem; font-weight: 900; line-height: 1; color: #22d3ee;
  animation: num-pulse 0.6s 0.4s cubic-bezier(0.34,1.56,0.64,1) both;
}
@keyframes num-pulse {
  from { transform: scale(0.5); opacity: 0; }
  to   { transform: scale(1); opacity: 1; }
}
.overlay-rang-transition {
  display: flex; align-items: center; justify-content: center;
  gap: 0.75rem; margin: 1rem 0 0.5rem; flex-wrap: wrap;
  font-weight: 800; font-size: 1rem;
  animation: fade-up 0.4s 0.7s both;
}
.overlay-rang-avant { opacity: 0.5; color: #94a3b8; }
.overlay-arrow { color: #475569; font-size: 1.2rem; }
.overlay-rang-apres { font-size: 1.15rem; animation: rang-glow 1.5s 1s ease-in-out infinite alternate; }
@keyframes rang-glow { from{text-shadow:none} to{text-shadow:0 0 16px currentColor} }
.overlay-rang-glow {
  height: 3px; border-radius: 99px; margin: 0 auto 1rem;
  width: 60%; background: var(--glow);
  animation: glow-bar 1.5s 1s ease-in-out infinite alternate; opacity: 0.7;
}
@keyframes glow-bar { from{box-shadow:none} to{box-shadow:0 0 12px var(--glow)} }
@keyframes fade-up { from{opacity:0;transform:translateY(12px)} to{opacity:1;transform:none} }
.overlay-btn {
  margin-top: 1.5rem; width: 100%;
  background: linear-gradient(135deg, #06b6d4, #3b82f6);
  color: #fff; font-weight: 800; font-size: 1rem;
  padding: 0.75rem; border-radius: 999px; border: none; cursor: pointer;
  animation: fade-up 0.4s 0.9s both; transition: opacity 0.15s;
}
.overlay-btn:hover { opacity: 0.85; }

/* Particules */
.particle {
  position: absolute; left: 50%; top: 50%;
  width: var(--size); height: var(--size); border-radius: 50%;
  background: hsl(var(--hue), 80%, 60%);
  animation: particle-burst 0.9s var(--delay) cubic-bezier(0.25,0.46,0.45,0.94) both;
  pointer-events: none;
}
@keyframes particle-burst {
  0%   { transform: translate(-50%,-50%) rotate(var(--angle)) translateX(0) scale(1); opacity:1; }
  80%  { opacity:1; }
  100% { transform: translate(-50%,-50%) rotate(var(--angle)) translateX(var(--dist)) scale(0); opacity:0; }
}
.overlay-fade-enter-active { transition: opacity 0.3s; }
.overlay-fade-leave-active { transition: opacity 0.4s; }
.overlay-fade-enter-from,
.overlay-fade-leave-to { opacity: 0; }
</style>
