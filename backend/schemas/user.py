from pydantic import BaseModel, ConfigDict


class UserSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    zone: str
    niveau_scolaire: str
    annee: str
    xp_total: int
    pieces_total: int


class UserUpdateRequest(BaseModel):
    zone: str | None = None
    niveau_scolaire: str | None = None
    annee: str | None = None


class NiveauSchema(BaseModel):
    """Niveau, rang et progression XP de l'utilisateur."""
    xp_total: int
    pieces_total: int
    niveau: int
    rang: str
    rang_nom: str
    rang_emoji: str
    rang_couleur: str
    progression: float     # 0.0 à 1.0 dans le niveau actuel
    xp_dans_niveau: int    # XP depuis le début du niveau actuel
    xp_pour_suivant: int   # XP total pour atteindre le prochain niveau


class ScoreSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    matiere_id: int | None
    score: int
    nb_correctes: int
    nb_total: int
    mode_nom: str
    date: str
