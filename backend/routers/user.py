"""Endpoints : profil utilisateur, niveau XP et statistiques (par compte)."""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import select, func
from pydantic import BaseModel

from database import get_db
from models.user import User
from models.question import Question, StatistiqueQuestion
from models.matiere import Matiere, Chapitre
from models.score import Score
from schemas.user import NiveauSchema, ScoreSchema
from dependencies.auth import get_current_user
from services.niveau import (
    niveau_depuis_xp, rang_depuis_niveau, RANGS,
    progression_niveau, xp_dans_niveau_actuel, xp_pour_niveau_suivant,
)

router = APIRouter(prefix="/user", tags=["Utilisateur"])


# ─── Schémas locaux ───────────────────────────────────────────────────────────

class UserUpdateRequest(BaseModel):
    pseudo: str | None = None
    zone: str | None = None
    niveau_scolaire: str | None = None
    annee: str | None = None


class UserSchema(BaseModel):
    id: int
    email: str
    pseudo: str
    zone: str
    niveau_scolaire: str
    annee: str
    xp_total: int
    pieces_total: int
    model_config = {"from_attributes": True}


class ChapitreStatSchema(BaseModel):
    id: int
    titre: str
    nb_vues: int
    reussite: float


class MatiereStatSchema(BaseModel):
    id: int
    nom: str
    niveau: str
    nb_vues: int
    reussite: float
    chapitres: list[ChapitreStatSchema]


class StatsSchema(BaseModel):
    questions_vues: int
    reussite_globale: float
    nb_quiz: int
    matieres: list[MatiereStatSchema]


class ClassementEntreeSchema(BaseModel):
    rang: int
    pseudo: str
    zone: str
    score: int
    nb_correctes: int
    nb_total: int
    label: str
    nb_sessions: int


# ─── Profil ──────────────────────────────────────────────────────────────────

@router.get("/profil", response_model=UserSchema)
def get_profil(current_user: User = Depends(get_current_user)):
    return current_user


