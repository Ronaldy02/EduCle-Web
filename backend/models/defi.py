"""Modèles ORM : défis et leur progression par utilisateur."""
import json
from sqlalchemy import String, Integer, Text, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column

from database import Base


class Defi(Base):
    __tablename__ = "defis"

    id:          Mapped[str] = mapped_column(String(10),  primary_key=True)
    type:        Mapped[str] = mapped_column(String(5),   nullable=False)   # d/w/m/s
    palier:      Mapped[int] = mapped_column(Integer,     nullable=False, default=1)
    nom:         Mapped[str] = mapped_column(String(200), nullable=False)
    description: Mapped[str] = mapped_column(Text,        nullable=False)
    metrique:    Mapped[str] = mapped_column(String(50),  nullable=False)
    cible:       Mapped[int] = mapped_column(Integer,     nullable=False)
    filtres:     Mapped[str | None] = mapped_column(Text, nullable=True)
    date_spe:    Mapped[str | None] = mapped_column(String(20), nullable=True)

    @property
    def filtres_dict(self) -> dict:
        return json.loads(self.filtres) if self.filtres else {}


class DefiProgres(Base):
    """Progression d'un défi pour un utilisateur sur une période donnée."""
    __tablename__ = "defis_progres"

    user_id:  Mapped[int] = mapped_column(Integer, ForeignKey("users.id", ondelete="CASCADE"), primary_key=True)
    defi_id:  Mapped[str] = mapped_column(String(10), ForeignKey("defis.id", ondelete="CASCADE"), primary_key=True)
    periode:  Mapped[str] = mapped_column(String(20), primary_key=True)
    progres:  Mapped[int] = mapped_column(Integer, nullable=False, default=0)
    complete: Mapped[int] = mapped_column(Integer, nullable=False, default=0)


class RealisationProgres(Base):
    """Progression d'une réalisation pour un utilisateur."""
    __tablename__ = "realisations_progres"

    user_id:        Mapped[int] = mapped_column(Integer, ForeignKey("users.id", ondelete="CASCADE"), primary_key=True)
    realisation_id: Mapped[str] = mapped_column(String(10), ForeignKey("realisations.id", ondelete="CASCADE"), primary_key=True)
    progres:        Mapped[int] = mapped_column(Integer, nullable=False, default=0)
    debloquee:      Mapped[int] = mapped_column(Integer, nullable=False, default=0)
    debloque_le:    Mapped[str | None] = mapped_column(String(30), nullable=True)
