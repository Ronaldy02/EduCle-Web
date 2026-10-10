"""Endpoints : défis (rotation déterministe) et leur progression par utilisateur."""
from datetime import date, datetime, timezone
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import select
from pydantic import BaseModel, ConfigDict

from database import get_db
from models import Defi, DefiProgres
from dependencies.auth import get_current_user
from models.user import User

router = APIRouter(prefix="/defis", tags=["Défis"])

# ── Constantes de rotation ─────────────────────────────────────────────────────
_EPOCH = date(2026, 1, 1)

_IDS_QUOTIDIENS = [
    # Interleaved palier 1/2/3 — chaque slot de 4 mélange les difficultés
    "D01","D15","D29","D02",  # slot 0 : Facile, Moyen, Difficile, Facile
    "D16","D30","D03","D17",  # slot 1 : Moyen, Difficile, Facile, Moyen
    "D31","D04","D18","D32",  # slot 2 : Difficile, Facile, Moyen, Difficile
    "D05","D19","D33","D06",  # slot 3 : Facile, Moyen, Difficile, Facile
    "D20","D34","D07","D21",  # slot 4 : Moyen, Difficile, Facile, Moyen
    "D35","D08","D22","D36",  # slot 5 : Difficile, Facile, Moyen, Difficile
    "D09","D23","D37","D10",  # slot 6 : Facile, Moyen, Difficile, Facile
    "D24","D38","D11","D25",  # slot 7 : Moyen, Difficile, Facile, Moyen
    "D39","D12","D26","D40",  # slot 8 : Difficile, Facile, Moyen, Difficile
    "D13","D27","D14","D28",  # slot 9 : Facile, Moyen, Facile, Moyen
]
_IDS_HEBDO = [
    "W01","W02","W03","W04","W05","W06","W07","W08","W09","W10",
    "W11","W12","W13","W14","W15","W16","W17","W18","W19","W20",
    "W21","W22","W23","W24","W25",
]
_IDS_MENSUELS = [
    "M01","M02","M03","M04","M05","M06","M07","M08","M09","M10",
    "M11","M12","M13","M14","M15","M16","M17","M18","M19","M20",
    "M21","M22",
]


def _periode_jour(d: date) -> str:
    return d.strftime("%Y-%m-%d")


def _periode_hebdo(d: date) -> str:
    days = (d - _EPOCH).days
    week_index = days // 7
    return f"2026-W{week_index:03d}"


def _periode_mensuel(d: date) -> str:
    epoch_month = 2026 * 12 + 0
    current_month = d.year * 12 + (d.month - 1)
    slot = (current_month - epoch_month) % 11
    return d.strftime("%Y-%m")


def _ids_quotidiens_pour(d: date) -> list[str]:
    days = (d - _EPOCH).days
    slot = days % 10
    return _IDS_QUOTIDIENS[slot * 4: slot * 4 + 4]


def _ids_hebdo_pour(d: date) -> list[str]:
    days = (d - _EPOCH).days
    slot = (days // 7) % 13
    if slot < 12:
        return _IDS_HEBDO[slot * 2: slot * 2 + 2]
    return ["W25"]


def _ids_mensuels_pour(d: date) -> list[str]:
    epoch_month = 2026 * 12 + 0
    current_month = d.year * 12 + (d.month - 1)
    slot = (current_month - epoch_month) % 11
    return _IDS_MENSUELS[slot * 2: slot * 2 + 2]


def _in_range(mmdd: str, start: str, end: str) -> bool:
    if start <= end:
        return start <= mmdd <= end
    return mmdd >= start or mmdd <= end


def _ids_speciaux_pour(d: date, all_defis: list[Defi]) -> list[str]:
    mmdd = d.strftime("%m-%d")
    result = []
    for defi in all_defis:
        if defi.type != "s" or not defi.date_spe:
            continue
        spe = defi.date_spe
        if "/" in spe:
            parts = spe.split("/")
            if _in_range(mmdd, parts[0], parts[1]):
                result.append(defi.id)
        elif spe == mmdd:
            result.append(defi.id)
    return result


# ── Schémas ────────────────────────────────────────────────────────────────────

class DefiSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: str
    type: str
    palier: int
    nom: str
    description: str
    metrique: str
    cible: int
    filtres: str | None
    date_spe: str | None


class DefiAvecProgresSchema(DefiSchema):
    progres: int = 0
    complete: bool = False
    periode: str = ""


class ProgresIn(BaseModel):
    delta: int = 1


# ── Helpers ────────────────────────────────────────────────────────────────────

def _enrichir(defis: list[Defi], progres_rows: list[DefiProgres], periode: str) -> list[dict]:
    progres_map = {r.defi_id: r for r in progres_rows if r.periode == periode}
    result = []
    for d in defis:
        p = progres_map.get(d.id)
        result.append({
            "id": d.id, "type": d.type, "palier": d.palier, "nom": d.nom,
            "description": d.description, "metrique": d.metrique, "cible": d.cible,
            "filtres": d.filtres, "date_spe": d.date_spe,
            "progres": p.progres if p else 0,
            "complete": bool(p.complete) if p else False,
            "periode": periode,
        })
    return result


# ── Endpoints ──────────────────────────────────────────────────────────────────

@router.get("/quotidiens", response_model=list[DefiAvecProgresSchema])
def defis_quotidiens(
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user),
):
    today = date.today()
    ids = _ids_quotidiens_pour(today)
    defis = db.scalars(select(Defi).where(Defi.id.in_(ids))).all()
    defis_sorted = sorted(defis, key=lambda d: ids.index(d.id))
    periode = _periode_jour(today)
    progres = db.scalars(
        select(DefiProgres).where(
            DefiProgres.user_id == user.id,
            DefiProgres.defi_id.in_(ids),
            DefiProgres.periode == periode,
        )
    ).all()
    return _enrichir(defis_sorted, list(progres), periode)


