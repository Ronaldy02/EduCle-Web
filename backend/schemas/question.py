from pydantic import BaseModel, ConfigDict


class QuestionSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    chapitre_id: int
    enonce: str
    choix: list[str]
    bonne_reponse: str
    explication: str
    niveau_complexite: str
    # Gains d'une bonne réponse (affichés en direct pendant le quiz, cf. /quiz/demarrer)
    xp: int = 0
    pieces: int = 0


class QuestionQuizSchema(BaseModel):
    """Question servie pendant une partie : sans bonne réponse ni explication."""
    id: int
    chapitre_id: int
    enonce: str
    choix: list[str]
    niveau_complexite: str
    xp: int = 0
    pieces: int = 0


class StatistiqueQuestionSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    question_id: int
    nb_affichee: int
    nb_correcte: float
    last_correct_at: str | None
