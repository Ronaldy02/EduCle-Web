<template>
  <div class="sc-wrap fade-in">

    <!-- ── Onglets ─────────────────────────────────────────────────────────── -->
    <div class="sc-tabs">
      <button class="sc-tab" :class="{ active: onglet === 'classement' }" @click="onglet = 'classement'">
        🏆 Classement
      </button>
      <button class="sc-tab" :class="{ active: onglet === 'historique' }" @click="onglet = 'historique'">
        📋 Historique
      </button>
    </div>

    <!-- ════════════════════════════════════════════════════════════════════ -->
    <!-- ONGLET CLASSEMENT                                                   -->
    <!-- ════════════════════════════════════════════════════════════════════ -->
    <div v-if="onglet === 'classement'" class="sc-panel">

      <!-- Filtres période -->
      <div class="sc-filter-section">
        <div class="sc-filter-label">Période</div>
        <div class="sc-chips">
          <button v-for="p in periodes" :key="p.val"
            class="sc-chip" :class="{ active: periode === p.val }"
            @click="periode = p.val; chargerClassement()">
            {{ p.label }}
          </button>
        </div>
      </div>

      <!-- Filtres matière -->
      <div class="sc-filter-section">
        <div class="sc-filter-label">Matière</div>
        <div class="sc-chips sc-chips-wrap">
          <button class="sc-chip" :class="{ active: matiereId === null }"
            @click="matiereId = null; chargerClassement()">
            Toutes
          </button>
          <button v-for="m in matieres" :key="m.id"
            class="sc-chip" :class="{ active: matiereId === m.id }"
            @click="matiereId = m.id; chargerClassement()">
            {{ m.nom }}
          </button>
        </div>
      </div>

      <!-- Zone de l'utilisateur -->
      <div v-if="userZone" class="sc-zone-pill">
        📍 {{ userZone }}
      </div>

      <!-- Chargement -->
      <div v-if="chargClst" class="sc-empty">Chargement…</div>

      <!-- Vide -->
      <div v-else-if="classement.length === 0" class="sc-empty">
        Aucun quiz {{ periodeLabel }} pour ce filtre. Lance un quiz !
      </div>

      <template v-else>
        <!-- Podium top 3 -->
        <div class="sc-podium" v-if="classement.length >= 1">
          <div v-if="classement.length >= 2" class="sc-podium-place place-2">
            <div class="sc-pod-medal">🥈</div>
            <div class="sc-pod-score">{{ classement[1].score }}</div>
            <div class="sc-pod-sub">{{ classement[1].nb_correctes }}/{{ classement[1].nb_total }}</div>
            <div class="sc-pod-block p2-block">
              <div class="sc-pod-pseudo">{{ classement[1].pseudo }}</div>
              <div class="sc-pod-zone">{{ classement[1].zone }}</div>
            </div>
          </div>
          <div class="sc-podium-place place-1">
            <div class="sc-pod-medal">🥇</div>
            <div class="sc-pod-score">{{ classement[0].score }}</div>
            <div class="sc-pod-sub">{{ classement[0].nb_correctes }}/{{ classement[0].nb_total }}</div>
            <div class="sc-pod-block p1-block">
              <div class="sc-pod-pseudo">{{ classement[0].pseudo }}</div>
              <div class="sc-pod-zone">{{ classement[0].zone }}</div>
            </div>
          </div>
          <div v-if="classement.length >= 3" class="sc-podium-place place-3">
            <div class="sc-pod-medal">🥉</div>
            <div class="sc-pod-score">{{ classement[2].score }}</div>
            <div class="sc-pod-sub">{{ classement[2].nb_correctes }}/{{ classement[2].nb_total }}</div>
            <div class="sc-pod-block p3-block">
              <div class="sc-pod-pseudo">{{ classement[2].pseudo }}</div>
              <div class="sc-pod-zone">{{ classement[2].zone }}</div>
            </div>
          </div>
        </div>

        <!-- Liste au-delà du podium -->
        <div v-if="classement.length > 3" class="sc-rank-list">
          <div v-for="e in classement.slice(3)" :key="e.rang" class="sc-rank-row">
            <span class="sc-rank-num">#{{ e.rang }}</span>
            <div class="sc-rank-info">
              <span class="sc-rank-pseudo">{{ e.pseudo }}</span>
              <span class="sc-rank-zone">{{ e.zone }}</span>
            </div>
            <div class="sc-rank-right">
              <span class="sc-rank-score">{{ e.score }}</span>
              <span class="sc-rank-pct" :class="couleurPct(e)">{{ pct(e) }}%</span>
            </div>
          </div>
        </div>

        <!-- Détails du top 1 -->
        <div class="sc-top1-detail">
          <div class="sc-detail-row">
            <span class="sc-detail-lbl">Mode</span>
            <span class="sc-detail-val">{{ classement[0].mode_nom }}</span>
          </div>
          <div v-if="classement[0].matiere_nom" class="sc-detail-row">
            <span class="sc-detail-lbl">Matière</span>
            <span class="sc-detail-val">{{ classement[0].matiere_nom }}</span>
          </div>
          <div class="sc-detail-row">
            <span class="sc-detail-lbl">Date</span>
            <span class="sc-detail-val">{{ formatDate(classement[0].date) }}</span>
          </div>
        </div>
      </template>
    </div>

    <!-- ════════════════════════════════════════════════════════════════════ -->
    <!-- ONGLET HISTORIQUE                                                   -->
    <!-- ════════════════════════════════════════════════════════════════════ -->
    <div v-if="onglet === 'historique'" class="sc-panel">
      <div v-if="chargHist" class="sc-empty">Chargement…</div>
      <div v-else-if="scores.length === 0" class="sc-empty">
        Aucun score enregistré. Lance un quiz !
      </div>
      <div v-else class="sc-hist-list">
        <div v-for="s in scores" :key="s.id" class="sc-hist-row card">
          <div class="sc-hist-top">
            <span class="sc-mode-badge">{{ s.mode_nom }}</span>
            <span class="sc-hist-fraction">{{ s.nb_correctes }} / {{ s.nb_total }}</span>
            <span class="sc-hist-pct" :class="couleurPct(s)">{{ pct(s) }}%</span>
          </div>
          <div class="sc-hist-bot">
            <span class="sc-hist-score">🏅 {{ s.score }} pts</span>
            <span class="sc-hist-date">{{ formatDate(s.date) }}</span>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { getScores, getClassement, getMatieres, getProfil } from '../api/client.js'

