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
import { niveauDepuisXp } from '../utils/niveau.js'

// Paliers de série (miroir de _PALIERS_SERIE côté serveur)
const PALIERS_SERIE = { 5: 5, 10: 10, 15: 18, 20: 25 }

function bonusSerie(correctes, modeNom) {
  if (modeNom === 'Bombardement') return [0, 0]
  let serie = 0, serieMax = 0, bonus = 0
  const atteints = new Set()
  for (const c of correctes) {
    if (c) {
      serie++
      serieMax = Math.max(serieMax, serie)
      for (const [palier, b] of Object.entries(PALIERS_SERIE)) {
        if (serie >= Number(palier) && !atteints.has(palier)) { atteints.add(palier); bonus += b }
      }
    } else {
      serie = 0
      atteints.clear()
    }
  }
  return [bonus, serieMax]
}

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

  // Résultat calculé localement (même règles que /quiz/terminer) pour l'afficher sans attendre
  // le serveur. Les défis, réalisations et bonus associés n'arrivent qu'avec la réponse serveur.
  function resultatProvisoire(xpAvant) {
    const qMap = new Map(questions.value.map(q => [q.id, q]))
    const lignes = reponses.value
      .filter(r => qMap.has(r.question_id))
      .map(r => {
        const q = qMap.get(r.question_id)
        const correcte = r.reponse.trim() === q.bonne_reponse.trim()
        return {
          question_id: q.id, enonce: q.enonce, choix: q.choix,
          bonne_reponse: q.bonne_reponse, explication: q.explication,
          reponse_donnee: r.reponse, correcte,
          xp_gagne: correcte ? (q.xp ?? 0) : 0,
          _pieces: correcte ? (q.pieces ?? 0) : 0,
        }
      })
    const [serieBonus, serieMax] = bonusSerie(lignes.map(l => l.correcte), modeNom.value)
    const xpGagne = lignes.reduce((s, l) => s + l.xp_gagne, 0)
    const score   = lignes.filter(l => l.correcte).length
    return {
      provisoire: true,
      score, total: lignes.length, mode_nom: modeNom.value,
      questions: lignes.map(({ _pieces, ...l }) => l),
      xp_gagne: xpGagne,
      pieces_gagnees: lignes.reduce((s, l) => s + l._pieces, 0) + serieBonus,
      serie_bonus: serieBonus, serie_max: serieMax,
      defis_completes: [], realisations_debloquees: [],
      xp_bonus_defis: 0, pieces_bonus_defis: 0,
      xp_total: xpAvant + xpGagne,
      niveau_avant: niveauDepuisXp(xpAvant),
      niveau_apres: niveauDepuisXp(xpAvant + xpGagne),
    }
  }

  // xpAvant connu → résultat provisoire affiché tout de suite, le serveur confirme ensuite.
  // Retourne la promesse de la réponse serveur (à attendre seulement si pas de provisoire).
  function terminer(xpAvant = null) {
    const provisoire = xpAvant !== null ? resultatProvisoire(xpAvant) : null
    if (provisoire) resultat.value = provisoire
    const envoi = terminerQuiz({
      chapitre_id: chapitreId.value,
      matiere_id:  matiereId.value,
      mode_nom:    modeNom.value,
      reponses:    reponses.value,
    }).then((r) => {
      resultat.value = r
      en_cours.value = false
      return r
    }).catch((e) => {
      // Le provisoire reste affiché, marqué comme non enregistré
      if (provisoire) resultat.value = { ...provisoire, provisoire: false, erreur: true }
      throw e
    })
    return { provisoire, envoi }
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
