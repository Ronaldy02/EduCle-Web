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
