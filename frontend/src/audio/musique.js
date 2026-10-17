// ══════════════════════════════════════════════════════════════════════════
//   Musique de fond adaptative (S1–S5), générée en Web Audio — aucun fichier.
//
//   musique.demarrer()        à appeler sur un geste de l'utilisateur (clic, touche)
//   musique.setScene(s)       'calme' (pages) · 'quiz' · 'off'
//   musique.setTension(bool)  zone critique : son plus serré (même tempo)
//   musique.setBombe(n)       palier du Bombardement 0 (aucun) → 4
//   musique.setSerie(bool)    couche de percussions en plus pendant une série
//   musique.duck(niveau, ms)  baisse temporaire (palier, explosion…)
// ══════════════════════════════════════════════════════════════════════════

import { watch } from 'vue'
import { musiqueOn, musiqueVolume } from './reglages.js'

// Grille harmonique : Do – Sol – La m – Fa (une mesure par accord)
const ACCORDS = [
  { basse: 36, notes: [60, 64, 67] },   // Do
  { basse: 43, notes: [59, 62, 67] },   // Sol
  { basse: 45, notes: [57, 60, 64] },   // La m
  { basse: 41, notes: [57, 60, 65] },   // Fa
]
const GAMME = [72, 74, 76, 79, 81, 84, 86, 88]   // pentatonique de Do, octave 5
const RYTHMES = [                                 // positions (sur 16) des notes de mélodie
  [0, 3, 6, 8, 10, 14],
  [0, 2, 4, 7, 10, 12],
  [2, 5, 8, 11, 12, 14],
  [0, 4, 6, 7, 10, 13],
]
const TEMPO = 90   // tempo unique : la musique garde le même rythme partout (pages, quiz, tension)

const midi = (n) => 440 * Math.pow(2, (n - 69) / 12)

let ctx = null
let bus, passeHaut, sceneGain, duckGain, userGain, tensionGain, echo, echoRetour, bruit
let scene = 'calme'
let tension = false
let bombe = 0
let serie = false
let prochainPas = 0
let pas = 0
let mesure = 0
let melodie = []
let planificateur = null

// ── Mise en place du graphe audio ───────────────────────────────────────────
function construire() {
  ctx = new (window.AudioContext || window.webkitAudioContext)()

  userGain  = ctx.createGain()
  duckGain  = ctx.createGain()
  sceneGain = ctx.createGain()
  sceneGain.gain.value = 0
  passeHaut = ctx.createBiquadFilter()
  passeHaut.type = 'highpass'
  passeHaut.frequency.value = 20
  tensionGain = ctx.createGain()
  const compresseur = ctx.createDynamicsCompressor()
  compresseur.threshold.value = -24
  compresseur.ratio.value = 4
  const compensation = ctx.createGain()     // remonte le niveau après compression (~ +11 dB)
  compensation.gain.value = 3.5

  bus = ctx.createGain()
  bus.connect(passeHaut).connect(tensionGain).connect(sceneGain).connect(duckGain)
    .connect(compresseur).connect(compensation).connect(userGain).connect(ctx.destination)

  // Écho rythmé pour la mélodie (donne de l'espace)
  echo = ctx.createDelay(1.5)
  echoRetour = ctx.createGain()
  echoRetour.gain.value = 0.32
  const echoNiveau = ctx.createGain()
  echoNiveau.gain.value = 0.35
  echo.connect(echoRetour).connect(echo)
  echo.connect(echoNiveau).connect(bus)

  // Bruit blanc partagé (charleston, claps, shaker)
  bruit = ctx.createBuffer(1, ctx.sampleRate, ctx.sampleRate)
  const d = bruit.getChannelData(0)
  for (let i = 0; i < d.length; i++) d[i] = Math.random() * 2 - 1

  appliquerVolume()
  nouvelleMelodie()
}

function appliquerVolume() {
  if (!ctx) return
  const v = musiqueOn.value ? musiqueVolume.value ** 2 : 0
  userGain.gain.setTargetAtTime(v, ctx.currentTime, 0.1)
}
watch([musiqueOn, musiqueVolume], appliquerVolume)

// ── Tempo ───────────────────────────────────────────────────────────────────
function bpm() {
  return TEMPO
}
const dureePas = () => 60 / bpm() / 4

