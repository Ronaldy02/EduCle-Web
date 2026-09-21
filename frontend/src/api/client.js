/**
 * Client Axios — toutes les requêtes vers le backend FastAPI.
 * Base URL : /api  (redirigé vers http://localhost:8000 par le proxy Vite en dev)
 */
import axios from 'axios'

// En dev : /api est redirigé vers localhost:8000 par le proxy Vite.
// En production : VITE_API_URL doit pointer vers le backend déployé.
const api = axios.create({ baseURL: import.meta.env.VITE_API_URL || '/api' })

// Injecte le JWT dans chaque requête si disponible
api.interceptors.request.use(config => {
  const token = localStorage.getItem('ec_token')
  if (token) config.headers.Authorization = `Bearer ${token}`
  return config
})

// ─── Matières ─────────────────────────────────────────────────────────────────
export const getMatieres = (niveau) =>
  api.get('/matieres/', { params: niveau ? { niveau } : {} }).then(r => r.data)

export const getNiveaux = () =>
  api.get('/matieres/niveaux').then(r => r.data)

export const getMatiere = (id) =>
  api.get(`/matieres/${id}`).then(r => r.data)

export const getChapitre = (matiereId, chapitreId) =>
  api.get(`/matieres/${matiereId}/chapitres/${chapitreId}`).then(r => r.data)

// ─── Quiz ──────────────────────────────────────────────────────────────────────
export const demarrerQuiz = (chapitreId, modeNom, nbQuestions = 10) =>
  api.post('/quiz/demarrer', { chapitre_id: chapitreId, mode_nom: modeNom, nb_questions: nbQuestions })
     .then(r => r.data)

export const terminerQuiz = (payload) =>
  api.post('/quiz/terminer', payload).then(r => r.data)

// ─── Utilisateur ──────────────────────────────────────────────────────────────
export const getProfil = () => api.get('/user/profil').then(r => r.data)
export const updateProfil = (data) => api.patch('/user/profil', data).then(r => r.data)
export const getNiveau = () => api.get('/user/niveau').then(r => r.data)
export const getScores = (matiereId) =>
  api.get('/user/scores', { params: matiereId ? { matiere_id: matiereId } : {} }).then(r => r.data)

export const getStats = () => api.get('/user/stats').then(r => r.data)
export const getClassement = (params) =>
  api.get('/user/classement', { params }).then(r => r.data)

// ─── Authentification ─────────────────────────────────────────────────────────
export const authCheckEmail = (email) =>
  api.post('/auth/check-email', { email }).then(r => r.data)
export const authRegister = (email, password, pseudo) =>
  api.post('/auth/register', { email, password, pseudo }).then(r => r.data)
export const authLogin = (email, password) =>
  api.post('/auth/login', { email, password }).then(r => r.data)
export const authMe = () => api.get('/auth/me').then(r => r.data)

// ─── Réalisations ─────────────────────────────────────────────────────────────
export const getRealisations = () => api.get('/realisations/').then(r => r.data)

// ─── Admin (lecture seule) ────────────────────────────────────────────────────
export const getMatieresAvecChapitres = () => api.get('/admin/matieres').then(r => r.data)

// ─── Propositions ─────────────────────────────────────────────────────────────
export const soumettreProposition = (data) => api.post('/proposals/', data).then(r => r.data)
