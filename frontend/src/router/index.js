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
import LoginView from '../views/LoginView.vue'
import AuthCallbackView from '../views/AuthCallbackView.vue'
import PrivacyView from '../views/PrivacyView.vue'
import TermsView from '../views/TermsView.vue'
import AdminLoginView from '../views/AdminLoginView.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/login',              name: 'login',         component: LoginView,         meta: { public: true } },
    { path: '/auth/callback',      name: 'auth-callback', component: AuthCallbackView,  meta: { public: true } },
    { path: '/auth/google/callback', name: 'google-cb',  component: AuthCallbackView,  meta: { public: true } },
    { path: '/privacy',            name: 'privacy',     component: PrivacyView,        meta: { public: true } },
    { path: '/terms',              name: 'terms',       component: TermsView,          meta: { public: true } },
    { path: '/admin/login',        name: 'admin-login', component: AdminLoginView,     meta: { public: true } },
    { path: '/',          name: 'home',        component: HomeView },
    { path: '/quiz',      name: 'quiz',        component: QuizView },
    { path: '/resultat',  name: 'resultat',    component: ResultatView },
    { path: '/profil',    name: 'profil',      component: ProfilView },
    { path: '/scores',    name: 'scores',      component: ScoresView },
    { path: '/stats',     name: 'stats',       component: StatsView },
    { path: '/reglages',  name: 'reglages',    component: ReglagesView },
    { path: '/revision',  name: 'revision',    component: RevisionView },
    { path: '/admin',     name: 'admin',        component: AdminView, meta: { public: true } },
    { path: '/taches',       name: 'taches',       component: { template: '<div style="padding:2rem"><h2>Tâches</h2><p>À venir…</p></div>' } },
    { path: '/realisations', name: 'realisations', component: { template: '<div style="padding:2rem"><h2>Réalisations</h2><p>À venir…</p></div>' } },
    { path: '/cartes/:matiereId/:chapitreId', name: 'cartes', component: CartesMentalesView },
  ],
})

// ── Guard d'authentification ──────────────────────────────────────────────────
router.beforeEach((to) => {
  if (to.meta.public) return true
  const token = localStorage.getItem('ec_token')
  if (!token) return { name: 'login' }
  return true
})

export default router
