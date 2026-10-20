<template>
  <div class="real-wrap fade-in">
    <div class="real-inner">

      <div class="real-header">
        <h1 class="real-titre">🏆 Réalisation</h1>
        <p class="real-sous">Débloque des récompenses en jouant et en relevant des défis.</p>
      </div>

      <div class="groupes-row">
        <button v-for="g in GROUPES" :key="g.key"
          class="groupe-btn" :class="{ active: groupeActif === g.key }"
          @click="groupeActif = g.key">
          {{ g.emoji }} {{ g.label }}
        </button>
      </div>

      <SkeletonBlock v-if="chargement" :lignes="3" hauteur="88px" />
      <template v-else>
        <div v-if="!realisationsFiltrees.length" class="vide-msg">Aucune réalisation pour ce groupe.</div>
        <div v-else class="realisations-grid">
          <RealisationCard v-for="(r, i) in realisationsFiltrees" :key="r.id" :realisation="r" :index="i" />
        </div>
      </template>

    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { getRealisations } from '../api/client.js'
import RealisationCard from '../components/RealisationCard.vue'
import SkeletonBlock from '../components/SkeletonBlock.vue'

const GROUPES = [
  { key: null, emoji: '🔍', label: 'Tout' },
  { key: 'A',  emoji: '🌱', label: 'Premiers pas' },
  { key: 'B',  emoji: '📅', label: 'Régularité' },
  { key: 'C',  emoji: '💯', label: 'Performance' },
  { key: 'D',  emoji: '📦', label: 'Volume' },
  { key: 'E',  emoji: '🌟', label: 'Secrets' },
]

const groupeActif = ref(null)
const realisations = ref([])
const chargement = ref(false)

const realisationsFiltrees = computed(() => {
  if (!groupeActif.value) return realisations.value
  return realisations.value.filter(r => r.groupe === groupeActif.value)
})

onMounted(async () => {
  chargement.value = true
  try { realisations.value = await getRealisations() } catch {}
  chargement.value = false
})
</script>

<style scoped>
.real-wrap { padding: 1.5rem 1rem 3rem; }
@media (min-width: 768px) { .real-wrap { padding: 2rem 2rem 3rem; } }
.real-inner { max-width: 900px; margin: 0 auto; display: flex; flex-direction: column; gap: 1.5rem; }

.real-titre { font-size: 1.5rem; font-weight: 800; color: var(--text); margin-bottom: 0.25rem; }
.real-sous  { font-size: 0.875rem; color: var(--text-muted); }

.groupes-row { display: flex; gap: 0.5rem; flex-wrap: wrap; }
.groupe-btn {
  padding: 0.35rem 0.8rem; border-radius: 99px;
  font-size: 0.8rem; font-weight: 600; border: 1px solid var(--border);
  cursor: pointer; background: var(--bg); color: var(--text-muted);
  transition: background 0.12s, color 0.12s, border-color 0.12s;
}
.groupe-btn:hover { border-color: var(--primary); color: var(--primary); }
.groupe-btn.active { background: var(--primary); color: #fff; border-color: var(--primary); }

.realisations-grid {
  display: grid; gap: 0.75rem;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
}

.vide-msg { color: var(--text-muted); font-size: 0.875rem; padding: 1rem 0; }

.fade-in { animation: fadeIn 0.3s ease; }
@keyframes fadeIn { from { opacity: 0; transform: translateY(8px); } to { opacity: 1; transform: none; } }
</style>
