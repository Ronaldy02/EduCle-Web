"""Modèle ORM : abonnements Web Push."""
from datetime import datetime
from sqlalchemy import BigInteger, Boolean, ForeignKey, Text, DateTime, func
from sqlalchemy.orm import Mapped, mapped_column
from database import Base


class AbonnementPush(Base):
    __tablename__ = "abonnements_push"

    id:              Mapped[int]           = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    user_id:         Mapped[int]           = mapped_column(ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    endpoint:        Mapped[str]           = mapped_column(Text, nullable=False, unique=True)
    cle_p256dh:      Mapped[str]           = mapped_column(Text, nullable=False)
    cle_auth:        Mapped[str]           = mapped_column(Text, nullable=False)
    rappel_debut:    Mapped[bool]          = mapped_column(Boolean, nullable=False, default=True)
    rappel_fin:      Mapped[bool]          = mapped_column(Boolean, nullable=False, default=True)
    derniere_erreur: Mapped[str | None]    = mapped_column(Text, nullable=True)
    created_at:      Mapped[datetime]      = mapped_column(DateTime(timezone=True), nullable=False, server_default=func.now())
