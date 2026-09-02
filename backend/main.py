"""Point d'entrée de l'API FastAPI — EduClé Web.

Lancer en développement :
    uvicorn main:app --reload

Documentation interactive (Swagger) :
    http://localhost:8000/docs
"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from config import settings
from routers import matieres, quiz, user, realisations, admin

app = FastAPI(
    title="EduClé API",
    description="API du quiz éducatif EduClé — version web. "
                "Documentation Swagger disponible ici pour explorer tous les endpoints.",
    version="1.0.0",
)

# ─── CORS (autorise le frontend Vue.js) ───────────────────────────────────────
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins_list,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ─── Routers ──────────────────────────────────────────────────────────────────
app.include_router(matieres.router)
app.include_router(quiz.router)
app.include_router(user.router)
app.include_router(realisations.router)
app.include_router(admin.router)


@app.get("/", tags=["Santé"])
def root():
    return {"message": "EduClé API opérationnelle", "docs": "/docs"}


@app.get("/health", tags=["Santé"])
def health():
    return {"status": "ok"}
