"""Endpoints propositions de questions par les utilisateurs."""
from datetime import datetime
from datetime import timedelta
from typing import Annotated, Literal

from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy.orm import Session
from sqlalchemy import select
from pydantic import BaseModel, Field, StringConstraints

from database import get_db
from models.proposal import QuestionProposal
from models import Question, Chapitre
from services import limiteur

router = APIRouter(prefix="/proposals", tags=["Propositions"])


Choix = Annotated[str, StringConstraints(strip_whitespace=True, min_length=1, max_length=300)]


class ProposalIn(BaseModel):
    chapitre_id: int | None = None
    matiere_id: int | None = None
    nom_proposant: str = Field(default="Anonyme", max_length=60)
    enonce: str = Field(max_length=1000)
    choix: list[Choix] = Field(min_length=2, max_length=6)
    bonne_reponse: str = Field(max_length=300)
    explication: str = Field(default="", max_length=2000)
    niveau_complexite: Literal["Facile", "Moyen", "Difficile"] = "Moyen"


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
def soumettre_proposition(body: ProposalIn, request: Request, db: Session = Depends(get_db)):
    """Soumettre une proposition de question (accessible sans authentification, 10 par heure et par IP)."""
    if not body.enonce.strip():
        raise HTTPException(status_code=422, detail="L'énoncé ne peut pas être vide.")
    if len(body.choix) < 2:
        raise HTTPException(status_code=422, detail="Au moins 2 choix sont requis.")
    if body.bonne_reponse.strip() not in body.choix:
        raise HTTPException(status_code=422, detail="La bonne réponse doit figurer dans les choix.")
    limiteur.limiter(db, f"proposal:ip:{limiteur.ip_client(request)}", 10, timedelta(hours=1))

    p = QuestionProposal(
        chapitre_id=body.chapitre_id,
        matiere_id=body.matiere_id,
        nom_proposant=body.nom_proposant.strip() or "Anonyme",
        enonce=body.enonce.strip(),
        choix=body.choix,
        bonne_reponse=body.bonne_reponse.strip(),
        explication=body.explication.strip(),
        niveau_complexite=body.niveau_complexite,
        statut="en_attente",
        created_at=datetime.now().isoformat(timespec="seconds"),
    )
    db.add(p)
    db.commit()
    db.refresh(p)
    return p
