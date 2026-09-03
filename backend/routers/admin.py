"""Endpoints admin : gestion des questions, chapitres, matières et utilisateur."""
from datetime import datetime, timedelta
from collections import defaultdict
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, selectinload
from sqlalchemy import select, func
from pydantic import BaseModel

from database import get_db
from models import Matiere, Chapitre, Question, UserPreferences, Score, StatistiqueQuestion
from models.realisation import Realisation

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
    last_correct_at: str | None = None

    class Config:
        from_attributes = True

class ChapitreIn(BaseModel):
    matiere_id: int
    titre: str

class ChapitreUpdate(BaseModel):
    titre: str | None = None

class ChapitreOut(BaseModel):
    id: int
    matiere_id: int
    matiere_nom: str
    titre: str
    nb_questions: int

class MatiereIn(BaseModel):
    niveau: str
    nom: str

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


# ── Activité (dashboard charts) ────────────────────────────────────────────────

@router.get("/activity")
def get_activity(period: str = "7d", db: Session = Depends(get_db)):
    now = datetime.now()
    if period == "today":
        since = now.replace(hour=0, minute=0, second=0, microsecond=0).isoformat()
    elif period == "7d":
        since = (now - timedelta(days=7)).isoformat()
    elif period == "30d":
        since = (now - timedelta(days=30)).isoformat()
    elif period == "90d":
        since = (now - timedelta(days=90)).isoformat()
    else:
        since = None

    stmt = select(Score)
    if since:
        stmt = stmt.where(Score.date >= since)
    scores = db.scalars(stmt).all()

    mode_dist: dict = {}
    mat_count: dict = {}
    daily: dict = defaultdict(int)
    total_score = 0.0

    for s in scores:
        mode = s.mode_nom or "Autre"
        mode_dist[mode] = mode_dist.get(mode, 0) + 1
        if s.matiere_id:
            mat_count[s.matiere_id] = mat_count.get(s.matiere_id, 0) + 1
        daily[s.date[:10]] += 1
        if s.nb_total:
            total_score += s.nb_correctes / s.nb_total * 100

    mat_ids = list(mat_count.keys())
    mat_map = {}
    if mat_ids:
        mats = db.scalars(select(Matiere).where(Matiere.id.in_(mat_ids))).all()
        mat_map = {m.id: m.nom for m in mats}

    top_matieres = sorted(
        [{"nom": mat_map.get(mid, "?"), "nb": nb} for mid, nb in mat_count.items()],
        key=lambda x: -x["nb"]
    )[:5]

    avg_score = round(total_score / len(scores), 1) if scores else 0.0

    return {
        "nb_parties": len(scores),
        "mode_distribution": sorted(
            [{"mode": k, "nb": v} for k, v in mode_dist.items()],
            key=lambda x: -x["nb"]
        ),
        "top_matieres": top_matieres,
        "daily": sorted([{"date": d, "nb": n} for d, n in daily.items()]),
        "avg_score": avg_score,
    }


# ── Matières ──────────────────────────────────────────────────────────────────

@router.post("/matieres", response_model=MatiereOut, status_code=201)
def create_matiere(body: MatiereIn, db: Session = Depends(get_db)):
    m = Matiere(niveau=body.niveau, nom=body.nom)
    db.add(m)
    db.commit()
    db.refresh(m)
    return MatiereOut(id=m.id, niveau=m.niveau, nom=m.nom, chapitres=[])

@router.get("/matieres", response_model=list[MatiereOut])
def list_matieres(db: Session = Depends(get_db)):
    matieres = db.scalars(
        select(Matiere).options(selectinload(Matiere.chapitres).selectinload(Chapitre.questions))
    ).all()
    result = []
    for m in matieres:
        chaps = [
            ChapitreOut(id=c.id, matiere_id=m.id, matiere_nom=m.nom,
                        titre=c.titre, nb_questions=len(c.questions))
            for c in m.chapitres
        ]
        result.append(MatiereOut(id=m.id, niveau=m.niveau, nom=m.nom, chapitres=chaps))
    return result


# ── Chapitres CRUD ─────────────────────────────────────────────────────────────

@router.get("/chapitres", response_model=list[ChapitreOut])
def list_chapitres(matiere_id: int | None = None, db: Session = Depends(get_db)):
    stmt = (
        select(Chapitre)
        .options(selectinload(Chapitre.matiere), selectinload(Chapitre.questions))
    )
    if matiere_id:
        stmt = stmt.where(Chapitre.matiere_id == matiere_id)
    chapitres = db.scalars(stmt).all()
    return [
        ChapitreOut(id=c.id, matiere_id=c.matiere_id,
                    matiere_nom=c.matiere.nom, titre=c.titre,
                    nb_questions=len(c.questions))
        for c in chapitres
    ]

@router.post("/chapitres", response_model=ChapitreOut, status_code=201)
def create_chapitre(body: ChapitreIn, db: Session = Depends(get_db)):
    mat = db.get(Matiere, body.matiere_id)
    if not mat:
        raise HTTPException(status_code=404, detail="Matière introuvable")
    c = Chapitre(matiere_id=body.matiere_id, titre=body.titre)
    db.add(c)
    db.commit()
    db.refresh(c)
    return ChapitreOut(id=c.id, matiere_id=c.matiere_id, matiere_nom=mat.nom, titre=c.titre, nb_questions=0)

@router.put("/chapitres/{chapitre_id}", response_model=ChapitreOut)
def update_chapitre(chapitre_id: int, body: ChapitreUpdate, db: Session = Depends(get_db)):
    c = db.get(Chapitre, chapitre_id)
    if not c:
        raise HTTPException(status_code=404, detail="Chapitre introuvable")
    if body.titre:
        c.titre = body.titre
    db.commit()
    mat = db.get(Matiere, c.matiere_id)
    nb_q = db.scalar(select(func.count()).select_from(Question).where(Question.chapitre_id == c.id))
    return ChapitreOut(id=c.id, matiere_id=c.matiere_id, matiere_nom=mat.nom, titre=c.titre, nb_questions=nb_q or 0)

@router.delete("/chapitres/{chapitre_id}", status_code=204)
def delete_chapitre(chapitre_id: int, db: Session = Depends(get_db)):
    c = db.get(Chapitre, chapitre_id)
    if not c:
        raise HTTPException(status_code=404, detail="Chapitre introuvable")
    nb_q = db.scalar(select(func.count()).select_from(Question).where(Question.chapitre_id == chapitre_id))
    if nb_q:
        raise HTTPException(status_code=409, detail=f"Ce chapitre contient {nb_q} question(s). Supprimez-les d'abord.")
    db.delete(c)
    db.commit()


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
            last_correct_at=q.statistique.last_correct_at if q.statistique else None,
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
    mat = db.get(Matiere, chap.matiere_id)
    return QuestionOut(
        id=q.id, chapitre_id=q.chapitre_id,
        matiere_id=mat.id, matiere_nom=mat.nom,
        chapitre_titre=chap.titre,
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
        last_correct_at=stat.last_correct_at if stat else None,
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


# ── Réalisations ───────────────────────────────────────────────────────────────

@router.get("/realisations")
def list_realisations(db: Session = Depends(get_db)):
    reals = db.scalars(select(Realisation)).all()
    return [
        {
            "id": r.id, "nom": r.nom, "description": r.description,
            "categorie": r.categorie, "rarete": r.rarete,
            "objectif": r.objectif, "recompense_pieces": r.recompense_pieces,
            "secret": r.secret, "progres": r.progres,
            "debloquee": r.debloquee, "debloquee_at": r.debloquee_at,
        }
        for r in reals
    ]
