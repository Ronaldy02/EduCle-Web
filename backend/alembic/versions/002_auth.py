"""Ajout du système d'authentification multi-utilisateurs.

- Crée la table `users`
- Recrée `statistiques_questions` avec PK composite (user_id, question_id)
- Ajoute `user_id` (nullable) à `scores`

Revision ID: 002
Revises: 001
Create Date: 2026-09-10
"""
from alembic import op
import sqlalchemy as sa

revision = "002"
down_revision = "001"
branch_labels = None
depends_on = None


def upgrade() -> None:
    # 1. Table users
    op.create_table(
        "users",
        sa.Column("id", sa.Integer, primary_key=True, autoincrement=True),
        sa.Column("email", sa.String(255), nullable=False, unique=True),
        sa.Column("hashed_password", sa.String(500), nullable=True),
        sa.Column("pseudo", sa.String(100), nullable=False, server_default=""),
        sa.Column("zone", sa.String(100), nullable=False, server_default=""),
        sa.Column("niveau_scolaire", sa.String(50), nullable=False, server_default="Fondamental"),
        sa.Column("annee", sa.String(20), nullable=False, server_default="7e AF"),
        sa.Column("xp_total", sa.Integer, nullable=False, server_default="0"),
        sa.Column("pieces_total", sa.Integer, nullable=False, server_default="100"),
        sa.Column("created_at", sa.String(30), nullable=False, server_default=""),
    )
    op.create_index("ix_users_email", "users", ["email"], unique=True)

    # 2. Recrée statistiques_questions avec PK composite
    #    (supprime les données existantes qui n'ont pas de user_id)
    op.drop_table("statistiques_questions")
    op.create_table(
        "statistiques_questions",
        sa.Column("user_id", sa.Integer, sa.ForeignKey("users.id"), primary_key=True),
        sa.Column("question_id", sa.Integer, sa.ForeignKey("questions.id"), primary_key=True),
        sa.Column("nb_affichee", sa.Integer, nullable=False, server_default="0"),
        sa.Column("nb_correcte", sa.Float, nullable=False, server_default="0"),
        sa.Column("historique", sa.JSON, nullable=True),
        sa.Column("last_correct_at", sa.String(30), nullable=True),
    )

    # 3. Ajoute user_id à scores (nullable pour les anciennes lignes)
    op.add_column(
        "scores",
        sa.Column("user_id", sa.Integer, sa.ForeignKey("users.id"), nullable=True),
    )


def downgrade() -> None:
    op.drop_column("scores", "user_id")

    op.drop_table("statistiques_questions")
    op.create_table(
        "statistiques_questions",
        sa.Column("question_id", sa.Integer, sa.ForeignKey("questions.id"), primary_key=True),
        sa.Column("nb_affichee", sa.Integer, nullable=False, server_default="0"),
        sa.Column("nb_correcte", sa.Float, nullable=False, server_default="0"),
        sa.Column("historique", sa.JSON, nullable=True),
        sa.Column("last_correct_at", sa.String(30), nullable=True),
    )

    op.drop_index("ix_users_email", table_name="users")
    op.drop_table("users")
