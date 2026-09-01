"""Endpoints : profil utilisateur et niveau XP."""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import select, func
from pydantic import BaseModel

from database import get_db
from models import UserPreferences
from models.question import Question, StatistiqueQuestion
from models.matiere import Matiere, Chapitre
from schemas.user import UserSchema, UserUpdateRequest, NiveauSchema, ScoreSchema
from models.score import Score
from services.niveau import (
    niveau_depuis_xp, rang_depuis_niveau, RANGS,
    progression_niveau, xp_dans_niveau_actuel, xp_pour_niveau_suivant,
)

router = APIRouter(prefix="/user", tags=["Utilisateur"])


def _get_or_create_user(db: Session) -> UserPreferences:
    user = db.get(UserPreferences, 1)
    if not user:
        user = UserPreferences(id=1, pieces_total=100)
        db.add(user)
        db.commit()
        db.refresh(user)
    return user


@router.get("/profil", response_model=UserSchema)
def get_profil(db: Session = Depends(get_db)):
    return _get_or_create_user(db)


@router.patch("/profil", response_model=UserSchema)
def update_profil(body: UserUpdateRequest, db: Session = Depends(get_db)):
    user = _get_or_create_user(db)
    if body.zone is not None:
        user.zone = body.zone
    if body.niveau_scolaire is not None:
        user.niveau_scolaire = body.niveau_scolaire
    if body.annee is not None:
        user.annee = body.annee
    db.commit()
    db.refresh(user)
    return user


@router.get("/niveau", response_model=NiveauSchema)
def get_niveau(db: Session = Depends(get_db)):
    """Retourne le niveau, rang et progression XP de l'utilisateur."""
    user = _get_or_create_user(db)
    xp = user.xp_total
    niv = niveau_depuis_xp(xp)
    rang_id = rang_depuis_niveau(niv)
    rang = RANGS[rang_id]
    return NiveauSchema(
        xp_total=xp,
        pieces_total=user.pieces_total,
        niveau=niv,
        rang=rang_id,
        rang_nom=rang["nom"],
        rang_emoji=rang["emoji"],
        rang_couleur=rang["couleur"],
        progression=progression_niveau(xp),
        xp_dans_niveau=xp_dans_niveau_actuel(xp),
        xp_pour_suivant=xp_pour_niveau_suivant(niv),
    )


class ChapitreStatSchema(BaseModel):
    id: int
    titre: str
    nb_vues: int
    reussite: float   # 0.0 – 1.0


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


@router.get("/stats", response_model=StatsSchema)
def get_stats(db: Session = Depends(get_db)):
    """Statistiques d'apprentissage agrégées par matière et chapitre."""
    # Agrégation par chapitre : SUM(nb_affichee), moyenne pondérée de nb_correcte
    rows = db.execute(
        select(
            Chapitre.id,
            Chapitre.titre,
            Chapitre.matiere_id,
            func.sum(StatistiqueQuestion.nb_affichee).label("nb_vues"),
            func.sum(StatistiqueQuestion.nb_correcte * StatistiqueQuestion.nb_affichee).label("sum_correcte"),
        )
        .join(Question, Question.chapitre_id == Chapitre.id)
        .join(StatistiqueQuestion, StatistiqueQuestion.question_id == Question.id)
        .group_by(Chapitre.id, Chapitre.titre, Chapitre.matiere_id)
    ).all()

    # Index par matiere_id
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

    nb_quiz = db.scalar(select(func.count()).select_from(Score)) or 0

    return StatsSchema(
        questions_vues=total_vues,
        reussite_globale=round(total_correcte / total_vues if total_vues else 0.0, 3),
        nb_quiz=nb_quiz,
        matieres=sorted(matieres_stat, key=lambda m: -m.nb_vues),
    )


@router.get("/scores", response_model=list[ScoreSchema])
def get_scores(matiere_id: int | None = None, db: Session = Depends(get_db)):
    """Historique des scores, optionnellement filtré par matière."""
    q = select(Score).order_by(Score.date.desc()).limit(100)
    if matiere_id is not None:
        q = q.where(Score.matiere_id == matiere_id)
    return db.scalars(q).all()
