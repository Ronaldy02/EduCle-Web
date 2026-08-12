"""Configuration Alembic pour les migrations PostgreSQL."""
from logging.config import fileConfig
from alembic import context
from sqlalchemy import engine_from_config, pool

# Charger les modèles pour que Base.metadata soit complet
import sys, os
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))

from database import Base, engine
import models  # noqa: F401 — force l'enregistrement de tous les modèles

config = context.config

if config.config_file_name is not None:
    fileConfig(config.config_file_name)

target_metadata = Base.metadata


def run_migrations_offline() -> None:
    url = engine.url
    context.configure(
        url=url,
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
    )
    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online() -> None:
    with engine.connect() as connection:
        context.configure(connection=connection, target_metadata=target_metadata)
        with context.begin_transaction():
            context.run_migrations()


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
