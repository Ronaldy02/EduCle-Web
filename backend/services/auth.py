"""Hachage de mots de passe et création/vérification de tokens JWT."""
from datetime import datetime, timedelta, timezone

import bcrypt
import jwt

from config import settings

ALGORITHM = "HS256"
TOKEN_EXPIRE_DAYS = 30
ADMIN_TOKEN_DUREE = timedelta(hours=12)


def _octets(password: str) -> bytes:
    # bcrypt ne prend en compte que 72 octets (même comportement que passlib)
    return password.encode("utf-8")[:72]


def hash_password(password: str) -> str:
    return bcrypt.hashpw(_octets(password), bcrypt.gensalt()).decode()


def verify_password(plain: str, hashed: str) -> bool:
    try:
        return bcrypt.checkpw(_octets(plain), hashed.encode())
    except ValueError:
        return False


def create_access_token(user_id: int, token_version: int = 0, duree: timedelta | None = None) -> str:
    expire = datetime.now(timezone.utc) + (duree or timedelta(days=TOKEN_EXPIRE_DAYS))
    return jwt.encode(
        {"sub": str(user_id), "tv": token_version, "exp": expire},
        settings.secret_key,
        algorithm=ALGORITHM,
    )


def decode_token(token: str) -> tuple[int, int] | None:
    """Retourne (user_id, token_version) ou None si le token est invalide ou expiré."""
    try:
        payload = jwt.decode(token, settings.secret_key, algorithms=[ALGORITHM])
        return int(payload["sub"]), int(payload.get("tv", 0))
    except (jwt.PyJWTError, KeyError, ValueError, TypeError):
        return None
