<template>
  <div class="real-card" :class="{ 'real-card--done': realisation.debloquee, 'real-card--secret': isSecret }">
    <div class="real-top">
      <span class="real-rarete" :style="{ background: rareté.bg, color: rareté.fg }">{{ rareté.label }}</span>
      <span v-if="realisation.debloquee" class="real-check material-symbols-outlined">check_circle</span>
      <span v-else-if="isSecret" class="real-lock material-symbols-outlined">lock</span>
    </div>
    <p class="real-nom">{{ isSecret && !realisation.debloquee ? '???' : realisation.nom }}</p>
    <p class="real-desc">{{ isSecret && !realisation.debloquee ? 'Réalisation secrète — continue à jouer pour la découvrir.' : realisation.description }}</p>
    <div v-if="!isSecret || realisation.debloquee" class="real-bar-row">
      <div class="real-bar-wrap">
        <div class="real-bar" :style="{ width: pct + '%', background: rareté.color }"></div>
      </div>
      <span class="real-pct">{{ realisation.progres }} / {{ realisation.cible }}</span>
    </div>
    <p v-if="realisation.debloquee && realisation.debloque_le" class="real-date">
      {{ formatDate(realisation.debloque_le) }}
    </p>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  realisation: { type: Object, required: true },
})

const RARETES = [
  { label: 'Commune',    bg: '#F3F4F6', fg: '#6B7280', color: '#9CA3AF' },
  { label: 'Rare',       bg: '#DBEAFE', fg: '#1D4ED8', color: '#3B82F6' },
  { label: 'Épique',     bg: '#EDE9FE', fg: '#6D28D9', color: '#8B5CF6' },
  { label: 'Légendaire', bg: '#FEF3C7', fg: '#B45309', color: '#F59E0B' },
  { label: 'Mythique',   bg: '#FEE2E2', fg: '#991B1B', color: '#EF4444' },
]

const rareté = computed(() => RARETES[Math.max(0, (props.realisation.rarete || 1) - 1)])

const isSecret = computed(() => !!props.realisation.secret)

const pct = computed(() => {
  const c = props.realisation.cible
  if (!c) return 0
  return Math.min(100, Math.round((props.realisation.progres / c) * 100))
})

function formatDate(iso) {
  try {
    return new Date(iso).toLocaleDateString('fr-FR', { day: 'numeric', month: 'short', year: 'numeric' })
  } catch { return '' }
}
</script>

<style scoped>
.real-card {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 14px; padding: 1rem;
  display: flex; flex-direction: column; gap: 0.4rem;
  transition: box-shadow 0.15s;
}
.real-card:hover { box-shadow: 0 4px 16px rgba(0,0,0,0.07); }
.real-card--done { border-color: #10B98144; }
.real-card--secret:not(.real-card--done) { opacity: 0.65; }

.real-top { display: flex; align-items: center; justify-content: space-between; }
.real-rarete {
  font-size: 0.62rem; font-weight: 800; text-transform: uppercase;
  letter-spacing: 0.07em; padding: 0.18rem 0.5rem; border-radius: 99px;
}
.real-check { font-size: 18px; color: #10B981; }
.real-lock  { font-size: 18px; color: var(--text-muted); }

.real-nom  { font-size: 0.875rem; font-weight: 700; color: var(--text); line-height: 1.3; }
.real-desc { font-size: 0.75rem; color: var(--text-muted); line-height: 1.4; }

.real-bar-row { display: flex; align-items: center; gap: 0.6rem; margin-top: 0.25rem; }
.real-bar-wrap { flex: 1; height: 5px; background: var(--border); border-radius: 99px; overflow: hidden; }
.real-bar { height: 100%; border-radius: 99px; transition: width 0.4s ease; }
.real-pct  { font-size: 0.7rem; font-weight: 700; color: var(--text-muted); white-space: nowrap; }

.real-date { font-size: 0.68rem; color: var(--text-muted); font-style: italic; }
</style>
