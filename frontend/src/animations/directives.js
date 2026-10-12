// ── Directives d'animation globales ──────────────────────────────────────────
//   v-stagger  (A2) : les enfants directs apparaissent en cascade
//   v-countup  (A6) : le nombre défile jusqu'à sa valeur
//   v-ripple   (E2) : onde au point de clic

import { animationsActives } from './motion.js'
import { ripple } from './effects.js'

// ── A2 · Cascade ────────────────────────────────────────────────────────────
// Seuls les enfants pas encore vus sont animés : une liste qui se met à jour
// n'anime que ses nouveaux éléments.
const STAGGER_MAX = 12

function marquerEnfants(el) {
  let n = 0
  for (const child of el.children) {
    if (child.dataset.stg) continue
    child.dataset.stg = '1'
    child.style.setProperty('--i', Math.min(n++, STAGGER_MAX))
    child.classList.add('stagger-item')
  }
}

export const vStagger = {
  mounted: marquerEnfants,
  updated: marquerEnfants,
}

// ── A6 · Compteur qui défile ─────────────────────────────────────────────────
const COUNT_MS = 800

function afficher(el, n) {
  el.textContent = Math.round(n).toLocaleString('fr-FR')
}

function animerCompteur(el, from, to) {
  cancelAnimationFrame(el._countRaf)
  if (!animationsActives() || from === to || !Number.isFinite(to)) {
    afficher(el, Number.isFinite(to) ? to : 0)
    return
  }
  const debut = performance.now()
  const step = (t) => {
    const p = Math.min(1, (t - debut) / COUNT_MS)
    const e = 1 - Math.pow(1 - p, 3)               // ease-out cubique
    afficher(el, from + (to - from) * e)
    if (p < 1) el._countRaf = requestAnimationFrame(step)
  }
  el._countRaf = requestAnimationFrame(step)
}

export const vCountup = {
  mounted(el, { value }) {
    animerCompteur(el, 0, Number(value))
  },
  updated(el, { value, oldValue }) {
    if (Number(value) !== Number(oldValue)) animerCompteur(el, Number(oldValue) || 0, Number(value))
  },
  beforeUnmount(el) {
    cancelAnimationFrame(el._countRaf)
  },
}

// ── E2 · Onde au clic ────────────────────────────────────────────────────────
export const vRipple = {
  mounted(el) {
    el._rippleHandler = (e) => {
      if (el.disabled) return
      ripple(el, e.clientX, e.clientY)
    }
    el.addEventListener('pointerdown', el._rippleHandler)
  },
  beforeUnmount(el) {
    el.removeEventListener('pointerdown', el._rippleHandler)
  },
}

export function installerAnimations(app) {
  app.directive('stagger', vStagger)
  app.directive('countup', vCountup)
  app.directive('ripple', vRipple)
}
