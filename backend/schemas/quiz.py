"""Schémas Pydantic pour le déroulement d'un quiz."""
from pydantic import BaseModel


class DemarrerQuizRequest(BaseModel):
    chapitre_id: int       # -1 = toutes les matières
    mode_nom: str          # "Révision" | "Rush" | "Bombardement"
    nb_questions: int = 10


class RepondreRequest(BaseModel):
    question_id: int
    reponse: str
    temps_restant: int     # secondes restantes au moment du clic


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
    # État après le quiz
    xp_total: int
    pieces_total: int
    niveau_avant: int
    niveau_apres: int
