"""
hash_utils.py — stable_hash EduClé
SHA256(normalize(v4_niveau)|normalize(v4_mat_canonical)|str(chapitre_id)|normalize(enonce))
"""

import hashlib
import re


def normalize(text: str) -> str:
    if text is None:
        return ""
    return re.sub(r"\s+", " ", str(text).strip().lower())


def stable_hash(v4_niveau: str, v4_mat_canonical: str, chapitre_id: int, enonce: str) -> str:
    parts = "|".join([
        normalize(v4_niveau),
        normalize(v4_mat_canonical),
        str(chapitre_id),
        normalize(enonce),
    ])
    return hashlib.sha256(parts.encode("utf-8")).hexdigest()
