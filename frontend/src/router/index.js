import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import QuizView from '../views/QuizView.vue'
import ResultatView from '../views/ResultatView.vue'
import ProfilView from '../views/ProfilView.vue'
import ScoresView from '../views/ScoresView.vue'
import CartesMentalesView from '../views/CartesMentalesView.vue'
import StatsView from '../views/StatsView.vue'
import ReglagesView from '../views/ReglagesView.vue'
import RevisionView from '../views/RevisionView.vue'
import AdminView from '../views/AdminView.vue'

export default createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/',         name: 'home',       component: HomeView },
    { path: '/quiz',     name: 'quiz',       component: QuizView },
    { path: '/resultat', name: 'resultat',   component: ResultatView },
    { path: '/profil',   name: 'profil',     component: ProfilView },
    { path: '/scores',   name: 'scores',     component: ScoresView },
    { path: '/stats',    name: 'stats',      component: StatsView },
    { path: '/reglages', name: 'reglages',   component: ReglagesView },
    { path: '/revision', name: 'revision',   component: RevisionView },
    { path: '/admin',    name: 'admin',       component: AdminView },
    { path: '/taches',        name: 'taches',       component: { template: '<div style="padding:2rem"><h2>Tâches</h2><p>À venir…</p></div>' } },
    { path: '/realisations',  name: 'realisations', component: { template: '<div style="padding:2rem"><h2>Réalisations</h2><p>À venir…</p></div>' } },
    { path: '/cartes/:matiereId/:chapitreId', name: 'cartes', component: CartesMentalesView },
  ],
})
