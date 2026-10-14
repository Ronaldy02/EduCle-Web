"""Limitation de débit stockée en base (Vercel lance plusieurs instances, la mémoire ne suffit pas)."""
from datetime import datetime, timedelta, timezone

from fastapi import HTTPException, Request
from sqlalchemy import select, func, delete
from sqlalchemy.orm import Session

from models.securite import Tentative


def ip_client(request: Request) -> str:
    """IP du client : Vercel place la vraie IP en tête de X-Forwarded-For."""
    xff = request.headers.get("x-forwarded-for", "")
    if xff:
        return xff.split(",")[0].strip()[:64]
    return request.client.host if request.client else "inconnue"


def verifier(db: Session, cle: str, maximum: int, fenetre: timedelta) -> None:
    """429 si `cle` a déjà `maximum` tentatives dans la fenêtre."""
    depuis = datetime.now(timezone.utc) - fenetre
    nb = db.scalar(
        select(func.count(Tentative.id)).where(Tentative.cle == cle[:300], Tentative.created_at >= depuis)
    )
    if nb >= maximum:
        raise HTTPException(429, "Trop de tentatives. Réessaie dans quelques minutes.")


def enregistrer(db: Session, cle: str) -> None:
    """Compte une tentative et purge celles de plus d'un jour pour cette clé."""
    cle = cle[:300]
    db.execute(delete(Tentative).where(
        Tentative.cle == cle,
        Tentative.created_at < datetime.now(timezone.utc) - timedelta(days=1),
    ))
    db.add(Tentative(cle=cle))
    db.commit()


def limiter(db: Session, cle: str, maximum: int, fenetre: timedelta) -> None:
    """Vérifie puis compte la tentative (actions comptées à chaque appel)."""
    verifier(db, cle, maximum, fenetre)
    enregistrer(db, cle)
