<template>
  <div class="page fade-in">
    <div v-if="!res" class="loading">Chargement…</div>
    <template v-else>
      <!-- Score principal -->
      <div class="card score-card" :class="{ parfait: res.score === res.total }">
        <div class="score-big">{{ res.score }} / {{ res.total }}</div>
        <div class="score-pct">{{ pct }}%</div>
        <p class="score-mode">Mode : {{ res.mode_nom }}</p>
        <div class="gains">
          <span>+{{ res.xp_gagne }} XP</span>
          <span>+{{ res.pieces_gagnees }} 🪙</span>
          <span v-if="res.serie_max >= 5" class="gains-serie">
            🔥 Série ×{{ res.serie_max }} +{{ res.serie_bonus }} 🪙
          </span>
        </div>
      </div>

      <!-- Niveau up -->
      <div v-if="niveauUp" class="card niveau-up fade-in">
        🎉 NIVEAU SUPÉRIEUR !
        <strong>{{ res.niveau_avant }} → {{ res.niveau_apres }}</strong>
      </div>

      <!-- Barre XP après -->
      <div class="card xp-recap">
        <div class="xp-bar-wrap">
          <div class="xp-bar" :style="{ width: (progression * 100) + '%' }"></div>
        </div>
        <p class="xp-label">{{ xpDans }} / {{ xpSuivant }} XP  · Niveau {{ res.niveau_apres }}</p>
      </div>

      <!-- Liste des questions -->
      <h3 class="section-title">Détail</h3>
      <div class="questions-list">
        <div
          v-for="q in res.questions"
          :key="q.question_id"
          class="q-item card"
          :class="{ correct: q.correcte, incorrect: !q.correcte }"
        >
          <div class="q-header">
            <span class="q-icon">{{ q.correcte ? '✓' : '✗' }}</span>
            <span class="q-enonce">{{ q.enonce }}</span>
          </div>
          <p class="q-bonne">Bonne réponse : <strong>{{ q.bonne_reponse }}</strong></p>
          <p v-if="!q.correcte && q.reponse_donnee" class="q-donnee">
            Ta réponse : {{ q.reponse_donnee }}
          </p>
          <p class="q-explication">{{ q.explication }}</p>
          <p v-if="q.xp_gagne > 0" class="q-xp">+{{ q.xp_gagne }} XP</p>
        </div>
      </div>

      <div class="actions">
        <button class="btn-primary" @click="rejouer">Rejouer</button>
        <button class="btn-secondary" @click="accueil">Accueil</button>
      </div>
    </template>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useQuizStore } from '../stores/quiz.js'
import { niveauDepuisXp, progressionNiveau, xpPourNiveau } from '../utils/niveau.js'

const router = useRouter()
const quizStore = useQuizStore()
const res = computed(() => quizStore.resultat)

const pct = computed(() => res.value ? Math.round(res.value.score / res.value.total * 100) : 0)
const niveauUp = computed(() => res.value && res.value.niveau_apres > res.value.niveau_avant)

const progression = computed(() => res.value ? progressionNiveau(res.value.xp_total) : 0)
const nAp = computed(() => res.value ? res.value.niveau_apres : 1)
const xpDans = computed(() => res.value ? res.value.xp_total - xpPourNiveau(nAp.value) : 0)
const xpSuivant = computed(() => res.value ? xpPourNiveau(nAp.value + 1) - xpPourNiveau(nAp.value) : 100)

function rejouer() {
  quizStore.reset()
  router.push('/')
}

function accueil() {
  quizStore.reset()
  router.push('/')
}
</script>

<style scoped>
.loading { text-align: center; color: var(--text-muted); padding: 2rem; }

.score-card { text-align: center; margin-bottom: 1rem; padding: 2rem; }
.score-card.parfait { border: 2px solid #F59E0B; box-shadow: 0 0 24px rgba(245,158,11,0.2); }
.score-big { font-size: 3rem; font-weight: 900; color: var(--primary); }
.score-pct { font-size: 1.5rem; font-weight: 700; color: var(--text-muted); }
.score-mode { color: var(--text-muted); margin-top: 0.5rem; }
.gains { display: flex; justify-content: center; gap: 1.5rem; margin-top: 1rem; }
.gains span { font-weight: 800; font-size: 1.1rem; color: var(--success); }
.gains-serie { color: #B45309 !important; }

.niveau-up {
  text-align: center; font-weight: 800; font-size: 1rem;
  background: var(--primary-light); border: 2px solid var(--primary);
  color: var(--primary); margin-bottom: 1rem;
}
.niveau-up strong { margin-left: 0.5rem; font-size: 1.2rem; }

.xp-recap { margin-bottom: 1.5rem; }
.xp-bar-wrap { height: 8px; background: var(--border); border-radius: 99px; overflow: hidden; margin-bottom: 0.5rem; }
.xp-bar { height: 100%; background: var(--primary); border-radius: 99px; transition: width 0.6s ease; }
.xp-label { font-size: 0.82rem; color: var(--text-muted); }

.section-title { font-weight: 800; font-size: 1rem; margin-bottom: 0.75rem; }

.questions-list { display: flex; flex-direction: column; gap: 0.75rem; margin-bottom: 1.5rem; }
.q-item { padding: 1rem; }
.q-item.correct { border-left: 4px solid var(--success); }
.q-item.incorrect { border-left: 4px solid var(--danger); }
.q-header { display: flex; gap: 0.6rem; align-items: flex-start; margin-bottom: 0.4rem; }
.q-icon { font-weight: 900; font-size: 1rem; flex-shrink: 0; }
.q-enonce { font-weight: 600; font-size: 0.9rem; }
.q-bonne, .q-donnee, .q-explication, .q-xp { font-size: 0.85rem; color: var(--text-muted); margin-top: 0.2rem; }
.q-explication { font-style: italic; }
.q-xp { color: var(--success); font-weight: 700; }

.actions { display: flex; gap: 0.75rem; }
.actions button { flex: 1; }
</style>
