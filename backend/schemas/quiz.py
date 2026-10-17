"""Schémas Pydantic pour le déroulement d'un quiz."""
from schemas.question import QuestionQuizSchema
from typing import Literal

from pydantic import BaseModel, Field

ModeNom = Literal["Révision", "Rush", "Génie", "Bombardement"]


class DemarrerQuizRequest(BaseModel):
    chapitre_id: int       # > 0 = un chapitre, -N = toute la matière N
    mode_nom: ModeNom
    nb_questions: int = Field(default=10, ge=1, le=50)


class DemarrerQuizResponse(BaseModel):
    partie_id: int
    questions: list[QuestionQuizSchema]


class UtiliserBonusRequest(BaseModel):
    type: Literal["elimination", "cinqCinq", "remplacer", "plusTemps"]
    partie_id: int
    question_id: int | None = None
    # Choix déjà masqués à l'écran (pour ne pas les « éliminer » une seconde fois)
    deja_elimines: list[str] = Field(default=[], max_length=10)


class UtiliserBonusResponse(BaseModel):
    cout: int
    pieces_total: int      # solde après déduction
    elimines: list[str] = []   # choix à masquer (élimination / 50-50)


class RepondreRequest(BaseModel):
    partie_id: int
    question_id: int
    reponse: str = Field(max_length=1000)   # "" = temps écoulé ou question passée


class RepondreResponse(BaseModel):
    correcte: bool
    bonne_reponse: str
    explication: str


class TerminerQuizRequest(BaseModel):
    partie_id: int


class QuestionResultatSchema(BaseModel):
    question_id: int
    enonce: str
    choix: list[str]
    bonne_reponse: str
    explication: str
    reponse_donnee: str | None
    correcte: bool
    xp_gagne: int


class ResultatQuizSchema(BaseModel):
    score: int
    total: int
    mode_nom: str
    questions: list[QuestionResultatSchema]
    xp_gagne: int
    pieces_gagnees: int
    serie_bonus: int = 0   # pièces bonus des paliers de série
    serie_max: int = 0     # meilleure série atteinte
    # Défis et réalisations complétés pendant ce quiz
    defis_completes: list[str] = []
    realisations_debloquees: list[str] = []
    xp_bonus_defis: int = 0
    pieces_bonus_defis: int = 0
    # État après le quiz
    xp_total: int
    pieces_total: int
    niveau_avant: int
    niveau_apres: int
