"""Service d'envoi d'e-mails via l'API Brevo (transactionnel)."""
import logging
from config import settings

logger = logging.getLogger(__name__)

_BREVO_URL = "https://api.brevo.com/v3/smtp/email"


def envoyer_code_reinitialisation(destinataire: str, code: str) -> None:
    """Envoie le code à 6 chiffres par e-mail.

    Si EMAIL_API_KEY n'est pas configurée, écrit le code dans les logs
    (niveau WARNING, affiché en développement uniquement).
    """
    if not settings.email_api_key or not settings.email_expediteur:
        logger.warning(
            "[DEV] Code de réinitialisation pour %s : %s (aucune clé Brevo configurée)",
            destinataire, code,
        )
        return

    import httpx  # import différé — non nécessaire si pas de clé

    payload = {
        "sender": {
            "name": settings.email_expediteur_nom,
            "email": settings.email_expediteur,
        },
        "to": [{"email": destinataire}],
        "subject": "Ton code EduClé",
        "htmlContent": (
            "<p>Bonjour,</p>"
            f"<p>Ton code de réinitialisation est : <strong style='font-size:1.5rem;letter-spacing:.2em'>{code}</strong></p>"
            "<p>Il est valable <strong>15 minutes</strong>.</p>"
            "<p>Si tu n'as pas demandé de réinitialisation, ignore ce message.</p>"
            "<p>— L'équipe EduClé</p>"
        ),
    }
    try:
        resp = httpx.post(
            _BREVO_URL,
            json=payload,
            headers={"api-key": settings.email_api_key, "Content-Type": "application/json"},
            timeout=10,
        )
        resp.raise_for_status()
    except Exception as exc:
        logger.error("Échec envoi e-mail Brevo vers %s : %s", destinataire, exc)
        raise
