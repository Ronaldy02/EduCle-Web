"""Endpoints : réalisations (achievements) et progression par utilisateur."""
from datetime import datetime, timezone
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import select
from pydantic import BaseModel, ConfigDict

from database import get_db
from models import Realisation
from models.defi import RealisationProgres
from dependencies.auth import get_current_user
from models.user import User

router = APIRouter(prefix="/realisations", tags=["Réalisations"])


class RealisationSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: str
    nom: str
    description: str
    groupe: str | None
    rarete: int
    metrique: str | None
    cible: int | None
    secret: int
    filtres: str | None
    # progress utilisateur
    progres: int = 0
    debloquee: bool = False
    debloque_le: str | None = None


class ProgresIn(BaseModel):
    delta: int = 1


@router.get("/", response_model=list[RealisationSchema])
def lister_realisations(
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user),
):
    """Liste toutes les réalisations avec la progression de l'utilisateur."""
    realisations = db.scalars(
        select(Realisation).order_by(Realisation.rarete, Realisation.id)
    ).all()

    progres_rows = db.scalars(
        select(RealisationProgres).where(RealisationProgres.user_id == user.id)
    ).all()
    progres_map = {r.realisation_id: r for r in progres_rows}

    result = []
    for r in realisations:
        p = progres_map.get(r.id)
        result.append({
            "id": r.id,
            "nom": r.nom,
            "description": r.description,
            "groupe": r.groupe,
            "rarete": r.rarete,
            "metrique": r.metrique,
            "cible": r.cible,
            "secret": r.secret,
            "filtres": r.filtres,
            "progres": p.progres if p else 0,
            "debloquee": bool(p.debloquee) if p else False,
            "debloque_le": p.debloque_le if p else None,
        })
    return result


@router.post("/{realisation_id}/progres", response_model=RealisationSchema)
def incrementer_progres(
    realisation_id: str,
    body: ProgresIn,
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user),
):
    real = db.get(Realisation, realisation_id)
    if not real:
        raise HTTPException(404, "Réalisation introuvable.")

    cible = real.cible or real.objectif or 1

    row = db.scalar(
        select(RealisationProgres).where(
            RealisationProgres.user_id == user.id,
            RealisationProgres.realisation_id == realisation_id,
        )
    )
    if row is None:
        new_progres = max(0, min(body.delta, cible))
        debloque = new_progres >= cible
        row = RealisationProgres(
            user_id=user.id,
            realisation_id=realisation_id,
            progres=new_progres,
            debloquee=1 if debloque else 0,
            debloque_le=datetime.now(timezone.utc).isoformat() if debloque else None,
        )
        db.add(row)
    else:
        if row.debloquee:
            pass  # déjà débloquée
        else:
            row.progres = min(row.progres + body.delta, cible)
            if row.progres >= cible:
                row.debloquee = 1
                row.debloque_le = datetime.now(timezone.utc).isoformat()
    db.commit()
    db.refresh(row)

    return {
        "id": real.id, "nom": real.nom, "description": real.description,
        "groupe": real.groupe, "rarete": real.rarete, "metrique": real.metrique,
        "cible": real.cible, "secret": real.secret, "filtres": real.filtres,
        "progres": row.progres, "debloquee": bool(row.debloquee),
        "debloque_le": row.debloque_le,
    }