// ── Instruments ─────────────────────────────────────────────────────────────
function enveloppe(t, crete, attaque, duree, dest = bus) {
  const g = ctx.createGain()
  g.gain.setValueAtTime(0.0001, t)
  g.gain.exponentialRampToValueAtTime(crete, t + attaque)
  g.gain.exponentialRampToValueAtTime(0.0001, t + duree)
  g.connect(dest)
  return g
}

function osc(type, freq, t, duree, sortie, detune = 0) {
  const o = ctx.createOscillator()
  o.type = type
  o.frequency.setValueAtTime(freq, t)
  o.detune.value = detune
  o.connect(sortie)
  o.start(t)
  o.stop(t + duree + 0.05)
  return o
}

function nappe(accord, t, duree) {
  const filtre = ctx.createBiquadFilter()
  filtre.type = 'lowpass'
  filtre.frequency.value = scene === 'quiz' ? 1400 : 900
  const g = enveloppe(t, 0.045, Math.min(0.5, duree * 0.3), duree)
  filtre.connect(g)
  for (const n of accord.notes) {
    osc('sawtooth', midi(n), t, duree, filtre, -7)
    osc('sawtooth', midi(n), t, duree, filtre, 7)
  }
}

function basse(note, t, duree) {
  const g = enveloppe(t, 0.2, 0.01, duree)
  osc('triangle', midi(note), t, duree, g)
  osc('sine', midi(note - 12), t, duree, g)
}

function pluck(note, t, niveau = 0.08) {
  const g = enveloppe(t, niveau, 0.005, 0.35)
  g.connect(echo)
  osc('triangle', midi(note), t, 0.35, g)
  osc('sine', midi(note + 12), t, 0.2, enveloppe(t, niveau * 0.25, 0.005, 0.2))
}

function grosseCaisse(t, niveau = 0.55) {
  const g = enveloppe(t, niveau, 0.002, 0.28)
  const o = ctx.createOscillator()
  o.frequency.setValueAtTime(150, t)
  o.frequency.exponentialRampToValueAtTime(42, t + 0.12)
  o.connect(g)
  o.start(t)
  o.stop(t + 0.3)
}

function bruitFiltre(t, type, freq, niveau, duree) {
  const src = ctx.createBufferSource()
  src.buffer = bruit
  const f = ctx.createBiquadFilter()
  f.type = type
  f.frequency.value = freq
  src.connect(f).connect(enveloppe(t, niveau, 0.002, duree))
  src.start(t)
  src.stop(t + duree + 0.02)
}

const charleston = (t, niveau = 0.05) => bruitFiltre(t, 'highpass', 7500, niveau, 0.045)
const clap       = (t)                => bruitFiltre(t, 'bandpass', 1500, 0.22, 0.13)
const shaker     = (t, niveau)        => bruitFiltre(t, 'bandpass', 6000, niveau, 0.06)

// ── Mélodie : un motif de 2 mesures, répété avec variation, renouvelé toutes les 8 mesures
function nouvelleMelodie() {
  const motif = []
  for (let m = 0; m < 2; m++) {
    const rythme = RYTHMES[Math.floor(Math.random() * RYTHMES.length)]
    let i = 2 + Math.floor(Math.random() * 3)
    motif.push(rythme.map(p => {
      i = Math.max(0, Math.min(GAMME.length - 1, i + Math.floor(Math.random() * 5) - 2))
      return { p, note: GAMME[i] }
    }))
  }
  // mesures 3–4 : même motif, la fin monte d'un cran (question → réponse)
  const variation = motif[1].map((n, k, arr) =>
    k === arr.length - 1 ? { ...n, note: GAMME[Math.min(GAMME.length - 1, GAMME.indexOf(n.note) + 2)] } : n)
  melodie = [motif[0], motif[1], motif[0], variation]
}

