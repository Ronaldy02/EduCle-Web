from pydantic import BaseModel, ConfigDict


class CarteMentaleSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    chapitre_id: int
    contenu: str
    image: str | None


class ChapitreSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    matiere_id: int
    titre: str


class ChapitreDetailSchema(ChapitreSchema):
    cartes_mentales: list[CarteMentaleSchema] = []


class MatiereSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    niveau: str
    nom: str


class MatiereDetailSchema(MatiereSchema):
    chapitres: list[ChapitreSchema] = []
