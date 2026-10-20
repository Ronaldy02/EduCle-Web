import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/carte_mentale.dart';
import '../models/chapitre.dart';
import '../models/defi.dart';
import '../models/matiere.dart';
import '../models/question.dart';
import '../models/realisation.dart';
import '../models/reponse_enregistree.dart';

Map<String, dynamic> _parseJson(String jsonStr) =>
    jsonDecode(jsonStr) as Map<String, dynamic>;

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _db;
  // Callback optionnel appelé lors du seeding pour afficher la progression
  static void Function(String)? onSeedProgress;

  Future<Database> get database async {
    _db ??= await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'quiz_educatif.db');
    return openDatabase(
      path,
      version: 17,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _createStatsAndScoresTables(db);
    }
    if (oldVersion < 3) {
      try {
        await db.execute(
          "ALTER TABLE user_preferences ADD COLUMN niveau_scolaire TEXT NOT NULL DEFAULT 'Fondamental'",
        );
      } catch (_) {}
      await _reseedAll(db);
    }
    if (oldVersion < 4) {
      try {
        await db.execute(
          "ALTER TABLE user_preferences ADD COLUMN annee TEXT NOT NULL DEFAULT '7e AF'",
        );
      } catch (_) {}
      await _reseedAll(db);
    }
    if (oldVersion < 5) {
      await _reseedAll(db);
    }
    if (oldVersion < 6) {
      try {
        await db.execute(
          "ALTER TABLE user_preferences ADD COLUMN pays TEXT NOT NULL DEFAULT 'Haïti'",
        );
      } catch (_) {}
      try {
        await db.execute(
          "ALTER TABLE user_preferences ADD COLUMN ville TEXT NOT NULL DEFAULT ''",
        );
      } catch (_) {}
      try {
        await db.execute(
          "ALTER TABLE user_preferences ADD COLUMN difficulte TEXT NOT NULL DEFAULT 'Toutes'",
        );
      } catch (_) {}
    }
    if (oldVersion < 7) {
      try {
        await db.execute(
          'ALTER TABLE user_preferences ADD COLUMN profil_configure INTEGER NOT NULL DEFAULT 0',
        );
      } catch (_) {}
    }
    if (oldVersion < 8) {
      await _reseedAll(db);
    }
    if (oldVersion < 9) {
      await _reseedAll(db);
    }
    if (oldVersion < 10) {
      await _reseedAll(db);
    }
    if (oldVersion < 11) {
      await _reseedAll(db);
    }
    if (oldVersion < 12) {
      await _createDefisTables(db);
    }
    if (oldVersion < 13) {
      try {
        await db.execute('ALTER TABLE chapitres ADD COLUMN niveau_v4 TEXT');
      } catch (_) {}
      await _reseedAll(db);
    }
    if (oldVersion < 14) {
      await _reseedAll(db);
    }
    if (oldVersion < 15) {
      await _reseedAll(db);
    }
    if (oldVersion < 16) {
      try {
        await db.execute(
          'ALTER TABLE scores ADD COLUMN synced INTEGER NOT NULL DEFAULT 0',
        );
      } catch (_) {}
    }
    if (oldVersion < 17) {
      try {
        await db.execute(
          'ALTER TABLE user_preferences ADD COLUMN nombre_questions INTEGER NOT NULL DEFAULT 10',
        );
      } catch (_) {}
    }
  }

  Future<void> _reseedAll(Database db) async {
    await db.delete('statistiques_questions');
    await db.delete('scores');
    await db.delete('quiz_en_cours');
    await db.delete('progression');
    await db.delete('questions');
    await db.delete('cartes_mentales');
    await db.delete('chapitres');
    await db.delete('matieres');
    await _seedData(db);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE matieres (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        niveau TEXT NOT NULL,
        nom TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE chapitres (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        matiere_id INTEGER NOT NULL,
        titre TEXT NOT NULL,
        niveau_v4 TEXT,
        FOREIGN KEY (matiere_id) REFERENCES matieres (id)
      )
    ''');
    await db.execute('''
      CREATE TABLE cartes_mentales (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chapitre_id INTEGER NOT NULL,
        contenu TEXT NOT NULL,
        image TEXT,
        FOREIGN KEY (chapitre_id) REFERENCES chapitres (id)
      )
    ''');
    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chapitre_id INTEGER NOT NULL,
        enonce TEXT NOT NULL,
        choix TEXT NOT NULL,
        bonne_reponse TEXT NOT NULL,
        explication TEXT NOT NULL,
        niveau_complexite TEXT NOT NULL,
        FOREIGN KEY (chapitre_id) REFERENCES chapitres (id)
      )
    ''');
    await db.execute('''
      CREATE TABLE progression (
        chapitre_id INTEGER PRIMARY KEY,
        score INTEGER NOT NULL,
        total INTEGER NOT NULL,
        date_maj TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE quiz_en_cours (
        id INTEGER PRIMARY KEY,
        chapitre_id INTEGER NOT NULL,
        mode_nom TEXT NOT NULL,
        index_courant INTEGER NOT NULL,
        score INTEGER NOT NULL,
        temps_restant INTEGER NOT NULL,
        reponses_correctes_ids TEXT NOT NULL,
        reponses_incorrectes_ids TEXT NOT NULL
      )
    ''');

    await _createStatsAndScoresTables(db);
    await _createDefisTables(db);
    await _seedData(db);
  }

  Future<void> _createDefisTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS defis (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        palier INTEGER NOT NULL DEFAULT 1,
        nom TEXT NOT NULL,
        description TEXT NOT NULL,
        metrique TEXT NOT NULL,
        cible INTEGER NOT NULL,
        filtres TEXT,
        date_spe TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS realisations (
        id TEXT PRIMARY KEY,
        rarete INTEGER NOT NULL,
        groupe TEXT NOT NULL,
        nom TEXT NOT NULL,
        description TEXT NOT NULL,
        metrique TEXT NOT NULL,
        cible INTEGER NOT NULL,
        secret INTEGER NOT NULL DEFAULT 0,
        filtres TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS defis_progres (
        defi_id TEXT NOT NULL,
        periode TEXT NOT NULL,
        progres INTEGER NOT NULL DEFAULT 0,
        complete INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY (defi_id, periode)
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS realisations_progres (
        realisation_id TEXT PRIMARY KEY,
        progres INTEGER NOT NULL DEFAULT 0,
        debloquee INTEGER NOT NULL DEFAULT 0,
        debloque_le TEXT
      )
    ''');
  }

  Future<void> _createStatsAndScoresTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS statistiques_questions (
        question_id INTEGER PRIMARY KEY,
        nb_affichee INTEGER NOT NULL DEFAULT 0,
        nb_correcte INTEGER NOT NULL DEFAULT 0
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS scores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        matiere_id INTEGER,
        score INTEGER NOT NULL,
        nb_correctes INTEGER NOT NULL,
        nb_total INTEGER NOT NULL,
        mode_nom TEXT NOT NULL,
        date TEXT NOT NULL,
        synced INTEGER NOT NULL DEFAULT 0
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS user_preferences (
        id INTEGER PRIMARY KEY,
        zone TEXT NOT NULL DEFAULT '',
        niveau_scolaire TEXT NOT NULL DEFAULT 'Fondamental',
        annee TEXT NOT NULL DEFAULT '7e AF'
      )
    ''');
  }

  Future<List<String>> getNiveaux() async {
    final db = await database;
    final rows = await db.rawQuery(
      'SELECT DISTINCT niveau FROM matieres ORDER BY niveau',
    );
    return rows.map((r) => r['niveau'] as String).toList();
  }

  Future<List<Matiere>> getToutesLesMatieres() async {
    final db = await database;
    final rows = await db.query('matieres', orderBy: 'nom');
    return rows.map((r) => Matiere.fromMap(r)).toList();
  }

  /// Retourne les matières du cycle choisi + les matières communes aux deux cycles.
  Future<List<Matiere>> getMatieresByCycle(String cycle) async {
    final db = await database;
    final rows = await db.rawQuery(
      "SELECT * FROM matieres WHERE niveau = ? OR niveau = 'Commun' ORDER BY nom",
      [cycle],
    );
    return rows.map((r) => Matiere.fromMap(r)).toList();
  }

  Future<List<Matiere>> getMatieres(String niveau) async {
    final db = await database;
    final rows = await db.query(
      'matieres',
      where: 'niveau = ?',
      whereArgs: [niveau],
      orderBy: 'nom',
    );
    return rows.map((r) => Matiere.fromMap(r)).toList();
  }

  Future<List<Chapitre>> getChapitres(int matiereId) async {
    final db = await database;
    final rows = await db.query(
      'chapitres',
      where: 'matiere_id = ?',
      whereArgs: [matiereId],
      orderBy: 'id',
    );
    return rows.map((r) => Chapitre.fromMap(r)).toList();
  }

  Future<Chapitre> getChapitreComplet(
    int chapitreId, {
    String difficulte = 'Toutes',
  }) async {
    final db = await database;
    final chapitreRows = await db.query(
      'chapitres',
      where: 'id = ?',
      whereArgs: [chapitreId],
    );
    final chapitre = Chapitre.fromMap(chapitreRows.first);

    final carteRows = await db.query(
      'cartes_mentales',
      where: 'chapitre_id = ?',
      whereArgs: [chapitreId],
    );
    final cartes = carteRows.map((r) => CarteMentale.fromMap(r)).toList();

    var questionRows = difficulte == 'Toutes'
        ? await db.query('questions', where: 'chapitre_id = ?', whereArgs: [chapitreId])
        : await db.query(
            'questions',
            where: 'chapitre_id = ? AND niveau_complexite = ?',
            whereArgs: [chapitreId, difficulte],
          );
    if (questionRows.isEmpty && difficulte != 'Toutes') {
      questionRows = await db.query(
        'questions',
        where: 'chapitre_id = ?',
        whereArgs: [chapitreId],
      );
    }
    final questions = questionRows.map((r) {
      final choix = List<String>.from(jsonDecode(r['choix'] as String));
      return Question.fromMap(r, choix);
    }).toList();

    return chapitre.copyWith(cartesMentales: cartes, questions: questions);
  }

  Future<void> enregistrerProgression(
    int chapitreId,
    int score,
    int total,
  ) async {
    final db = await database;
    await db.insert('progression', {
      'chapitre_id': chapitreId,
      'score': score,
      'total': total,
      'date_maj': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getProgression(int chapitreId) async {
    final db = await database;
    final rows = await db.query(
      'progression',
      where: 'chapitre_id = ?',
      whereArgs: [chapitreId],
    );
    return rows.isEmpty ? null : rows.first;
  }

  Future<void> sauvegarderQuizEnCours({
    required int chapitreId,
    required String modeNom,
    required int indexCourant,
    required int score,
    required int tempsRestant,
    required List<int> reponsesCorrectesIds,
    required List<int> reponsesIncorrectesIds,
  }) async {
    final db = await database;
    await db.insert('quiz_en_cours', {
      'id': 1,
      'chapitre_id': chapitreId,
      'mode_nom': modeNom,
      'index_courant': indexCourant,
      'score': score,
      'temps_restant': tempsRestant,
      'reponses_correctes_ids': jsonEncode(reponsesCorrectesIds),
      'reponses_incorrectes_ids': jsonEncode(reponsesIncorrectesIds),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getQuizEnCours() async {
    final db = await database;
    final rows = await db.query('quiz_en_cours', where: 'id = 1');
    return rows.isEmpty ? null : rows.first;
  }

  Future<void> effacerQuizEnCours() async {
    final db = await database;
    await db.delete('quiz_en_cours', where: 'id = 1');
  }

  Future<void> enregistrerStatistiquesQuestions(
    List<ReponseEnregistree> historique,
  ) async {
    final db = await database;
    for (final reponse in historique) {
      final existing = await db.query(
        'statistiques_questions',
        where: 'question_id = ?',
        whereArgs: [reponse.question.id],
      );
      if (existing.isEmpty) {
        await db.insert('statistiques_questions', {
          'question_id': reponse.question.id,
          'nb_affichee': 1,
          'nb_correcte': reponse.correcte ? 1 : 0,
        });
      } else {
        final current = existing.first;
        await db.update(
          'statistiques_questions',
          {
            'nb_affichee': (current['nb_affichee'] as int) + 1,
            'nb_correcte': (current['nb_correcte'] as int) + (reponse.correcte ? 1 : 0),
          },
          where: 'question_id = ?',
          whereArgs: [reponse.question.id],
        );
      }
    }
  }

  Future<void> enregistrerScore({
    int? matiereId,
    required int score,
    required int nbCorrectes,
    required int nbTotal,
    required String modeNom,
  }) async {
    final db = await database;
    await db.insert('scores', {
      'matiere_id': matiereId,
      'score': score,
      'nb_correctes': nbCorrectes,
      'nb_total': nbTotal,
      'mode_nom': modeNom,
      'date': DateTime.now().toIso8601String(),
    });
  }

  Future<Map<String, dynamic>> getStatsGlobales() async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT
        COUNT(*) as nb_quiz,
        COALESCE(SUM(score), 0) as score_total,
        COALESCE(SUM(nb_correctes), 0) as total_correctes,
        COALESCE(SUM(nb_total), 0) as total_questions
      FROM scores
    ''');
    return result.first;
  }

  Future<List<Map<String, dynamic>>> getStatsByMatiere() async {
    final db = await database;
    return db.rawQuery('''
      SELECT m.nom, m.id,
        COALESCE(SUM(s.nb_correctes), 0) as nb_correctes,
        COALESCE(SUM(s.nb_total), 0) as nb_total,
        COALESCE(SUM(s.score), 0) as score_total
      FROM matieres m
      LEFT JOIN scores s ON s.matiere_id = m.id
      GROUP BY m.id, m.nom
      ORDER BY score_total DESC
    ''');
  }

  Future<List<Map<String, dynamic>>> getAvancementParMatiere() async {
    final db = await database;
    return db.rawQuery('''
      SELECT
        m.nom,
        m.id,
        COUNT(DISTINCT q.id)           AS nb_questions,
        COALESCE(SUM(s.nb_correctes),0) AS nb_correctes,
        COALESCE(SUM(s.nb_total),0)     AS nb_quizzees
      FROM matieres m
      LEFT JOIN chapitres c ON c.matiere_id = m.id
      LEFT JOIN questions  q ON q.chapitre_id = c.id
      LEFT JOIN scores     s ON s.matiere_id  = m.id
      GROUP BY m.id, m.nom
      ORDER BY m.nom
    ''');
  }

  Future<List<Map<String, dynamic>>> getScores({int? matiereId}) async {
    final db = await database;
    if (matiereId != null) {
      return db.query(
        'scores',
        where: 'matiere_id = ?',
        whereArgs: [matiereId],
        orderBy: 'score DESC',
        limit: 20,
      );
    }
    return db.query('scores', orderBy: 'date DESC', limit: 50);
  }

  Future<String> getZone() async {
    final db = await database;
    final rows = await db.query('user_preferences', where: 'id = 1');
    if (rows.isEmpty) return '';
    return (rows.first['zone'] as String?) ?? '';
  }

  Future<void> setZone(String zone) async {
    final db = await database;
    await _ensurePrefsRow(db);
    await db.update('user_preferences', {'zone': zone}, where: 'id = 1');
  }

  Future<String> getNiveauScolaire() async {
    final db = await database;
    final rows = await db.query('user_preferences', where: 'id = 1');
    if (rows.isEmpty) return 'Fondamental';
    return (rows.first['niveau_scolaire'] as String?) ?? 'Fondamental';
  }

  Future<void> setNiveauScolaire(String niveau) async {
    final db = await database;
    await _ensurePrefsRow(db);
    await db.update('user_preferences', {'niveau_scolaire': niveau}, where: 'id = 1');
  }

  Future<String> getAnnee() async {
    final db = await database;
    final rows = await db.query('user_preferences', where: 'id = 1');
    if (rows.isEmpty) return '7e AF';
    return (rows.first['annee'] as String?) ?? '7e AF';
  }

  Future<void> setAnnee(String annee) async {
    final db = await database;
    await _ensurePrefsRow(db);
    await db.update('user_preferences', {'annee': annee}, where: 'id = 1');
  }

  Future<String> getPays() async {
    final db = await database;
    final rows = await db.query('user_preferences', where: 'id = 1');
    if (rows.isEmpty) return 'Haïti';
    return (rows.first['pays'] as String?) ?? 'Haïti';
  }

  Future<void> setPays(String pays) async {
    final db = await database;
    await _ensurePrefsRow(db);
    await db.update('user_preferences', {'pays': pays}, where: 'id = 1');
  }

  Future<String> getVille() async {
    final db = await database;
    final rows = await db.query('user_preferences', where: 'id = 1');
    if (rows.isEmpty) return '';
    return (rows.first['ville'] as String?) ?? '';
  }

  Future<void> setVille(String ville) async {
    final db = await database;
    await _ensurePrefsRow(db);
    await db.update('user_preferences', {'ville': ville}, where: 'id = 1');
  }

  Future<String> getDifficulte() async {
    final db = await database;
    final rows = await db.query('user_preferences', where: 'id = 1');
    if (rows.isEmpty) return 'Toutes';
    return (rows.first['difficulte'] as String?) ?? 'Toutes';
  }

  Future<void> setDifficulte(String difficulte) async {
    final db = await database;
    await _ensurePrefsRow(db);
    await db.update('user_preferences', {'difficulte': difficulte}, where: 'id = 1');
  }

  Future<bool> getProfilConfigure() async {
    final db = await database;
    final rows = await db.query('user_preferences', where: 'id = 1');
    if (rows.isEmpty) return false;
    return (rows.first['profil_configure'] as int? ?? 0) == 1;
  }

  Future<void> setProfilConfigure() async {
    final db = await database;
    await _ensurePrefsRow(db);
    await db.update('user_preferences', {'profil_configure': 1}, where: 'id = 1');
  }

  Future<int> getNombreQuestions() async {
    final db = await database;
    final rows = await db.query('user_preferences', where: 'id = 1');
    if (rows.isEmpty) return 10;
    return (rows.first['nombre_questions'] as int?) ?? 10;
  }

  Future<void> setNombreQuestions(int nb) async {
    final db = await database;
    await _ensurePrefsRow(db);
    await db.update('user_preferences', {'nombre_questions': nb}, where: 'id = 1');
  }

  // ── Défis : progression ───────────────────────────────────────────────────

  Future<List<DefiProgres>> getDefisProgres(String periode) async {
    final db = await database;
    final rows = await db.query(
      'defis_progres',
      where: 'periode = ?',
      whereArgs: [periode],
    );
    return rows.map((r) => DefiProgres.fromMap(r)).toList();
  }

  Future<void> upsertDefiProgres(
    String defiId,
    String periode,
    int delta,
    int cible,
  ) async {
    final db = await database;
    final rows = await db.query(
      'defis_progres',
      where: 'defi_id = ? AND periode = ?',
      whereArgs: [defiId, periode],
    );
    if (rows.isEmpty) {
      final progres = delta.clamp(0, cible);
      await db.insert('defis_progres', {
        'defi_id': defiId,
        'periode': periode,
        'progres': progres,
        'complete': progres >= cible ? 1 : 0,
      });
    } else {
      final current = rows.first['progres'] as int;
      final newProgres = (current + delta).clamp(0, cible);
      await db.update(
        'defis_progres',
        {'progres': newProgres, 'complete': newProgres >= cible ? 1 : 0},
        where: 'defi_id = ? AND periode = ?',
        whereArgs: [defiId, periode],
      );
    }
  }

  // ── Réalisations : progression ────────────────────────────────────────────

  Future<List<RealisationProgres>> getAllRealisationsProgres() async {
    final db = await database;
    final rows = await db.query('realisations_progres');
    return rows.map((r) => RealisationProgres.fromMap(r)).toList();
  }

  Future<void> upsertRealisationProgres(
    String realId,
    int delta,
    int cible,
  ) async {
    final db = await database;
    final rows = await db.query(
      'realisations_progres',
      where: 'realisation_id = ?',
      whereArgs: [realId],
    );
    if (rows.isEmpty) {
      final progres = delta.clamp(0, cible);
      final debloque = progres >= cible;
      await db.insert('realisations_progres', {
        'realisation_id': realId,
        'progres': progres,
        'debloquee': debloque ? 1 : 0,
        'debloque_le': debloque ? DateTime.now().toIso8601String() : null,
      });
    } else {
      final current = rows.first;
      if ((current['debloquee'] as int) == 1) return; // déjà débloquée
      final newProgres = ((current['progres'] as int) + delta).clamp(0, cible);
      final debloque = newProgres >= cible;
      await db.update(
        'realisations_progres',
        {
          'progres': newProgres,
          'debloquee': debloque ? 1 : 0,
          'debloque_le': debloque ? DateTime.now().toIso8601String() : null,
        },
        where: 'realisation_id = ?',
        whereArgs: [realId],
      );
    }
  }

  // ── Sync helpers (utilisés par SupabaseService) ───────────────────────────

  Future<List<Map<String, dynamic>>> getAllProgression() async {
    final db = await database;
    return db.query('progression');
  }

  Future<void> upsertProgression({
    required int chapitreId,
    required int score,
    required int total,
    required String dateMaj,
  }) async {
    final db = await database;
    await db.insert('progression', {
      'chapitre_id': chapitreId,
      'score': score,
      'total': total,
      'date_maj': dateMaj,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllScoresNonSync() async {
    final db = await database;
    return db.query('scores', where: 'synced = 0');
  }

  Future<void> marquerScoresSynces(List<int> ids) async {
    if (ids.isEmpty) return;
    final db = await database;
    final placeholders = ids.map((_) => '?').join(',');
    await db.rawUpdate(
      'UPDATE scores SET synced = 1 WHERE id IN ($placeholders)',
      ids,
    );
  }

  Future<void> remplacerScores(List<Map<String, dynamic>> rows) async {
    final db = await database;
    await db.delete('scores');
    final batch = db.batch();
    for (final r in rows) {
      batch.insert('scores', {...r, 'synced': 1});
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getAllStatsQuestions() async {
    final db = await database;
    return db.query('statistiques_questions');
  }

  Future<void> upsertStatQuestion({
    required int questionId,
    required int nbAffichee,
    required int nbCorrecte,
  }) async {
    final db = await database;
    await db.insert('statistiques_questions', {
      'question_id': questionId,
      'nb_affichee': nbAffichee,
      'nb_correcte': nbCorrecte,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> _ensurePrefsRow(Database db) async {
    final rows = await db.query('user_preferences', where: 'id = 1');
    if (rows.isEmpty) {
      await db.insert('user_preferences', {
        'id': 1,
        'zone': '',
        'niveau_scolaire': 'Fondamental',
        'annee': '7e AF',
        'pays': 'Haïti',
        'ville': '',
        'difficulte': 'Toutes',
        'profil_configure': 0,
      });
    }
  }

  Future<void> _seedData(Database db) async {
    final jsonStr = await rootBundle.loadString('assets/data/questions.json');
    final data = await Isolate.run(() => _parseJson(jsonStr));

    final matieres = data['matieres'] as List<dynamic>;
    var matId = 1;
    var chapId = 1;

    final batch = db.batch();

    for (final m in matieres) {
      final mat = m as Map<String, dynamic>;
      final currentMatId = matId++;
      batch.insert('matieres', {
        'id': currentMatId,
        'niveau': mat['niveau'],
        'nom': mat['nom'],
      });
      for (final c in mat['chapitres'] as List<dynamic>) {
        final chap = c as Map<String, dynamic>;
        final currentChapId = chapId++;
        batch.insert('chapitres', {
          'id': currentChapId,
          'matiere_id': currentMatId,
          'titre': chap['titre'],
          'niveau_v4': chap['niveau_v4'],
        });
        for (final carte in (chap['cartes_mentales'] as List<dynamic>? ?? [])) {
          batch.insert('cartes_mentales', {
            'chapitre_id': currentChapId,
            'contenu': carte as String,
            'image': null,
          });
        }
        for (final q in chap['questions'] as List<dynamic>) {
          final quest = q as Map<String, dynamic>;
          batch.insert('questions', {
            'chapitre_id': currentChapId,
            'enonce': quest['enonce'],
            'choix': jsonEncode(quest['choix']),
            'bonne_reponse': quest['bonne_reponse'],
            'explication': quest['explication'],
            'niveau_complexite': quest['niveau_complexite'],
          });
        }
      }
    }

    await batch.commit(noResult: true);
  }
}
