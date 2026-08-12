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


class StatistiqueQuestionSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    question_id: int
    nb_affichee: int
    nb_correcte: float
    last_correct_at: str | None
