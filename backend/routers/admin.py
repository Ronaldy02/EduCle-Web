"""Endpoints admin : gestion des questions, chapitres, matières et utilisateur."""
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, selectinload
from sqlalchemy import select, func
from pydantic import BaseModel

from database import get_db
from models import Matiere, Chapitre, Question, UserPreferences, Score, StatistiqueQuestion

router = APIRouter(prefix="/admin", tags=["Admin"])


# ── Schémas ────────────────────────────────────────────────────────────────────

class QuestionIn(BaseModel):
    chapitre_id: int
    enonce: str
    choix: list[str]
    bonne_reponse: str
    explication: str
    niveau_complexite: str = "Moyen"

class QuestionOut(BaseModel):
    id: int
    chapitre_id: int
    matiere_id: int
    matiere_nom: str
    chapitre_titre: str
    enonce: str
    choix: list[str]
    bonne_reponse: str
    explication: str
    niveau_complexite: str
    nb_affichee: int = 0
    taux_reussite: float = 0.0

    class Config:
        from_attributes = True

class ChapitreOut(BaseModel):
    id: int
    matiere_id: int
    matiere_nom: str
    titre: str
    nb_questions: int

class MatiereOut(BaseModel):
    id: int
    niveau: str
    nom: str
    chapitres: list[ChapitreOut]

class UserOut(BaseModel):
    id: int
    xp_total: int
    pieces_total: int
    niveau_scolaire: str
    annee: str
    zone: str

class UserPatch(BaseModel):
    xp_total: int | None = None
    pieces_total: int | None = None
    niveau_scolaire: str | None = None
    annee: str | None = None
    zone: str | None = None

class ScoreOut(BaseModel):
    id: int
    matiere_id: int | None
    score: int
    nb_correctes: int
    nb_total: int
    mode_nom: str
    date: str

class StatsOut(BaseModel):
    nb_questions: int
    nb_matieres: int
    nb_chapitres: int
    nb_parties: int
    xp_total: int
    pieces_total: int


# ── Stats globales ─────────────────────────────────────────────────────────────

@router.get("/stats", response_model=StatsOut)
def get_stats(db: Session = Depends(get_db)):
    nb_questions = db.scalar(select(func.count()).select_from(Question))
    nb_matieres  = db.scalar(select(func.count()).select_from(Matiere))
    nb_chapitres = db.scalar(select(func.count()).select_from(Chapitre))
    nb_parties   = db.scalar(select(func.count()).select_from(Score))
    user = db.get(UserPreferences, 1)
    return StatsOut(
        nb_questions=nb_questions or 0,
        nb_matieres=nb_matieres or 0,
        nb_chapitres=nb_chapitres or 0,
        nb_parties=nb_parties or 0,
        xp_total=user.xp_total if user else 0,
        pieces_total=user.pieces_total if user else 0,
    )


# ── Matières + chapitres ───────────────────────────────────────────────────────

@router.get("/matieres", response_model=list[MatiereOut])
def list_matieres(db: Session = Depends(get_db)):
    matieres = db.scalars(
        select(Matiere).options(selectinload(Matiere.chapitres).selectinload(Chapitre.questions))
    ).all()
    result = []
    for m in matieres:
        chaps = [
            ChapitreOut(
                id=c.id, matiere_id=m.id, matiere_nom=m.nom,
                titre=c.titre, nb_questions=len(c.questions)
            )
            for c in m.chapitres
        ]
        result.append(MatiereOut(id=m.id, niveau=m.niveau, nom=m.nom, chapitres=chaps))
    return result


# ── Questions ─────────────────────────────────────────────────────────────────

@router.get("/questions", response_model=list[QuestionOut])
def list_questions(
    chapitre_id: int | None = None,
    matiere_id:  int | None = None,
    search:      str | None = None,
    db: Session = Depends(get_db),
):
    stmt = (
        select(Question)
        .options(selectinload(Question.chapitre).selectinload(Chapitre.matiere),
                 selectinload(Question.statistique))
    )
    if chapitre_id:
        stmt = stmt.where(Question.chapitre_id == chapitre_id)
    elif matiere_id:
        stmt = stmt.join(Chapitre).where(Chapitre.matiere_id == matiere_id)
    if search:
        stmt = stmt.where(Question.enonce.ilike(f"%{search}%"))
    questions = db.scalars(stmt).all()

    return [
        QuestionOut(
            id=q.id,
            chapitre_id=q.chapitre_id,
            matiere_id=q.chapitre.matiere_id,
            matiere_nom=q.chapitre.matiere.nom,
            chapitre_titre=q.chapitre.titre,
            enonce=q.enonce,
            choix=q.choix,
            bonne_reponse=q.bonne_reponse,
            explication=q.explication,
            niveau_complexite=q.niveau_complexite,
            nb_affichee=q.statistique.nb_affichee if q.statistique else 0,
            taux_reussite=round(q.statistique.nb_correcte * 100) if q.statistique else 0,
        )
        for q in questions
    ]


