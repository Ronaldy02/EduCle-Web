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

      <!-- Filtres (menus déroulants) -->
      <div class="sc-filters">
        <div class="sc-select-wrap">
          <label class="sc-select-label">Période</label>
          <select class="sc-select" v-model="periode" @change="chargerClassement">
            <option value="semaine">Cette semaine</option>
            <option value="mois">Ce mois</option>
            <option value="annee">Cette année</option>
            <option value="general">Général</option>
          </select>
        </div>
        <div class="sc-select-wrap">
          <label class="sc-select-label">Matière</label>
          <select class="sc-select" v-model="matiereId" @change="chargerClassement">
            <option :value="null">Toutes les matières</option>
            <option v-for="m in matieres" :key="m.id" :value="m.id">{{ m.nom }}</option>
          </select>
        </div>
      </div>

      <!-- Zone de l'utilisateur -->
      <div v-if="userZone" class="sc-zone-pill">📍 {{ userZone }}</div>

      <!-- Sous-titre contextuel -->
      <div class="sc-context-lbl">
        {{ matiereId ? 'Classement par mode — ' + matiereNom : 'Classement par matière' }}
        <span class="sc-context-sub">· score total accumulé</span>
      </div>

      <!-- Chargement -->
      <div v-if="chargClst" class="sc-empty">Chargement…</div>

      <!-- Vide -->
      <div v-else-if="classement.length === 0" class="sc-empty">
        Aucune donnée pour cette sélection. Lance des quiz !
      </div>

      <template v-else>
        <!-- Podium top 3 -->
        <div class="sc-podium">
          <div v-if="classement[1]" class="sc-podium-place place-2">
            <div class="sc-pod-medal">🥈</div>
            <div class="sc-pod-score">{{ classement[1].score.toLocaleString('fr-FR') }}</div>
            <div class="sc-pod-pct">{{ pct(classement[1]) }}%</div>
            <div class="sc-pod-block p2-block">
              <div class="sc-pod-label">{{ classement[1].label }}</div>
              <div class="sc-pod-zone">{{ classement[1].nb_sessions }} quiz</div>
            </div>
          </div>
          <div class="sc-podium-place place-1">
            <div class="sc-pod-crown">👑</div>
            <div class="sc-pod-medal">🥇</div>
            <div class="sc-pod-score">{{ classement[0].score.toLocaleString('fr-FR') }}</div>
            <div class="sc-pod-pct">{{ pct(classement[0]) }}%</div>
            <div class="sc-pod-block p1-block">
              <div class="sc-pod-label">{{ classement[0].label }}</div>
              <div class="sc-pod-zone">{{ classement[0].nb_sessions }} quiz</div>
            </div>
          </div>
          <div v-if="classement[2]" class="sc-podium-place place-3">
            <div class="sc-pod-medal">🥉</div>
            <div class="sc-pod-score">{{ classement[2].score.toLocaleString('fr-FR') }}</div>
            <div class="sc-pod-pct">{{ pct(classement[2]) }}%</div>
            <div class="sc-pod-block p3-block">
              <div class="sc-pod-label">{{ classement[2].label }}</div>
              <div class="sc-pod-zone">{{ classement[2].nb_sessions }} quiz</div>
            </div>
          </div>
        </div>

        <!-- Liste rang 4+ -->
        <div v-if="classement.length > 3" class="sc-rank-list">
          <div v-for="e in classement.slice(3)" :key="e.rang" class="sc-rank-row">
            <span class="sc-rank-num">#{{ e.rang }}</span>
            <div class="sc-rank-info">
              <span class="sc-rank-label">{{ e.label }}</span>
              <span class="sc-rank-sub">{{ e.pseudo }} · {{ e.zone }}</span>
            </div>
            <div class="sc-rank-right">
              <span class="sc-rank-score">{{ e.score.toLocaleString('fr-FR') }}</span>
              <span class="sc-rank-pct" :class="couleurPct(e)">{{ pct(e) }}%</span>
            </div>
          </div>
        </div>

        <!-- Résumé total -->
        <div class="sc-total-card">
          <div class="sc-total-row">
            <span class="sc-total-lbl">Score total</span>
            <span class="sc-total-val">{{ scoreTotal.toLocaleString('fr-FR') }} pts</span>
          </div>
          <div class="sc-total-row">
            <span class="sc-total-lbl">Taux de réussite</span>
            <span class="sc-total-val" :class="couleurGlobal">{{ reussiteGlobale }}%</span>
          </div>
          <div class="sc-total-row">
            <span class="sc-total-lbl">Quiz comptés</span>
            <span class="sc-total-val">{{ totalSessions }}</span>
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

