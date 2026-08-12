"""Sélecteur adaptatif de questions — miroir de lib/services/adaptive_selector.dart.

Algorithme :
  - Les questions jamais vues ont la priorité maximale.
  - Le poids d'une question est proportionnel à (1 - taux_reussite).
  - Les questions répondues correctement récemment sont pénalisées.
  - On tire sans remise jusqu'à nbVoulu questions.
"""
import random
from datetime import datetime, timedelta


def _anciennete_jours(last_correct_at: str | None) -> float:
    """Nombre de jours depuis la dernière bonne réponse (∞ si jamais vue)."""
    if not last_correct_at:
        return float("inf")
    try:
        dt = datetime.fromisoformat(last_correct_at)
        return (datetime.now() - dt).total_seconds() / 86400
    except ValueError:
        return float("inf")


def selectionner(
    pool: list[dict],
    stats: dict[int, dict],
    nb_voulu: int,
    session_ids: set[int] | None = None,
) -> list[dict]:
    """Sélectionne `nb_voulu` questions depuis `pool`.

    Args:
        pool: liste de dicts question (clés : id, chapitre_id, …)
        stats: {question_id: {"nb_affichee": int, "nb_correcte": float, "last_correct_at": str|None}}
        nb_voulu: nombre de questions à retourner
        session_ids: ids déjà répondus dans la session (pénalité légère)

    Returns:
        Liste de questions triée dans un ordre aléatoire pondéré.
    """
    if not pool:
        return []

    session_ids = session_ids or set()
    nb_voulu = min(nb_voulu, len(pool))

    def poids(q: dict) -> float:
        qid = q["id"]
        stat = stats.get(qid)

        if stat is None or stat["nb_affichee"] == 0:
            # Jamais vue : priorité maximum
            w = 10.0
        else:
            taux = stat["nb_correcte"]  # entre 0.0 et 1.0
            w = 1.0 + 9.0 * (1 - taux)  # de 1.0 (parfaite) à 10.0 (jamais réussie)

        # Pénalité pour les questions récentes (< 3 jours)
        anciennete = _anciennete_jours(stat["last_correct_at"] if stat else None)
        if anciennete < 1:
            w *= 0.1
        elif anciennete < 3:
            w *= 0.4

        # Légère pénalité si déjà dans la session
        if qid in session_ids:
            w *= 0.2

        return max(0.01, w)

    poids_liste = [poids(q) for q in pool]

    # Tirage pondéré sans remise
    selected: list[dict] = []
    remaining = list(range(len(pool)))
    remaining_poids = list(poids_liste)

    for _ in range(nb_voulu):
        total = sum(remaining_poids)
        if total <= 0:
            break
        r = random.uniform(0, total)
        cumul = 0.0
        for i, (idx, w) in enumerate(zip(remaining, remaining_poids)):
            cumul += w
            if cumul >= r:
                selected.append(pool[idx])
                remaining.pop(i)
                remaining_poids.pop(i)
                break

    return selected
