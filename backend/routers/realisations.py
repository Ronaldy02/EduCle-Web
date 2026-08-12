"""Endpoints : réalisations (achievements)."""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import select

from database import get_db
from models import Realisation
from pydantic import BaseModel, ConfigDict

router = APIRouter(prefix="/realisations", tags=["Réalisations"])


class RealisationSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: str
    nom: str
    description: str
    categorie: int
    rarete: int
    objectif: int
    recompense_pieces: int
    secret: int
    progres: int
    debloquee: int
    debloquee_at: str | None


@router.get("/", response_model=list[RealisationSchema])
def lister_realisations(db: Session = Depends(get_db)):
    """Liste toutes les réalisations (débloquées et en cours)."""
    return db.scalars(select(Realisation).order_by(Realisation.rarete.desc())).all()