const onglet    = ref('classement')
const periode   = ref('general')
const matiereId = ref(null)

const classement = ref([])
const scores     = ref([])
const matieres   = ref([])
const userZone   = ref('')
const chargClst  = ref(true)
const chargHist  = ref(true)

const matiereNom = computed(() => {
  const m = matieres.value.find(m => m.id === matiereId.value)
  return m ? m.nom : ''
})

const scoreTotal = computed(() =>
  classement.value.reduce((s, e) => s + e.score, 0)
)
const totalSessions = computed(() =>
  classement.value.reduce((s, e) => s + e.nb_sessions, 0)
)
const reussiteGlobale = computed(() => {
  const totalQ = classement.value.reduce((s, e) => s + e.nb_total, 0)
  const totalC = classement.value.reduce((s, e) => s + e.nb_correctes, 0)
  return totalQ ? Math.round(totalC / totalQ * 100) : 0
})
const couleurGlobal = computed(() => {
  const r = reussiteGlobale.value
  if (r >= 80) return 'vert'
  if (r >= 50) return 'orange'
  return 'rouge'
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

function pct(s) {
  if (!s.nb_total) return 0
  return Math.round(s.nb_correctes / s.nb_total * 100)
}
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
  margin: 0 -1rem 1.5rem; padding: 0.75rem 1rem 0;
  position: sticky; top: 0; z-index: 10;
}
.sc-tab {
  flex: 1; padding: 0.55rem 0.5rem; border: none; background: none;
  font-size: 0.88rem; font-weight: 700; color: var(--text-muted);
  border-bottom: 3px solid transparent; cursor: pointer;
  transition: color .12s, border-color .12s; margin-bottom: -2px;
}
.sc-tab.active { color: var(--primary); border-bottom-color: var(--primary); }

.sc-panel { padding-top: 0.25rem; }

/* ── Filtres menus déroulants ── */
.sc-filters {
  display: flex; gap: 0.75rem; margin-bottom: 1.1rem; flex-wrap: wrap;
}
.sc-select-wrap { display: flex; flex-direction: column; gap: 0.3rem; flex: 1; min-width: 140px; }
.sc-select-label {
  font-size: 0.68rem; font-weight: 800; text-transform: uppercase;
  letter-spacing: 0.07em; color: var(--text-muted);
}
.sc-select {
  width: 100%; padding: 0.5rem 0.75rem;
  border: 1.5px solid var(--border); border-radius: 10px;
  background: var(--surface); color: var(--text);
  font-size: 0.85rem; font-weight: 600;
  cursor: pointer; appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%239aa1ad' d='M1 1l5 5 5-5'/%3E%3C/svg%3E");
  background-repeat: no-repeat; background-position: right 10px center;
  padding-right: 2rem;
}
.sc-select:focus { outline: none; border-color: var(--primary); }

/* Zone pill */
.sc-zone-pill {
  display: inline-flex; align-items: center; gap: 4px;
  background: var(--primary-light); color: var(--primary);
  font-size: 0.78rem; font-weight: 700;
  padding: 0.3rem 0.75rem; border-radius: 99px; margin-bottom: 0.75rem;
}

/* Sous-titre contextuel */
.sc-context-lbl {
  font-size: 0.8rem; font-weight: 700; color: var(--text); margin-bottom: 1.25rem;
}
.sc-context-sub { font-weight: 500; color: var(--text-muted); }

/* Vide / loading */
.sc-empty { text-align: center; color: var(--text-muted); padding: 2.5rem 1rem; font-size: 0.9rem; }

/* ── Podium ── */
.sc-podium {
  display: flex; align-items: flex-end; justify-content: center;
  gap: 8px; margin: 0.25rem 0 1.25rem;
}
.sc-podium-place { display: flex; flex-direction: column; align-items: center; flex: 1; max-width: 115px; }
.sc-pod-crown  { font-size: 1.1rem; line-height: 1; margin-bottom: 1px; }
.sc-pod-medal  { font-size: 1.45rem; line-height: 1; margin-bottom: 3px; }
.sc-pod-score  { font-size: 1.1rem; font-weight: 800; color: var(--text); line-height: 1.15; }
.sc-pod-pct    { font-size: 0.7rem; font-weight: 700; color: var(--text-muted); margin-bottom: 5px; }
.sc-pod-block  {
  width: 100%; border-radius: 10px 10px 0 0;
  display: flex; flex-direction: column; align-items: center;
  padding: 8px 6px 14px;
}
.p1-block { background: linear-gradient(160deg,#ffd700,#ffb800); min-height: 82px; }
.p2-block { background: linear-gradient(160deg,#d8d8d8,#b8b8b8); min-height: 64px; }
.p3-block { background: linear-gradient(160deg,#e8a87c,#c97950); min-height: 50px; }
.sc-pod-label { font-size: 0.78rem; font-weight: 800; color: #fff; text-align: center; line-height: 1.2; }
.sc-pod-zone  { font-size: 0.65rem; font-weight: 600; color: rgba(255,255,255,0.82); margin-top: 2px; }

/* ── Liste rang 4+ ── */
.sc-rank-list { display: flex; flex-direction: column; gap: 5px; margin-bottom: 1rem; }
.sc-rank-row {
  display: flex; align-items: center; gap: 10px;
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 10px; padding: 0.6rem 0.85rem;
}
.sc-rank-num   { font-size: 0.78rem; font-weight: 800; color: var(--text-muted); min-width: 26px; }
.sc-rank-info  { flex: 1; display: flex; flex-direction: column; gap: 1px; min-width: 0; }
.sc-rank-label { font-size: 0.85rem; font-weight: 700; color: var(--text); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.sc-rank-sub   { font-size: 0.7rem; color: var(--text-muted); }
.sc-rank-right { display: flex; flex-direction: column; align-items: flex-end; gap: 1px; }
.sc-rank-score { font-size: 0.88rem; font-weight: 800; color: var(--text); }
.sc-rank-pct   { font-size: 0.72rem; font-weight: 700; }

/* ── Résumé total ── */
.sc-total-card {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 12px; padding: 0.9rem 1.1rem;
  display: flex; flex-direction: column; gap: 0.55rem; margin-top: 0.25rem;
}
.sc-total-row  { display: flex; justify-content: space-between; align-items: center; }
.sc-total-lbl  { font-size: 0.82rem; color: var(--text-muted); }
.sc-total-val  { font-size: 0.88rem; font-weight: 800; color: var(--text); }

/* ── Historique ── */
.sc-hist-list { display: flex; flex-direction: column; gap: 0.5rem; }
.sc-hist-row  { padding: 0.85rem 1.1rem; }
.sc-hist-top  { display: flex; align-items: center; gap: 0.75rem; margin-bottom: 0.3rem; }
.sc-mode-badge {
  background: var(--primary-light); color: var(--primary);
  font-size: 0.75rem; font-weight: 700; padding: 0.18rem 0.5rem;
  border-radius: 99px; white-space: nowrap;
}
.sc-hist-fraction { font-weight: 700; font-size: 0.88rem; }
.sc-hist-pct  { font-weight: 800; margin-left: auto; font-size: 0.9rem; }
.sc-hist-bot  { display: flex; justify-content: space-between; align-items: center; }
.sc-hist-score { font-size: 0.8rem; font-weight: 700; color: var(--primary); }
.sc-hist-date  { font-size: 0.78rem; color: var(--text-muted); }

.vert   { color: var(--success); }
.orange { color: #D97706; }
.rouge  { color: var(--danger); }
</style>
