"""Endpoint principal du quiz : démarrer, répondre, terminer.

Flux :
  POST /quiz/demarrer  → reçoit chapitre_id + mode_nom + nb_questions
                         → retourne la liste des questions sélectionnées
  POST /quiz/terminer  → reçoit les réponses de l'utilisateur
                         → calcule le score, met à jour XP/pièces/stats
                         → retourne ResultatQuizSchema
"""
import random
from datetime import datetime
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import select

from database import get_db
from models import Matiere, Chapitre, Question, StatistiqueQuestion, UserPreferences
from models.score import Score
from schemas.question import QuestionSchema
from schemas.quiz import DemarrerQuizRequest, ResultatQuizSchema, QuestionResultatSchema
from services.adaptive_selector import selectionner
from services.niveau import (
    calculer_xp_question,
    calculer_pieces_question,
    niveau_depuis_xp,
)

router = APIRouter(prefix="/quiz", tags=["Quiz"])


def _get_stats(db: Session, question_ids: list[int]) -> dict[int, dict]:
    rows = db.scalars(
        select(StatistiqueQuestion).where(StatistiqueQuestion.question_id.in_(question_ids))
    ).all()
    return {
        r.question_id: {
            "nb_affichee": r.nb_affichee,
            "nb_correcte": r.nb_correcte,
            "last_correct_at": r.last_correct_at,
        }
        for r in rows
    }


def _questions_du_chapitre(db: Session, chapitre_id: int) -> list[Question]:
    if chapitre_id == -1:
        # Toutes les matières
        return db.scalars(select(Question)).all()
    return db.scalars(
        select(Question).where(Question.chapitre_id == chapitre_id)
    ).all()


@router.post("/demarrer", response_model=list[QuestionSchema])
def demarrer_quiz(body: DemarrerQuizRequest, db: Session = Depends(get_db)):
    """Sélectionne les questions du quiz de façon adaptative."""
    questions_orm = _questions_du_chapitre(db, body.chapitre_id)
    if not questions_orm:
        raise HTTPException(status_code=404, detail="Aucune question pour ce chapitre")

    pool = []
    for q in questions_orm:
        choix = list(q.choix)
        random.shuffle(choix)
        pool.append({
            "id": q.id,
            "chapitre_id": q.chapitre_id,
            "enonce": q.enonce,
            "choix": choix,
            "bonne_reponse": q.bonne_reponse,
            "explication": q.explication,
            "niveau_complexite": q.niveau_complexite,
        })

    stats = _get_stats(db, [q["id"] for q in pool])
    selected = selectionner(pool=pool, stats=stats, nb_voulu=body.nb_questions)
    return [QuestionSchema(**q) for q in selected]


class ReponseItem(DemarrerQuizRequest):
    pass


from pydantic import BaseModel

class ReponseUtilisateur(BaseModel):
    question_id: int
    reponse: str
    temps_restant: int = 0


class TerminerQuizRequest(BaseModel):
    chapitre_id: int
    matiere_id: int | None = None
    mode_nom: str
    reponses: list[ReponseUtilisateur]


_PALIERS_SERIE = {5: 5, 10: 10, 15: 18, 20: 25}


def _calculer_bonus_serie(correctes: list[bool], mode_nom: str) -> tuple[int, int]:
    """Retourne (pièces_bonus, série_max). Uniquement pour Rush et Révision."""
    if mode_nom == "Bombardement":
        return 0, 0
    serie = 0
    serie_max = 0
    paliers_atteints: set[int] = set()
    bonus_total = 0
    for c in correctes:
        if c:
            serie += 1
            serie_max = max(serie_max, serie)
            for palier, bonus in _PALIERS_SERIE.items():
                if serie >= palier and palier not in paliers_atteints:
                    paliers_atteints.add(palier)
                    bonus_total += bonus
        else:
            serie = 0
            paliers_atteints.clear()
    return bonus_total, serie_max


