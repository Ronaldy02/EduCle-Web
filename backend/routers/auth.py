"""Endpoints d'authentification : inscription, connexion, profil courant, Google OAuth."""
import hmac
import secrets
from datetime import datetime, timedelta
from urllib.parse import urlencode, quote
from fastapi import APIRouter, Depends, HTTPException, Request
from fastapi.responses import RedirectResponse
from pydantic import BaseModel, EmailStr, Field
from sqlalchemy.orm import Session
from sqlalchemy import select, func
import httpx

from config import settings
from database import get_db
from models.user import User
from services.auth import hash_password, verify_password, create_access_token
from services import limiteur
from dependencies.auth import get_current_user

GOOGLE_AUTH_URL = "https://accounts.google.com/o/oauth2/v2/auth"
GOOGLE_TOKEN_URL = "https://oauth2.googleapis.com/token"
GOOGLE_USERINFO_URL = "https://www.googleapis.com/oauth2/v3/userinfo"

router = APIRouter(prefix="/auth", tags=["Authentification"])

# Limites (les écoles partagent souvent une même IP : seuls les échecs comptent pour la connexion)
_FENETRE_LOGIN = timedelta(minutes=15)
_MAX_ECHECS_EMAIL = 8
_MAX_ECHECS_IP = 30


# ─── Schémas ─────────────────────────────────────────────────────────────────

class RegisterRequest(BaseModel):
    email: EmailStr
    password: str = Field(max_length=128)
    pseudo: str = Field(default="", max_length=50)


class LoginRequest(BaseModel):
    email: EmailStr
    password: str = Field(max_length=128)


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


# ─── Utilitaires ─────────────────────────────────────────────────────────────

def trouver_par_email(db: Session, email: str) -> User | None:
    return db.scalar(select(User).where(func.lower(User.email) == email.lower()))


def verifier_identifiants(db: Session, request: Request, email: str, password: str) -> User:
    """Contrôle e-mail + mot de passe avec limitation des échecs par e-mail et par IP."""
    cle_email = f"login-echec:email:{email.lower()}"
    cle_ip = f"login-echec:ip:{limiteur.ip_client(request)}"
    limiteur.verifier(db, cle_email, _MAX_ECHECS_EMAIL, _FENETRE_LOGIN)
    limiteur.verifier(db, cle_ip, _MAX_ECHECS_IP, _FENETRE_LOGIN)

    user = trouver_par_email(db, email)
    if user and not user.hashed_password:
        raise HTTPException(401, "Ce compte se connecte avec Google.")
    if not user or not verify_password(password, user.hashed_password):
        limiteur.enregistrer(db, cle_email)
        limiteur.enregistrer(db, cle_ip)
        raise HTTPException(401, "E-mail ou mot de passe incorrect.")
    return user


# ─── Endpoints ───────────────────────────────────────────────────────────────

@router.post("/check-email")
def check_email(body: CheckEmailRequest, request: Request, db: Session = Depends(get_db)):
    """Vérifie si une adresse e-mail est déjà enregistrée."""
    limiteur.limiter(db, f"check-email:ip:{limiteur.ip_client(request)}", 60, timedelta(minutes=10))
    return {"exists": trouver_par_email(db, body.email) is not None}


@router.post("/register", response_model=TokenSchema)
def register(body: RegisterRequest, request: Request, db: Session = Depends(get_db)):
    """Crée un nouveau compte et retourne un token JWT."""
    if len(body.password) < 8:
        raise HTTPException(400, "Le mot de passe doit contenir au moins 8 caractères.")
    limiteur.limiter(db, f"register:ip:{limiteur.ip_client(request)}", 20, timedelta(hours=1))

    if trouver_par_email(db, body.email):
        raise HTTPException(409, "Cette adresse e-mail est déjà utilisée.")

    email = body.email.lower()
    pseudo = body.pseudo.strip() or email.split("@")[0]
    now = datetime.now().isoformat(timespec="seconds")
    user = User(
        email=email,
        hashed_password=hash_password(body.password),
        pseudo=pseudo[:50],
        pieces_total=100,
        xp_total=0,
        created_at=now,
    )
    db.add(user)
    db.commit()
    db.refresh(user)

    token = create_access_token(user.id, user.token_version)
    return TokenSchema(access_token=token, user=UserPublicSchema.model_validate(user))


@router.post("/login", response_model=TokenSchema)
def login(body: LoginRequest, request: Request, db: Session = Depends(get_db)):
    """Authentifie un utilisateur et retourne un token JWT."""
    user = verifier_identifiants(db, request, body.email, body.password)
    token = create_access_token(user.id, user.token_version)
    return TokenSchema(access_token=token, user=UserPublicSchema.model_validate(user))


@router.get("/me", response_model=UserPublicSchema)
def me(current_user: User = Depends(get_current_user)):
    """Retourne le profil de l'utilisateur connecté."""
    return current_user


