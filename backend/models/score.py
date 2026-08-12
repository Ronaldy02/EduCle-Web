"""Modèle ORM : historique des scores de quiz."""
from sqlalchemy import String, Integer, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column

from database import Base


class Score(Base):
    __tablename__ = "scores"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    matiere_id: Mapped[int | None] = mapped_column(
        Integer, ForeignKey("matieres.id"), nullable=True
    )
    score: Mapped[int] = mapped_column(Integer, nullable=False)
    nb_correctes: Mapped[int] = mapped_column(Integer, nullable=False)
    nb_total: Mapped[int] = mapped_column(Integer, nullable=False)
    mode_nom: Mapped[str] = mapped_column(String(50), nullable=False)
    # ISO 8601 : "2026-08-11T14:30:00"
    date: Mapped[str] = mapped_column(String(30), nullable=False)
