<template>
  <!-- Mobile header -->
  <header v-if="showNav" class="mobile-header">
    <div class="mh-left">
      <button class="hamburger-btn" @click="sidebarOuvert = !sidebarOuvert" aria-label="Menu">
        <span class="material-symbols-outlined">{{ sidebarOuvert ? 'close' : 'menu' }}</span>
      </button>
      <span class="logo-text">🔑 EduClé</span>
    </div>
    <div class="mh-right">
      <div class="stat-pill" v-if="niveau">
        <span class="material-symbols-outlined filled" style="color:#D97706">monetization_on</span>
        {{ niveau.pieces_total }}
      </div>
      <div class="mh-avatar">🎓</div>
    </div>
  </header>

  <!-- Mobile sidebar overlay -->
  <transition name="fade">
    <div v-if="showNav && sidebarOuvert" class="sidebar-overlay" @click="sidebarOuvert = false"></div>
  </transition>

  <!-- Shell -->
  <div :class="['body-shell', { 'body-shell--nav': showNav }]">

    <!-- Sidebar (desktop always visible, mobile slide-in) -->
    <nav v-if="showNav" :class="['sidebar', { 'sidebar--open': sidebarOuvert }]">
      <div class="sidebar-logo">
        <span class="logo-text">🔑 EduClé</span>
        <span class="sidebar-tagline">Apprentissage Académique</span>
      </div>

      <div class="sidebar-links">
        <router-link to="/" class="nav-link" :class="{ active: $route.name === 'home' }" @click="sidebarOuvert = false">
          <span class="material-symbols-outlined">home</span> Accueil
        </router-link>
        <router-link to="/stats" class="nav-link" :class="{ active: $route.name === 'stats' }" @click="sidebarOuvert = false">
          <span class="material-symbols-outlined">bar_chart</span> Statistiques
        </router-link>
        <router-link to="/scores" class="nav-link" :class="{ active: $route.name === 'scores' }" @click="sidebarOuvert = false">
          <span class="material-symbols-outlined">emoji_events</span> Classement
        </router-link>
        <router-link to="/profil" class="nav-link" :class="{ active: $route.name === 'profil' }" @click="sidebarOuvert = false">
          <span class="material-symbols-outlined">person</span> Profil
        </router-link>
        <router-link to="/taches" class="nav-link" :class="{ active: $route.name === 'taches' }" @click="sidebarOuvert = false">
          <span class="material-symbols-outlined">task_alt</span> Tâches
        </router-link>
        <router-link to="/realisations" class="nav-link" :class="{ active: $route.name === 'realisations' }" @click="sidebarOuvert = false">
          <span class="material-symbols-outlined">military_tech</span> Réalisations
        </router-link>
      </div>

      <div class="sidebar-foot">
        <router-link to="/reglages" class="nav-link" :class="{ active: $route.name === 'reglages' }" @click="sidebarOuvert = false">
          <span class="material-symbols-outlined">settings</span> Paramètres
        </router-link>
        <button class="nav-link nav-link-btn" @click="toggleConnexion">
          <span class="material-symbols-outlined">{{ connecte ? 'logout' : 'login' }}</span>
          {{ connecte ? 'Déconnexion' : 'Connexion' }}
        </button>
      </div>
    </nav>

    <!-- Main area -->
    <div class="main-area">
      <!-- Desktop top bar -->
      <div v-if="showNav && niveau" class="desktop-topbar">
        <div class="dtb-niveau">
          <div class="niveau-circle" :style="{ background: niveau.rang_couleur + '22', color: niveau.rang_couleur }">
            {{ niveau.niveau }}
          </div>
          <div>
            <p class="dtb-rang">{{ niveau.rang_emoji }} {{ niveau.rang_nom }}</p>
            <div class="dtb-xp-row">
              <div class="xp-bar-wrap" style="width:140px">
                <div class="xp-bar" :style="{ width: (niveau.progression * 100) + '%', background: niveau.rang_couleur }"></div>
              </div>
              <span class="dtb-xp-label">{{ niveau.xp_dans_niveau }}/{{ niveau.xp_pour_suivant }} XP</span>
            </div>
          </div>
        </div>
        <div class="dtb-right">
          <!-- Séries : icône seule -->
          <div class="icon-pill" title="Séries">
            <span class="material-symbols-outlined" style="color:#EF4444">local_fire_department</span>
            <span>0</span>
          </div>
          <!-- Tâches : icône seule -->
          <div class="icon-pill" title="Tâches">
            <span class="material-symbols-outlined" style="color:#6366F1">task_alt</span>
            <span>0</span>
          </div>
          <div class="stat-pill">
            <span class="material-symbols-outlined filled" style="color:#D97706;font-size:18px">monetization_on</span>
            {{ niveau.pieces_total }}
          </div>
          <div class="mh-avatar">🎓</div>
        </div>
      </div>

      <!-- Page content -->
      <div class="page-content">
        <router-view />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import { getNiveau } from './api/client.js'

