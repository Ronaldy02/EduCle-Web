"""Point d'entrée de l'API FastAPI — EduClé Web.

Lancer en développement :
    uvicorn main:app --reload

Documentation interactive (Swagger) :
    http://localhost:8000/docs
"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from config import settings
from routers import matieres, quiz, user, realisations, admin, defis
from routers.auth import router as auth_router
from routers.admin_auth import router as admin_auth_router
from routers.proposals import router as proposals_router
from routers.sync import router as sync_router
from routers.notifications import router as notifications_router

app = FastAPI(
    title="EduClé API",
    description="API du quiz éducatif EduClé — version web. "
                "Documentation Swagger disponible ici pour explorer tous les endpoints.",
    version="1.0.0",
    docs_url="/docs" if settings.exposer_docs else None,
    redoc_url="/redoc" if settings.exposer_docs else None,
    openapi_url="/openapi.json" if settings.exposer_docs else None,
)

# ─── CORS (autorise le frontend Vue.js) ───────────────────────────────────────
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins_list,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ─── En-têtes de sécurité (réponses JSON : pas d'affichage en cadre, pas de devinette de type) ──
@app.middleware("http")
async def entetes_securite(request, call_next):
    response = await call_next(request)
    response.headers["X-Content-Type-Options"] = "nosniff"
    response.headers["X-Frame-Options"] = "DENY"
    response.headers["Referrer-Policy"] = "no-referrer"
    response.headers.setdefault("Cache-Control", "no-store")
    return response


# ─── Routers ──────────────────────────────────────────────────────────────────
app.include_router(auth_router)
app.include_router(matieres.router)
app.include_router(quiz.router)
app.include_router(user.router)
app.include_router(realisations.router)
app.include_router(defis.router)
app.include_router(admin.router)
app.include_router(admin_auth_router)
app.include_router(proposals_router)
app.include_router(sync_router)
app.include_router(notifications_router)


@app.get("/", tags=["Santé"])
def root():
    return {"message": "EduClé API opérationnelle"}


@app.get("/health", tags=["Santé"])
def health():
    return {"status": "ok"}
