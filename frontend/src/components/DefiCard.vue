<template>
  <div class="defi-card" :class="{ 'defi-card--done': defi.complete }">
    <div class="dc-top">
      <div class="dc-palier" :class="`palier-${defi.palier}`">
        {{ palierLabel }}
      </div>
      <span v-if="defi.complete" class="dc-check material-symbols-outlined">check_circle</span>
    </div>
    <p class="dc-nom">{{ defi.nom }}</p>
    <p class="dc-desc">{{ defi.description }}</p>
    <div class="dc-progres-row">
      <div class="dc-bar-wrap">
        <div class="dc-bar" :style="{ width: pct + '%' }"></div>
      </div>
      <span class="dc-pct-label">{{ defi.progres }} / {{ defi.cible }}</span>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  defi: { type: Object, required: true },
  periode: { type: String, default: '' },
})

const PALIER_LABELS = { 1: 'Facile', 2: 'Moyen', 3: 'Difficile' }
const palierLabel = computed(() => PALIER_LABELS[props.defi.palier] || '')
const pct = computed(() => {
  if (!props.defi.cible) return 0
  return Math.min(100, Math.round((props.defi.progres / props.defi.cible) * 100))
})
</script>

<style scoped>
.defi-card {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 14px; padding: 1rem;
  display: flex; flex-direction: column; gap: 0.5rem;
  transition: box-shadow 0.15s;
}
.defi-card:hover { box-shadow: 0 4px 16px rgba(0,0,0,0.07); }
.defi-card--done { opacity: 0.75; }

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

.dc-check { font-size: 20px; color: #10B981; }
.dc-nom { font-size: 0.9rem; font-weight: 700; color: var(--text); line-height: 1.3; }
.dc-desc { font-size: 0.78rem; color: var(--text-muted); line-height: 1.4; }

.dc-progres-row { display: flex; align-items: center; gap: 0.6rem; margin-top: 0.25rem; }
.dc-bar-wrap {
  flex: 1; height: 6px; background: var(--border); border-radius: 99px; overflow: hidden;
}
.dc-bar {
  height: 100%; border-radius: 99px; background: var(--primary);
  transition: width 0.4s ease;
}
.defi-card--done .dc-bar { background: #10B981; }
.dc-pct-label { font-size: 0.72rem; font-weight: 700; color: var(--text-muted); white-space: nowrap; }
</style>