const route = useRoute()
const niveau = ref(null)
const connecte = ref(true)
const sidebarOuvert = ref(false)

const NO_NAV = ['quiz', 'resultat', 'revision', 'admin']
const showNav = computed(() => !NO_NAV.includes(route.name))

function toggleConnexion() {
  connecte.value = !connecte.value
}

async function chargerNiveau() {
  try { niveau.value = await getNiveau() } catch {}
}

onMounted(chargerNiveau)
watch(() => route.name, (n) => {
  if (n && !NO_NAV.includes(n)) chargerNiveau()
  sidebarOuvert.value = false
})

</script>

<style>
/* ── Shell layout ──────────────────────────────────────────────────── */
.body-shell { display: flex; flex-direction: column; min-height: 100dvh; }
@media (min-width: 768px) {
  .body-shell--nav { flex-direction: row; }
  .body-shell--nav .main-area { margin-left: 256px; }
}

/* ── Mobile header ─────────────────────────────────────────────────── */
.mobile-header {
  display: flex; align-items: center; justify-content: space-between;
  padding: 0 1rem; height: 64px;
  background: var(--surface); border-bottom: 1px solid var(--border);
  position: sticky; top: 0; z-index: 50;
}
@media (min-width: 768px) { .mobile-header { display: none; } }

.mh-left { display: flex; align-items: center; gap: 0.5rem; }
.mh-right { display: flex; align-items: center; gap: 0.75rem; }

.hamburger-btn {
  background: none; border: none; cursor: pointer;
  display: flex; align-items: center; justify-content: center;
  width: 38px; height: 38px; border-radius: 10px;
  color: var(--text-muted);
  transition: background 0.12s;
}
.hamburger-btn:hover { background: var(--primary-light-solid); color: var(--text); }
.hamburger-btn:active { transform: scale(0.95); }

.mh-avatar {
  width: 36px; height: 36px; border-radius: 50%;
  background: var(--primary-light-solid); border: 2px solid var(--primary);
  display: flex; align-items: center; justify-content: center; font-size: 1.1rem;
}

/* ── Sidebar overlay (mobile) ──────────────────────────────────────── */
.sidebar-overlay {
  position: fixed; inset: 0; background: rgba(0,0,0,0.35);
  z-index: 45; backdrop-filter: blur(2px);
}
@media (min-width: 768px) { .sidebar-overlay { display: none; } }

.fade-enter-active, .fade-leave-active { transition: opacity 0.2s; }
.fade-enter-from, .fade-leave-to { opacity: 0; }

/* ── Sidebar ───────────────────────────────────────────────────────── */
.sidebar {
  width: 256px;
  position: fixed; left: 0; top: 0; bottom: 0;
  background: var(--surface); border-right: 1px solid var(--border);
  display: flex; flex-direction: column; z-index: 46; overflow-y: auto;
  transform: translateX(-100%);
  transition: transform 0.22s cubic-bezier(0.4,0,0.2,1);
}
.sidebar--open { transform: translateX(0); }
@media (min-width: 768px) {
  .sidebar { transform: translateX(0); z-index: 40; }
}

