import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'database_helper.dart';

const _supabaseUrl = 'https://uqwrzaehvxgfxglxneax.supabase.co';
// À remplir : Supabase Dashboard → Settings → API → anon public
const _supabaseAnonKey = 'REMPLACER_PAR_LA_CLE_ANON';

class SupabaseService {
  SupabaseService._();
  static final SupabaseService instance = SupabaseService._();

  SupabaseClient get _client => Supabase.instance.client;
  User? get currentUser => _client.auth.currentUser;
  bool get estConnecte => currentUser != null;

  static Future<void> initialiser() async {
    await Supabase.initialize(url: _supabaseUrl, anonKey: _supabaseAnonKey);
  }

  // ── Auth ──────────────────────────────────────────────────────────────────

  Future<AuthResponse> inscription(String email, String password) =>
      _client.auth.signUp(email: email, password: password);

  Future<AuthResponse> connexion(String email, String password) =>
      _client.auth.signInWithPassword(email: email, password: password);

  Future<void> deconnexion() => _client.auth.signOut();

  // ── Sync ──────────────────────────────────────────────────────────────────

  /// Pousse toutes les stats locales vers Supabase.
  /// Appelé au démarrage si connecté, et après chaque quiz.
  Future<void> syncVersServeur() async {
    if (!estConnecte) return;
    final connectivite = await Connectivity().checkConnectivity();
    if (connectivite.contains(ConnectivityResult.none)) return;

    final uid = currentUser!.id;
    final db = DatabaseHelper.instance;

    await Future.wait([
      _syncProfil(uid, db),
      _syncProgression(uid, db),
      _syncScores(uid, db),
      _syncStatsQuestions(uid, db),
    ]);
  }

  /// Tire les stats depuis Supabase vers la base locale (nouveau device).
  Future<void> syncDepuisServeur() async {
    if (!estConnecte) return;
    final connectivite = await Connectivity().checkConnectivity();
    if (connectivite.contains(ConnectivityResult.none)) return;

    final uid = currentUser!.id;
    final db = DatabaseHelper.instance;

    await Future.wait([
      _pullProfil(uid, db),
      _pullProgression(uid, db),
      _pullScores(uid, db),
      _pullStatsQuestions(uid, db),
    ]);
  }

  // ── Push helpers ──────────────────────────────────────────────────────────

  Future<void> _syncProfil(String uid, DatabaseHelper db) async {
    final niveau = await db.getNiveauScolaire();
    final annee = await db.getAnnee();
    await _client.from('user_profils').upsert({
      'user_id': uid,
      'niveau_scolaire': niveau,
      'annee': annee,
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'user_id');
  }

  Future<void> _syncProgression(String uid, DatabaseHelper db) async {
    final rows = await db.getAllProgression();
    if (rows.isEmpty) return;
    final payload = rows.map((r) => {...r, 'user_id': uid}).toList();
    await _client.from('user_progression').upsert(
      payload,
      onConflict: 'user_id,chapitre_id',
    );
  }

  Future<void> _syncScores(String uid, DatabaseHelper db) async {
    final rows = await db.getAllScoresNonSync();
    if (rows.isEmpty) return;
    final payload = rows.map((r) => {
      'user_id': uid,
      'matiere_id': r['matiere_id'],
      'score': r['score'],
      'nb_correctes': r['nb_correctes'],
      'nb_total': r['nb_total'],
      'mode_nom': r['mode_nom'],
      'date': r['date'],
    }).toList();
    await _client.from('user_scores').insert(payload);
    await db.marquerScoresSynces(rows.map((r) => r['id'] as int).toList());
  }

  Future<void> _syncStatsQuestions(String uid, DatabaseHelper db) async {
    final rows = await db.getAllStatsQuestions();
    if (rows.isEmpty) return;
    final payload = rows.map((r) => {...r, 'user_id': uid}).toList();
    await _client.from('user_statistiques_questions').upsert(
      payload,
      onConflict: 'user_id,question_id',
    );
  }

  // ── Pull helpers ──────────────────────────────────────────────────────────

  Future<void> _pullProfil(String uid, DatabaseHelper db) async {
    final res = await _client
        .from('user_profils')
        .select()
        .eq('user_id', uid)
        .maybeSingle();
    if (res == null) return;
    await db.setNiveauScolaire(res['niveau_scolaire'] as String);
    await db.setAnnee(res['annee'] as String);
  }

  Future<void> _pullProgression(String uid, DatabaseHelper db) async {
    final rows = await _client
        .from('user_progression')
        .select()
        .eq('user_id', uid);
    for (final r in rows) {
      await db.upsertProgression(
        chapitreId: r['chapitre_id'] as int,
        score: r['score'] as int,
        total: r['total'] as int,
        dateMaj: r['date_maj'] as String,
      );
    }
  }

  Future<void> _pullScores(String uid, DatabaseHelper db) async {
    final rows = await _client
        .from('user_scores')
        .select()
        .eq('user_id', uid)
        .order('date');
    await db.remplacerScores(rows.map((r) => {
      'matiere_id': r['matiere_id'],
      'score': r['score'],
      'nb_correctes': r['nb_correctes'],
      'nb_total': r['nb_total'],
      'mode_nom': r['mode_nom'],
      'date': r['date'],
    }).toList());
  }

  Future<void> _pullStatsQuestions(String uid, DatabaseHelper db) async {
    final rows = await _client
        .from('user_statistiques_questions')
        .select()
        .eq('user_id', uid);
    for (final r in rows) {
      await db.upsertStatQuestion(
        questionId: r['question_id'] as int,
        nbAffichee: r['nb_affichee'] as int,
        nbCorrecte: r['nb_correcte'] as int,
      );
    }
  }
}
