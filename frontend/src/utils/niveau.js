/** Logique XP / niveaux / rangs — miroir de lib/utils/niveau.dart et services/niveau.py */

export function niveauDepuisXp(xp) {
  if (xp <= 0) return 1
  const n = Math.floor((1 + Math.sqrt(1 + 8 * xp / 100)) / 2)
  return Math.max(1, n)
}

export function xpPourNiveau(n) {
  return 100 * n * (n - 1) / 2
}

export function progressionNiveau(xp) {
  const n = niveauDepuisXp(xp)
  const debut = xpPourNiveau(n)
  const fin = xpPourNiveau(n + 1)
  if (fin === debut) return 1
  return (xp - debut) / (fin - debut)
}

export const RANGS = {
  debutant:    { nom: 'Débutant',    emoji: '🌱', couleur: '#6B7280' },
  apprenti:    { nom: 'Apprenti',    emoji: '📘', couleur: '#3B82F6' },
  explorateur: { nom: 'Explorateur', emoji: '🔎', couleur: '#10B981' },
  confirme:    { nom: 'Confirmé',    emoji: '🧠', couleur: '#8B5CF6' },
  avance:      { nom: 'Avancé',      emoji: '🎓', couleur: '#F59E0B' },
  expert:      { nom: 'Expert',      emoji: '🏆', couleur: '#EF4444' },
  maitre:      { nom: 'Maître',      emoji: '💎', couleur: '#06B6D4' },
  grand_maitre:{ nom: 'Grand Maître',emoji: '👑', couleur: '#F59E0B' },
}

export function rangDepuisNiveau(niveau) {
  if (niveau >= 100) return 'grand_maitre'
  if (niveau >= 75)  return 'maitre'
  if (niveau >= 50)  return 'expert'
  if (niveau >= 30)  return 'avance'
  if (niveau >= 20)  return 'confirme'
  if (niveau >= 10)  return 'explorateur'
  if (niveau >= 5)   return 'apprenti'
  return 'debutant'
}
