<template>
  <div class="defi-card" :class="{ 'defi-card--done': defi.complete }" :style="cardStyle">
    <div class="dc-top">
      <div class="dc-palier" :class="`palier-${defi.palier}`">
        {{ palierLabel }}
      </div>
      <span v-if="defi.complete" class="dc-check material-symbols-outlined dc-check--pulse">check_circle</span>
    </div>
    <p class="dc-nom">{{ defi.nom }}</p>
    <p class="dc-desc">{{ defi.description }}</p>
    <div class="dc-progres-row">
      <div class="dc-bar-wrap">
        <div class="dc-bar" :style="{ width: displayPct + '%' }"></div>
      </div>
      <span class="dc-pct-label">{{ defi.progres }} / {{ defi.cible }}</span>
    </div>
  </div>
</template>

<script setup>
import { computed, ref, onMounted } from 'vue'

const props = defineProps({
  defi: { type: Object, required: true },
  periode: { type: String, default: '' },
  index: { type: Number, default: 0 },
})

const PALIER_LABELS = { 1: 'Facile', 2: 'Moyen', 3: 'Difficile' }
const palierLabel = computed(() => PALIER_LABELS[props.defi.palier] || '')

const pct = computed(() => {
  if (!props.defi.cible) return 0
  return Math.min(100, Math.round((props.defi.progres / props.defi.cible) * 100))
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
  animationDelay: `${props.index * 60}ms`,
}))
</script>

<style scoped>
@keyframes card-in {
  from { opacity: 0; transform: translateY(14px); }
  to   { opacity: 1; transform: translateY(0); }
}

@keyframes check-pulse {
  0%   { transform: scale(1); }
  40%  { transform: scale(1.25); }
  70%  { transform: scale(0.95); }
  100% { transform: scale(1); }
}

.defi-card {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 14px; padding: 1rem;
  display: flex; flex-direction: column; gap: 0.5rem;
  transition: box-shadow 0.18s, border-color 0.18s, transform 0.15s;
  animation: card-in 0.38s cubic-bezier(0.22, 1, 0.36, 1) both;
  will-change: transform, opacity;
}
.defi-card:hover {
  box-shadow: 0 6px 20px rgba(0,0,0,0.08);
  transform: translateY(-2px);
}
.defi-card--done {
  opacity: 0.78;
  border-color: #10B98140;
  box-shadow: 0 0 0 1px #10B98120;
}

.dc-top { display: flex; align-items: center; justify-content: space-between; }
.dc-palier {
  font-size: 0.65rem; font-weight: 800; text-transform: uppercase;
  letter-spacing: 0.07em; padding: 0.2rem 0.55rem;
  border-radius: 99px;
}
.palier-1 { background: #D1FAE5; color: #065F46; }
.palier-2 { background: #FEF3C7; color: #92400E; }
.palier-3 { background: #FEE2E2; color: #991B1B; }
:root[data-theme="dark"] .palier-1 { background: #065F4633; color: #6EE7B7; }
:root[data-theme="dark"] .palier-2 { background: #92400E33; color: #FCD34D; }
:root[data-theme="dark"] .palier-3 { background: #991B1B33; color: #FCA5A5; }
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) .palier-1 { background: #065F4633; color: #6EE7B7; }
  :root:not([data-theme="light"]) .palier-2 { background: #92400E33; color: #FCD34D; }
  :root:not([data-theme="light"]) .palier-3 { background: #991B1B33; color: #FCA5A5; }
}

.dc-check {
  font-size: 20px; color: #10B981;
}
.dc-check--pulse {
  animation: check-pulse 0.55s cubic-bezier(0.22, 1, 0.36, 1) both;
  animation-delay: calc(var(--card-index, 0) * 60ms + 300ms);
}

.dc-nom  { font-size: 0.9rem; font-weight: 700; color: var(--text); line-height: 1.3; }
.dc-desc { font-size: 0.78rem; color: var(--text-muted); line-height: 1.4; }

.dc-progres-row { display: flex; align-items: center; gap: 0.6rem; margin-top: 0.25rem; }
.dc-bar-wrap {
  flex: 1; height: 6px; background: var(--border); border-radius: 99px; overflow: hidden;
}
.dc-bar {
  height: 100%; border-radius: 99px; background: var(--primary);
  transition: width 0.7s cubic-bezier(0.22, 1, 0.36, 1);
}
.defi-card--done .dc-bar { background: #10B981; }
.dc-pct-label { font-size: 0.72rem; font-weight: 700; color: var(--text-muted); white-space: nowrap; }
</style>
