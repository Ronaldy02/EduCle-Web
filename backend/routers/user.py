"""Endpoints : profil utilisateur et niveau XP."""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import select

from database import get_db
from models import UserPreferences
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
        user = UserPreferences(id=1)
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


@router.get("/scores", response_model=list[ScoreSchema])
def get_scores(matiere_id: int | None = None, db: Session = Depends(get_db)):
    """Historique des scores, optionnellement filtré par matière."""
    q = select(Score).order_by(Score.date.desc()).limit(100)
    if matiere_id is not None:
        q = q.where(Score.matiere_id == matiere_id)
    return db.scalars(q).all()
