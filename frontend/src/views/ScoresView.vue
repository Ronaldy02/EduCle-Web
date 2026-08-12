<template>
  <div class="page fade-in">
    <h2 class="section-title">Historique des scores</h2>

    <div v-if="chargement" class="loading">Chargement…</div>
    <div v-else-if="scores.length === 0" class="empty">Aucun score enregistré. Lance un quiz !</div>
    <div v-else class="scores-list">
      <div v-for="s in scores" :key="s.id" class="score-row card">
        <div class="score-info">
          <span class="score-mode-badge">{{ s.mode_nom }}</span>
          <span class="score-fraction">{{ s.nb_correctes }} / {{ s.nb_total }}</span>
          <span class="score-pct" :class="couleurPct(s)">{{ pct(s) }}%</span>
        </div>
        <p class="score-date">{{ formatDate(s.date) }}</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getScores } from '../api/client.js'

const scores = ref([])
const chargement = ref(true)

onMounted(async () => {
  scores.value = await getScores()
  chargement.value = false
})

function pct(s) { return Math.round(s.nb_correctes / s.nb_total * 100) }
function couleurPct(s) {
  const p = pct(s)
  if (p >= 80) return 'vert'
  if (p >= 50) return 'orange'
  return 'rouge'
}
function formatDate(iso) {
  try { return new Date(iso).toLocaleString('fr-FR', { dateStyle: 'medium', timeStyle: 'short' }) }
  catch { return iso }
}
</script>

<style scoped>
.section-title { font-weight: 800; font-size: 1rem; margin: 1.25rem 0 0.75rem; }
.loading, .empty { text-align: center; color: var(--text-muted); padding: 2rem; }

.scores-list { display: flex; flex-direction: column; gap: 0.5rem; }
.score-row { padding: 0.85rem 1.1rem; }
.score-info { display: flex; align-items: center; gap: 1rem; }
.score-mode-badge {
  background: var(--primary-light); color: var(--primary);
  font-size: 0.78rem; font-weight: 700; padding: 0.2rem 0.55rem; border-radius: 99px;
}
.score-fraction { font-weight: 700; }
.score-pct { font-weight: 800; margin-left: auto; }
.score-pct.vert   { color: var(--success); }
.score-pct.orange { color: #D97706; }
.score-pct.rouge  { color: var(--danger); }
.score-date { font-size: 0.8rem; color: var(--text-muted); margin-top: 0.25rem; }
</style>
