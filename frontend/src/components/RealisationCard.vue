<template>
  <div
    class="real-card"
    :class="[
      { 'real-card--done': realisation.debloquee, 'real-card--secret': isSecret },
      rareteClass,
    ]"
    :style="cardStyle"
  >
    <div class="real-top">
      <span class="real-rarete" :style="{ background: rareté.bg, color: rareté.fg }">{{ rareté.label }}</span>
      <span v-if="realisation.debloquee" class="real-check material-symbols-outlined real-check--bounce">check_circle</span>
      <span v-else-if="isSecret" class="real-lock material-symbols-outlined">lock</span>
    </div>
    <p class="real-nom">{{ isSecret && !realisation.debloquee ? '???' : realisation.nom }}</p>
    <p class="real-desc">{{ isSecret && !realisation.debloquee ? 'Réalisation secrète — continue à jouer pour la découvrir.' : realisation.description }}</p>
    <div v-if="!isSecret || realisation.debloquee" class="real-bar-row">
      <div class="real-bar-wrap">
        <div class="real-bar" :style="{ width: displayPct + '%', background: rareté.color }"></div>
      </div>
      <span class="real-pct">{{ realisation.progres }} / {{ realisation.cible }}</span>
    </div>
    <p v-if="realisation.debloquee && realisation.debloque_le" class="real-date">
      {{ formatDate(realisation.debloque_le) }}
    </p>
  </div>
</template>

<script setup>
import { computed, ref, onMounted } from 'vue'

const props = defineProps({
  realisation: { type: Object, required: true },
  index: { type: Number, default: 0 },
})

const RARETES = [
  { label: 'Commune',    bg: '#F3F4F6', fg: '#6B7280', color: '#9CA3AF' },
  { label: 'Rare',       bg: '#DBEAFE', fg: '#1D4ED8', color: '#3B82F6' },
  { label: 'Épique',     bg: '#EDE9FE', fg: '#6D28D9', color: '#8B5CF6' },
  { label: 'Légendaire', bg: '#FEF3C7', fg: '#B45309', color: '#F59E0B' },
  { label: 'Mythique',   bg: '#FEE2E2', fg: '#991B1B', color: '#EF4444' },
]

const rareté = computed(() => RARETES[Math.max(0, (props.realisation.rarete || 1) - 1)])

const rareteClass = computed(() => {
  const r = props.realisation.rarete || 1
  if (r === 4) return 'real-card--legendary'
  if (r >= 5) return 'real-card--mythic'
  return ''
})

const isSecret = computed(() => !!props.realisation.secret)

const pct = computed(() => {
  const c = props.realisation.cible
  if (!c) return 0
  return Math.min(100, Math.round((props.realisation.progres / c) * 100))
})

const displayPct = ref(0)

onMounted(() => {
  requestAnimationFrame(() => {
    requestAnimationFrame(() => {
      displayPct.value = pct.value
    })
  })
})

const cardStyle = computed(() => ({
  animationDelay: `${props.index * 45}ms`,
}))

function formatDate(iso) {
  try {
    return new Date(iso).toLocaleDateString('fr-FR', { day: 'numeric', month: 'short', year: 'numeric' })
  } catch { return '' }
}
</script>

<style scoped>
@keyframes card-in {
  from { opacity: 0; transform: translateY(12px) scale(0.97); }
  to   { opacity: 1; transform: translateY(0) scale(1); }
}

@keyframes check-bounce {
  0%   { transform: scale(0.6) rotate(-10deg); opacity: 0; }
  60%  { transform: scale(1.2) rotate(5deg); opacity: 1; }
  80%  { transform: scale(0.95); }
  100% { transform: scale(1) rotate(0deg); opacity: 1; }
}

@keyframes shimmer {
  0%   { background-position: -200% center; }
  100% { background-position: 200% center; }
}

.real-card {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 14px; padding: 1rem;
  display: flex; flex-direction: column; gap: 0.4rem;
  transition: box-shadow 0.18s, border-color 0.18s, transform 0.15s;
  animation: card-in 0.38s cubic-bezier(0.22, 1, 0.36, 1) both;
  will-change: transform, opacity;
}
.real-card:hover {
  box-shadow: 0 6px 20px rgba(0,0,0,0.08);
  transform: translateY(-2px);
}
.real-card--done { border-color: #10B98140; }
.real-card--secret:not(.real-card--done) { opacity: 0.65; }

/* Légendaire : golden glow */
.real-card--legendary {
  border-color: #F59E0B55;
  box-shadow: 0 0 0 1px #F59E0B22;
}
.real-card--legendary .real-rarete {
  background: linear-gradient(90deg, #FDE68A, #F59E0B, #FDE68A) !important;
  background-size: 200% !important;
  animation: shimmer 2.4s linear infinite;
  color: #78350F !important;
}

/* Mythique : red shimmer */
.real-card--mythic {
  border-color: #EF444455;
  box-shadow: 0 0 0 1px #EF444422, 0 4px 16px #EF444412;
}
.real-card--mythic .real-rarete {
  background: linear-gradient(90deg, #FECACA, #EF4444, #FECACA) !important;
  background-size: 200% !important;
  animation: shimmer 1.8s linear infinite;
  color: #7F1D1D !important;
}

.real-top { display: flex; align-items: center; justify-content: space-between; }
.real-rarete {
  font-size: 0.62rem; font-weight: 800; text-transform: uppercase;
  letter-spacing: 0.07em; padding: 0.18rem 0.5rem; border-radius: 99px;
}
.real-check {
  font-size: 18px; color: #10B981;
}
.real-check--bounce {
  animation: check-bounce 0.55s cubic-bezier(0.22, 1, 0.36, 1) both;
  animation-delay: 180ms;
}
.real-lock  { font-size: 18px; color: var(--text-muted); }

.real-nom  { font-size: 0.875rem; font-weight: 700; color: var(--text); line-height: 1.3; }
.real-desc { font-size: 0.75rem; color: var(--text-muted); line-height: 1.4; }

.real-bar-row { display: flex; align-items: center; gap: 0.6rem; margin-top: 0.25rem; }
.real-bar-wrap { flex: 1; height: 5px; background: var(--border); border-radius: 99px; overflow: hidden; }
.real-bar { height: 100%; border-radius: 99px; transition: width 0.7s cubic-bezier(0.22, 1, 0.36, 1); }
.real-pct  { font-size: 0.7rem; font-weight: 700; color: var(--text-muted); white-space: nowrap; }

.real-date { font-size: 0.68rem; color: var(--text-muted); font-style: italic; }
</style>
