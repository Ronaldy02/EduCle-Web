from pydantic import field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    database_url: str
    cors_origins: str = "http://localhost:5173"
    # Obligatoire (variable SECRET_KEY) : aucune valeur par défaut, sinon les JWT sont falsifiables
    secret_key: str
    google_client_id: str = ""
    google_client_secret: str = ""
    frontend_url: str = "http://localhost:5173"
    # Swagger (/docs, /openapi.json) : désactivé par défaut, à activer en local (EXPOSER_DOCS=true)
    exposer_docs: bool = False

    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")

    @field_validator("secret_key")
    @classmethod
    def _secret_key_robuste(cls, v: str) -> str:
        if len(v) < 32 or v.startswith("changez-moi"):
            raise ValueError("SECRET_KEY doit être une valeur aléatoire d'au moins 32 caractères")
        return v

    @property
    def cors_origins_list(self) -> list[str]:
        return [o.strip() for o in self.cors_origins.split(",")]


settings = Settings()