// ── Planification d'un pas (double croche) ──────────────────────────────────
function planifier(p, t) {
  const accord = ACCORDS[mesure % 4]
  const quiz = scene === 'quiz'
  const dPas = dureePas()

  if (p === 0) nappe(accord, t, dPas * 16)

  // Basse : temps 1 et 3 au calme, croches en quiz
  if (quiz ? p % 2 === 0 : (p === 0 || p === 8)) {
    basse(accord.basse + (quiz && p % 4 === 2 ? 12 : 0), t, quiz ? dPas * 1.6 : dPas * 7)
  }

  // Mélodie (plus clairsemée au calme)
  const notes = melodie[mesure % 4]
  const n = notes.find(x => x.p === p)
  if (n && (quiz || p % 4 !== 2)) pluck(n.note, t, quiz ? 0.075 : 0.06)

  if (quiz) {
    if (p === 0 || p === 6 || p === 8) grosseCaisse(t)
    if (p === 4 || p === 12) clap(t)
    if (p % 2 === 0) charleston(t, p % 4 === 2 ? 0.07 : 0.04)
  } else if (p % 4 === 2) {
    charleston(t, 0.025)
  }

  // S4 · série : shaker en doubles croches + grosse caisse supplémentaire
  if (serie && quiz) {
    shaker(t, p % 2 ? 0.03 : 0.055)
    if (p === 14) grosseCaisse(t, 0.35)
  }
}

function boucle() {
  while (prochainPas < ctx.currentTime + 0.12) {
    planifier(pas, prochainPas)
    prochainPas += dureePas()
    pas = (pas + 1) % 16
    if (pas === 0) {
      mesure++
      if (mesure % 8 === 0) nouvelleMelodie()
      echo.delayTime.setValueAtTime(dureePas() * 3, prochainPas)
    }
  }
}

// S3 · tension : le passe-haut amincit le son, le gain compense la perte de graves
function filtrer() {
  if (!ctx) return
  const serre = tension || bombe >= 4
  passeHaut.frequency.setTargetAtTime(serre ? 200 : 20, ctx.currentTime, 0.15)
  tensionGain.gain.setTargetAtTime(serre ? 1.45 : 1, ctx.currentTime, 0.15)
}

// ── API ─────────────────────────────────────────────────────────────────────
function fondu(cible, duree = 0.6) {
  sceneGain.gain.cancelScheduledValues(ctx.currentTime)
  sceneGain.gain.setValueAtTime(sceneGain.gain.value, ctx.currentTime)
  sceneGain.gain.linearRampToValueAtTime(cible, ctx.currentTime + duree)
}

export const musique = {
  demarrer() {
    if (!ctx) construire()
    if (ctx.state === 'suspended') ctx.resume()
    if (!planificateur) {
      prochainPas = ctx.currentTime + 0.05
      planificateur = setInterval(boucle, 25)
    }
    if (scene !== 'off') fondu(1, 1.2)
  },

  setScene(s) {
    if (s === scene) return
    scene = s
    if (!ctx) return
    // S5 · fondu au changement de scène
    if (s === 'off') fondu(0, 0.5)
    else {
      sceneGain.gain.cancelScheduledValues(ctx.currentTime)
      sceneGain.gain.setValueAtTime(sceneGain.gain.value, ctx.currentTime)
      sceneGain.gain.linearRampToValueAtTime(0.35, ctx.currentTime + 0.25)
      sceneGain.gain.linearRampToValueAtTime(1, ctx.currentTime + 1.2)
    }
  },

  setTension(on) {
    if (on === tension) return
    tension = on
    filtrer()
  },

  setBombe(n) {
    bombe = n
    filtrer()
  },

  setSerie(on) { serie = on },

  duck(niveau = 0.3, ms = 1500) {
    if (!ctx) return
    const t = ctx.currentTime
    duckGain.gain.cancelScheduledValues(t)
    duckGain.gain.setValueAtTime(duckGain.gain.value, t)
    duckGain.gain.linearRampToValueAtTime(niveau, t + 0.15)
    duckGain.gain.setValueAtTime(niveau, t + ms / 1000)
    duckGain.gain.linearRampToValueAtTime(1, t + ms / 1000 + 0.5)
  },
}

// Onglet masqué : on met la musique en pause
document.addEventListener('visibilitychange', () => {
  if (!ctx) return
  if (document.hidden) ctx.suspend()
  else if (planificateur) {
    ctx.resume().then(() => { prochainPas = Math.max(prochainPas, ctx.currentTime + 0.05) })
  }
})