const onglet   = ref('classement')
const periode  = ref('general')
const matiereId = ref(null)

const classement = ref([])
const scores     = ref([])
const matieres   = ref([])
const userZone   = ref('')
const chargClst  = ref(true)
const chargHist  = ref(true)

const periodes = [
  { val: 'semaine', label: 'Cette semaine' },
  { val: 'mois',   label: 'Ce mois' },
  { val: 'annee',  label: 'Cette année' },
  { val: 'general', label: 'Général' },
]

const periodeLabel = computed(() => {
  const p = periodes.find(p => p.val === periode.value)
  return p ? `(${p.label.toLowerCase()})` : ''
})

onMounted(async () => {
  const [mat, profil] = await Promise.all([getMatieres(), getProfil()])
  matieres.value = mat
  userZone.value = profil.zone || ''
  await Promise.all([chargerClassement(), chargerHistorique()])
})

async function chargerClassement() {
  chargClst.value = true
  const params = { periode: periode.value }
  if (matiereId.value !== null) params.matiere_id = matiereId.value
  classement.value = await getClassement(params)
  chargClst.value = false
}

async function chargerHistorique() {
  chargHist.value = true
  scores.value = await getScores()
  chargHist.value = false
}

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
.sc-wrap { padding: 0 1rem 3rem; max-width: 680px; margin: 0 auto; }

/* ── Onglets ── */
.sc-tabs {
  display: flex; gap: 4px;
  background: var(--bg); border-bottom: 2px solid var(--border);
  margin: 0 -1rem 1.25rem; padding: 0.75rem 1rem 0;
  position: sticky; top: 0; z-index: 10;
}
.sc-tab {
  flex: 1; padding: 0.55rem 0.5rem; border: none; background: none;
  font-size: 0.88rem; font-weight: 700; color: var(--text-muted);
  border-bottom: 3px solid transparent; cursor: pointer;
  transition: color .12s, border-color .12s;
  margin-bottom: -2px;
}
.sc-tab.active { color: var(--primary); border-bottom-color: var(--primary); }

.sc-panel { padding-top: 0.25rem; }