@router.get("/hebdo", response_model=list[DefiAvecProgresSchema])
def defis_hebdo(
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user),
):
    today = date.today()
    ids = _ids_hebdo_pour(today)
    defis = db.scalars(select(Defi).where(Defi.id.in_(ids))).all()
    defis_sorted = sorted(defis, key=lambda d: ids.index(d.id))
    periode = _periode_hebdo(today)
    progres = db.scalars(
        select(DefiProgres).where(
            DefiProgres.user_id == user.id,
            DefiProgres.defi_id.in_(ids),
            DefiProgres.periode == periode,
        )
    ).all()
    return _enrichir(defis_sorted, list(progres), periode)


@router.get("/mensuels", response_model=list[DefiAvecProgresSchema])
def defis_mensuels(
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user),
):
    today = date.today()
    ids = _ids_mensuels_pour(today)
    defis = db.scalars(select(Defi).where(Defi.id.in_(ids))).all()
    defis_sorted = sorted(defis, key=lambda d: ids.index(d.id))
    periode = _periode_mensuel(today)
    progres = db.scalars(
        select(DefiProgres).where(
            DefiProgres.user_id == user.id,
            DefiProgres.defi_id.in_(ids),
            DefiProgres.periode == periode,
        )
    ).all()
    return _enrichir(defis_sorted, list(progres), periode)


@router.get("/speciaux", response_model=list[DefiAvecProgresSchema])
def defis_speciaux(
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user),
):
    today = date.today()
    all_defis = db.scalars(select(Defi).where(Defi.type == "s")).all()
    ids = _ids_speciaux_pour(today, list(all_defis))
    if not ids:
        return []
    defis = [d for d in all_defis if d.id in ids]
    periode = _periode_jour(today)
    progres = db.scalars(
        select(DefiProgres).where(
            DefiProgres.user_id == user.id,
            DefiProgres.defi_id.in_(ids),
            DefiProgres.periode == periode,
        )
    ).all()
    return _enrichir(defis, list(progres), periode)


@router.post("/{defi_id}/progres", response_model=DefiAvecProgresSchema)
def incrementer_progres(
    defi_id: str,
    body: ProgresIn,
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user),
):
    defi = db.get(Defi, defi_id)
    if not defi:
        raise HTTPException(404, "Défi introuvable.")

    today = date.today()
    if defi.type == "d":
        periode = _periode_jour(today)
    elif defi.type == "w":
        periode = _periode_hebdo(today)
    elif defi.type == "m":
        periode = _periode_mensuel(today)
    else:
        periode = _periode_jour(today)

    row = db.scalar(
        select(DefiProgres).where(
            DefiProgres.user_id == user.id,
            DefiProgres.defi_id == defi_id,
            DefiProgres.periode == periode,
        )
    )
    _BONUS_XP    = {1: 20, 2: 50, 3: 100}
    _BONUS_PIECES = {1: 10, 2: 25, 3: 50}

    if row is None:
        new_progres = max(0, min(body.delta, defi.cible))
        newly_complete = new_progres >= defi.cible
        row = DefiProgres(
            user_id=user.id, defi_id=defi_id, periode=periode,
            progres=new_progres, complete=1 if newly_complete else 0,
        )
        db.add(row)
    else:
        if row.complete:
            newly_complete = False
        else:
            row.progres = min(row.progres + body.delta, defi.cible)
            newly_complete = row.progres >= defi.cible
            row.complete = 1 if newly_complete else 0

    if newly_complete:
        user.xp_total     += _BONUS_XP.get(defi.palier, 20)
        user.pieces_total += _BONUS_PIECES.get(defi.palier, 10)

    db.commit()
    db.refresh(row)

    return {
        "id": defi.id, "type": defi.type, "palier": defi.palier, "nom": defi.nom,
        "description": defi.description, "metrique": defi.metrique, "cible": defi.cible,
        "filtres": defi.filtres, "date_spe": defi.date_spe,
        "progres": row.progres, "complete": bool(row.complete), "periode": periode,
    }