@router.patch("/profil", response_model=UserSchema)
def update_profil(
    body: UserUpdateRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    if body.pseudo is not None:
        current_user.pseudo = body.pseudo
    if body.zone is not None:
        current_user.zone = body.zone
    if body.niveau_scolaire is not None:
        current_user.niveau_scolaire = body.niveau_scolaire
    if body.annee is not None:
        current_user.annee = body.annee
    db.commit()
    db.refresh(current_user)
    return current_user


# ─── Niveau / XP ─────────────────────────────────────────────────────────────

@router.get("/niveau", response_model=NiveauSchema)
def get_niveau(current_user: User = Depends(get_current_user)):
    xp = current_user.xp_total
    niv = niveau_depuis_xp(xp)
    rang_id = rang_depuis_niveau(niv)
    rang = RANGS[rang_id]
    return NiveauSchema(
        xp_total=xp,
        pieces_total=current_user.pieces_total,
        niveau=niv,
        rang=rang_id,
        rang_nom=rang["nom"],
        rang_emoji=rang["emoji"],
        rang_couleur=rang["couleur"],
        progression=progression_niveau(xp),
        xp_dans_niveau=xp_dans_niveau_actuel(xp),
        xp_pour_suivant=xp_pour_niveau_suivant(niv),
    )


# ─── Statistiques ────────────────────────────────────────────────────────────

@router.get("/stats", response_model=StatsSchema)
def get_stats(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    rows = db.execute(
        select(
            Chapitre.id,
            Chapitre.titre,
            Chapitre.matiere_id,
            func.sum(StatistiqueQuestion.nb_affichee).label("nb_vues"),
            func.sum(
                StatistiqueQuestion.nb_correcte * StatistiqueQuestion.nb_affichee
            ).label("sum_correcte"),
        )
        .join(Question, Question.chapitre_id == Chapitre.id)
        .join(
            StatistiqueQuestion,
            (StatistiqueQuestion.question_id == Question.id)
            & (StatistiqueQuestion.user_id == current_user.id),
        )
        .group_by(Chapitre.id, Chapitre.titre, Chapitre.matiere_id)
    ).all()

    chap_par_matiere: dict[int, list] = {}
    for r in rows:
        chap_par_matiere.setdefault(r.matiere_id, []).append(r)

    matieres_orm = db.scalars(select(Matiere).order_by(Matiere.nom)).all()

    matieres_stat = []
    total_vues = 0
    total_correcte = 0.0

    for mat in matieres_orm:
        chaps = chap_par_matiere.get(mat.id, [])
        if not chaps:
            continue
        mat_vues = sum(c.nb_vues for c in chaps)
        mat_sum_cor = sum(c.sum_correcte for c in chaps)
        mat_reussite = mat_sum_cor / mat_vues if mat_vues else 0.0
        total_vues += mat_vues
        total_correcte += mat_sum_cor

        matieres_stat.append(MatiereStatSchema(
            id=mat.id,
            nom=mat.nom,
            niveau=mat.niveau,
            nb_vues=mat_vues,
            reussite=round(mat_reussite, 3),
            chapitres=[
                ChapitreStatSchema(
                    id=c.id,
                    titre=c.titre,
                    nb_vues=c.nb_vues,
                    reussite=round(c.sum_correcte / c.nb_vues if c.nb_vues else 0.0, 3),
                )
                for c in sorted(chaps, key=lambda x: x.titre)
            ],
        ))

    nb_quiz = db.scalar(
        select(func.count()).select_from(Score).where(Score.user_id == current_user.id)
    ) or 0

    return StatsSchema(
        questions_vues=total_vues,
        reussite_globale=round(total_correcte / total_vues if total_vues else 0.0, 3),
        nb_quiz=nb_quiz,
        matieres=sorted(matieres_stat, key=lambda m: -m.nb_vues),
    )


# ─── Scores ──────────────────────────────────────────────────────────────────

@router.get("/scores", response_model=list[ScoreSchema])
def get_scores(
    matiere_id: int | None = None,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    q = (
        select(Score)
        .where(Score.user_id == current_user.id)
        .order_by(Score.date.desc())
        .limit(100)
    )
    if matiere_id is not None:
        q = q.where(Score.matiere_id == matiere_id)
    return db.scalars(q).all()


# ─── Classement ──────────────────────────────────────────────────────────────

@router.get("/classement", response_model=list[ClassementEntreeSchema])
def get_classement(
    periode: str = "general",
    matiere_id: int | None = None,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    from datetime import datetime, timedelta, timezone

    now = datetime.now(timezone.utc)
    date_min: str | None = None
    if periode == "semaine":
        date_min = (now - timedelta(days=7)).isoformat()
    elif periode == "mois":
        date_min = (now - timedelta(days=30)).isoformat()
    elif periode == "annee":
        date_min = (now - timedelta(days=365)).isoformat()

    if matiere_id is None:
        q = (
            select(
                Matiere.nom.label("label"),
                func.sum(Score.score).label("total_score"),
                func.sum(Score.nb_correctes).label("total_correctes"),
                func.sum(Score.nb_total).label("total_total"),
                func.count(Score.id).label("nb_sessions"),
            )
            .join(Score, Score.matiere_id == Matiere.id)
            .where(Score.user_id == current_user.id)
            .group_by(Matiere.id, Matiere.nom)
            .order_by(func.sum(Score.score).desc())
        )
    else:
        q = (
            select(
                Score.mode_nom.label("label"),
                func.sum(Score.score).label("total_score"),
                func.sum(Score.nb_correctes).label("total_correctes"),
                func.sum(Score.nb_total).label("total_total"),
                func.count(Score.id).label("nb_sessions"),
            )
            .where(Score.matiere_id == matiere_id, Score.user_id == current_user.id)
            .group_by(Score.mode_nom)
            .order_by(func.sum(Score.score).desc())
        )

    if date_min:
        q = q.where(Score.date >= date_min)

    rows = db.execute(q).all()

    return [
        ClassementEntreeSchema(
            rang=i + 1,
            pseudo=current_user.pseudo or "Moi",
            zone=current_user.zone or "—",
            score=r.total_score,
            nb_correctes=r.total_correctes,
            nb_total=r.total_total,
            label=r.label,
            nb_sessions=r.nb_sessions,
        )
        for i, r in enumerate(rows)
    ]
