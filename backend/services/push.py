"""Service d'envoi de notifications Web Push via pywebpush."""
import json
import logging
from config import settings

logger = logging.getLogger(__name__)


def _webpush_disponible() -> bool:
    return bool(settings.vapid_private_key)


def envoyer(endpoint: str, cle_p256dh: str, cle_auth: str, titre: str, corps: str, url: str = "/defis") -> bool:
    """Envoie une notification Web Push. Retourne True si OK, False si l'abonnement est expiré (404/410)."""
    if not _webpush_disponible():
        logger.warning("[DEV] Web Push non configuré (VAPID_PRIVATE_KEY absent) — notification ignorée.")
        return True

    from pywebpush import webpush, WebPushException

    data = json.dumps({"title": titre, "body": corps, "url": url})
    try:
        webpush(
            subscription_info={
                "endpoint": endpoint,
                "keys": {"p256dh": cle_p256dh, "auth": cle_auth},
            },
            data=data,
            vapid_private_key=settings.vapid_private_key,
            vapid_claims={"sub": settings.vapid_subject},
        )
        return True
    except WebPushException as exc:
        status = getattr(exc.response, "status_code", None) if exc.response else None
        if status in (404, 410):
            return False  # abonnement expiré → supprimer
        logger.error("WebPush échec endpoint=%s status=%s : %s", endpoint[:60], status, exc)
        return True  # erreur temporaire : ne pas supprimer
