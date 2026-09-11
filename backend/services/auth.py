"""Hachage de mots de passe et création/vérification de tokens JWT."""
from datetime import datetime, timedelta, timezone

from jose import JWTError, jwt
from passlib.context import CryptContext

from config import settings

_pwd = CryptContext(schemes=["bcrypt"], deprecated="auto")

ALGORITHM = "HS256"
TOKEN_EXPIRE_DAYS = 30


def hash_password(password: str) -> str:
    return _pwd.hash(password)


def verify_password(plain: str, hashed: str) -> bool:
    return _pwd.verify(plain, hashed)


def create_access_token(user_id: int) -> str:
    expire = datetime.now(timezone.utc) + timedelta(days=TOKEN_EXPIRE_DAYS)
    return jwt.encode(
        {"sub": str(user_id), "exp": expire},
        settings.secret_key,
        algorithm=ALGORITHM,
    )


def decode_token(token: str) -> int | None:
    try:
        payload = jwt.decode(token, settings.secret_key, algorithms=[ALGORITHM])
        return int(payload["sub"])
    except (JWTError, KeyError, ValueError):
        return None
