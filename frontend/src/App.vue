<template>
  <!-- Mobile header -->
  <header v-if="showNav" class="mobile-header">
    <span class="logo-text">🔑 EduClé</span>
    <div class="mh-right">
      <div class="stat-pill" v-if="niveau">
        <span class="material-symbols-outlined filled" style="color:#D97706">monetization_on</span>
        {{ niveau.pieces_total }}
      </div>
      <div class="mh-avatar">🎓</div>
    </div>
  </header>

  <!-- Shell -->
  <div :class="['body-shell', { 'body-shell--nav': showNav }]">

    <!-- Desktop sidebar -->
    <nav v-if="showNav" class="sidebar">
      <div class="sidebar-logo">
        <span class="logo-text">🔑 EduClé</span>
        <span class="sidebar-tagline">Apprentissage Académique</span>
      </div>

      <div class="sidebar-links">
        <router-link to="/" class="nav-link" :class="{ active: $route.name === 'home' }">
          <span class="material-symbols-outlined">home</span> Accueil
        </router-link>
        <router-link to="/stats" class="nav-link" :class="{ active: $route.name === 'stats' }">
          <span class="material-symbols-outlined">bar_chart</span> Statistiques
        </router-link>
        <router-link to="/scores" class="nav-link" :class="{ active: $route.name === 'scores' }">
          <span class="material-symbols-outlined">emoji_events</span> Classement
        </router-link>
        <router-link to="/profil" class="nav-link" :class="{ active: $route.name === 'profil' }">
          <span class="material-symbols-outlined">person</span> Profil
        </router-link>
        <router-link to="/taches" class="nav-link" :class="{ active: $route.name === 'taches' }">
          <span class="material-symbols-outlined">task_alt</span> Tâches
        </router-link>
        <router-link to="/realisations" class="nav-link" :class="{ active: $route.name === 'realisations' }">
          <span class="material-symbols-outlined">military_tech</span> Réalisations
        </router-link>
      </div>

      <div class="sidebar-foot">
        <router-link to="/profil" class="nav-link">
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
          <div class="stat-pill">
            <span class="material-symbols-outlined" style="color:#EF4444;font-size:18px">local_fire_department</span>
            <span>0</span>
            <span class="pill-sub">Séries</span>
          </div>
          <div class="stat-pill">
            <span class="material-symbols-outlined" style="color:#6366F1;font-size:18px">task_alt</span>
            <span>0</span>
            <span class="pill-sub">Tâches</span>
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

const NO_NAV = ['quiz', 'resultat']
const showNav = computed(() => !NO_NAV.includes(route.name))

function toggleConnexion() {
  connecte.value = !connecte.value
}

async function chargerNiveau() {
  try { niveau.value = await getNiveau() } catch {}
}

onMounted(chargerNiveau)
watch(() => route.name, (n) => { if (n && !NO_NAV.includes(n)) chargerNiveau() })
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
  padding: 0 1.25rem; height: 64px;
  background: var(--surface); border-bottom: 1px solid var(--border);
  position: sticky; top: 0; z-index: 50;
}
@media (min-width: 768px) { .mobile-header { display: none; } }
.mh-right { display: flex; align-items: center; gap: 0.75rem; }
.mh-avatar {
  width: 36px; height: 36px; border-radius: 50%;
  background: var(--primary-light-solid); border: 2px solid var(--primary);
  display: flex; align-items: center; justify-content: center; font-size: 1.1rem;
}

/* ── Sidebar ───────────────────────────────────────────────────────── */
.sidebar {
  display: none; width: 256px;
  position: fixed; left: 0; top: 0; bottom: 0;
  background: var(--surface); border-right: 1px solid var(--border);
  flex-direction: column; z-index: 40; overflow-y: auto;
}
@media (min-width: 768px) { .sidebar { display: flex; } }

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

/* Button-style nav link (no router-link underline behavior) */
.nav-link-btn {
  background: none; border: none; cursor: pointer;
  width: 100%; text-align: left; font-family: inherit;
}
.nav-link-btn:active { transform: none; }

.sidebar-foot { padding: 0.75rem 0.5rem 1rem; border-top: 1px solid var(--border); margin-top: auto; display: flex; flex-direction: column; gap: 0.25rem; }

/* ── XP card in sidebar ────────────────────────────────────────────── */
.sidebar-xp { background: var(--bg); border: 1px solid var(--border); border-radius: 12px; padding: 0.75rem; margin-bottom: 0.35rem; }
.sxp-top { display: flex; align-items: center; justify-content: space-between; margin-bottom: 0.5rem; }
.sxp-level { font-size: 0.72rem; font-weight: 700; color: var(--text-muted); }
.rang-badge { font-size: 0.72rem; font-weight: 700; padding: 0.15rem 0.5rem; border-radius: 99px; }

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

.xp-label-sm { font-size: 0.7rem; color: var(--text-muted); margin-top: 0.35rem; font-weight: 500; }

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
.pill-sub { font-size: 0.68rem; font-weight: 600; color: var(--text-muted); margin-left: 0.1rem; }

/* ── Page content scroll ───────────────────────────────────────────── */
.page-content { flex: 1; }
</style>
