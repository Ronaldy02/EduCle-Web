"""Migration initiale — crée toutes les tables EduClé.

Revision ID: 001
Revises:
Create Date: 2026-08-11
"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects.postgresql import JSONB

revision = "001"
down_revision = None
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.create_table(
        "matieres",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("niveau", sa.String(50), nullable=False),
        sa.Column("nom", sa.String(100), nullable=False),
    )

    op.create_table(
        "chapitres",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("matiere_id", sa.Integer, sa.ForeignKey("matieres.id"), nullable=False),
        sa.Column("titre", sa.String(200), nullable=False),
    )

    op.create_table(
        "cartes_mentales",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("chapitre_id", sa.Integer, sa.ForeignKey("chapitres.id"), nullable=False),
        sa.Column("contenu", sa.Text, nullable=False),
        sa.Column("image", sa.Text, nullable=True),
    )

    op.create_table(
        "questions",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("chapitre_id", sa.Integer, sa.ForeignKey("chapitres.id"), nullable=False),
        sa.Column("enonce", sa.Text, nullable=False),
        sa.Column("choix", JSONB, nullable=False),
        sa.Column("bonne_reponse", sa.String(500), nullable=False),
        sa.Column("explication", sa.Text, nullable=False),
        sa.Column("niveau_complexite", sa.String(20), nullable=False),
    )

    op.create_table(
        "statistiques_questions",
        sa.Column("question_id", sa.Integer, sa.ForeignKey("questions.id"), primary_key=True),
        sa.Column("nb_affichee", sa.Integer, default=0, nullable=False),
        sa.Column("nb_correcte", sa.Float, default=0.0, nullable=False),
        sa.Column("historique", JSONB, nullable=True),
        sa.Column("last_correct_at", sa.String(30), nullable=True),
    )

    op.create_table(
        "user_preferences",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("zone", sa.String(100), default="", nullable=False),
        sa.Column("niveau_scolaire", sa.String(50), default="Fondamental", nullable=False),
        sa.Column("annee", sa.String(20), default="7e AF", nullable=False),
        sa.Column("xp_total", sa.Integer, default=0, nullable=False),
        sa.Column("pieces_total", sa.Integer, default=0, nullable=False),
    )

    op.create_table(
        "scores",
        sa.Column("id", sa.Integer, primary_key=True, autoincrement=True),
        sa.Column("matiere_id", sa.Integer, sa.ForeignKey("matieres.id"), nullable=True),
        sa.Column("score", sa.Integer, nullable=False),
        sa.Column("nb_correctes", sa.Integer, nullable=False),
        sa.Column("nb_total", sa.Integer, nullable=False),
        sa.Column("mode_nom", sa.String(50), nullable=False),
        sa.Column("date", sa.String(30), nullable=False),
    )

    op.create_table(
        "realisations",
        sa.Column("id", sa.String(100), primary_key=True),
        sa.Column("nom", sa.String(200), nullable=False),
        sa.Column("description", sa.String(500), nullable=False),
        sa.Column("categorie", sa.Integer, nullable=False),
        sa.Column("rarete", sa.Integer, nullable=False),
        sa.Column("objectif", sa.Integer, nullable=False),
        sa.Column("recompense_pieces", sa.Integer, default=0, nullable=False),
        sa.Column("secret", sa.Integer, default=0, nullable=False),
        sa.Column("progres", sa.Integer, default=0, nullable=False),
        sa.Column("debloquee", sa.Integer, default=0, nullable=False),
        sa.Column("debloquee_at", sa.String(30), nullable=True),
    )

    op.create_table(
        "realisation_stats",
        sa.Column("cle", sa.String(100), primary_key=True),
        sa.Column("valeur_int", sa.Integer, default=0, nullable=False),
        sa.Column("valeur_text", sa.String(500), nullable=True),
    )


def downgrade() -> None:
    op.drop_table("realisation_stats")
    op.drop_table("realisations")
    op.drop_table("scores")
    op.drop_table("user_preferences")
    op.drop_table("statistiques_questions")
    op.drop_table("questions")
    op.drop_table("cartes_mentales")
    op.drop_table("chapitres")
    op.drop_table("matieres")
