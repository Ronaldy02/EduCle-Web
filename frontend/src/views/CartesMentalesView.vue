<template>
  <div class="page fade-in">
    <div v-if="chargement" class="loading">Chargement…</div>

    <template v-else-if="cartes.length === 0">
      <div class="vide">
        <p>Aucune carte mentale pour ce chapitre.</p>
        <button class="btn-secondary" @click="retour">← Retour</button>
      </div>
    </template>

    <template v-else>
      <!-- En-tête -->
      <div class="carte-header">
        <button class="btn-back" @click="retour">←</button>
        <div class="carte-meta">
          <p class="carte-matiere">{{ nomMatiere }}</p>
          <p class="carte-chapitre">{{ titreChapitre }}</p>
        </div>
      </div>

      <!-- Compteur + barre de progression -->
      <div class="compteur">
        <div class="compteur-bar-wrap">
          <div class="compteur-bar" :style="{ width: progression + '%' }"></div>
        </div>
        <span class="compteur-label">{{ index + 1 }} / {{ cartes.length }}</span>
      </div>

      <!-- Carte active -->
      <transition :name="direction === 1 ? 'slide-left' : 'slide-right'" mode="out-in">
        <div :key="index" class="carte-card card" @click="flipper">
          <div class="carte-num">Carte {{ index + 1 }}</div>
          <div class="carte-contenu">{{ cartes[index].contenu }}</div>
          <p class="carte-hint">Tapez pour passer à la suivante</p>
        </div>
      </transition>

      <!-- Navigation -->
      <div class="nav-row">
        <button class="nav-btn" :disabled="index === 0" @click="precedente">‹ Précédente</button>
        <button v-if="index < cartes.length - 1" class="nav-btn nav-btn-primary" @click="suivante">
          Suivante ›
        </button>
        <button v-else class="nav-btn nav-btn-primary" @click="lancerQuiz">
          🎯 Quiz
        </button>
      </div>

      <!-- Aperçu de toutes les cartes (accordéon) -->
      <div class="toutes-wrap">
        <button class="toutes-toggle" @click="showToutes = !showToutes">
          {{ showToutes ? '▲ Masquer' : '▼ Voir toutes les cartes' }}
        </button>
        <div v-if="showToutes" class="toutes-list">
          <div
            v-for="(c, i) in cartes"
            :key="c.id"
            class="toutes-item"
            :class="{ active: i === index }"
            @click="allerA(i)"
          >
            <span class="toutes-num">{{ i + 1 }}</span>
            <span class="toutes-contenu">{{ c.contenu }}</span>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getChapitre } from '../api/client.js'
import { useQuizStore } from '../stores/quiz.js'

const route  = useRoute()
const router = useRouter()
const quiz   = useQuizStore()

const matiereId  = Number(route.params.matiereId)
const chapitreId = Number(route.params.chapitreId)

const chargement   = ref(true)
const cartes       = ref([])
const titreChapitre = ref('')
const nomMatiere   = ref(route.query.matiere ?? '')
const index        = ref(0)
const direction    = ref(1)
const showToutes   = ref(false)

const progression = computed(() =>
  cartes.value.length ? ((index.value + 1) / cartes.value.length) * 100 : 0
)

onMounted(async () => {
  const data = await getChapitre(matiereId, chapitreId)
  titreChapitre.value = data.titre
  cartes.value = data.cartes_mentales ?? []
  chargement.value = false
})

function suivante() {
  if (index.value < cartes.value.length - 1) {
    direction.value = 1
    index.value++
  }
}

function precedente() {
  if (index.value > 0) {
    direction.value = -1
    index.value--
  }
}

function allerA(i) {
  direction.value = i > index.value ? 1 : -1
  index.value = i
  showToutes.value = false
}

function flipper() {
  suivante()
}

function retour() {
  router.back()
}

function lancerQuiz() {
  quiz.configurer({
    chapitreId,
    matiereId,
    modeNom: 'Révision',
    nbQuestions: 10,
  })
  router.push('/quiz')
}
</script>

