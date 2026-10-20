<template>
  <div class="defis-wrap fade-in">
    <div class="defis-inner">

      <!-- En-tête -->
      <div class="defis-header">
        <h1 class="defis-titre">🎯 Défis</h1>
        <p class="defis-sous">Relève des défis quotidiens, hebdomadaires et mensuels, et débloque des réalisations.</p>
      </div>

      <!-- Onglets -->
      <div class="tabs-row">
        <button v-for="t in TABS" :key="t.key"
          class="tab-btn" :class="{ active: ongletActif === t.key }"
          @click="ongletActif = t.key">
          <span class="tab-emoji">{{ t.emoji }}</span>
          <span class="tab-label">{{ t.label }}</span>
          <span v-if="t.key !== 'realisations' && badges[t.key]" class="tab-badge">{{ badges[t.key] }}</span>
        </button>
      </div>

      <!-- Contenu des onglets avec transition -->
      <Transition name="tab-fade" mode="out-in">
        <div :key="ongletActif" class="tab-content">

          <!-- Quotidiens -->
          <template v-if="ongletActif === 'quotidiens'">
            <SkeletonBlock v-if="chargement.quotidiens" :lignes="3" hauteur="88px" />
            <template v-else>
              <div v-if="!defisQuotidiens.length" class="vide-msg">Aucun défi aujourd'hui.</div>
              <div v-else class="defis-grid">
                <DefiCard v-for="(d, i) in defisQuotidiens" :key="d.id" :defi="d" :index="i" :periode="periodeJour" @done="rechargerQuotidiens" />
              </div>
            </template>
          </template>

          <!-- Hebdo -->
          <template v-else-if="ongletActif === 'hebdo'">
            <SkeletonBlock v-if="chargement.hebdo" :lignes="3" hauteur="88px" />
            <template v-else>
              <p class="periode-label">Semaine en cours</p>
              <div v-if="!defisHebdo.length" class="vide-msg">Aucun défi hebdomadaire.</div>
              <div v-else class="defis-grid">
                <DefiCard v-for="(d, i) in defisHebdo" :key="d.id" :defi="d" :index="i" :periode="d.periode" @done="rechargerHebdo" />
              </div>
            </template>
          </template>

          <!-- Mensuel -->
          <template v-else-if="ongletActif === 'mensuel'">
            <SkeletonBlock v-if="chargement.mensuel" :lignes="3" hauteur="88px" />
            <template v-else>
              <p class="periode-label">{{ moisCourant }}</p>
              <div v-if="!defisMensuels.length" class="vide-msg">Aucun défi mensuel.</div>
              <div v-else class="defis-grid">
                <DefiCard v-for="(d, i) in defisMensuels" :key="d.id" :defi="d" :index="i" :periode="d.periode" @done="rechargerMensuel" />
              </div>
            </template>
          </template>

        </div>
      </Transition>

    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { getDefisQuotidiens, getDefisHebdo, getDefisMensuels } from '../api/client.js'
import DefiCard from '../components/DefiCard.vue'

const TABS = [
  { key: 'quotidiens', emoji: '🌅', label: 'Quotidiens' },
  { key: 'hebdo',      emoji: '📅', label: 'Hebdo' },
  { key: 'mensuel',    emoji: '📆', label: 'Mensuel' },
]

const ongletActif = ref('quotidiens')
const defisQuotidiens = ref([])
const defisHebdo = ref([])
const defisMensuels = ref([])
const chargement = ref({ quotidiens: false, hebdo: false, mensuel: false })

const periodeJour = new Date().toISOString().slice(0, 10)
const moisCourant = new Date().toLocaleDateString('fr-FR', { month: 'long', year: 'numeric' })

const badges = computed(() => ({
  quotidiens: defisQuotidiens.value.filter(d => !d.complete).length || null,
  hebdo: defisHebdo.value.filter(d => !d.complete).length || null,
  mensuel: defisMensuels.value.filter(d => !d.complete).length || null,
}))

