"""
test_pipeline.py
Tests contrôlés du pipeline avant reprise de la génération.

Teste les 7 scénarios de robustesse :
  T1 : deux publications simultanées du même batch → 0 doublon
  T2 : retry après erreur → idempotent
  T3 : question déjà publiée → ignorée proprement
  T4 : stable_hash identique → rejeté
  T5 : crash pendant 'processing' → récupération automatique
  T6 : question invalide → rejetée avant publication
  T7 : question valide → publiée

Prérequis :
  - Migration 001 appliquée (processing_started_at)
  - Pas de nouvelles questions générées (test isolé)
  - DATABASE_URL défini en variable d'environnement

Usage:
    python test_pipeline.py [--cleanup]  # --cleanup supprime les données de test
"""

import argparse
import json
import os
import sys
import time
import threading
import psycopg2
import psycopg2.extras

DB_URL = os.environ.get("DATABASE_URL", "")
TEST_BATCH = "test_pipeline_robustesse"


def get_conn():
    return psycopg2.connect(DB_URL, cursor_factory=psycopg2.extras.RealDictCursor)


def cleanup(verbose=True):
    conn = get_conn()
    conn.autocommit = True
    cur = conn.cursor()
    cur.execute("DELETE FROM questions_staging WHERE batch_id = %s", (TEST_BATCH,))
    cur.execute("DELETE FROM questions WHERE stable_hash LIKE 'test_%'")
    if verbose:
        print(f"Nettoyage effectué (batch={TEST_BATCH}, questions test supprimées)")
    conn.close()


def insert_test_question(cur, suffix, statut="draft", invalid=False):
    """Insère une question de test avec un stable_hash unique."""
    from hash_utils import stable_hash as compute_hash
    enonce = f"Question de test {suffix} — pipeline robustesse"
    h = f"test_{suffix}_" + compute_hash("NS1", "M06", 82, enonce)
    choix = [f"Réponse A {suffix}", f"Réponse B {suffix}", f"Réponse C {suffix}", f"Réponse D {suffix}"]
    bonne = choix[0]

    if invalid:
        # Question invalide : bonne_reponse absente des choix
        bonne = "Réponse inexistante"

    cur.execute(
        """INSERT INTO questions_staging
           (batch_id, chapitre_id, enonce, choix, bonne_reponse, explication,
            niveau_complexite, v4_niveau, v4_mat_canonical, v4_mat_old,
            v4_composante, v4_conf, stable_hash, rubrique_educle, statut)
           VALUES (%s, 82, %s, %s, %s,
                   'Explication de test suffisamment longue pour passer la validation.',
                   'Moyen', 'NS1', 'M06', NULL, NULL, 'A', %s, 'A', %s)
           RETURNING id""",
        (TEST_BATCH, enonce, json.dumps(choix, ensure_ascii=False), bonne, h, statut)
    )
    return cur.fetchone()["id"], h


def assert_eq(label, actual, expected):
    status = "OK" if actual == expected else "FAIL"
    print(f"  [{status}] {label}: attendu={expected!r}, obtenu={actual!r}")
    if actual != expected:
        raise AssertionError(f"{label}: attendu {expected!r}, obtenu {actual!r}")


