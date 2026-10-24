// Modes de jeu — source unique (accueil + page de connexion).
// Ajouter un mode ici le fait apparaître partout, compteur compris.
export const MODES = [
  { key: 'revision',    label: 'Révision',     icon: '✓', timing: '30 s / question', color: '#2f6fed', bg: '#e9f0fe',
    desc: 'Correction immédiate après chaque réponse, avec explication pédagogique.' },
  { key: 'rush',        label: 'Rush',         icon: '⚡', timing: '20 s / question', color: '#f2705a', bg: '#fdeee9',
    desc: 'Aucune correction pendant la partie — elle arrive entièrement à la fin. Rapidité pure.' },
  { key: 'genie',       label: 'Génie',        icon: '🧠', timing: '10 s / question', color: '#7c3aed', bg: '#f3e8ff',
    desc: 'Le chrono s\'emballe. Réponds vite, marque plus — aucune correction avant la fin.' },
  { key: 'bombardement', label: 'Bombardement', icon: '⏱', timing: '1 min au total',  color: '#1e2a52', bg: '#e7e9f2',
    desc: 'Réponds à un maximum de questions avant la fin du temps, sous pression.' },
  { key: 'cartes',      label: 'Cartes mentales', icon: '🗂', timing: 'À ton rythme', color: '#059669', bg: '#d1fae5',
    desc: 'Parcours les fiches du chapitre une par une, puis lance un quiz Révision.' },
]

export const NB_MODES = MODES.length
