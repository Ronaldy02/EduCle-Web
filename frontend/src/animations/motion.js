// ── Réglage global des animations ────────────────────────────────────────────
// Préférence enregistrée dans localStorage ('on' / 'off').
// Sans préférence explicite, on suit le réglage système « réduire les animations ».
// L'état est reflété sur <html data-anim="on|off"> : le CSS (motion.css) coupe
// alors toutes les transitions/keyframes, et les effets JS vérifient animationsActives().

import { ref, watch } from 'vue'

const LS_KEY = 'educle_animations'

function lirePreference() {
  try {
    const v = localStorage.getItem(LS_KEY)
    if (v === 'on')  return true
    if (v === 'off') return false
  } catch {}
  return !window.matchMedia?.('(prefers-reduced-motion: reduce)').matches
}

export const animationsOn = ref(lirePreference())

function appliquer(on) {
  document.documentElement.dataset.anim = on ? 'on' : 'off'
}
appliquer(animationsOn.value)

watch(animationsOn, (on) => {
  appliquer(on)
  try { localStorage.setItem(LS_KEY, on ? 'on' : 'off') } catch {}
})

export function animationsActives() {
  return animationsOn.value
}

// Durées partagées avec le CSS (ms) — garder synchronisé avec motion.css
export const DUREE = {
  rapide: 150,
  normal: 300,
  lent:   600,
}
