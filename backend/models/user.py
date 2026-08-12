"""Modèle ORM : préférences et progression de l'utilisateur.

Application mono-utilisateur : toujours id=1.
"""
from sqlalchemy import String, Integer
from sqlalchemy.orm import Mapped, mapped_column

from database import Base


class UserPreferences(Base):
    __tablename__ = "user_preferences"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, default=1)
    zone: Mapped[str] = mapped_column(String(100), default="", nullable=False)
    niveau_scolaire: Mapped[str] = mapped_column(String(50), default="Fondamental", nullable=False)
    annee: Mapped[str] = mapped_column(String(20), default="7e AF", nullable=False)
    xp_total: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    pieces_total: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