@router.post("/terminer", response_model=ResultatQuizSchema)
def terminer_quiz(body: TerminerQuizRequest, db: Session = Depends(get_db)):
    """Corrige les réponses, met à jour les stats et retourne le résultat."""
    question_ids = [r.question_id for r in body.reponses]
    questions_orm = db.scalars(
        select(Question).where(Question.id.in_(question_ids))
    ).all()
    questions_map = {q.id: q for q in questions_orm}

    stats = _get_stats(db, question_ids)
    now_iso = datetime.now().isoformat(timespec="seconds")

    xp_total_gagne = 0
    pieces_totales_gagnees = 0
    resultats: list[QuestionResultatSchema] = []

    for rep in body.reponses:
        q = questions_map.get(rep.question_id)
        if not q:
            continue

        correcte = rep.reponse.strip() == q.bonne_reponse.strip()
        stat = stats.get(q.id, {"nb_affichee": 0, "nb_correcte": 0.0, "last_correct_at": None})
        maitrise = stat["nb_correcte"]

        xp = calculer_xp_question(maitrise, body.mode_nom) if correcte else 0
        pieces = calculer_pieces_question(correcte, body.mode_nom)
        xp_total_gagne += xp
        pieces_totales_gagnees += pieces

        resultats.append(QuestionResultatSchema(
            question_id=q.id,
            enonce=q.enonce,
            choix=q.choix,
            bonne_reponse=q.bonne_reponse,
            explication=q.explication,
            reponse_donnee=rep.reponse,
            correcte=correcte,
            xp_gagne=xp,
        ))

        # ── Mise à jour des statistiques adaptatives ─────────────────────────
        stat_orm = db.get(StatistiqueQuestion, q.id)
        if stat_orm is None:
            stat_orm = StatistiqueQuestion(question_id=q.id, nb_affichee=0, nb_correcte=0.0)
            db.add(stat_orm)

        nb = stat_orm.nb_affichee + 1
        # Taux de réussite glissant (moyenne mobile)
        nouveau_taux = (stat_orm.nb_correcte * stat_orm.nb_affichee + (1.0 if correcte else 0.0)) / nb
        stat_orm.nb_affichee = nb
        stat_orm.nb_correcte = nouveau_taux
        if correcte:
            stat_orm.last_correct_at = now_iso

    # ── Bonus de série ────────────────────────────────────────────────────────
    ordre_correctes = [r.correcte for r in resultats]
    serie_bonus, serie_max = _calculer_bonus_serie(ordre_correctes, body.mode_nom)
    pieces_totales_gagnees += serie_bonus

    # ── Mise à jour XP / pièces utilisateur ──────────────────────────────────
    user = db.get(UserPreferences, 1)
    if not user:
        user = UserPreferences(id=1)
        db.add(user)

    niveau_avant = niveau_depuis_xp(user.xp_total)
    user.xp_total += xp_total_gagne
    user.pieces_total += pieces_totales_gagnees
    niveau_apres = niveau_depuis_xp(user.xp_total)

    # ── Enregistrement du score ───────────────────────────────────────────────
    score_val = sum(1 for r in resultats if r.correcte)
    db.add(Score(
        matiere_id=body.matiere_id,
        score=score_val,
        nb_correctes=score_val,
        nb_total=len(resultats),
        mode_nom=body.mode_nom,
        date=now_iso,
    ))

    db.commit()

    return ResultatQuizSchema(
        score=score_val,
        total=len(resultats),
        mode_nom=body.mode_nom,
        questions=resultats,
        xp_gagne=xp_total_gagne,
        pieces_gagnees=pieces_totales_gagnees,
        serie_bonus=serie_bonus,
        serie_max=serie_max,
        xp_total=user.xp_total,
        pieces_total=user.pieces_total,
        niveau_avant=niveau_avant,
        niveau_apres=niveau_apres,
    )
