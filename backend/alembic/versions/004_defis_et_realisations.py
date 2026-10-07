"""Migration 004 — Défis + refonte réalisations multi-utilisateur.

Revision ID: 004
Revises: 003
Create Date: 2026-10-06
"""
from alembic import op
import sqlalchemy as sa

revision = "004"
down_revision = "003"
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ── 1. Nouvelles colonnes sur la table realisations ───────────────────────
    # On garde l'ancienne structure et on ajoute les nouveaux champs.
    # progres/debloquee/debloquee_at restent pour rétrocompatibilité (ignorés).
    with op.batch_alter_table("realisations") as batch:
        batch.add_column(sa.Column("groupe",   sa.String(10),  nullable=True))
        batch.add_column(sa.Column("metrique", sa.String(50),  nullable=True))
        batch.add_column(sa.Column("cible",    sa.Integer,     nullable=True))
        batch.add_column(sa.Column("filtres",  sa.Text,        nullable=True))

    # ── 2. Table défis (définitions canoniques) ───────────────────────────────
    op.create_table(
        "defis",
        sa.Column("id",          sa.String(10),  primary_key=True),
        sa.Column("type",        sa.String(5),   nullable=False),   # d/w/m/s
        sa.Column("palier",      sa.Integer,     nullable=False, server_default="1"),
        sa.Column("nom",         sa.String(200), nullable=False),
        sa.Column("description", sa.Text,        nullable=False),
        sa.Column("metrique",    sa.String(50),  nullable=False),
        sa.Column("cible",       sa.Integer,     nullable=False),
        sa.Column("filtres",     sa.Text,        nullable=True),
        sa.Column("date_spe",    sa.String(20),  nullable=True),
    )

    # ── 3. Progression des défis par utilisateur ──────────────────────────────
    op.create_table(
        "defis_progres",
        sa.Column("user_id",  sa.Integer,     sa.ForeignKey("users.id", ondelete="CASCADE"), nullable=False),
        sa.Column("defi_id",  sa.String(10),  sa.ForeignKey("defis.id", ondelete="CASCADE"), nullable=False),
        sa.Column("periode",  sa.String(20),  nullable=False),   # YYYY-MM-DD / YYYY-Www / YYYY-MM
        sa.Column("progres",  sa.Integer,     nullable=False, server_default="0"),
        sa.Column("complete", sa.Integer,     nullable=False, server_default="0"),
        sa.PrimaryKeyConstraint("user_id", "defi_id", "periode"),
    )

    # ── 4. Progression des réalisations par utilisateur ───────────────────────
    op.create_table(
        "realisations_progres",
        sa.Column("user_id",        sa.Integer,     sa.ForeignKey("users.id", ondelete="CASCADE"), nullable=False),
        sa.Column("realisation_id", sa.String(10),  sa.ForeignKey("realisations.id", ondelete="CASCADE"), nullable=False),
        sa.Column("progres",        sa.Integer,     nullable=False, server_default="0"),
        sa.Column("debloquee",      sa.Integer,     nullable=False, server_default="0"),
        sa.Column("debloque_le",    sa.String(30),  nullable=True),
        sa.PrimaryKeyConstraint("user_id", "realisation_id"),
    )


def downgrade() -> None:
    op.drop_table("realisations_progres")
    op.drop_table("defis_progres")
    op.drop_table("defis")
    with op.batch_alter_table("realisations") as batch:
        batch.drop_column("filtres")
        batch.drop_column("cible")
        batch.drop_column("metrique")
        batch.drop_column("groupe")
