import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import QuizView from '../views/QuizView.vue'
import ResultatView from '../views/ResultatView.vue'
import ProfilView from '../views/ProfilView.vue'
import ScoresView from '../views/ScoresView.vue'
import CartesMentalesView from '../views/CartesMentalesView.vue'

export default createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/',         name: 'home',    component: HomeView },
    { path: '/quiz',     name: 'quiz',    component: QuizView },
    { path: '/resultat', name: 'resultat',component: ResultatView },
    { path: '/profil',   name: 'profil',  component: ProfilView },
    { path: '/scores',   name: 'scores',  component: ScoresView },
    { path: '/cartes/:matiereId/:chapitreId', name: 'cartes', component: CartesMentalesView },
  ],
})
