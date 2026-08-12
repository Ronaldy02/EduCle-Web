<template>
  <div class="page fade-in">
    <h2 class="section-title">Mon profil</h2>

    <div v-if="niveau" class="card profil-card">
      <div class="rang-hero" :style="{ color: niveau.rang_couleur }">
        <span class="rang-emoji">{{ niveau.rang_emoji }}</span>
        <div>
          <div class="rang-nom">{{ niveau.rang_nom }}</div>
          <div class="niveau-label">Niveau {{ niveau.niveau }}</div>
        </div>
      </div>
      <div class="xp-bar-wrap">
        <div class="xp-bar" :style="{ width: (niveau.progression * 100) + '%', background: niveau.rang_couleur }"></div>
      </div>
      <p class="xp-label">{{ niveau.xp_dans_niveau }} / {{ niveau.xp_pour_suivant }} XP · 🪙 {{ niveau.pieces_total }}</p>
    </div>

    <!-- Réalisations -->
    <h3 class="section-title">Réalisations</h3>
    <div v-if="realisations.length === 0" class="empty">Aucune réalisation pour l'instant.</div>
    <div class="realisations-grid">
      <div
        v-for="r in realisations"
        :key="r.id"
        class="real-card card"
        :class="{ debloquee: r.debloquee }"
      >
        <div class="real-header">
          <span class="real-rarete" :class="'rarete-' + r.rarete">{{ rareteLabel(r.rarete) }}</span>
          <span v-if="r.debloquee" class="real-check">✓</span>
        </div>
        <p class="real-nom">{{ r.nom }}</p>
        <p class="real-desc">{{ r.description }}</p>
        <div class="real-progress-wrap">
          <div class="real-progress" :style="{ width: Math.min(r.progres / r.objectif, 1) * 100 + '%' }"></div>
        </div>
        <p class="real-pct">{{ r.progres }} / {{ r.objectif }}</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getNiveau, getRealisations } from '../api/client.js'

const niveau = ref(null)
const realisations = ref([])

onMounted(async () => {
  const [niv, real] = await Promise.all([getNiveau(), getRealisations()])
  niveau.value = niv
  realisations.value = real
})

const rareteLabels = ['Commune', 'Peu commune', 'Rare', 'Épique', 'Légendaire']
function rareteLabel(r) { return rareteLabels[r] ?? 'Commune' }
</script>

<style scoped>
.section-title { font-weight: 800; font-size: 1rem; margin: 1.25rem 0 0.75rem; }

.profil-card { margin-bottom: 1.5rem; }
.rang-hero { display: flex; align-items: center; gap: 1rem; margin-bottom: 1rem; }
.rang-emoji { font-size: 2.5rem; }
.rang-nom { font-size: 1.3rem; font-weight: 900; }
.niveau-label { font-weight: 600; color: var(--text-muted); }
.xp-bar-wrap { height: 8px; background: var(--border); border-radius: 99px; overflow: hidden; margin-bottom: 0.5rem; }
.xp-bar { height: 100%; border-radius: 99px; transition: width 0.4s; }
.xp-label { font-size: 0.82rem; color: var(--text-muted); }

.empty { color: var(--text-muted); font-style: italic; margin-bottom: 1rem; }

.realisations-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 0.75rem; }
.real-card { opacity: 0.55; padding: 1rem; }
.real-card.debloquee { opacity: 1; }
.real-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem; }
.real-check { color: var(--success); font-weight: 900; }
.real-rarete { font-size: 0.75rem; font-weight: 700; padding: 0.2rem 0.5rem; border-radius: 99px; }
.rarete-0 { background: #F3F4F6; color: var(--text-muted); }
.rarete-1 { background: #D1FAE5; color: #059669; }
.rarete-2 { background: #DBEAFE; color: #2563EB; }
.rarete-3 { background: #EDE9FE; color: #7C3AED; }
.rarete-4 { background: #FEF3C7; color: #B45309; }
.real-nom { font-weight: 700; font-size: 0.9rem; margin-bottom: 0.25rem; }
.real-desc { font-size: 0.8rem; color: var(--text-muted); margin-bottom: 0.5rem; }
.real-progress-wrap { height: 5px; background: var(--border); border-radius: 99px; overflow: hidden; margin-bottom: 0.25rem; }
.real-progress { height: 100%; background: var(--primary); border-radius: 99px; }
.real-pct { font-size: 0.75rem; color: var(--text-muted); }
</style>