async function rechargerQuotidiens() {
  chargement.value.quotidiens = true
  try { defisQuotidiens.value = await getDefisQuotidiens() } catch {}
  chargement.value.quotidiens = false
}
async function rechargerHebdo() {
  chargement.value.hebdo = true
  try { defisHebdo.value = await getDefisHebdo() } catch {}
  chargement.value.hebdo = false
}
async function rechargerMensuel() {
  chargement.value.mensuel = true
  try { defisMensuels.value = await getDefisMensuels() } catch {}
  chargement.value.mensuel = false
}
watch(ongletActif, (val) => {
  if (val === 'quotidiens' && !defisQuotidiens.value.length) rechargerQuotidiens()
  if (val === 'hebdo'      && !defisHebdo.value.length)      rechargerHebdo()
  if (val === 'mensuel'    && !defisMensuels.value.length)    rechargerMensuel()
})

onMounted(rechargerQuotidiens)
</script>

<style scoped>
.defis-wrap { padding: 1.5rem 1rem 3rem; }
@media (min-width: 768px) { .defis-wrap { padding: 2rem 2rem 3rem; } }
.defis-inner { max-width: 900px; margin: 0 auto; display: flex; flex-direction: column; gap: 1.5rem; }

.defis-header { }
.defis-titre { font-size: 1.5rem; font-weight: 800; color: var(--text); margin-bottom: 0.25rem; }
.defis-sous { font-size: 0.875rem; color: var(--text-muted); }

/* ── Onglets ─────────────────────────────────────────────── */
.tabs-row {
  display: flex; gap: 0.5rem; flex-wrap: wrap;
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 14px; padding: 0.5rem;
}
.tab-btn {
  display: flex; align-items: center; gap: 0.4rem;
  padding: 0.45rem 0.9rem; border-radius: 10px;
  font-size: 0.85rem; font-weight: 700; border: none; cursor: pointer;
  background: transparent; color: var(--text-muted);
  transition: background 0.12s, color 0.12s;
  position: relative;
}
.tab-btn:hover { background: var(--bg); color: var(--text); }
.tab-btn.active { background: var(--primary); color: #fff; }
.tab-badge {
  background: #EF4444; color: #fff;
  border-radius: 99px; padding: 0 0.35rem;
  font-size: 0.65rem; font-weight: 800;
  min-width: 16px; height: 16px; display: flex; align-items: center; justify-content: center;
}

/* ── Content ─────────────────────────────────────────────── */
.tab-content { display: flex; flex-direction: column; gap: 1rem; }
.periode-label { font-size: 0.75rem; font-weight: 700; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.07em; }

.loading-row { display: flex; align-items: center; gap: 0.75rem; color: var(--text-muted); font-size: 0.875rem; }
.spinner {
  display: inline-block; width: 16px; height: 16px;
  border: 2px solid var(--border); border-top-color: var(--primary);
  border-radius: 50%; animation: spin 0.7s linear infinite;
}
@keyframes spin { to { transform: rotate(360deg); } }
.vide-msg { color: var(--text-muted); font-size: 0.875rem; padding: 1rem 0; }

/* ── Grilles ─────────────────────────────────────────────── */
.defis-grid {
  display: grid; gap: 0.75rem;
  grid-template-columns: 1fr;
}
@media (min-width: 640px) {
  .defis-grid { grid-template-columns: repeat(2, 1fr); }
}
.realisations-grid {
  display: grid; gap: 0.75rem;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
}

/* ── Filtres groupes ─────────────────────────────────────── */
.groupes-row { display: flex; gap: 0.5rem; flex-wrap: wrap; }
.groupe-btn {
  padding: 0.35rem 0.8rem; border-radius: 99px;
  font-size: 0.8rem; font-weight: 600; border: 1px solid var(--border);
  cursor: pointer; background: var(--bg); color: var(--text-muted);
  transition: background 0.12s, color 0.12s, border-color 0.12s;
}
.groupe-btn:hover { border-color: var(--primary); color: var(--primary); }
.groupe-btn.active { background: var(--primary); color: #fff; border-color: var(--primary); }

.fade-in { animation: fadeIn 0.3s ease; }
@keyframes fadeIn { from { opacity: 0; transform: translateY(8px); } to { opacity: 1; transform: none; } }

/* ── Transition onglets ──────────────────────────────────── */
.tab-fade-enter-active { transition: opacity 0.22s ease, transform 0.22s cubic-bezier(0.22, 1, 0.36, 1); }
.tab-fade-leave-active { transition: opacity 0.15s ease, transform 0.15s ease; }
.tab-fade-enter-from  { opacity: 0; transform: translateY(10px); }
.tab-fade-leave-to    { opacity: 0; transform: translateY(-6px); }
</style>