@router.post("/logout-all", status_code=204)
def logout_all(current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    """Révoque tous les tokens du compte (tous les appareils)."""
    current_user.token_version += 1
    db.commit()


# ─── Google OAuth ─────────────────────────────────────────────────────────────

GOOGLE_REDIRECT_URI = "https://educleweb.vercel.app/auth/google/callback"
# Cookie anti-CSRF : le "state" renvoyé par Google doit contenir le même nonce
_COOKIE_OAUTH = "ec_oauth_nonce"


@router.get("/google")
def google_login(admin: bool = False, platform: str = "web"):
    """Redirige vers la page d'autorisation Google.

    platform="mobile" → encode la plateforme dans le state pour que
    le callback redirige vers le custom scheme educle:// de l'app.
    """
    if not settings.google_client_id:
        raise HTTPException(503, "Google OAuth non configuré.")
    role = "admin" if admin else "user"
    platform = "mobile" if platform == "mobile" else "web"
    nonce = secrets.token_urlsafe(24)
    # State : "role|plateforme|nonce"
    params = {
        "client_id": settings.google_client_id,
        "redirect_uri": GOOGLE_REDIRECT_URI,
        "response_type": "code",
        "scope": "openid email profile",
        "prompt": "select_account",
        "state": f"{role}|{platform}|{nonce}",
    }
    resp = RedirectResponse(f"{GOOGLE_AUTH_URL}?{urlencode(params)}")
    resp.set_cookie(
        _COOKIE_OAUTH, nonce, max_age=600, httponly=True, secure=True,
        samesite="lax", path="/auth/google",
    )
    return resp


@router.get("/google/callback")
def google_callback(
    request: Request,
    code: str = None,
    error: str = None,
    state: str = "",
    db: Session = Depends(get_db),
):
    """Reçoit le code de Google, crée/connecte l'utilisateur, redirige vers le frontend.

    Web : le token est placé dans le fragment (#token=…), jamais envoyé aux serveurs ni journalisé.
    Mobile : redirige vers educle://auth/callback?token=… (custom scheme capturé par l'app).
    """
    parts = state.split("|")
    is_admin = parts[0] == "admin"
    is_mobile = len(parts) > 1 and parts[1] == "mobile"
    nonce = parts[2] if len(parts) > 2 else ""

    frontend = settings.frontend_url.rstrip("/")

    def echec(code_erreur: str) -> RedirectResponse:
        if is_mobile:
            resp = RedirectResponse(f"educle://auth/callback?error={code_erreur}")
        else:
            page = "admin/login" if is_admin else "login"
            resp = RedirectResponse(f"{frontend}/{page}?error={code_erreur}")
        resp.delete_cookie(_COOKIE_OAUTH, path="/auth/google")
        return resp

    cookie = request.cookies.get(_COOKIE_OAUTH, "")
    if not nonce or not cookie or not hmac.compare_digest(nonce, cookie):
        return echec("google_state")

    if error or not code:
        return echec("google_cancelled")

    # Échange du code contre un token Google
    with httpx.Client(timeout=10) as client:
        token_resp = client.post(GOOGLE_TOKEN_URL, data={
            "code": code,
            "client_id": settings.google_client_id,
            "client_secret": settings.google_client_secret,
            "redirect_uri": GOOGLE_REDIRECT_URI,
            "grant_type": "authorization_code",
        })
        if token_resp.status_code != 200:
            return echec("google_token")

        access_token = token_resp.json().get("access_token")

        user_resp = client.get(GOOGLE_USERINFO_URL, headers={"Authorization": f"Bearer {access_token}"})
        if user_resp.status_code != 200:
            return echec("google_userinfo")

        info = user_resp.json()

    email = (info.get("email") or "").lower()
    if not email:
        return echec("google_no_email")
    if info.get("email_verified") is not True:
        return echec("google_email_non_verifie")
    name = (info.get("name") or info.get("given_name") or email.split("@")[0])[:50]

    # Création ou récupération du compte
    user = trouver_par_email(db, email)
    if not user:
        now = datetime.now().isoformat(timespec="seconds")
        user = User(
            email=email,
            hashed_password=None,
            pseudo=name,
            pieces_total=100,
            xp_total=0,
            created_at=now,
            email_verifie=True,
        )
        db.add(user)
        db.commit()
        db.refresh(user)
    elif not user.email_verifie:
        # Premier passage par Google sur un compte créé par mot de passe : l'adresse n'avait
        # jamais été prouvée. On coupe le mot de passe et les sessions existantes, qui ont pu
        # être créés par quelqu'un d'autre que le vrai propriétaire de l'adresse.
        if user.hashed_password:
            user.hashed_password = None
            user.token_version += 1
        user.email_verifie = True
        db.commit()
        db.refresh(user)

    if is_admin and user.role not in ("admin", "superadmin"):
        return echec("unauthorized")

    jwt = quote(create_access_token(user.id, user.token_version), safe="")
    if is_mobile:
        resp = RedirectResponse(f"educle://auth/callback?token={jwt}")
    elif is_admin:
        resp = RedirectResponse(
            f"{frontend}/admin/callback#token={jwt}&role={user.role}&pseudo={quote(user.pseudo, safe='')}"
        )
    else:
        resp = RedirectResponse(f"{frontend}/auth/callback#token={jwt}")
    resp.delete_cookie(_COOKIE_OAUTH, path="/auth/google")
    return resp
