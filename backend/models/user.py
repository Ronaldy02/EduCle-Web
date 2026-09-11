"""Modèles ORM : utilisateurs authentifiés (multi-compte) et legacy."""
from sqlalchemy import String, Integer
from sqlalchemy.orm import Mapped, mapped_column

from database import Base


class User(Base):
    """Compte utilisateur authentifié — un par personne."""
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    email: Mapped[str] = mapped_column(String(255), unique=True, nullable=False, index=True)
    hashed_password: Mapped[str | None] = mapped_column(String(500), nullable=True)
    pseudo: Mapped[str] = mapped_column(String(100), nullable=False, default="")
    zone: Mapped[str] = mapped_column(String(100), nullable=False, default="")
    niveau_scolaire: Mapped[str] = mapped_column(String(50), nullable=False, default="Fondamental")
    annee: Mapped[str] = mapped_column(String(20), nullable=False, default="7e AF")
    xp_total: Mapped[int] = mapped_column(Integer, nullable=False, default=0)
    pieces_total: Mapped[int] = mapped_column(Integer, nullable=False, default=100)
    created_at: Mapped[str] = mapped_column(String(30), nullable=False, default="")


class UserPreferences(Base):
    """Legacy — table mono-utilisateur conservée pour rétrocompatibilité DB."""
    __tablename__ = "user_preferences"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, default=1)
    zone: Mapped[str] = mapped_column(String(100), default="", nullable=False)
    niveau_scolaire: Mapped[str] = mapped_column(String(50), default="Fondamental", nullable=False)
    annee: Mapped[str] = mapped_column(String(20), default="7e AF", nullable=False)
    xp_total: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    pieces_total: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
