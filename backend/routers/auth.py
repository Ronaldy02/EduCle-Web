"""Endpoints d'authentification : inscription, connexion, profil courant."""
from datetime import datetime
from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel, EmailStr
from sqlalchemy.orm import Session
from sqlalchemy import select

from database import get_db
from models.user import User
from services.auth import hash_password, verify_password, create_access_token
from dependencies.auth import get_current_user

router = APIRouter(prefix="/auth", tags=["Authentification"])


# ─── Schémas ─────────────────────────────────────────────────────────────────

class RegisterRequest(BaseModel):
    email: EmailStr
    password: str
    pseudo: str = ""


class LoginRequest(BaseModel):
    email: EmailStr
    password: str


class CheckEmailRequest(BaseModel):
    email: EmailStr


class UserPublicSchema(BaseModel):
    id: int
    email: str
    pseudo: str
    zone: str
    niveau_scolaire: str
    annee: str
    xp_total: int
    pieces_total: int
    created_at: str

    model_config = {"from_attributes": True}


class TokenSchema(BaseModel):
    access_token: str
    token_type: str = "bearer"
    user: UserPublicSchema


# ─── Endpoints ───────────────────────────────────────────────────────────────

@router.post("/check-email")
def check_email(body: CheckEmailRequest, db: Session = Depends(get_db)):
    """Vérifie si une adresse e-mail est déjà enregistrée."""
    exists = db.scalar(select(User).where(User.email == body.email)) is not None
    return {"exists": exists}


@router.post("/register", response_model=TokenSchema)
def register(body: RegisterRequest, db: Session = Depends(get_db)):
    """Crée un nouveau compte et retourne un token JWT."""
    if len(body.password) < 8:
        raise HTTPException(400, "Le mot de passe doit contenir au moins 8 caractères.")

    existing = db.scalar(select(User).where(User.email == body.email))
    if existing:
        raise HTTPException(409, "Cette adresse e-mail est déjà utilisée.")

    pseudo = body.pseudo.strip() or body.email.split("@")[0]
    now = datetime.now().isoformat(timespec="seconds")
    user = User(
        email=body.email,
        hashed_password=hash_password(body.password),
        pseudo=pseudo,
        pieces_total=100,
        xp_total=0,
        created_at=now,
    )
    db.add(user)
    db.commit()
    db.refresh(user)

    token = create_access_token(user.id)
    return TokenSchema(access_token=token, user=UserPublicSchema.model_validate(user))


@router.post("/login", response_model=TokenSchema)
def login(body: LoginRequest, db: Session = Depends(get_db)):
    """Authentifie un utilisateur et retourne un token JWT."""
    user = db.scalar(select(User).where(User.email == body.email))
    if not user or not user.hashed_password:
        raise HTTPException(401, "E-mail ou mot de passe incorrect.")
    if not verify_password(body.password, user.hashed_password):
        raise HTTPException(401, "E-mail ou mot de passe incorrect.")

    token = create_access_token(user.id)
    return TokenSchema(access_token=token, user=UserPublicSchema.model_validate(user))


@router.get("/me", response_model=UserPublicSchema)
def me(current_user: User = Depends(get_current_user)):
    """Retourne le profil de l'utilisateur connecté."""
    return current_user
