"""Endpoints d'administration : login admin, gestion des rôles."""
from datetime import datetime
from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm import Session
from sqlalchemy import select

from database import get_db
from models.user import User
from services.auth import hash_password, verify_password, create_access_token
from dependencies.auth import get_current_user

router = APIRouter(prefix="/admin", tags=["Administration"])


# ─── Schémas ─────────────────────────────────────────────────────────────────

class AdminLoginRequest(BaseModel):
    email: str
    password: str


class UserAdminSchema(BaseModel):
    id: int
    email: str
    pseudo: str
    role: str
    xp_total: int
    pieces_total: int
    created_at: str

    model_config = {"from_attributes": True}


class ChangeRoleRequest(BaseModel):
    role: str  # "user", "admin", "superadmin"


# ─── Dépendances ──────────────────────────────────────────────────────────────

def require_admin(current_user: User = Depends(get_current_user)) -> User:
    if current_user.role not in ("admin", "superadmin"):
        raise HTTPException(403, "Accès réservé aux administrateurs.")
    return current_user


def require_superadmin(current_user: User = Depends(get_current_user)) -> User:
    if current_user.role != "superadmin":
        raise HTTPException(403, "Accès réservé aux super-administrateurs.")
    return current_user


# ─── Endpoints ───────────────────────────────────────────────────────────────

@router.post("/login")
def admin_login(body: AdminLoginRequest, db: Session = Depends(get_db)):
    """Connexion admin — vérifie le rôle avant d'émettre le token."""
    user = db.scalar(select(User).where(User.email == body.email))
    if not user or not user.hashed_password:
        raise HTTPException(401, "Identifiants incorrects.")
    if not verify_password(body.password, user.hashed_password):
        raise HTTPException(401, "Identifiants incorrects.")
    if user.role not in ("admin", "superadmin"):
        raise HTTPException(403, "Ce compte n'a pas les droits d'administration.")

    token = create_access_token(user.id)
    return {
        "access_token": token,
        "token_type": "bearer",
        "role": user.role,
        "pseudo": user.pseudo,
        "email": user.email,
    }


@router.get("/me")
def admin_me(current_user: User = Depends(require_admin)):
    """Retourne le profil admin connecté."""
    return {"id": current_user.id, "email": current_user.email,
            "pseudo": current_user.pseudo, "role": current_user.role}


@router.get("/users", response_model=list[UserAdminSchema])
def list_users(
    db: Session = Depends(get_db),
    _: User = Depends(require_admin),
):
    """Liste tous les utilisateurs (admin+)."""
    return db.scalars(select(User).order_by(User.created_at.desc())).all()


@router.patch("/users/{user_id}/role")
def change_role(
    user_id: int,
    body: ChangeRoleRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(require_superadmin),
):
    """Change le rôle d'un utilisateur (superadmin uniquement)."""
    if body.role not in ("user", "admin", "superadmin"):
        raise HTTPException(400, "Rôle invalide. Valeurs : user, admin, superadmin.")

    target = db.get(User, user_id)
    if not target:
        raise HTTPException(404, "Utilisateur introuvable.")
    if target.id == current_user.id:
        raise HTTPException(400, "Tu ne peux pas modifier ton propre rôle.")

    target.role = body.role
    db.commit()
    return {"id": target.id, "email": target.email, "role": target.role}
