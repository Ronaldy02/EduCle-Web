"""Endpoints de synchronisation mobile → serveur."""
from fastapi import APIRouter, Depends
from pydantic import BaseModel
from sqlalchemy.orm import Session
from sqlalchemy import select

from database import get_db
from dependencies.auth import get_current_user
from models.user import User
from models.score import Score
from models.question import StatistiqueQuestion

router = APIRouter(prefix="/sync", tags=["Sync mobile"])


# ── Schémas ──────────────────────────────────────────────────────────────────

class ScoreMobile(BaseModel):
    matiere_id: int | None
    score: int
    nb_correctes: int
    nb_total: int
    mode_nom: str
    date: str


class StatQuestionMobile(BaseModel):
    question_id: int
    nb_affichee: int
    nb_correcte: int


class ProfilMobile(BaseModel):
    niveau_scolaire: str
    annee: str


class SyncPushRequest(BaseModel):
    profil: ProfilMobile | None = None
    scores: list[ScoreMobile] = []
    stats_questions: list[StatQuestionMobile] = []


class SyncPullResponse(BaseModel):
    niveau_scolaire: str
    annee: str
    scores: list[dict]
    stats_questions: list[dict]


# ── Push (mobile → serveur) ──────────────────────────────────────────────────

@router.post("/push")
def push(
    body: SyncPushRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Reçoit les données locales du mobile et les enregistre côté serveur."""

    # Profil
    if body.profil:
        current_user.niveau_scolaire = body.profil.niveau_scolaire
        current_user.annee = body.profil.annee

    # Scores
    for s in body.scores:
        db.add(Score(
            user_id=current_user.id,
            matiere_id=s.matiere_id,
            score=s.score,
            nb_correctes=s.nb_correctes,
            nb_total=s.nb_total,
            mode_nom=s.mode_nom,
            date=s.date,
        ))

    # Stats questions (upsert)
    for sq in body.stats_questions:
        existing = db.scalar(
            select(StatistiqueQuestion).where(
                StatistiqueQuestion.user_id == current_user.id,
                StatistiqueQuestion.question_id == sq.question_id,
            )
        )
        if existing:
            existing.nb_affichee = max(existing.nb_affichee, sq.nb_affichee)
            existing.nb_correcte = max(existing.nb_correcte, sq.nb_correcte)
        else:
            db.add(StatistiqueQuestion(
                user_id=current_user.id,
                question_id=sq.question_id,
                nb_affichee=sq.nb_affichee,
                nb_correcte=float(sq.nb_correcte),
            ))

    db.commit()
    return {"ok": True}


# ── Pull (serveur → mobile) ──────────────────────────────────────────────────

@router.get("/pull", response_model=SyncPullResponse)
def pull(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Retourne toutes les données du compte pour restaurer un nouvel appareil."""

    scores = db.scalars(
        select(Score)
        .where(Score.user_id == current_user.id)
        .order_by(Score.date)
    ).all()

    stats = db.scalars(
        select(StatistiqueQuestion)
        .where(StatistiqueQuestion.user_id == current_user.id)
    ).all()

    return SyncPullResponse(
        niveau_scolaire=current_user.niveau_scolaire or "Fondamental",
        annee=current_user.annee or "7e AF",
        scores=[{
            "matiere_id": s.matiere_id,
            "score": s.score,
            "nb_correctes": s.nb_correctes,
            "nb_total": s.nb_total,
            "mode_nom": s.mode_nom,
            "date": s.date,
        } for s in scores],
        stats_questions=[{
            "question_id": sq.question_id,
            "nb_affichee": sq.nb_affichee,
            "nb_correcte": int(sq.nb_correcte),
        } for sq in stats],
    )
