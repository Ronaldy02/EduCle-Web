"""Modèles ORM : parties de quiz tenues par le serveur et tentatives (limitation de débit)."""
from datetime import datetime

from sqlalchemy import String, Integer, BigInteger, Boolean, DateTime, ForeignKey, func
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.orm import Mapped, mapped_column

from database import Base


class Partie(Base):
    """Une partie démarrée : seules ses questions peuvent être répondues, une fois chacune."""
    __tablename__ = "parties"

    id:           Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    user_id:      Mapped[int] = mapped_column(ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    mode_nom:     Mapped[str] = mapped_column(String(30), nullable=False)
    chapitre_id:  Mapped[int] = mapped_column(Integer, nullable=False)
    matiere_id:   Mapped[int | None] = mapped_column(Integer, nullable=True)
    question_ids: Mapped[list[int]] = mapped_column(JSONB, nullable=False)
    # [{"question_id": int, "reponse": str}] dans l'ordre des réponses
    reponses:     Mapped[list[dict]] = mapped_column(JSONB, nullable=False, default=list)
    created_at:   Mapped[datetime] = mapped_column(DateTime(timezone=True), nullable=False, server_default=func.now())
    terminee:     Mapped[bool] = mapped_column(Boolean, nullable=False, default=False)


class Tentative(Base):
    __tablename__ = "tentatives"

    id:         Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    cle:        Mapped[str] = mapped_column(String(300), nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), nullable=False, server_default=func.now())
