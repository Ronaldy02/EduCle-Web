import 'package:flutter/foundation.dart';
import '../models/defi.dart';
import '../models/realisation.dart';
import '../data/defis_data.dart';
import '../data/realisations_data.dart';
import 'database_helper.dart';

// Époque fixe pour la rotation déterministe — identique pour tous les utilisateurs.
const _kEpoch = '2026-01-01';

class DefisService extends ChangeNotifier {
  static final DefisService _instance = DefisService._internal();
  factory DefisService() => _instance;
  DefisService._internal();

  // Cache des définitions indexées par id
  final Map<String, Defi> _defisById = {};
  final Map<String, Realisation> _realisationsById = {};

  bool _initialized = false;

  // ── Initialisation ────────────────────────────────────────────────────────

  Future<void> init() async {
    if (_initialized) return;
    for (final m in kDefisData) {
      final d = Defi.fromMap(m);
      _defisById[d.id] = d;
    }
    for (final m in kRealisationsData) {
      final r = Realisation.fromMap(m);
      _realisationsById[r.id] = r;
    }
    _initialized = true;
  }

  // ── Rotation déterministe ─────────────────────────────────────────────────

  /// Retourne les 4 défis quotidiens pour [date] (par défaut aujourd'hui).
  List<Defi> defisQuotidiensForDate(DateTime? date) {
    final d = date ?? DateTime.now();
    final epoch = DateTime.parse(_kEpoch);
    final days = d.difference(epoch).inDays;
    final slot = days % 10; // 10 slots × 4 défis = 40
    final ids = kDefisQuotidiensIds.skip(slot * 4).take(4).toList();
    return ids.map((id) => _defisById[id]!).toList();
  }

  /// Retourne les 2 défis hebdomadaires pour la semaine contenant [date].
  /// Slot = weekIndex % 13, sauf le slot 12 qui donne W25 seul.
  List<Defi> defisHebdoForDate(DateTime? date) {
    final d = date ?? DateTime.now();
    final epoch = DateTime.parse(_kEpoch);
    final weekIndex = (d.difference(epoch).inDays / 7).floor();
    final slot = weekIndex % 13;
    final ids = slot < 12
        ? kDefisHebdoIds.skip(slot * 2).take(2).toList()
        : ['W25'];
    return ids.map((id) => _defisById[id]!).toList();
  }

  /// Retourne les 2 défis mensuels pour le mois de [date].
  List<Defi> defisMensuelsForDate(DateTime? date) {
    final d = date ?? DateTime.now();
    final monthIndex = d.year * 12 + (d.month - 1);
    final epochMonth = 2026 * 12 + 0; // Jan 2026 = index 0
    final slot = (monthIndex - epochMonth) % 11;
    final ids = kDefisMensuelsIds.skip(slot * 2).take(2).toList();
    return ids.map((id) => _defisById[id]!).toList();
  }

  /// Retourne les défis spéciaux actifs pour [date].
  List<Defi> defisSpeciauxForDate(DateTime? date) {
    final d = date ?? DateTime.now();
    final mmdd = '${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    return _defisById.values.where((defi) {
      if (defi.type != 's' || defi.dateSpe == null) return false;
      final spe = defi.dateSpe!;
      if (spe.contains('/')) {
        // plage: MM-DD/MM-DD
        final parts = spe.split('/');
        return _inRange(mmdd, parts[0], parts[1]);
      }
      return spe == mmdd;
    }).toList();
  }

  bool _inRange(String mmdd, String start, String end) {
    if (start.compareTo(end) <= 0) {
      return mmdd.compareTo(start) >= 0 && mmdd.compareTo(end) <= 0;
    }
    // plage chevauchant le 31/12
    return mmdd.compareTo(start) >= 0 || mmdd.compareTo(end) <= 0;
  }

  // ── Clés de période ───────────────────────────────────────────────────────

  static String periodeJour(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static String periodeHebdo(DateTime d) {
    // ISO week: Lundi = 1er jour
    final epoch = DateTime(2026, 1, 1);
    final weekIndex = (d.difference(epoch).inDays / 7).floor();
    return '2026-W${weekIndex.toString().padLeft(3, '0')}';
  }

  static String periodeMensuel(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}';

  // ── Progression des défis ─────────────────────────────────────────────────

  Future<List<DefiProgres>> getProgresJour([DateTime? date]) async {
    final d = date ?? DateTime.now();
    final db = DatabaseHelper.instance;
    return db.getDefisProgres(periodeJour(d));
  }

  Future<List<DefiProgres>> getProgresHebdo([DateTime? date]) async {
    final d = date ?? DateTime.now();
    final db = DatabaseHelper.instance;
    return db.getDefisProgres(periodeHebdo(d));
  }

  Future<List<DefiProgres>> getProgresMensuel([DateTime? date]) async {
    final d = date ?? DateTime.now();
    final db = DatabaseHelper.instance;
    return db.getDefisProgres(periodeMensuel(d));
  }

  Future<void> incrementerProgres(String defiId, String periode, int delta) async {
    final defi = _defisById[defiId];
    if (defi == null) return;
    final db = DatabaseHelper.instance;
    await db.upsertDefiProgres(defiId, periode, delta, defi.cible);
    notifyListeners();
  }

  // ── Progression des réalisations ─────────────────────────────────────────

  Future<List<RealisationProgres>> getRealisationsProgres() async {
    final db = DatabaseHelper.instance;
    return db.getAllRealisationsProgres();
  }

  Future<void> incrementerRealisationProgres(String realId, int delta) async {
    final real = _realisationsById[realId];
    if (real == null) return;
    final db = DatabaseHelper.instance;
    await db.upsertRealisationProgres(realId, delta, real.cible);
    notifyListeners();
  }

  // ── Accès aux définitions ─────────────────────────────────────────────────

  Defi? defi(String id) => _defisById[id];
  Realisation? realisation(String id) => _realisationsById[id];

  List<Realisation> get toutesLesRealisations =>
      _realisationsById.values.toList()
        ..sort((a, b) => a.rarete.compareTo(b.rarete));
}
