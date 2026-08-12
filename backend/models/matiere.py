"""Modèles ORM : matières, chapitres, cartes mentales."""
from sqlalchemy import String, Integer, ForeignKey, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from database import Base


class Matiere(Base):
    __tablename__ = "matieres"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    niveau: Mapped[str] = mapped_column(String(50), nullable=False)
    nom: Mapped[str] = mapped_column(String(100), nullable=False)

    chapitres: Mapped[list["Chapitre"]] = relationship(back_populates="matiere")


class Chapitre(Base):
    __tablename__ = "chapitres"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    matiere_id: Mapped[int] = mapped_column(ForeignKey("matieres.id"), nullable=False)
    titre: Mapped[str] = mapped_column(String(200), nullable=False)

    matiere: Mapped["Matiere"] = relationship(back_populates="chapitres")
    questions: Mapped[list["Question"]] = relationship(back_populates="chapitre")
    cartes_mentales: Mapped[list["CarteMentale"]] = relationship(back_populates="chapitre")


class CarteMentale(Base):
    __tablename__ = "cartes_mentales"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    chapitre_id: Mapped[int] = mapped_column(ForeignKey("chapitres.id"), nullable=False)
    contenu: Mapped[str] = mapped_column(Text, nullable=False)
    image: Mapped[str | None] = mapped_column(Text, nullable=True)

    chapitre: Mapped["Chapitre"] = relationship(back_populates="cartes_mentales")
