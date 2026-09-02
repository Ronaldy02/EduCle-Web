<template>
  <!-- Page plein-écran avec fond dégradé -->
  <div class="rt-shell">
    <!-- Orbes décoratifs -->
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>

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
          <defs>
            <linearGradient id="sg" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" stop-color="#22d3ee"/>
              <stop offset="100%" stop-color="#3b82f6"/>
            </linearGradient>
          </defs>
          <circle cx="60" cy="60" r="50" fill="transparent" stroke="rgba(255,255,255,0.08)" stroke-width="8"/>
          <circle class="ring-arc" cx="60" cy="60" r="50" fill="transparent"
            stroke="url(#sg)" stroke-width="8" stroke-linecap="round"
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
          <div class="rt-reward-icon" style="background:rgba(96,165,250,0.15);border-color:rgba(96,165,250,0.3)">
            <span class="material-symbols-outlined" style="font-size:28px;color:#60a5fa;filter:drop-shadow(0 0 8px rgba(96,165,250,0.8))">star</span>
          </div>
          <div>
            <p class="rt-reward-val">+{{ res.xp_gagne }} XP</p>
            <p class="rt-reward-sub">Expérience</p>
          </div>
        </div>
        <div class="rt-reward rt-reward-coins">
          <div class="rt-reward-icon" style="background:rgba(253,230,138,0.15);border-color:rgba(253,230,138,0.3)">
            <span class="material-symbols-outlined" style="font-size:28px;color:#fbbf24;filter:drop-shadow(0 0 8px rgba(251,191,36,0.8))">monetization_on</span>
          </div>
          <div>
            <p class="rt-reward-val">+{{ res.pieces_gagnees }} 🪙</p>
            <p class="rt-reward-sub">Pièces</p>
          </div>
        </div>
        <!-- Bonus série si applicable -->
        <div v-if="res.serie_max >= 5" class="rt-reward rt-reward-serie" style="grid-column:1/-1">
          <div class="rt-reward-icon" style="background:rgba(239,68,68,0.15);border-color:rgba(239,68,68,0.3)">
            <span class="material-symbols-outlined" style="font-size:28px;color:#f87171">local_fire_department</span>
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
/* ── Shell plein-écran ────────────────────────────────────────────── */
.rt-shell {
  position: fixed; inset: 0; overflow-y: auto;
  background: linear-gradient(135deg, #0f172a 0%, #31135e 50%, #1e3a8a 100%);
  background-attachment: fixed;
  color: #f1f5f9;
  font-family: 'Inter', sans-serif;
}

.orb {
  position: fixed; border-radius: 50%;
  pointer-events: none; z-index: 0;
}
.orb-1 {
  top: -20%; left: -10%; width: 60vw; height: 60vw;
  background: radial-gradient(circle, rgba(139,92,246,0.22) 0%, transparent 60%);
}
.orb-2 {
  bottom: -20%; right: -10%; width: 70vw; height: 70vw;
  background: radial-gradient(circle, rgba(56,189,248,0.2) 0%, transparent 60%);
}

.rt-loading {
  display: flex; align-items: center; justify-content: center;
  height: 100dvh; color: rgba(255,255,255,0.5);
}

.rt-main {
  position: relative; z-index: 1;
  max-width: 48rem; margin: 0 auto;
  padding: 2rem 1.25rem 5rem;
  display: flex; flex-direction: column; align-items: center; gap: 1.5rem;
}

/* ── Header ──────────────────────────────────────────────────────── */
.rt-header { text-align: center; width: 100%; max-width: 36rem; }

.rt-breadcrumb-pill {
  display: inline-flex; align-items: center; gap: 0.4rem;
  background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2);
  border-radius: 999px; padding: 0.35rem 0.9rem;
  font-size: 0.78rem; font-weight: 600; letter-spacing: 0.05em;
  color: #cbd5e1; margin-bottom: 0.75rem;
  text-transform: uppercase;
}