.sidebar-logo { padding: 1.25rem 1rem 0.75rem; }
.logo-text { font-size: 1.2rem; font-weight: 900; color: var(--primary); display: block; }
.sidebar-tagline { font-size: 0.68rem; color: var(--text-muted); font-weight: 600; text-transform: uppercase; letter-spacing: 0.07em; margin-top: 0.2rem; display: block; }

.sidebar-links { flex: 1; display: flex; flex-direction: column; gap: 0.15rem; padding: 0.5rem; }

.nav-link {
  display: flex; align-items: center; gap: 0.65rem;
  padding: 0.55rem 0.75rem; border-radius: 10px;
  font-size: 0.875rem; font-weight: 600; color: var(--text-muted);
  transition: background 0.12s, color 0.12s; text-decoration: none;
}
.nav-link:hover { background: var(--primary-light-solid); color: var(--text); }
.nav-link.active { background: var(--primary-light-solid); color: var(--primary); font-weight: 700; }
.nav-link.active .material-symbols-outlined { color: var(--primary); }

.nav-link-btn {
  background: none; border: none; cursor: pointer;
  width: 100%; text-align: left; font-family: inherit;
}
.nav-link-btn:active { transform: none; }

.sidebar-foot { padding: 0.75rem 0.5rem 1rem; border-top: 1px solid var(--border); margin-top: auto; display: flex; flex-direction: column; gap: 0.25rem; }

/* ── XP bar (shared) ───────────────────────────────────────────────── */
.xp-bar-wrap {
  height: 6px; background: var(--border); border-radius: 99px;
  overflow: hidden; flex-shrink: 0;
}
.xp-bar {
  height: 100%; border-radius: 99px;
  background: var(--primary);
  transition: width 0.4s ease;
  min-width: 4px;
}

/* ── Desktop top bar ───────────────────────────────────────────────── */
.main-area { flex: 1; min-width: 0; display: flex; flex-direction: column; }

.desktop-topbar {
  display: none; align-items: center; justify-content: space-between;
  padding: 0 1.5rem; height: 64px;
  background: var(--surface); border-bottom: 1px solid var(--border);
  position: sticky; top: 0; z-index: 30;
}
@media (min-width: 768px) { .desktop-topbar { display: flex; } }

.dtb-niveau { display: flex; align-items: center; gap: 0.75rem; }
.niveau-circle { width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 1rem; flex-shrink: 0; }
.dtb-rang { font-size: 0.8rem; font-weight: 700; color: var(--text); margin-bottom: 0.25rem; line-height: 1; }
.dtb-xp-row { display: flex; align-items: center; gap: 0.5rem; }
.dtb-xp-label { font-size: 0.72rem; font-weight: 600; color: var(--text-muted); white-space: nowrap; }
.dtb-right { display: flex; align-items: center; gap: 0.5rem; }

/* ── Stat pill ─────────────────────────────────────────────────────── */
.stat-pill {
  display: flex; align-items: center; gap: 0.25rem;
  background: var(--bg); border: 1px solid var(--border);
  border-radius: 99px; padding: 0.3rem 0.65rem;
  font-size: 0.82rem; font-weight: 700;
}

/* ── Icon pill (icône + chiffre, sans label texte) ─────────────────── */
.icon-pill {
  display: flex; align-items: center; gap: 0.2rem;
  background: var(--bg); border: 1px solid var(--border);
  border-radius: 99px; padding: 0.3rem 0.55rem;
  font-size: 0.82rem; font-weight: 700;
  cursor: default;
}
.icon-pill .material-symbols-outlined { font-size: 18px; }

/* ── Page content scroll ───────────────────────────────────────────── */
.page-content { flex: 1; }
</style>