/* ── Filtres ── */
.sc-filter-section { margin-bottom: 1rem; }
.sc-filter-label {
  font-size: 0.7rem; font-weight: 800; text-transform: uppercase;
  letter-spacing: 0.07em; color: var(--text-muted); margin-bottom: 0.5rem;
}
.sc-chips { display: flex; gap: 0.4rem; flex-wrap: nowrap; overflow-x: auto; padding-bottom: 2px; }
.sc-chips-wrap { flex-wrap: wrap; }
.sc-chip {
  flex-shrink: 0; padding: 0.38rem 0.85rem; border-radius: 99px;
  background: var(--bg); border: 1.5px solid var(--border);
  font-weight: 700; font-size: 0.8rem; color: var(--text-muted);
  cursor: pointer; transition: all .12s; white-space: nowrap;
}
.sc-chip:hover:not(.active) { border-color: var(--primary); color: var(--text); }
.sc-chip.active { background: var(--primary); border-color: var(--primary); color: #fff; }

/* Zone pill */
.sc-zone-pill {
  display: inline-flex; align-items: center; gap: 4px;
  background: var(--primary-light); color: var(--primary);
  font-size: 0.78rem; font-weight: 700; padding: 0.3rem 0.75rem;
  border-radius: 99px; margin-bottom: 1.25rem;
}

/* Vide / loading */
.sc-empty { text-align: center; color: var(--text-muted); padding: 2.5rem 1rem; font-size: 0.9rem; }

/* ── Podium ── */
.sc-podium {
  display: flex; align-items: flex-end; justify-content: center;
  gap: 10px; margin: 0.5rem 0 1.5rem;
}
.sc-podium-place { display: flex; flex-direction: column; align-items: center; flex: 1; max-width: 120px; }
.sc-pod-medal  { font-size: 1.6rem; line-height: 1; margin-bottom: 4px; }
.sc-pod-score  { font-size: 1.3rem; font-weight: 800; color: var(--text); line-height: 1.1; }
.sc-pod-sub    { font-size: 0.72rem; font-weight: 700; color: var(--text-muted); margin-bottom: 6px; }
.sc-pod-block  {
  width: 100%; border-radius: 12px 12px 0 0;
  display: flex; flex-direction: column; align-items: center;
  padding: 10px 8px 14px;
}
.p1-block { background: linear-gradient(160deg,#ffd700 0%,#ffb800 100%); min-height: 90px; }
.p2-block { background: linear-gradient(160deg,#d8d8d8 0%,#b8b8b8 100%); min-height: 70px; }
.p3-block { background: linear-gradient(160deg,#e8a87c 0%,#c97950 100%); min-height: 55px; }
.sc-pod-pseudo { font-size: 0.82rem; font-weight: 800; color: #fff; text-align: center; }
.sc-pod-zone   { font-size: 0.68rem; font-weight: 600; color: rgba(255,255,255,0.8); text-align: center; }

/* ── Liste rang 4+ ── */
.sc-rank-list { display: flex; flex-direction: column; gap: 6px; margin-bottom: 1rem; }
.sc-rank-row  {
  display: flex; align-items: center; gap: 10px;
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 10px; padding: 0.65rem 0.9rem;
}
.sc-rank-num  { font-size: 0.78rem; font-weight: 800; color: var(--text-muted); min-width: 28px; }
.sc-rank-info { flex: 1; display: flex; flex-direction: column; gap: 1px; }
.sc-rank-pseudo { font-size: 0.85rem; font-weight: 700; color: var(--text); }
.sc-rank-zone   { font-size: 0.72rem; color: var(--text-muted); }
.sc-rank-right  { display: flex; flex-direction: column; align-items: flex-end; gap: 1px; }
.sc-rank-score  { font-size: 0.9rem; font-weight: 800; color: var(--text); }
.sc-rank-pct    { font-size: 0.75rem; font-weight: 700; }

/* ── Détail top 1 ── */
.sc-top1-detail {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 12px; padding: 0.85rem 1.1rem;
  display: flex; flex-direction: column; gap: 0.5rem;
}
.sc-detail-row { display: flex; justify-content: space-between; align-items: center; }
.sc-detail-lbl { font-size: 0.8rem; color: var(--text-muted); }
.sc-detail-val { font-size: 0.85rem; font-weight: 700; color: var(--text); }

/* ── Historique ── */
.sc-hist-list { display: flex; flex-direction: column; gap: 0.5rem; }
.sc-hist-row  { padding: 0.85rem 1.1rem; }
.sc-hist-top  { display: flex; align-items: center; gap: 0.75rem; margin-bottom: 0.3rem; }
.sc-mode-badge {
  background: var(--primary-light); color: var(--primary);
  font-size: 0.75rem; font-weight: 700; padding: 0.18rem 0.5rem; border-radius: 99px;
  white-space: nowrap;
}
.sc-hist-fraction { font-weight: 700; font-size: 0.88rem; }
.sc-hist-pct  { font-weight: 800; margin-left: auto; font-size: 0.9rem; }
.sc-hist-pct.vert   { color: var(--success); }
.sc-hist-pct.orange { color: #D97706; }
.sc-hist-pct.rouge  { color: var(--danger); }
.sc-hist-bot  { display: flex; justify-content: space-between; align-items: center; }
.sc-hist-score { font-size: 0.8rem; font-weight: 700; color: var(--primary); }
.sc-hist-date  { font-size: 0.78rem; color: var(--text-muted); }

/* pct colors partagées */
.vert   { color: var(--success); }
.orange { color: #D97706; }
.rouge  { color: var(--danger); }
</style>
