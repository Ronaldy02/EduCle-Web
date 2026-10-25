"""Endpoints : abonnements Web Push et préférences de rappels."""
import hmac
from urllib.parse import urlsplit
from datetime import date, timezone, datetime
from zoneinfo import ZoneInfo

from fastapi import APIRouter, Depends, HTTPException, Header
from pydantic import BaseModel, Field, field_validator
from sqlalchemy.orm import Session
from sqlalchemy import select, delete

from config import settings
from database import get_db
from dependencies.auth import get_current_user
from models.user import User
from models.abonnement import AbonnementPush
from models.defi import Defi, DefiProgres
from services.push import envoyer
from routers.defis import (
    _ids_quotidiens_pour, _periode_jour, _enrichir,
)

router = APIRouter(prefix="/notifications", tags=["Notifications"])

_TZ_HAP = ZoneInfo("America/Port-au-Prince")


# ─── Schémas ──────────────────────────────────────────────────────────────────

# Hôtes des services Web Push des navigateurs (Chrome/Edge Android, Firefox, Safari, Edge Windows)
_HOTES_PUSH = ("fcm.googleapis.com", "android.googleapis.com", "updates.push.services.mozilla.com",
               "web.push.apple.com")
_SUFFIXES_PUSH = (".push.services.mozilla.com", ".notify.windows.com", ".push.apple.com")
_MAX_ABONNEMENTS = 10


class AbonnerRequest(BaseModel):
    endpoint: str = Field(max_length=1000)
    cle_p256dh: str = Field(max_length=200)
    cle_auth: str = Field(max_length=100)

    @field_validator("endpoint")
    @classmethod
    def _endpoint_push(cls, v: str) -> str:
        url = urlsplit(v)
        hote = (url.hostname or "").lower()
        if url.scheme != "https" or url.port not in (None, 443) or not (
            hote in _HOTES_PUSH or hote.endswith(_SUFFIXES_PUSH)
        ):
            raise ValueError("Adresse d'abonnement push non reconnue.")
        return v


class PreferencesSchema(BaseModel):
    rappel_debut: bool
    rappel_fin: bool


# ─── Endpoints utilisateur ────────────────────────────────────────────────────

@router.post("/abonner", status_code=200)
def abonner(body: AbonnerRequest, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    """Enregistre ou met à jour un abonnement push pour l'utilisateur connecté."""
    existant = db.scalar(select(AbonnementPush).where(AbonnementPush.endpoint == body.endpoint))
    if existant:
        existant.user_id    = current_user.id
        existant.cle_p256dh = body.cle_p256dh
        existant.cle_auth   = body.cle_auth
    else:
        db.add(AbonnementPush(
            user_id=current_user.id,
            endpoint=body.endpoint,
            cle_p256dh=body.cle_p256dh,
            cle_auth=body.cle_auth,
        ))
    db.flush()
    # Au plus 10 appareils par compte : les plus anciens abonnements sont retirés
    anciens = db.scalars(
        select(AbonnementPush.id)
        .where(AbonnementPush.user_id == current_user.id)
        .order_by(AbonnementPush.created_at.desc(), AbonnementPush.id.desc())
        .offset(_MAX_ABONNEMENTS)
    ).all()
    if anciens:
        db.execute(delete(AbonnementPush).where(AbonnementPush.id.in_(anciens)))
    db.commit()
    return {"ok": True}


@router.post("/desabonner", status_code=200)
def desabonner(body: AbonnerRequest, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    """Supprime un abonnement push."""
    db.execute(
        delete(AbonnementPush).where(
            AbonnementPush.endpoint == body.endpoint,
            AbonnementPush.user_id == current_user.id,
        )
    )
    db.commit()
    return {"ok": True}


@router.get("/preferences", response_model=PreferencesSchema)
def get_preferences(current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    """Retourne les préférences de rappels de l'utilisateur (premier abonnement trouvé)."""
    abo = db.scalar(select(AbonnementPush).where(AbonnementPush.user_id == current_user.id))
    if not abo:
        return PreferencesSchema(rappel_debut=True, rappel_fin=True)
    return PreferencesSchema(rappel_debut=abo.rappel_debut, rappel_fin=abo.rappel_fin)


@router.patch("/preferences", response_model=PreferencesSchema)
def set_preferences(
    body: PreferencesSchema,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Met à jour les préférences sur tous les abonnements de l'utilisateur."""
    abos = db.scalars(select(AbonnementPush).where(AbonnementPush.user_id == current_user.id)).all()
    for abo in abos:
        abo.rappel_debut = body.rappel_debut
        abo.rappel_fin   = body.rappel_fin
    db.commit()
    return body


# ─── Déclencheurs cron (protégés par CRON_SECRET) ─────────────────────────────

def _verifier_cron(authorization: str | None):
    if not settings.cron_secret:
        raise HTTPException(503, "CRON_SECRET non configuré.")
    token = (authorization or "").removeprefix("Bearer ").strip()
    if not hmac.compare_digest(token, settings.cron_secret):
        raise HTTPException(401, "Non autorisé.")


@router.post("/cron/debut", status_code=200, include_in_schema=False)
def cron_debut(authorization: str | None = Header(default=None), db: Session = Depends(get_db)):
    """Envoie « Tes défis du jour sont prêts. » à tous les abonnés rappel_debut=True."""
    _verifier_cron(authorization)
    _envoyer_a_tous(db, rappel="debut")
    return {"ok": True}


@router.post("/cron/fin", status_code=200, include_in_schema=False)
def cron_fin(authorization: str | None = Header(default=None), db: Session = Depends(get_db)):
    """Envoie un rappel aux abonnés rappel_fin=True qui ont encore des défis non terminés."""
    _verifier_cron(authorization)
    _envoyer_a_tous(db, rappel="fin")
    return {"ok": True}


def _envoyer_a_tous(db: Session, rappel: str) -> None:
    champ = AbonnementPush.rappel_debut if rappel == "debut" else AbonnementPush.rappel_fin
    abos = db.scalars(select(AbonnementPush).where(champ == True)).all()

    today = datetime.now(_TZ_HAP).date()
    ids_today = _ids_quotidiens_pour(today)
    periode = _periode_jour(today)

    expirer = []
    for abo in abos:
        if rappel == "fin":
            # N'envoyer que si des défis restent à faire
            defis = db.scalars(
                select(Defi).where(Defi.id.in_(ids_today))
            ).all()
            progres_rows = db.scalars(
                select(DefiProgres).where(
                    DefiProgres.user_id == abo.user_id,
                    DefiProgres.defi_id.in_(ids_today),
                    DefiProgres.periode == periode,
                )
            ).all()
            enrichis = _enrichir(defis, list(progres_rows), periode)
            restants = sum(1 for d in enrichis if not d["complete"])
            if restants == 0:
                continue
            corps = f"Il te reste {restants} défi(s) aujourd'hui."
        else:
            corps = "Tes défis du jour sont prêts."

        ok = envoyer(
            endpoint=abo.endpoint,
            cle_p256dh=abo.cle_p256dh,
            cle_auth=abo.cle_auth,
            titre="EduClé",
            corps=corps,
            url="/defis",
        )
        if not ok:
            expirer.append(abo.id)
            abo.derniere_erreur = "410 Gone"

    if expirer:
        db.execute(delete(AbonnementPush).where(AbonnementPush.id.in_(expirer)))
    db.commit()