def run_tests():
    if not DB_URL:
        print("ERREUR: DATABASE_URL non défini", file=sys.stderr)
        sys.exit(1)

    print(f"\n{'='*60}")
    print("TEST PIPELINE — 7 SCÉNARIOS")
    print(f"{'='*60}")

    # Nettoyage initial
    cleanup(verbose=False)

    results = []

    # ── T6 : Question invalide → validate_staging la rejette ─────────────────
    print("\n[T6] Question invalide → rejetée par validate_staging")
    conn = get_conn()
    conn.autocommit = False
    cur = conn.cursor()
    id_invalid, hash_invalid = insert_test_question(cur, "T6_invalid", statut="draft", invalid=True)
    conn.commit()

    import subprocess
    proc = subprocess.run(
        [sys.executable, "validate_staging.py", "--batch", TEST_BATCH],
        env={**os.environ, "DATABASE_URL": DB_URL},
        capture_output=True, text=True, cwd=os.path.dirname(__file__)
    )
    print(proc.stdout)
    if proc.stderr:
        print("STDERR:", proc.stderr)

    cur.execute("SELECT statut FROM questions_staging WHERE id = %s", (id_invalid,))
    row = cur.fetchone()
    assert_eq("T6 statut après validate", row["statut"], "rejected")
    results.append(("T6", True))

    # ── T7 : Question valide → validate → mark_ready → publish ───────────────
    print("\n[T7] Question valide → publiée correctement")
    id_valid, hash_valid = insert_test_question(cur, "T7_valid", statut="draft")
    conn.commit()

    subprocess.run(
        [sys.executable, "validate_staging.py", "--batch", TEST_BATCH],
        env={**os.environ, "DATABASE_URL": DB_URL},
        capture_output=True, cwd=os.path.dirname(__file__)
    )
    subprocess.run(
        [sys.executable, "mark_ready.py", "--batch", TEST_BATCH],
        env={**os.environ, "DATABASE_URL": DB_URL},
        capture_output=True, cwd=os.path.dirname(__file__)
    )

    proc = subprocess.run(
        [sys.executable, "publish_to_prod.py", "--batch", TEST_BATCH],
        env={**os.environ, "DATABASE_URL": DB_URL},
        capture_output=True, text=True, cwd=os.path.dirname(__file__)
    )
    print(proc.stdout)

    cur.execute("SELECT statut, published_q_id FROM questions_staging WHERE id = %s", (id_valid,))
    row = cur.fetchone()
    assert_eq("T7 statut après publish", row["statut"], "published")
    assert_eq("T7 published_q_id renseigné", row["published_q_id"] is not None, True)
    results.append(("T7", True))

    prod_id_t7 = row["published_q_id"]

    # ── T3 : Question déjà publiée → republication ignorée ───────────────────
    print("\n[T3] Question déjà publiée → ignorée")
    cur.execute(
        "UPDATE questions_staging SET statut = 'ready' WHERE id = %s",
        (id_valid,)
    )
    conn.commit()

    proc = subprocess.run(
        [sys.executable, "publish_to_prod.py", "--batch", TEST_BATCH],
        env={**os.environ, "DATABASE_URL": DB_URL},
        capture_output=True, text=True, cwd=os.path.dirname(__file__)
    )
    print(proc.stdout)

    cur.execute("SELECT COUNT(*) AS n FROM questions WHERE stable_hash = %s", (hash_valid,))
    n = cur.fetchone()["n"]
    assert_eq("T3 aucun doublon créé", n, 1)
    results.append(("T3", True))

    # ── T4 : stable_hash identique inséré manuellement → rejeté ──────────────
    print("\n[T4] stable_hash identique → rejeté")
    id_dup, _ = insert_test_question(cur, "T7_valid", statut="ready")  # même hash que T7
    cur.execute(
        "UPDATE questions_staging SET stable_hash = %s WHERE id = %s",
        (hash_valid, id_dup)
    )
    conn.commit()

    proc = subprocess.run(
        [sys.executable, "publish_to_prod.py"],
        env={**os.environ, "DATABASE_URL": DB_URL},
        capture_output=True, text=True, cwd=os.path.dirname(__file__)
    )
    print(proc.stdout)

    cur.execute("SELECT statut FROM questions_staging WHERE id = %s", (id_dup,))
    row = cur.fetchone()
    assert_eq("T4 statut", row["statut"], "rejected")
    cur.execute("SELECT COUNT(*) AS n FROM questions WHERE stable_hash = %s", (hash_valid,))
    n = cur.fetchone()["n"]
    assert_eq("T4 toujours 1 en prod", n, 1)
    results.append(("T4", True))

    # ── T5 : Crash pendant 'processing' → récupération ───────────────────────
    print("\n[T5] Crash pendant processing → récupération après timeout simulé")
    id_stuck, hash_stuck = insert_test_question(cur, "T5_stuck", statut="ready")
    conn.commit()

    # Simuler un crash : mettre directement en 'processing' avec un vieux timestamp
    cur.execute(
        """UPDATE questions_staging
           SET statut = 'processing',
               processing_started_at = NOW() - INTERVAL '31 minutes'
           WHERE id = %s""",
        (id_stuck,)
    )
    conn.commit()

    proc = subprocess.run(
        [sys.executable, "publish_to_prod.py", "--recover"],
        env={**os.environ, "DATABASE_URL": DB_URL},
        capture_output=True, text=True, cwd=os.path.dirname(__file__)
    )
    print(proc.stdout)

    cur.execute("SELECT statut FROM questions_staging WHERE id = %s", (id_stuck,))
    row = cur.fetchone()
    assert_eq("T5 ligne remise en ready", row["statut"], "ready")
    results.append(("T5", True))

    # ── T2 : Retry après erreur → idempotent ──────────────────────────────────
    print("\n[T2] Retry après erreur → idempotent (basé sur T5)")
    proc = subprocess.run(
        [sys.executable, "publish_to_prod.py"],
        env={**os.environ, "DATABASE_URL": DB_URL},
        capture_output=True, text=True, cwd=os.path.dirname(__file__)
    )
    print(proc.stdout)

    cur.execute("SELECT statut FROM questions_staging WHERE id = %s", (id_stuck,))
    row_after = cur.fetchone()
    assert_eq("T2 publiée après retry", row_after["statut"], "published")
    results.append(("T2", True))

    # ── T1 : Deux publications simultanées → 0 doublon ───────────────────────
    print("\n[T1] Deux publications simultanées → 0 doublon")
    id_race1, hash_race = insert_test_question(cur, "T1_race", statut="ready")
    conn.commit()

    errors_t1 = []

    def run_publish():
        try:
            subprocess.run(
                [sys.executable, "publish_to_prod.py"],
                env={**os.environ, "DATABASE_URL": DB_URL},
                capture_output=True, cwd=os.path.dirname(__file__)
            )
        except Exception as e:
            errors_t1.append(str(e))

    t1 = threading.Thread(target=run_publish)
    t2 = threading.Thread(target=run_publish)
    t1.start(); t2.start()
    t1.join(); t2.join()

    cur.execute("SELECT COUNT(*) AS n FROM questions WHERE stable_hash = %s", (hash_race,))
    n = cur.fetchone()["n"]
    assert_eq("T1 aucun doublon (0 ou 1 en prod)", n <= 1, True)
    results.append(("T1", True))

    conn.close()

    # ── Résumé ────────────────────────────────────────────────────────────────
    print(f"\n{'='*60}")
    print("RÉSUMÉ DES TESTS")
    print(f"{'='*60}")
    all_ok = True
    for name, ok in results:
        status = "PASS" if ok else "FAIL"
        print(f"  [{status}] {name}")
        if not ok:
            all_ok = False

    print(f"\n{'TOUS LES TESTS PASSENT' if all_ok else 'ÉCHECS DÉTECTÉS'}")

    # Nettoyage final
    cleanup()
    return all_ok


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--cleanup", action="store_true",
                        help="Supprime uniquement les données de test et quitte")
    args = parser.parse_args()

    if args.cleanup:
        cleanup()
        sys.exit(0)

    try:
        success = run_tests()
        sys.exit(0 if success else 1)
    except AssertionError as e:
        print(f"\nASSERTION ÉCHOUÉE: {e}", file=sys.stderr)
        cleanup()
        sys.exit(1)
    except Exception as e:
        print(f"\nERREUR INATTENDUE: {e}", file=sys.stderr)
        cleanup()
        sys.exit(1)
