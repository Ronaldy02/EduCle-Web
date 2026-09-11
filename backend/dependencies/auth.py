"""Dépendance FastAPI : extrait l'utilisateur courant depuis le JWT."""
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from sqlalchemy.orm import Session
from sqlalchemy import select

from database import get_db
from models.user import User
from services.auth import decode_token

_bearer = HTTPBearer(auto_error=False)


def get_current_user(
    credentials: HTTPAuthorizationCredentials | None = Depends(_bearer),
    db: Session = Depends(get_db),
) -> User:
    if not credentials:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Authentification requise.",
            headers={"WWW-Authenticate": "Bearer"},
        )
    user_id = decode_token(credentials.credentials)
    if user_id is None:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token invalide ou expiré.",
            headers={"WWW-Authenticate": "Bearer"},
        )
    user = db.scalar(select(User).where(User.id == user_id))
    if user is None:
        raise HTTPException(status_code=404, detail="Utilisateur introuvable.")
    return user
