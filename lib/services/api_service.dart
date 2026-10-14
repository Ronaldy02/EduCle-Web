import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;

import 'database_helper.dart';

const _baseUrl = 'https://educleweb.vercel.app';
const _storage = FlutterSecureStorage();
const _tokenKey = 'educle_token';
const _userKey = 'educle_user';

class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();

  String? _token;
  Map<String, dynamic>? _user;

  bool get estConnecte => _token != null;
  Map<String, dynamic>? get user => _user;

  // ── Initialisation ────────────────────────────────────────────────────────

  Future<void> chargerSession() async {
    _token = await _storage.read(key: _tokenKey);
    final userJson = await _storage.read(key: _userKey);
    if (userJson != null) _user = jsonDecode(userJson) as Map<String, dynamic>;
  }

  // ── Auth ──────────────────────────────────────────────────────────────────

  Future<void> connexion(String email, String password) async {
    final res = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (res.statusCode != 200) {
      final msg = (jsonDecode(res.body) as Map)['detail'] as String? ?? 'Erreur';
      throw ApiException(_traduireErreur(msg));
    }
    await _sauvegarderSession(res.body);
  }

  Future<void> inscription(String email, String password) async {
    final res = await http.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (res.statusCode != 200 && res.statusCode != 201) {
      final msg = (jsonDecode(res.body) as Map)['detail'] as String? ?? 'Erreur';
      throw ApiException(_traduireErreur(msg));
    }
    await _sauvegarderSession(res.body);
  }

  Future<void> deconnexion() async {
    _token = null;
    _user = null;
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }

  /// Ouvre le flux Google OAuth du backend dans SFSafariViewController (iOS)
  /// et capture le token JWT via le custom URL scheme educle://.
  Future<void> connexionGoogle() async {
    final result = await WebAuthClient.authenticate(
      url: '$_baseUrl/auth/google?platform=mobile',
      callbackUrlScheme: 'educle',
    );
    final uri = Uri.parse(result);
    final error = uri.queryParameters['error'];
    if (error != null) {
      throw ApiException(_traduireErreurGoogle(error));
    }
    final token = uri.queryParameters['token'];
    if (token == null || token.isEmpty) {
      throw ApiException('Connexion Google échouée.');
    }
    _token = token;
    await _storage.write(key: _tokenKey, value: token);

    // Récupérer le profil utilisateur
    final res = await http.get(
      Uri.parse('$_baseUrl/auth/me'),
      headers: _headers,
    );
    if (res.statusCode == 200) {
      _user = jsonDecode(res.body) as Map<String, dynamic>;
      await _storage.write(key: _userKey, value: res.body);
    }
  }

  // ── Sync ──────────────────────────────────────────────────────────────────

  Future<void> syncVersServeur() async {
    if (!estConnecte) return;
    if (!await _connecte()) return;

    final db = DatabaseHelper.instance;
    final scores = await db.getAllScoresNonSync();
    final stats = await db.getAllStatsQuestions();
    final niveau = await db.getNiveauScolaire();
    final annee = await db.getAnnee();

    final body = {
      'profil': {'niveau_scolaire': niveau, 'annee': annee},
      'scores': scores.map((s) => {
        'matiere_id': s['matiere_id'],
        'score': s['score'],
        'nb_correctes': s['nb_correctes'],
        'nb_total': s['nb_total'],
        'mode_nom': s['mode_nom'],
        'date': s['date'],
      }).toList(),
      'stats_questions': stats.map((s) => {
        'question_id': s['question_id'],
        'nb_affichee': s['nb_affichee'],
        'nb_correcte': s['nb_correcte'],
      }).toList(),
    };

    final res = await http.post(
      Uri.parse('$_baseUrl/sync/push'),
      headers: _headers,
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      final ids = scores.map((s) => s['id'] as int).toList();
      await db.marquerScoresSynces(ids);
    }
  }

  Future<void> syncDepuisServeur() async {
    if (!estConnecte) return;
    if (!await _connecte()) return;

    final res = await http.get(
      Uri.parse('$_baseUrl/sync/pull'),
      headers: _headers,
    );
    if (res.statusCode != 200) return;

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final db = DatabaseHelper.instance;

    await db.setNiveauScolaire(data['niveau_scolaire'] as String);
    await db.setAnnee(data['annee'] as String);

    final scores = (data['scores'] as List).cast<Map<String, dynamic>>();
    await db.remplacerScores(scores);

    final statsQ = (data['stats_questions'] as List).cast<Map<String, dynamic>>();
    for (final s in statsQ) {
      await db.upsertStatQuestion(
        questionId: s['question_id'] as int,
        nbAffichee: s['nb_affichee'] as int,
        nbCorrecte: s['nb_correcte'] as int,
      );
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $_token',
  };

  Future<bool> _connecte() async {
    final r = await Connectivity().checkConnectivity();
    return !r.contains(ConnectivityResult.none);
  }

  Future<void> _sauvegarderSession(String body) async {
    final json = jsonDecode(body) as Map<String, dynamic>;
    _token = json['access_token'] as String;
    _user = json['user'] as Map<String, dynamic>?;
    await _storage.write(key: _tokenKey, value: _token);
    if (_user != null) {
      await _storage.write(key: _userKey, value: jsonEncode(_user));
    }
  }

  String _traduireErreurGoogle(String code) {
    switch (code) {
      case 'google_cancelled': return 'Connexion Google annulée.';
      case 'unauthorized': return 'Accès non autorisé.';
      default: return 'Erreur Google Sign-In ($code).';
    }
  }

  String _traduireErreur(String msg) {
    if (msg.contains('incorrect') || msg.contains('Invalid')) {
      return 'Email ou mot de passe incorrect.';
    }
    if (msg.contains('déjà utilisée') || msg.contains('already')) {
      return 'Cet email est déjà utilisé.';
    }
    if (msg.contains('8 caractères')) {
      return 'Le mot de passe doit contenir au moins 8 caractères.';
    }
    return msg;
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}