.rt-title {
  font-size: clamp(2.5rem, 8vw, 3.5rem);
  font-weight: 800; line-height: 1.1; letter-spacing: -0.02em;
  background: linear-gradient(135deg, #fcd34d, #f59e0b);
  -webkit-background-clip: text; -webkit-text-fill-color: transparent;
  background-clip: text;
}
.rt-subtitle { font-size: 1rem; color: #94a3b8; margin-top: 0.35rem; }

/* ── Score ring ──────────────────────────────────────────────────── */
.rt-ring-wrap {
  position: relative; display: flex;
  align-items: center; justify-content: center;
}
.rt-ring-svg {
  width: clamp(10rem, 40vw, 16rem); height: clamp(10rem, 40vw, 16rem);
  filter: drop-shadow(0 0 28px rgba(6,182,212,0.35));
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
  font-size: clamp(1.8rem, 6vw, 2.75rem);
  font-weight: 800; color: #fff; line-height: 1;
}
.rt-ring-label {
  font-size: 0.65rem; font-weight: 700; letter-spacing: 0.1em;
  text-transform: uppercase; color: #67e8f9; margin-top: 0.25rem;
}

/* ── Récompenses ─────────────────────────────────────────────────── */
.rt-rewards {
  display: grid; grid-template-columns: 1fr 1fr;
  gap: 0.75rem; width: 100%; max-width: 36rem;
}
.rt-reward {
  display: flex; align-items: center; gap: 0.85rem;
  border-radius: 14px; padding: 1rem 1.1rem;
  border: 1px solid rgba(255,255,255,0.12);
  transition: transform 0.15s;
}
.rt-reward:hover { transform: scale(1.03); }
.rt-reward-xp {
  background: linear-gradient(135deg, rgba(37,99,235,0.55), rgba(67,56,202,0.7));
  box-shadow: 0 0 20px rgba(37,99,235,0.3);
}
.rt-reward-coins {
  background: linear-gradient(135deg, rgba(217,119,6,0.55), rgba(180,83,9,0.7));
  box-shadow: 0 0 20px rgba(245,158,11,0.3);
}
.rt-reward-serie {
  background: linear-gradient(135deg, rgba(185,28,28,0.5), rgba(127,29,29,0.65));
  box-shadow: 0 0 20px rgba(239,68,68,0.3);
}
.rt-reward-icon {
  width: 52px; height: 52px; flex-shrink: 0;
  border-radius: 50%; border: 1px solid transparent;
  display: flex; align-items: center; justify-content: center;
}
.rt-reward-val {
  font-size: 1.1rem; font-weight: 800; color: #fff;
}
.rt-reward-sub {
  font-size: 0.7rem; font-weight: 700; text-transform: uppercase;
  letter-spacing: 0.06em; color: rgba(255,255,255,0.6); margin-top: 0.1rem;
}

/* ── XP card ─────────────────────────────────────────────────────── */
.rt-xp-card {
  width: 100%; max-width: 36rem;
  background: rgba(255,255,255,0.08); border: 1px solid rgba(255,255,255,0.15);
  backdrop-filter: blur(12px); border-radius: 16px;
  padding: 1.1rem 1.25rem;
}
.rt-xp-head {
  display: flex; justify-content: space-between; align-items: flex-end;
  margin-bottom: 0.75rem;
}
.rt-xp-cap {
  font-size: 0.68rem; font-weight: 700; text-transform: uppercase;
  letter-spacing: 0.07em; color: #67e8f9;
}
.rt-xp-niveau { font-size: 1.2rem; font-weight: 800; color: #fff; }
.rt-xp-chiffres { font-size: 0.82rem; font-weight: 600; color: #67e8f9; }
.rt-xp-bar-wrap {
  height: 12px; background: rgba(15,23,42,0.6);
  border-radius: 99px; overflow: hidden;
}
.rt-xp-bar {
  height: 100%; border-radius: 99px;
  background: linear-gradient(90deg, #22d3ee, #3b82f6);
  box-shadow: 0 0 10px rgba(34,211,238,0.5);
  position: relative; transition: width 0.8s cubic-bezier(0.22,1,0.36,1);
}
.rt-xp-bar-glow {
  position: absolute; inset: 0;
  background: rgba(255,255,255,0.18);
  animation: xp-pulse 2s ease-in-out infinite;
}
@keyframes xp-pulse { 0%,100%{opacity:0.3} 50%{opacity:0.7} }

/* ── Actions ─────────────────────────────────────────────────────── */
.rt-actions {
  display: flex; flex-wrap: wrap; gap: 0.65rem;
  width: 100%; max-width: 36rem;
}
.rt-btn {
  flex: 1; min-width: 10rem; height: 48px; border-radius: 999px;
  font-size: 0.875rem; font-weight: 700; display: flex;
  align-items: center; justify-content: center; gap: 0.4rem;
  cursor: pointer; border: none; transition: all 0.15s;
}
.rt-btn .material-symbols-outlined { font-size: 20px; }
.rt-btn-primary {
  background: linear-gradient(135deg, #06b6d4, #3b82f6);
  color: #fff;
  box-shadow: 0 0 20px rgba(6,182,212,0.4);
}
.rt-btn-primary:hover {
  background: linear-gradient(135deg, #22d3ee, #60a5fa);
  box-shadow: 0 0 28px rgba(6,182,212,0.6);
  transform: translateY(-1px);
}
.rt-btn-glass {
  background: rgba(255,255,255,0.1); color: #fff;
  border: 1px solid rgba(255,255,255,0.2);
  backdrop-filter: blur(8px);
}
.rt-btn-glass:hover { background: rgba(255,255,255,0.2); }

/* ── Détail questions ─────────────────────────────────────────────── */
.rt-questions { width: 100%; max-width: 36rem; }
.rt-q-titre {
  font-size: 0.8rem; font-weight: 800; text-transform: uppercase;
  letter-spacing: 0.07em; color: rgba(255,255,255,0.5);
  margin-bottom: 0.75rem;
}
.rt-q-item {
  background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.1);
  border-radius: 12px; padding: 0.9rem 1rem;
  margin-bottom: 0.6rem; border-left-width: 3px;
}
.rt-q-ok { border-left-color: #4ade80; }
.rt-q-ko { border-left-color: #f87171; }
.rt-q-header { display: flex; gap: 0.6rem; align-items: flex-start; margin-bottom: 0.4rem; }
.rt-q-badge { font-weight: 900; font-size: 0.95rem; flex-shrink: 0; line-height: 1.4; }
.rt-q-ok .rt-q-badge { color: #4ade80; }
.rt-q-ko .rt-q-badge { color: #f87171; }
.rt-q-enonce { font-weight: 600; font-size: 0.875rem; color: #e2e8f0; }
.rt-q-bonne, .rt-q-donnee, .rt-q-expl, .rt-q-xp {
  font-size: 0.8rem; color: rgba(255,255,255,0.55); margin-top: 0.2rem;
}
.rt-q-xp { color: #4ade80; font-weight: 700; }
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
