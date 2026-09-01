<template>
  <div class="page fade-in">
    <h2 class="page-title">Statistiques</h2>

    <div v-if="chargement" class="loading">Chargement…</div>

    <template v-else-if="stats">
      <!-- Tuiles globales -->
      <div class="tuiles">
        <div class="tuile card">
          <div class="tuile-val">{{ stats.questions_vues }}</div>
          <div class="tuile-label">Questions vues</div>
        </div>
        <div class="tuile card">
          <div class="tuile-val" :style="{ color: couleurReussite(stats.reussite_globale) }">
            {{ pct(stats.reussite_globale) }}%
          </div>
          <div class="tuile-label">Réussite globale</div>
        </div>
        <div class="tuile card">
          <div class="tuile-val">{{ stats.nb_quiz }}</div>
          <div class="tuile-label">Quiz terminés</div>
        </div>
      </div>

      <!-- Message si aucune donnée -->
      <div v-if="stats.matieres.length === 0" class="vide">
        Lance un quiz pour voir tes statistiques ici !
      </div>

      <!-- Liste des matières -->
      <div v-else class="matieres-list">
        <div
          v-for="mat in stats.matieres"
          :key="mat.id"
          class="matiere-bloc card"
        >
          <!-- En-tête matière -->
          <div class="matiere-header" @click="toggle(mat.id)">
            <div class="matiere-info">
              <span class="matiere-nom">{{ mat.nom }}</span>
              <span class="matiere-niveau">{{ mat.niveau }}</span>
            </div>
            <div class="matiere-right">
              <span class="matiere-reussite" :style="{ color: couleurReussite(mat.reussite) }">
                {{ pct(mat.reussite) }}%
              </span>
              <span class="matiere-vues">{{ mat.nb_vues }} vues</span>
              <span class="chevron-icon">{{ ouvert.has(mat.id) ? '▲' : '▼' }}</span>
            </div>
          </div>

          <!-- Barre de maîtrise matière -->
          <div class="barre-wrap">
            <div class="barre" :style="{ width: pct(mat.reussite) + '%', background: couleurReussite(mat.reussite) }"></div>
          </div>

          <!-- Chapitres (accordéon) -->
          <div v-if="ouvert.has(mat.id)" class="chapitres-stats">
            <div
              v-for="chap in mat.chapitres"
              :key="chap.id"
              class="chap-row"
            >
              <div class="chap-titre">{{ chap.titre }}</div>
              <div class="chap-right">
                <div class="chap-barre-wrap">
                  <div
                    class="chap-barre"
                    :style="{ width: pct(chap.reussite) + '%', background: couleurReussite(chap.reussite) }"
                  ></div>
                </div>
                <span class="chap-pct" :style="{ color: couleurReussite(chap.reussite) }">
                  {{ pct(chap.reussite) }}%
                </span>
                <span class="chap-vues">{{ chap.nb_vues }}×</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getStats } from '../api/client.js'

const stats     = ref(null)
const chargement = ref(true)
const ouvert    = ref(new Set())

onMounted(async () => {
  stats.value = await getStats()
  chargement.value = false
})

function toggle(id) {
  if (ouvert.value.has(id)) ouvert.value.delete(id)
  else ouvert.value.add(id)
  ouvert.value = new Set(ouvert.value)  // déclenche la réactivité
}

function pct(v) { return Math.round((v ?? 0) * 100) }

function couleurReussite(v) {
  const p = (v ?? 0) * 100
  if (p >= 75) return 'var(--success)'
  if (p >= 45) return '#D97706'
  return 'var(--danger)'
}
</script>

<style scoped>
.page-title { font-size: 1.1rem; font-weight: 800; margin-bottom: 1.25rem; }
.loading    { text-align: center; color: var(--text-muted); padding: 3rem; }
.vide       { text-align: center; color: var(--text-muted); padding: 2rem; font-style: italic; }

/* Tuiles */
.tuiles { display: grid; grid-template-columns: repeat(3, 1fr); gap: 0.75rem; margin-bottom: 1.5rem; }
.tuile { text-align: center; padding: 1rem 0.5rem; }
.tuile-val   { font-size: 1.6rem; font-weight: 900; line-height: 1; font-variant-numeric: tabular-nums; }
.tuile-label { font-size: 0.72rem; font-weight: 600; color: var(--text-muted); margin-top: 0.35rem; text-transform: uppercase; letter-spacing: 0.06em; }

/* Matières */
.matieres-list { display: flex; flex-direction: column; gap: 0.75rem; }
.matiere-bloc  { padding: 1rem; }

.matiere-header {
  display: flex; align-items: center; justify-content: space-between;
  cursor: pointer; gap: 0.5rem; margin-bottom: 0.6rem;
}
.matiere-info { display: flex; flex-direction: column; gap: 0.15rem; min-width: 0; }
.matiere-nom  { font-weight: 700; font-size: 0.95rem; }
.matiere-niveau { font-size: 0.72rem; color: var(--text-muted); font-weight: 600; }
.matiere-right { display: flex; align-items: center; gap: 0.75rem; flex-shrink: 0; }
.matiere-reussite { font-weight: 900; font-size: 1.1rem; font-variant-numeric: tabular-nums; }
.matiere-vues { font-size: 0.75rem; color: var(--text-muted); font-weight: 600; }
.chevron-icon { font-size: 0.7rem; color: var(--text-muted); }

.barre-wrap { height: 6px; background: var(--border); border-radius: 99px; overflow: hidden; margin-bottom: 0.25rem; }
.barre { height: 100%; border-radius: 99px; transition: width 0.5s ease; }

/* Chapitres */
.chapitres-stats { margin-top: 0.75rem; display: flex; flex-direction: column; gap: 0.5rem; }
.chap-row  { display: flex; align-items: center; gap: 0.75rem; }
.chap-titre { font-size: 0.82rem; font-weight: 600; flex: 1; min-width: 0; }
.chap-right { display: flex; align-items: center; gap: 0.5rem; flex-shrink: 0; }
.chap-barre-wrap { width: 80px; height: 4px; background: var(--border); border-radius: 99px; overflow: hidden; }
.chap-barre { height: 100%; border-radius: 99px; transition: width 0.4s ease; }
.chap-pct  { font-size: 0.78rem; font-weight: 800; width: 2.8rem; text-align: right; font-variant-numeric: tabular-nums; }
.chap-vues { font-size: 0.72rem; color: var(--text-muted); width: 2.2rem; }
</style>
