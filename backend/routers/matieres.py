"""Endpoints : matières, chapitres, cartes mentales."""
import time

from fastapi import APIRouter, Depends, HTTPException, Response
from sqlalchemy.orm import Session, selectinload
from sqlalchemy import select, func

from database import get_db
from models import Matiere, Chapitre, CarteMentale, Question
from schemas.matiere import MatiereSchema, MatiereDetailSchema, ChapitreDetailSchema

router = APIRouter(prefix="/matieres", tags=["Matières"])

_MIN_QUESTIONS = 10


@router.get("/", response_model=list[MatiereSchema])
def lister_matieres(niveau: str | None = None, db: Session = Depends(get_db)):
    """Liste les matières ayant au moins un chapitre avec ≥ 10 questions."""
    viable_chap_ids = (
        select(Question.chapitre_id)
        .group_by(Question.chapitre_id)
        .having(func.count(Question.id) >= _MIN_QUESTIONS)
    )
    matiere_ids_visibles = select(Chapitre.matiere_id).where(
        Chapitre.id.in_(viable_chap_ids)
    )
    q = select(Matiere).where(Matiere.id.in_(matiere_ids_visibles))
    if niveau:
        q = q.where(Matiere.niveau == niveau)
    return db.scalars(q.order_by(Matiere.nom)).all()


@router.get("/niveaux", response_model=list[str])
def lister_niveaux(db: Session = Depends(get_db)):
    """Retourne les niveaux scolaires distincts présents dans la base."""
    rows = db.execute(select(Matiere.niveau).distinct()).scalars().all()
    return sorted(rows)


@router.get("/themes")
def lister_themes(db: Session = Depends(get_db)):
    """Chapitres jouables (≥ 10 questions) groupés par matière, pour la recherche de l'accueil."""
    rows = db.execute(
        select(Matiere.id, Matiere.nom, Chapitre.id, Chapitre.titre, func.count(Question.id))
        .join(Chapitre, Chapitre.matiere_id == Matiere.id)
        .join(Question, Question.chapitre_id == Chapitre.id)
        .group_by(Matiere.id, Matiere.nom, Chapitre.id, Chapitre.titre)
        .having(func.count(Question.id) >= _MIN_QUESTIONS)
        .order_by(Matiere.nom, Chapitre.titre)
    ).all()
    par_matiere: dict[int, dict] = {}
    for m_id, m_nom, c_id, c_titre, nb in rows:
        m = par_matiere.setdefault(m_id, {"id": m_id, "nom": m_nom, "chapitres": []})
        m["chapitres"].append({"id": c_id, "titre": c_titre, "nb_questions": nb})
    return list(par_matiere.values())


_apercu_cache: dict = {"t": 0.0, "data": None}
_APERCU_TTL = 600  # secondes


@router.get("/apercu")
def apercu_public(response: Response, db: Session = Depends(get_db)):
    """Chiffres de la page de connexion (public). Mis en cache 10 min : une seule requête SQL légère."""
    maintenant = time.monotonic()
    if _apercu_cache["data"] is None or maintenant - _apercu_cache["t"] > _APERCU_TTL:
        rows = db.execute(
            select(Matiere.nom, func.count(Question.id))
            .join(Chapitre, Chapitre.matiere_id == Matiere.id)
            .join(Question, Question.chapitre_id == Chapitre.id)
            .group_by(Chapitre.id, Matiere.nom)
            .having(func.count(Question.id) >= _MIN_QUESTIONS)
        ).all()
        _apercu_cache["data"] = {
            "matieres": len({nom.strip().casefold() for nom, _ in rows}),
            "questions": sum(nb for _, nb in rows),
        }
        _apercu_cache["t"] = maintenant
    response.headers["Cache-Control"] = "public, max-age=300"
    return _apercu_cache["data"]


@router.get("/{matiere_id}", response_model=MatiereDetailSchema)
def detail_matiere(matiere_id: int, db: Session = Depends(get_db)):
    """Détail d'une matière avec ses chapitres (≥ 10 questions seulement)."""
    matiere = db.scalar(
        select(Matiere)
        .options(selectinload(Matiere.chapitres))
        .where(Matiere.id == matiere_id)
    )
    if not matiere:
        raise HTTPException(status_code=404, detail="Matière introuvable")

    chap_ids = [c.id for c in matiere.chapitres]
    counts: dict[int, int] = {}
    if chap_ids:
        rows = db.execute(
            select(Question.chapitre_id, func.count(Question.id))
            .where(Question.chapitre_id.in_(chap_ids))
            .group_by(Question.chapitre_id)
        ).all()
        counts = {chap_id: cnt for chap_id, cnt in rows}

    return {
        "id": matiere.id,
        "niveau": matiere.niveau,
        "nom": matiere.nom,
        "chapitres": [
            {
                "id": c.id, "matiere_id": c.matiere_id, "titre": c.titre,
                "niveau_v4": c.niveau_v4, "nb_questions": counts.get(c.id, 0),
            }
            for c in matiere.chapitres
            if counts.get(c.id, 0) >= _MIN_QUESTIONS
        ],
    }


@router.get("/{matiere_id}/chapitres/{chapitre_id}", response_model=ChapitreDetailSchema)
def detail_chapitre(matiere_id: int, chapitre_id: int, db: Session = Depends(get_db)):
    """Détail d'un chapitre avec ses cartes mentales."""
    chapitre = db.scalar(
        select(Chapitre)
        .options(selectinload(Chapitre.cartes_mentales))
        .where(Chapitre.id == chapitre_id, Chapitre.matiere_id == matiere_id)
    )
    if not chapitre:
        raise HTTPException(status_code=404, detail="Chapitre introuvable")
    return chapitre
