// ── S6 · Réglages du son (mémorisés sur l'appareil) ──────────────────────────
//   musique : on/off + volume   ·   effets sonores : on/off + volume

import { ref, watch } from 'vue'

function lire(cle, defaut) {
  try {
    const v = localStorage.getItem(cle)
    if (v === null) return defaut
    return typeof defaut === 'boolean' ? v === 'on' : Number(v)
  } catch { return defaut }
}

function lier(cle, defaut) {
  const r = ref(lire(cle, defaut))
  watch(r, (v) => {
    try { localStorage.setItem(cle, typeof v === 'boolean' ? (v ? 'on' : 'off') : String(v)) } catch {}
  })
  return r
}

export const musiqueOn     = lier('educle_musique', true)
export const musiqueVolume = lier('educle_musique_volume', 0.5)   // 0 → 1
export const effetsOn      = lier('educle_effets', true)
export const effetsVolume  = lier('educle_effets_volume', 0.8)    // 0 → 1

// Volume à appliquer à un effet sonore (0 si les effets sont coupés)
export function volumeEffets() {
  return effetsOn.value ? effetsVolume.value : 0
}
