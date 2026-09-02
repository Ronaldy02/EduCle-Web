/**
 * Store Pinia — état du quiz en cours.
 *
 * Flux :
 *   configurer() → demarrer() → [l'utilisateur répond]
 *   → terminer() → le résultat est stocké dans `resultat`
 *   → ProfilView lit `resultat` via le router
 */
import { defineStore } from 'pinia'
import { ref } from 'vue'
import { demarrerQuiz, terminerQuiz } from '../api/client.js'

export const useQuizStore = defineStore('quiz', () => {
  // Configuration
  const chapitreId  = ref(null)
  const matiereId   = ref(null)
  const modeNom     = ref('Révision')
  const nbQuestions = ref(10)
  const matNom      = ref('')
  const chapNom     = ref('')

  // Déroulement
  const questions  = ref([])
  const indexCourant = ref(0)
  const reponses   = ref([])   // [{question_id, reponse, temps_restant}]
  const en_cours   = ref(false)

  // Résultat final (rempli après terminer())
  const resultat = ref(null)

  function configurer(config) {
    chapitreId.value  = config.chapitreId
    matiereId.value   = config.matiereId ?? null
    modeNom.value     = config.modeNom
    nbQuestions.value = config.nbQuestions ?? 10
    matNom.value      = config.matNom  ?? ''
    chapNom.value     = config.chapNom ?? ''
  }

  async function demarrer() {
    questions.value    = await demarrerQuiz(chapitreId.value, modeNom.value, nbQuestions.value)
    indexCourant.value = 0
    reponses.value     = []
    resultat.value     = null
    en_cours.value     = true
  }

  function enregistrerReponse(questionId, reponse, tempsRestant) {
    reponses.value.push({ question_id: questionId, reponse, temps_restant: tempsRestant })
    indexCourant.value++
  }

  async function terminer() {
    resultat.value = await terminerQuiz({
      chapitre_id: chapitreId.value,
      matiere_id:  matiereId.value,
      mode_nom:    modeNom.value,
      reponses:    reponses.value,
    })
    en_cours.value = false
    return resultat.value
  }

  function reset() {
    questions.value    = []
    reponses.value     = []
    indexCourant.value = 0
    en_cours.value     = false
  }

  return {
    chapitreId, matiereId, modeNom, nbQuestions, matNom, chapNom,
    questions, indexCourant, reponses, en_cours, resultat,
    configurer, demarrer, enregistrerReponse, terminer, reset,
  }
})
