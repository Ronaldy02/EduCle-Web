"""Endpoints propositions de questions par les utilisateurs."""
from datetime import datetime
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import select
from pydantic import BaseModel

from database import get_db
from models.proposal import QuestionProposal
from models import Question, Chapitre

router = APIRouter(prefix="/proposals", tags=["Propositions"])


class ProposalIn(BaseModel):
    chapitre_id: int | None = None
    matiere_id: int | None = None
    nom_proposant: str = "Anonyme"
    enonce: str
    choix: list[str]
    bonne_reponse: str
    explication: str = ""
    niveau_complexite: str = "Moyen"


class ProposalOut(BaseModel):
    id: int
    chapitre_id: int | None
    matiere_id: int | None
    nom_proposant: str
    enonce: str
    choix: list[str]
    bonne_reponse: str
    explication: str
    niveau_complexite: str
    statut: str
    created_at: str
    remarque_admin: str | None = None

    class Config:
        from_attributes = True


class ProposalPatch(BaseModel):
    statut: str  # "approuve" | "rejete"
    remarque_admin: str | None = None


@router.post("/", response_model=ProposalOut, status_code=201)
def soumettre_proposition(body: ProposalIn, db: Session = Depends(get_db)):
    """Soumettre une proposition de question (accessible sans authentification)."""
    if not body.enonce.strip():
        raise HTTPException(status_code=422, detail="L'énoncé ne peut pas être vide.")
    if len(body.choix) < 2:
        raise HTTPException(status_code=422, detail="Au moins 2 choix sont requis.")
    if body.bonne_reponse not in body.choix:
        raise HTTPException(status_code=422, detail="La bonne réponse doit figurer dans les choix.")

    p = QuestionProposal(
        chapitre_id=body.chapitre_id,
        matiere_id=body.matiere_id,
        nom_proposant=body.nom_proposant.strip() or "Anonyme",
        enonce=body.enonce.strip(),
        choix=body.choix,
        bonne_reponse=body.bonne_reponse,
        explication=body.explication.strip(),
        niveau_complexite=body.niveau_complexite,
        statut="en_attente",
        created_at=datetime.now().isoformat(timespec="seconds"),
    )
    db.add(p)
    db.commit()
    db.refresh(p)
    return p
