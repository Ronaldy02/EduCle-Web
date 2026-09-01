<template>
  <nav class="nav">
    <router-link to="/" class="nav-logo">🔑 EduClé</router-link>
    <div class="nav-links">
      <router-link to="/">Accueil</router-link>
      <router-link to="/scores">Scores</router-link>
      <router-link to="/stats">Stats</router-link>
      <router-link to="/profil">Profil</router-link>
    </div>
  </nav>
  <router-view />
</template>

<style scoped>
.nav { display: flex; align-items: center; justify-content: space-between; }
.nav-logo { font-size: 1.25rem; font-weight: 900; color: var(--primary); }
.nav-links { display: flex; gap: 1.25rem; }
.nav-links a { font-weight: 600; color: var(--text-muted); font-size: 0.9rem; }
.nav-links a.router-link-active { color: var(--primary); }
</style>
