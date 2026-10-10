<template>
  <!-- Pièce dessinée en SVG : rendu identique sur ordinateur et mobile
       (l'emoji 🪙 dépend de la police du système et varie selon l'appareil). -->
  <svg class="coin-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false">
    <circle cx="12" cy="12" r="11" fill="#E8A317" />
    <circle cx="12" cy="12" r="11" fill="none" stroke="#B7791F" stroke-width="1.5" />
    <circle cx="12" cy="12" r="7.5" fill="#F6C343" stroke="#C98A12" stroke-width="1.2" />
    <path d="M7.2 8.4a6 6 0 0 1 4-2.6" fill="none" stroke="#FFF3C4" stroke-width="1.4" stroke-linecap="round" />
    <text x="12" y="15.6" text-anchor="middle" font-size="10" font-weight="800"
          font-family="Arial, Helvetica, sans-serif" fill="#9A5B0B">G</text>
  </svg>
</template>

<style scoped>
.coin-icon {
  display: inline-block;
  width: 1.15em;
  height: 1.15em;
  vertical-align: -0.2em;
  flex-shrink: 0;
}
</style>
