"""Modèle ORM : propositions de questions par les utilisateurs."""
from sqlalchemy import String, Integer, ForeignKey, Text, JSON
from sqlalchemy.orm import Mapped, mapped_column

from database import Base


class QuestionProposal(Base):
    __tablename__ = "question_proposals"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    chapitre_id: Mapped[int | None] = mapped_column(ForeignKey("chapitres.id"), nullable=True)
    matiere_id: Mapped[int | None] = mapped_column(Integer, nullable=True)
    nom_proposant: Mapped[str] = mapped_column(String(100), nullable=False, default="Anonyme")
    enonce: Mapped[str] = mapped_column(Text, nullable=False)
    choix: Mapped[list] = mapped_column(JSON, nullable=False)
    bonne_reponse: Mapped[str] = mapped_column(String(500), nullable=False)
    explication: Mapped[str] = mapped_column(Text, nullable=False, default="")
    niveau_complexite: Mapped[str] = mapped_column(String(20), nullable=False, default="Moyen")
    statut: Mapped[str] = mapped_column(String(20), nullable=False, default="en_attente")
    created_at: Mapped[str] = mapped_column(String(30), nullable=False, default="")
    remarque_admin: Mapped[str | None] = mapped_column(Text, nullable=True)
