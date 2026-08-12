"""Modèles ORM : réalisations (achievements) et leurs statistiques."""
from sqlalchemy import String, Integer
from sqlalchemy.orm import Mapped, mapped_column

from database import Base


class Realisation(Base):
    __tablename__ = "realisations"

    # Identifiant textuel, ex. "premier_quiz", "serie_5"
    id: Mapped[str] = mapped_column(String(100), primary_key=True)
    nom: Mapped[str] = mapped_column(String(200), nullable=False)
    description: Mapped[str] = mapped_column(String(500), nullable=False)
    categorie: Mapped[int] = mapped_column(Integer, nullable=False)
    rarete: Mapped[int] = mapped_column(Integer, nullable=False)
    objectif: Mapped[int] = mapped_column(Integer, nullable=False)
    recompense_pieces: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    secret: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    progres: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    debloquee: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    debloquee_at: Mapped[str | None] = mapped_column(String(30), nullable=True)


class RealisationStat(Base):
    """Compteurs persistants utilisés par le moteur de réalisations."""
    __tablename__ = "realisation_stats"

    cle: Mapped[str] = mapped_column(String(100), primary_key=True)
    valeur_int: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    valeur_text: Mapped[str | None] = mapped_column(String(500), nullable=True)
