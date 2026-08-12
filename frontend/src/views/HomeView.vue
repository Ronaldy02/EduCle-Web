<template>
  <div class="page fade-in">
    <!-- Niveau / XP -->
    <div v-if="niveau" class="card niveau-card">
      <div class="niveau-top">
        <span class="rang-badge" :style="{ background: niveau.rang_couleur + '22', color: niveau.rang_couleur }">
          {{ niveau.rang_emoji }} {{ niveau.rang_nom }}
        </span>
        <span class="niveau-num">Niveau {{ niveau.niveau }}</span>
      </div>
      <div class="xp-bar-wrap">
        <div class="xp-bar" :style="{ width: (niveau.progression * 100) + '%', background: niveau.rang_couleur }"></div>
      </div>
      <p class="xp-label">{{ niveau.xp_dans_niveau }} / {{ niveau.xp_pour_suivant }} XP  ·  🪙 {{ niveau.pieces_total }}</p>
    </div>

    <h2 class="section-title">Choisir une matière</h2>

    <!-- Filtre par niveau scolaire -->
    <div class="filtres">
      <button
        v-for="niv in niveaux"
        :key="niv"
        class="filtre-btn"
        :class="{ active: niveauActif === niv }"
        @click="filtrer(niv)"
      >{{ niv }}</button>
    </div>

    <!-- Liste des matières -->
    <div v-if="chargement" class="loading">Chargement…</div>
    <div v-else class="matieres-grid">
      <div
        v-for="mat in matieres"
        :key="mat.id"
        class="matiere-card card"
        @click="choisirMatiere(mat)"
      >
        <span class="matiere-nom">{{ mat.nom }}</span>
        <span class="chevron">›</span>
      </div>
    </div>

    <!-- Modal choix chapitre -->
    <div v-if="matiereSelectionnee" class="modal-overlay" @click.self="matiereSelectionnee = null">
      <div class="modal card">
        <h3>{{ matiereSelectionnee.nom }}</h3>
        <div class="chapitres-list">
          <button
            v-for="chap in chapitres"
            :key="chap.id"
            class="chapitre-btn"
            @click="choisirChapitre(chap)"
          >{{ chap.titre }}</button>
          <button class="chapitre-btn chapitre-tout" @click="choisirChapitre({ id: -1, titre: 'Tous les chapitres' })">
            ✨ Tous les chapitres
          </button>
        </div>
        <div class="modal-modes">
          <label>Mode</label>
          <select v-model="modeNom">
            <option v-for="m in modes" :key="m">{{ m }}</option>
          </select>
          <label>Questions</label>
          <select v-model.number="nbQuestions">
            <option v-for="n in [5, 10, 15, 20]" :key="n">{{ n }}</option>
          </select>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { getMatieres, getNiveaux, getMatiere } from '../api/client.js'
import { getNiveau } from '../api/client.js'
import { useQuizStore } from '../stores/quiz.js'

const router = useRouter()
const quiz = useQuizStore()

const niveaux = ref([])
const niveauActif = ref(null)
const matieres = ref([])
const chargement = ref(true)
const niveau = ref(null)

const matiereSelectionnee = ref(null)
const chapitres = ref([])
const modeNom = ref('Révision')
const nbQuestions = ref(10)
const modes = ['Révision', 'Rush', 'Bombardement']

onMounted(async () => {
  const [niv, nivList] = await Promise.all([getNiveau(), getNiveaux()])
  niveau.value = niv
  niveaux.value = nivList
  niveauActif.value = nivList[0] ?? null
  await filtrer(niveauActif.value)
  chargement.value = false
})

async function filtrer(niv) {
  niveauActif.value = niv
  chargement.value = true
  matieres.value = await getMatieres(niv)
  chargement.value = false
}

async function choisirMatiere(mat) {
  const detail = await getMatiere(mat.id)
  matiereSelectionnee.value = mat
  chapitres.value = detail.chapitres
}

async function choisirChapitre(chap) {
  quiz.configurer({
    chapitreId: chap.id === -1 ? matiereSelectionnee.value.id * -1 : chap.id,
    matiereId: matiereSelectionnee.value.id,
    modeNom: modeNom.value,
    nbQuestions: nbQuestions.value,
  })
  matiereSelectionnee.value = null
  router.push('/quiz')
}
</script>

<style scoped>
.niveau-card { margin-bottom: 1.5rem; }
.niveau-top { display: flex; align-items: center; justify-content: space-between; margin-bottom: 0.75rem; }
.rang-badge { font-weight: 700; padding: 0.25rem 0.75rem; border-radius: 99px; font-size: 0.9rem; }
.niveau-num { font-weight: 700; color: var(--text-muted); }
.xp-bar-wrap { height: 8px; background: var(--border); border-radius: 99px; overflow: hidden; }
.xp-bar { height: 100%; border-radius: 99px; transition: width 0.4s ease; }
.xp-label { margin-top: 0.5rem; font-size: 0.8rem; color: var(--text-muted); }

.section-title { font-size: 1.1rem; font-weight: 800; margin: 1.25rem 0 0.75rem; }

.filtres { display: flex; gap: 0.5rem; flex-wrap: wrap; margin-bottom: 1rem; }
.filtre-btn {
  padding: 0.4rem 0.9rem; border-radius: 99px;
  background: var(--border); font-weight: 600; font-size: 0.85rem;
}
.filtre-btn.active { background: var(--primary); color: white; }

.matieres-grid { display: flex; flex-direction: column; gap: 0.5rem; }
.matiere-card {
  display: flex; align-items: center; justify-content: space-between;
  padding: 1rem 1.25rem; cursor: pointer;
  transition: box-shadow 0.15s;
}
.matiere-card:hover { box-shadow: 0 4px 16px rgba(0,0,0,0.12); }
.matiere-nom { font-weight: 600; }
.chevron { font-size: 1.4rem; color: var(--text-muted); }

.loading { text-align: center; color: var(--text-muted); padding: 2rem; }

/* Modal */
.modal-overlay {
  position: fixed; inset: 0; background: rgba(0,0,0,0.45);
  display: flex; align-items: center; justify-content: center; z-index: 100;
}
.modal { width: min(480px, 94vw); max-height: 85dvh; overflow-y: auto; }
.modal h3 { font-size: 1.1rem; font-weight: 800; margin-bottom: 1rem; }
.chapitres-list { display: flex; flex-direction: column; gap: 0.4rem; margin-bottom: 1rem; }
.chapitre-btn {
  background: var(--bg); border: 1px solid var(--border);
  padding: 0.6rem 1rem; text-align: left; border-radius: 8px;
  font-weight: 600; font-size: 0.9rem;
}
.chapitre-btn:hover { background: var(--primary-light); }
.chapitre-tout { color: var(--primary); border-color: var(--primary); }
.modal-modes { display: flex; align-items: center; gap: 0.75rem; flex-wrap: wrap; margin-top: 0.5rem; }
.modal-modes label { font-size: 0.85rem; font-weight: 600; }
.modal-modes select { padding: 0.4rem 0.6rem; border-radius: 8px; border: 1px solid var(--border); font-family: inherit; }
</style>
