"""Endpoints : matières, chapitres, cartes mentales."""
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, selectinload
from sqlalchemy import select

from database import get_db
from models import Matiere, Chapitre, CarteMentale
from schemas.matiere import MatiereSchema, MatiereDetailSchema, ChapitreDetailSchema

router = APIRouter(prefix="/matieres", tags=["Matières"])


@router.get("/", response_model=list[MatiereSchema])
def lister_matieres(niveau: str | None = None, db: Session = Depends(get_db)):
    """Liste toutes les matières, optionnellement filtrées par niveau scolaire."""
    q = select(Matiere)
    if niveau:
        q = q.where(Matiere.niveau == niveau)
    return db.scalars(q.order_by(Matiere.nom)).all()


@router.get("/niveaux", response_model=list[str])
def lister_niveaux(db: Session = Depends(get_db)):
    """Retourne les niveaux scolaires distincts présents dans la base."""
    rows = db.execute(select(Matiere.niveau).distinct()).scalars().all()
    return sorted(rows)


@router.get("/{matiere_id}", response_model=MatiereDetailSchema)
def detail_matiere(matiere_id: int, db: Session = Depends(get_db)):
    """Détail d'une matière avec ses chapitres."""
    matiere = db.scalar(
        select(Matiere)
        .options(selectinload(Matiere.chapitres))
        .where(Matiere.id == matiere_id)
    )
    if not matiere:
        raise HTTPException(status_code=404, detail="Matière introuvable")
    return matiere


@router.get("/{matiere_id}/chapitres/{chapitre_id}", response_model=ChapitreDetailSchema)
def detail_chapitre(matiere_id: int, chapitre_id: int, db: Session = Depends(get_db)):
    """Détail d'un chapitre avec ses cartes mentales."""
    chapitre = db.scalar(
        select(Chapitre)
        .options(selectinload(Chapitre.cartes_mentales))
        .where(Chapitre.id == chapitre_id, Chapitre.matiere_id == matiere_id)
    )
    if not chapitre:
        raise HTTPException(status_code=404, detail="Chapitre introuvable")
    return chapitre
