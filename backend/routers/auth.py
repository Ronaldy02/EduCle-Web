"""Endpoints d'authentification : inscription, connexion, profil courant, Google OAuth."""
from datetime import datetime
from urllib.parse import urlencode, quote
from fastapi import APIRouter, Depends, HTTPException
from fastapi.responses import RedirectResponse
from pydantic import BaseModel, EmailStr
from sqlalchemy.orm import Session
from sqlalchemy import select
import httpx

from config import settings
from database import get_db
from models.user import User
from services.auth import hash_password, verify_password, create_access_token
from dependencies.auth import get_current_user

GOOGLE_AUTH_URL = "https://accounts.google.com/o/oauth2/v2/auth"
GOOGLE_TOKEN_URL = "https://oauth2.googleapis.com/token"
GOOGLE_USERINFO_URL = "https://www.googleapis.com/oauth2/v3/userinfo"

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


# ─── Google OAuth ─────────────────────────────────────────────────────────────

GOOGLE_REDIRECT_URI = "https://educleweb.vercel.app/auth/google/callback"

@router.get("/google")
def google_login(admin: bool = False, platform: str = "web"):
    """Redirige vers la page d'autorisation Google.

    platform="mobile" → encode la plateforme dans le state pour que
    le callback redirige vers le custom scheme educle:// de l'app.
    """
    if not settings.google_client_id:
        raise HTTPException(503, "Google OAuth non configuré.")
    # State format: "admin|mobile", "admin|web", "user|mobile", "user|web"
    role = "admin" if admin else "user"
    state = f"{role}|{platform}"
    params = {
        "client_id": settings.google_client_id,
        "redirect_uri": GOOGLE_REDIRECT_URI,
        "response_type": "code",
        "scope": "openid email profile",
        "access_type": "offline",
        "prompt": "select_account",
        "state": state,
    }
    return RedirectResponse(f"{GOOGLE_AUTH_URL}?{urlencode(params)}")


@router.get("/google/callback")
def google_callback(code: str = None, error: str = None, state: str = "user|web", db: Session = Depends(get_db)):
    """Reçoit le code de Google, crée/connecte l'utilisateur, redirige vers le frontend.

    Si state contient "|mobile", redirige vers educle://auth/callback?token=...
    (custom URL scheme capturé par flutter_web_auth_2 sur iOS/Android).
    """
    # Parse state — rétrocompat avec l'ancien format "admin"/"user"
    parts = state.split("|")
    role_part = parts[0]
    platform_part = parts[1] if len(parts) > 1 else "web"
    is_admin = role_part == "admin"
    is_mobile = platform_part == "mobile"

    frontend = settings.frontend_url.rstrip("/")

    if error or not code:
        if is_mobile:
            return RedirectResponse("educle://auth/callback?error=google_cancelled")
        dest = f"{frontend}/admin/login?error=google_cancelled" if is_admin else f"{frontend}/login?error=google_cancelled"
        return RedirectResponse(dest)

    # Échange du code contre un token Google
    with httpx.Client() as client:
        token_resp = client.post(GOOGLE_TOKEN_URL, data={
            "code": code,
            "client_id": settings.google_client_id,
            "client_secret": settings.google_client_secret,
            "redirect_uri": GOOGLE_REDIRECT_URI,
            "grant_type": "authorization_code",
        })
        if token_resp.status_code != 200:
            if is_mobile:
                return RedirectResponse("educle://auth/callback?error=google_token")
            return RedirectResponse(f"{frontend}/login?error=google_token")

        access_token = token_resp.json().get("access_token")

        user_resp = client.get(GOOGLE_USERINFO_URL, headers={"Authorization": f"Bearer {access_token}"})
        if user_resp.status_code != 200:
            if is_mobile:
                return RedirectResponse("educle://auth/callback?error=google_userinfo")
            return RedirectResponse(f"{frontend}/login?error=google_userinfo")

        info = user_resp.json()

    email = info.get("email", "").lower()
    name = info.get("name") or info.get("given_name") or email.split("@")[0]

    if not email:
        if is_mobile:
            return RedirectResponse("educle://auth/callback?error=google_no_email")
        return RedirectResponse(f"{frontend}/login?error=google_no_email")

    # Création ou récupération du compte
    user = db.scalar(select(User).where(User.email == email))
    if not user:
        now = datetime.now().isoformat(timespec="seconds")
        user = User(
            email=email,
            hashed_password=None,
            pseudo=name,
            pieces_total=100,
            xp_total=0,
            created_at=now,
        )
        db.add(user)
        db.commit()
        db.refresh(user)

    # Flux admin : vérifier le rôle
    if is_admin:
        if user.role not in ("admin", "superadmin"):
            if is_mobile:
                return RedirectResponse("educle://auth/callback?error=unauthorized")
            return RedirectResponse(f"{frontend}/admin/login?error=unauthorized")
        jwt = create_access_token(user.id)
        if is_mobile:
            return RedirectResponse(f"educle://auth/callback?token={quote(jwt, safe='')}")
        return RedirectResponse(
            f"{frontend}/admin/callback?token={quote(jwt, safe='')}&role={user.role}&pseudo={quote(user.pseudo, safe='')}"
        )

    jwt = create_access_token(user.id)
    if is_mobile:
        return RedirectResponse(f"educle://auth/callback?token={quote(jwt, safe='')}")
    return RedirectResponse(f"{frontend}/auth/callback?token={quote(jwt, safe='')}")
