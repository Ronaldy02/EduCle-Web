"""Modèles ORM : questions et leurs statistiques d'apprentissage."""
from sqlalchemy import String, Integer, Float, ForeignKey, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.dialects.postgresql import JSONB

from database import Base


class Question(Base):
    __tablename__ = "questions"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    chapitre_id: Mapped[int] = mapped_column(ForeignKey("chapitres.id"), nullable=False)
    enonce: Mapped[str] = mapped_column(Text, nullable=False)
    # Stocké en JSONB PostgreSQL : liste de 4 chaînes ["A", "B", "C", "D"]
    choix: Mapped[list[str]] = mapped_column(JSONB, nullable=False)
    bonne_reponse: Mapped[str] = mapped_column(String(500), nullable=False)
    explication: Mapped[str] = mapped_column(Text, nullable=False)
    niveau_complexite: Mapped[str] = mapped_column(String(20), nullable=False)

    chapitre: Mapped["Chapitre"] = relationship(back_populates="questions")
    statistique: Mapped["StatistiqueQuestion | None"] = relationship(
        back_populates="question", uselist=False
    )


class StatistiqueQuestion(Base):
    """Maîtrise adaptative d'une question pour l'utilisateur."""
    __tablename__ = "statistiques_questions"

    question_id: Mapped[int] = mapped_column(
        ForeignKey("questions.id"), primary_key=True
    )
    nb_affichee: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    # Taux de réussite entre 0.0 et 1.0 (nb_correcte / nb_affichee)
    nb_correcte: Mapped[float] = mapped_column(Float, default=0.0, nullable=False)
    # Historique JSON : liste de {"correct": bool, "date": "ISO8601"}
    historique: Mapped[list | None] = mapped_column(JSONB, nullable=True)
    last_correct_at: Mapped[str | None] = mapped_column(String(30), nullable=True)

    question: Mapped["Question"] = relationship(back_populates="statistique")