<style scoped>
.loading { text-align: center; color: var(--text-muted); padding: 3rem; }
.vide    { text-align: center; padding: 3rem; color: var(--text-muted); }
.vide p  { margin-bottom: 1rem; }

/* En-tête */
.carte-header {
  display: flex; align-items: flex-start; gap: 0.75rem; margin-bottom: 1rem;
}
.btn-back {
  background: var(--surface); border: 1px solid var(--border);
  border-radius: 8px; padding: 0.5rem 0.8rem;
  font-size: 1.2rem; cursor: pointer; flex-shrink: 0;
}
.carte-meta { min-width: 0; }
.carte-matiere  { font-size: 0.75rem; color: var(--text-muted); font-weight: 600; }
.carte-chapitre { font-size: 1rem; font-weight: 800; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }

/* Barre de progression */
.compteur { display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1rem; }
.compteur-bar-wrap { flex: 1; height: 5px; background: var(--border); border-radius: 99px; overflow: hidden; }
.compteur-bar { height: 100%; background: var(--primary); border-radius: 99px; transition: width 0.3s; }
.compteur-label { font-size: 0.8rem; font-weight: 700; color: var(--text-muted); white-space: nowrap; }

/* Carte */
.carte-card {
  min-height: 220px; display: flex; flex-direction: column;
  align-items: center; justify-content: center;
  padding: 2rem 1.5rem; text-align: center;
  cursor: pointer; user-select: none;
  margin-bottom: 1rem;
  transition: box-shadow 0.15s;
}
.carte-card:hover { box-shadow: 0 6px 20px rgba(0,0,0,0.12); }
.carte-num { font-size: 0.72rem; font-weight: 700; color: var(--primary); letter-spacing: 0.1em; text-transform: uppercase; margin-bottom: 1rem; }
.carte-contenu { font-size: 1rem; font-weight: 600; line-height: 1.6; color: var(--text); }
.carte-hint { margin-top: 1.5rem; font-size: 0.72rem; color: var(--text-muted); }

/* Navigation */
.nav-row { display: flex; gap: 0.75rem; margin-bottom: 1.5rem; }
.nav-btn {
  flex: 1; padding: 0.7rem; border-radius: var(--radius);
  font-weight: 700; font-size: 0.95rem;
  background: var(--surface); border: 1px solid var(--border);
  cursor: pointer; transition: opacity 0.15s;
}
.nav-btn:disabled { opacity: 0.35; cursor: not-allowed; }
.nav-btn-primary { background: var(--primary); color: white; border-color: transparent; }
.nav-btn-primary:hover { opacity: 0.88; }

/* Toutes les cartes */
.toutes-wrap { margin-bottom: 2rem; }
.toutes-toggle {
  width: 100%; padding: 0.6rem; font-size: 0.85rem; font-weight: 600;
  background: var(--surface); border: 1px solid var(--border);
  border-radius: var(--radius); cursor: pointer; color: var(--text-muted);
}
.toutes-list { margin-top: 0.5rem; display: flex; flex-direction: column; gap: 0.35rem; }
.toutes-item {
  display: flex; gap: 0.75rem; align-items: flex-start;
  padding: 0.6rem 0.75rem; border-radius: 8px;
  background: var(--surface); border: 1px solid var(--border);
  cursor: pointer; transition: background 0.15s;
}
.toutes-item.active { border-color: var(--primary); background: var(--primary-light); }
.toutes-item:hover:not(.active) { background: var(--bg); }
.toutes-num { font-size: 0.75rem; font-weight: 800; color: var(--primary); flex-shrink: 0; min-width: 1.2rem; }
.toutes-contenu { font-size: 0.85rem; line-height: 1.4; color: var(--text); }

/* Transitions slide */
.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active { transition: transform 0.25s ease, opacity 0.2s ease; }

.slide-left-enter-from  { transform: translateX(40px);  opacity: 0; }
.slide-left-leave-to    { transform: translateX(-40px); opacity: 0; }
.slide-right-enter-from { transform: translateX(-40px); opacity: 0; }
.slide-right-leave-to   { transform: translateX(40px);  opacity: 0; }
</style>
