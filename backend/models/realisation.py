"""Modèles ORM : réalisations (achievements) et leurs statistiques."""
from sqlalchemy import String, Integer, Text
from sqlalchemy.orm import Mapped, mapped_column

from database import Base


class Realisation(Base):
    __tablename__ = "realisations"

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
    # Colonnes ajoutées en migration 004
    groupe: Mapped[str | None] = mapped_column(String(10), nullable=True)
    metrique: Mapped[str | None] = mapped_column(String(50), nullable=True)
    cible: Mapped[int | None] = mapped_column(Integer, nullable=True)
    filtres: Mapped[str | None] = mapped_column(Text, nullable=True)


class RealisationStat(Base):
    """Compteurs persistants utilisés par le moteur de réalisations."""
    __tablename__ = "realisation_stats"

    cle: Mapped[str] = mapped_column(String(100), primary_key=True)
    valeur_int: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    valeur_text: Mapped[str | None] = mapped_column(String(500), nullable=True)
