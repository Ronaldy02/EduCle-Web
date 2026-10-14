"""Connexion SQLAlchemy à PostgreSQL.

Une session est créée par requête HTTP via la dépendance `get_db`.
"""
from sqlalchemy import create_engine
from sqlalchemy.orm import DeclarativeBase, sessionmaker, Session
from typing import Generator

from config import settings



def _url_pg8000(url: str) -> str:
    """Force le pilote pg8000 (seul installé) quelle que soit l'URL collée depuis Supabase.

    "postgresql://" ou "postgres://" ferait chercher psycopg2 et planterait au démarrage ;
    pg8000 refuse aussi le paramètre ?sslmode=.
    """
    for prefixe in ("postgresql://", "postgres://"):
        if url.startswith(prefixe):
            url = "postgresql+pg8000://" + url[len(prefixe):]
    base, _, query = url.partition("?")
    params = [p for p in query.split("&") if p and not p.startswith("sslmode=")]
    return base + ("?" + "&".join(params) if params else "")


engine = create_engine(_url_pg8000(settings.database_url))

SessionLocal = sessionmaker(bind=engine, autocommit=False, autoflush=False)


class Base(DeclarativeBase):
    pass


def get_db() -> Generator[Session, None, None]:
    """Dépendance FastAPI : fournit une session DB et la ferme après la requête."""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