@router.post("/questions", response_model=QuestionOut, status_code=201)
def create_question(body: QuestionIn, db: Session = Depends(get_db)):
    chap = db.get(Chapitre, body.chapitre_id)
    if not chap:
        raise HTTPException(status_code=404, detail="Chapitre introuvable")
    if body.bonne_reponse not in body.choix:
        raise HTTPException(status_code=422, detail="bonne_reponse doit faire partie des choix")

    q = Question(**body.model_dump())
    db.add(q)
    db.commit()
    db.refresh(q)
    # reload relations
    db.refresh(q)
    chap2 = db.get(Chapitre, q.chapitre_id)
    mat   = db.get(Matiere, chap2.matiere_id)
    return QuestionOut(
        id=q.id, chapitre_id=q.chapitre_id,
        matiere_id=mat.id, matiere_nom=mat.nom,
        chapitre_titre=chap2.titre,
        enonce=q.enonce, choix=q.choix,
        bonne_reponse=q.bonne_reponse, explication=q.explication,
        niveau_complexite=q.niveau_complexite,
    )


@router.put("/questions/{question_id}", response_model=QuestionOut)
def update_question(question_id: int, body: QuestionIn, db: Session = Depends(get_db)):
    q = db.get(Question, question_id)
    if not q:
        raise HTTPException(status_code=404, detail="Question introuvable")
    if body.bonne_reponse not in body.choix:
        raise HTTPException(status_code=422, detail="bonne_reponse doit faire partie des choix")
    for k, v in body.model_dump().items():
        setattr(q, k, v)
    db.commit()
    chap = db.get(Chapitre, q.chapitre_id)
    mat  = db.get(Matiere, chap.matiere_id)
    stat = db.get(StatistiqueQuestion, q.id)
    return QuestionOut(
        id=q.id, chapitre_id=q.chapitre_id,
        matiere_id=mat.id, matiere_nom=mat.nom,
        chapitre_titre=chap.titre,
        enonce=q.enonce, choix=q.choix,
        bonne_reponse=q.bonne_reponse, explication=q.explication,
        niveau_complexite=q.niveau_complexite,
        nb_affichee=stat.nb_affichee if stat else 0,
        taux_reussite=round(stat.nb_correcte * 100) if stat else 0,
    )


@router.delete("/questions/{question_id}", status_code=204)
def delete_question(question_id: int, db: Session = Depends(get_db)):
    q = db.get(Question, question_id)
    if not q:
        raise HTTPException(status_code=404, detail="Question introuvable")
    stat = db.get(StatistiqueQuestion, question_id)
    if stat:
        db.delete(stat)
    db.delete(q)
    db.commit()


# ── Utilisateur ────────────────────────────────────────────────────────────────

@router.get("/user", response_model=UserOut)
def get_user(db: Session = Depends(get_db)):
    user = db.get(UserPreferences, 1)
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur introuvable")
    return user

@router.patch("/user", response_model=UserOut)
def patch_user(body: UserPatch, db: Session = Depends(get_db)):
    user = db.get(UserPreferences, 1)
    if not user:
        user = UserPreferences(id=1)
        db.add(user)
    for k, v in body.model_dump(exclude_none=True).items():
        setattr(user, k, v)
    db.commit()
    return user


# ── Scores ─────────────────────────────────────────────────────────────────────

@router.get("/scores", response_model=list[ScoreOut])
def list_scores(limit: int = 50, db: Session = Depends(get_db)):
    scores = db.scalars(
        select(Score).order_by(Score.date.desc()).limit(limit)
    ).all()
    return scores

@router.delete("/scores/{score_id}", status_code=204)
def delete_score(score_id: int, db: Session = Depends(get_db)):
    s = db.get(Score, score_id)
    if not s:
        raise HTTPException(status_code=404, detail="Score introuvable")
    db.delete(s)
    db.commit()
