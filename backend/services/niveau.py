"""Logique XP / niveaux / rangs — miroir de lib/utils/niveau.dart."""
import math


# ─── Niveaux ──────────────────────────────────────────────────────────────────

def niveau_depuis_xp(xp: int) -> int:
    """Calcule le niveau à partir du total XP.

    Formule : floor((1 + sqrt(1 + 8*xp/100)) / 2)
    Niveau minimum : 1.
    """
    if xp <= 0:
        return 1
    n = math.floor((1 + math.sqrt(1 + 8 * xp / 100)) / 2)
    return max(1, n)


def xp_pour_niveau(n: int) -> int:
    """XP total nécessaire pour *atteindre* le niveau n.

    Formule : 100 * n * (n-1) / 2
    """
    return 100 * n * (n - 1) // 2


def xp_dans_niveau_actuel(xp: int) -> int:
    """XP accumulé depuis le début du niveau actuel."""
    n = niveau_depuis_xp(xp)
    return xp - xp_pour_niveau(n)


def xp_pour_niveau_suivant(niveau: int) -> int:
    """XP *supplémentaire* nécessaire pour passer du niveau `niveau` au suivant."""
    return xp_pour_niveau(niveau + 1) - xp_pour_niveau(niveau)


def progression_niveau(xp: int) -> float:
    """Progression dans le niveau actuel, entre 0.0 et 1.0."""
    n = niveau_depuis_xp(xp)
    xp_debut = xp_pour_niveau(n)
    xp_fin = xp_pour_niveau(n + 1)
    if xp_fin == xp_debut:
        return 1.0
    return (xp - xp_debut) / (xp_fin - xp_debut)


# ─── Rangs ────────────────────────────────────────────────────────────────────

RANGS: dict[str, dict] = {
    "debutant":    {"nom": "Débutant",    "emoji": "🌱", "couleur": "#6B7280", "niveau_min": 1},
    "apprenti":    {"nom": "Apprenti",    "emoji": "📘", "couleur": "#3B82F6", "niveau_min": 5},
    "explorateur": {"nom": "Explorateur", "emoji": "🔎", "couleur": "#10B981", "niveau_min": 10},
    "confirme":    {"nom": "Confirmé",    "emoji": "🧠", "couleur": "#8B5CF6", "niveau_min": 20},
    "avance":      {"nom": "Avancé",      "emoji": "🎓", "couleur": "#F59E0B", "niveau_min": 30},
    "expert":      {"nom": "Expert",      "emoji": "🏆", "couleur": "#EF4444", "niveau_min": 50},
    "maitre":      {"nom": "Maître",      "emoji": "💎", "couleur": "#06B6D4", "niveau_min": 75},
    "grand_maitre":{"nom": "Grand Maître","emoji": "👑", "couleur": "#F59E0B", "niveau_min": 100},
}


def rang_depuis_niveau(niveau: int) -> str:
    """Identifiant du rang pour un niveau donné."""
    if niveau >= 100: return "grand_maitre"
    if niveau >= 75:  return "maitre"
    if niveau >= 50:  return "expert"
    if niveau >= 30:  return "avance"
    if niveau >= 20:  return "confirme"
    if niveau >= 10:  return "explorateur"
    if niveau >= 5:   return "apprenti"
    return "debutant"


# ─── XP par question ──────────────────────────────────────────────────────────

def calculer_xp_question(maitrise: float, mode_nom: str, double_xp: bool = False) -> int:
    """XP pour une bonne réponse.

    Formule : (2 + 8 × (1 − maîtrise)) × facteur_mode
    - Rush et Bombardement : facteur 1.5
    - Révision : facteur 1.0
    Minimum : 2 XP.
    Double XP double le résultat final.
    """
    facteur = 1.5 if mode_nom in ("Rush", "Bombardement") else 1.0
    xp = (2 + 8 * (1 - maitrise)) * facteur
    xp = max(2, round(xp))
    return xp * 2 if double_xp else xp


def calculer_pieces_question(correcte: bool, mode_nom: str) -> int:
    """Pièces pour une réponse (base simple)."""
    if not correcte:
        return 0
    return {"Rush": 3, "Bombardement": 3}.get(mode_nom, 2)
