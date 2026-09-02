<template>
  <div class="rv-wrap">
    <div v-if="!res" class="rv-vide">
      Aucun résultat à afficher.
      <router-link to="/" class="rv-lien">Retour à l'accueil</router-link>
    </div>

    <div v-else class="rv-inner">

      <!-- En-tête -->
      <div class="rv-header">
        <button class="rv-retour" @click="$router.back()">
          <span class="material-symbols-outlined">arrow_back</span>
          Résultats
        </button>
        <h1 class="rv-titre">Révision de tes réponses</h1>
        <p class="rv-sous-titre">{{ sousTitre }}</p>
      </div>

      <!-- Liste des questions -->
      <div class="rv-liste">
        <div
          v-for="(q, i) in res.questions"
          :key="q.question_id"
          class="rv-carte"
        >
          <!-- Numéro + badge -->
          <div class="rv-carte-head">
            <span class="rv-num">QUESTION {{ i + 1 }}</span>
            <span class="rv-badge" :class="q.correcte ? 'rv-badge-ok' : 'rv-badge-ko'">
              {{ q.correcte ? 'Correct' : 'Incorrect' }}
            </span>
          </div>

          <!-- Énoncé -->
          <p class="rv-enonce">{{ q.enonce }}</p>

          <!-- Réponses -->
          <div class="rv-reponses">
            <div class="rv-ligne-rep" :class="q.correcte ? 'rv-rep-ok' : 'rv-rep-ko'">
              <span class="rv-rep-lib">Ta réponse</span>
              <span class="rv-rep-val">{{ q.reponse_donnee || 'Aucune réponse' }}</span>
            </div>
            <div v-if="!q.correcte" class="rv-ligne-rep rv-rep-ok">
              <span class="rv-rep-lib">Bonne réponse</span>
              <span class="rv-rep-val">{{ q.bonne_reponse }}</span>
            </div>
          </div>

          <!-- Explication -->
          <div v-if="q.explication" class="rv-expl-wrap">
            <p class="rv-expl-label">Explication</p>
            <p class="rv-expl-texte">{{ q.explication }}</p>
          </div>

          <!-- XP -->
          <p v-if="q.xp_gagne > 0" class="rv-xp">+{{ q.xp_gagne }} XP</p>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useQuizStore } from '../stores/quiz.js'

const quizStore = useQuizStore()
const res = computed(() => quizStore.resultat)

const sousTitre = computed(() => {
  if (!res.value) return ''
  const score = `${res.value.score}/${res.value.total} bonnes réponses`
  const mat = quizStore.matNom
  return mat ? `${score} · ${mat}` : score
})
</script>

<style scoped>
.rv-wrap {
  min-height: calc(100dvh - 64px);
  background: var(--bg);
  padding-bottom: 3rem;
}

.rv-vide {
  display: flex; flex-direction: column; align-items: center;
  gap: 1rem; padding: 3rem 1.25rem;
  color: var(--text-muted); font-size: 0.95rem;
}
.rv-lien { color: var(--primary); font-weight: 700; text-decoration: none; }

/* ── Inner ──────────────────────────────────────────────────── */
.rv-inner { max-width: 680px; margin: 0 auto; padding: 1.5rem 1.25rem; }

/* ── Header ─────────────────────────────────────────────────── */
.rv-header { margin-bottom: 1.5rem; }

.rv-retour {
  display: inline-flex; align-items: center; gap: 0.35rem;
  background: none; border: none; cursor: pointer;
  font-size: 0.875rem; font-weight: 700;
  color: var(--primary); padding: 0; margin-bottom: 1rem;
  font-family: inherit;
}
.rv-retour .material-symbols-outlined { font-size: 18px; }
.rv-retour:hover { opacity: 0.75; }

.rv-titre {
  font-size: 1.5rem; font-weight: 800; color: var(--text);
  letter-spacing: -0.015em; margin-bottom: 0.25rem;
}
.rv-sous-titre { font-size: 0.875rem; color: var(--text-muted); }

/* ── Liste ──────────────────────────────────────────────────── */
.rv-liste { display: flex; flex-direction: column; gap: 1.25rem; }

/* ── Carte ──────────────────────────────────────────────────── */
.rv-carte {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 16px; padding: 1.1rem 1.25rem;
}

.rv-carte-head {
  display: flex; justify-content: space-between; align-items: center;
  margin-bottom: 0.6rem;
}

.rv-num {
  font-size: 0.68rem; font-weight: 800; letter-spacing: 0.07em;
  color: var(--text-muted); text-transform: uppercase;
}

.rv-badge {
  font-size: 0.75rem; font-weight: 800;
  padding: 0.25rem 0.75rem; border-radius: 99px;
}
.rv-badge-ok { background: #dcfce7; color: #16a34a; }
.rv-badge-ko { background: #fee2e2; color: #dc2626; }

.rv-enonce {
  font-size: 0.95rem; font-weight: 800; color: var(--text);
  line-height: 1.5; margin-bottom: 1rem;
}

/* ── Lignes réponses ────────────────────────────────────────── */
.rv-reponses { display: flex; flex-direction: column; gap: 0.5rem; margin-bottom: 1rem; }

.rv-ligne-rep {
  display: flex; justify-content: space-between; align-items: center;
  gap: 0.75rem;
  padding: 0.6rem 0.9rem; border-radius: 10px;
  flex-wrap: wrap;
}
.rv-rep-ok { background: #dcfce7; }
.rv-rep-ko { background: #fee2e2; }

.rv-rep-lib {
  font-size: 0.8rem; font-weight: 700;
  color: var(--text-muted); white-space: nowrap;
}
.rv-rep-ok .rv-rep-lib { color: #15803d; }
.rv-rep-ko .rv-rep-lib { color: #b91c1c; }

.rv-rep-val {
  font-size: 0.875rem; font-weight: 800; text-align: right;
  flex: 1;
}
.rv-rep-ok .rv-rep-val { color: #16a34a; }
.rv-rep-ko .rv-rep-val { color: #dc2626; }

/* ── Explication ────────────────────────────────────────────── */
.rv-expl-wrap { border-top: 1px solid var(--border); padding-top: 0.85rem; }
.rv-expl-label {
  font-size: 0.78rem; font-weight: 800; color: var(--text);
  margin-bottom: 0.3rem;
}
.rv-expl-texte {
  font-size: 0.83rem; color: var(--text-muted); line-height: 1.55;
}

.rv-xp {
  font-size: 0.8rem; font-weight: 800; color: #16a34a;
  margin-top: 0.6rem;
}
</style>
