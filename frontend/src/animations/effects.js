// ── Effets JS ponctuels (ripple, éclats d'étoiles) ───────────────────────────
// Les éléments créés sont temporaires et retirés à la fin de leur animation.

import { animationsActives } from './motion.js'

// E2 — onde circulaire depuis un point (coordonnées écran)
export function ripple(el, clientX, clientY) {
  if (!el || !animationsActives()) return
  let layer = el.querySelector(':scope > .fx-ripple-layer')
  if (!layer) {
    // Style inline plutôt qu'une classe : un :class Vue réécrirait la classe
    if (getComputedStyle(el).position === 'static') el.style.position = 'relative'
    layer = document.createElement('span')
    layer.className = 'fx-ripple-layer'
    el.appendChild(layer)
  }
  const r    = el.getBoundingClientRect()
  const x    = (clientX ?? r.left + r.width / 2) - r.left
  const y    = (clientY ?? r.top + r.height / 2) - r.top
  const size = Math.hypot(Math.max(x, r.width - x), Math.max(y, r.height - y)) * 2

  const dot = document.createElement('span')
  dot.className = 'fx-ripple'
  dot.style.cssText = `width:${size}px;height:${size}px;left:${x - size / 2}px;top:${y - size / 2}px`
  layer.appendChild(dot)
  dot.addEventListener('animationend', () => dot.remove(), { once: true })
}

// H1/H2 — un élément vole en arc d'un point de départ jusqu'à une cible.
// `contenu` : HTML de l'élément volant. Résout la promesse à l'arrivée
// (immédiatement si les animations sont coupées ou si un élément manque).
export function voler(depuis, vers, { contenu, classe = '', duree = 800, delai = 0, ecart = 0, hauteur = 80 } = {}) {
  if (!depuis || !vers || !animationsActives()) return Promise.resolve()
  const a = depuis.getBoundingClientRect()
  const b = vers.getBoundingClientRect()
  if (!b.width && !b.height) return Promise.resolve()   // cible masquée (display:none)

  const el = document.createElement('div')
  el.className = 'fx-vol ' + classe
  el.innerHTML = contenu
  const x0 = a.left + a.width / 2 + ecart
  const y0 = a.top + a.height / 2
  el.style.left = x0 + 'px'
  el.style.top  = y0 + 'px'
  document.body.appendChild(el)

  const dx = b.left + b.width / 2 - x0
  const dy = b.top + b.height / 2 - y0
  const anim = el.animate([
    { transform: 'translate(-50%, -50%) scale(0.6)', opacity: 0 },
    { transform: 'translate(-50%, -50%) translateY(-18px) scale(1.15)', opacity: 1, offset: 0.18 },
    { transform: `translate(-50%, -50%) translate(${dx * 0.5 + ecart}px, ${dy * 0.5 - hauteur}px) scale(1)`, opacity: 1, offset: 0.55 },
    { transform: `translate(-50%, -50%) translate(${dx}px, ${dy}px) scale(0.45)`, opacity: 0.4 },
  ], { duration: duree, delay: delai, easing: 'cubic-bezier(0.45, 0, 0.55, 1)', fill: 'both' })

  // Filet de sécurité : si l'onglet est en arrière-plan, l'animation peut rester figée ;
  // le gain doit quand même être crédité à l'heure prévue.
  const filet = new Promise(r => setTimeout(r, delai + duree + 250))
  return Promise.race([anim.finished.catch(() => {}), filet]).then(() => el.remove())
}

// Petit « boing » d'un compteur qui reçoit un gain
export function rebond(el) {
  if (!el || !animationsActives()) return
  el.animate([
    { transform: 'scale(1)' },
    { transform: 'scale(1.25)', offset: 0.35 },
    { transform: 'scale(0.95)', offset: 0.7 },
    { transform: 'scale(1)' },
  ], { duration: 420, easing: 'ease-out' })
}

// E3 — petites étoiles qui jaillissent d'un élément
export function burst(el, { count = 8, color = '#16A34A', symbol = '✦' } = {}) {
  if (!el || !animationsActives()) return
  if (getComputedStyle(el).position === 'static') el.style.position = 'relative'
  for (let i = 0; i < count; i++) {
    const s     = document.createElement('span')
    const angle = (i / count) * 360 + (Math.random() * 30 - 15)
    const dist  = 38 + Math.random() * 34
    s.className = 'fx-star'
    s.textContent = symbol
    s.style.setProperty('--a', angle + 'deg')
    s.style.setProperty('--d', dist + 'px')
    s.style.setProperty('--s', (0.6 + Math.random() * 0.6).toFixed(2))
    s.style.color = color
    el.appendChild(s)
    s.addEventListener('animationend', () => s.remove(), { once: true })
  }
}
