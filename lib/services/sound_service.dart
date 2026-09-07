import 'dart:async' show unawaited;
import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Génère tous les sons du quiz synthétiquement (pas de fichiers audio).
/// Sons : tick décompte (3 intensités), arpège bonne réponse style QPUC,
/// buzzer mauvaise réponse, gong final.
class SoundService {
  SoundService._();
  static final SoundService instance = SoundService._();

  static const int _sr = 22050; // fréquence d'échantillonnage

  late Uint8List _tickNormal;
  late Uint8List _tickCritique;
  late Uint8List _tickUrgent;
  late Uint8List _bonneReponse;
  late Uint8List _mauvaiseReponse;
  late Uint8List _gong;

  bool mute = false;
  bool _ready = false;
  final AudioPlayer _tickPlayer = AudioPlayer();

  Future<void> initialiser() async {
    if (_ready || kIsWeb) return;
    _ready = true;
    await _tickPlayer.setReleaseMode(ReleaseMode.stop);

    _tickNormal      = _wav(_tone(440,  0.055, vol: 0.28, fadeMs: 25));
    _tickCritique    = _wav(_tone(660,  0.055, vol: 0.50, fadeMs: 20));
    _tickUrgent      = _wav(_tone(880,  0.040, vol: 0.70, fadeMs: 12));
    _bonneReponse    = _wav(_arpeggio());
    _mauvaiseReponse = _wav(_buzzer());
    _gong            = _wav(_buildGong());
  }

  Future<void> jouerTick(int tempsRestant) async {
    if (mute || !_ready) return;
    final b = tempsRestant <= 3 ? _tickUrgent
             : tempsRestant <= 7 ? _tickCritique
             : _tickNormal;
    await _tickPlayer.stop();
    unawaited(_tickPlayer.play(BytesSource(b)));
  }

  Future<void> jouerBonneReponse() async {
    if (mute || !_ready) return;
    final p = AudioPlayer();
    await p.setReleaseMode(ReleaseMode.release);
    unawaited(p.play(BytesSource(_bonneReponse)));
  }

  Future<void> jouerMauvaiseReponse() async {
    if (mute || !_ready) return;
    final p = AudioPlayer();
    await p.setReleaseMode(ReleaseMode.release);
    unawaited(p.play(BytesSource(_mauvaiseReponse)));
  }

  Future<void> jouerGong() async {
    if (mute || !_ready) return;
    final p = AudioPlayer();
    await p.setReleaseMode(ReleaseMode.release);
    unawaited(p.play(BytesSource(_gong)));
  }

  Future<void> stopTick() => _tickPlayer.stop();

  // ─── Génération WAV (PCM 16-bit mono) ──────────────────────────────────────

  List<int> _tone(double freq, double dur, {double vol = 0.5, int fadeMs = 30}) {
    final n  = (_sr * dur).round();
    final fo = (_sr * fadeMs / 1000).round().clamp(1, n);
    final fi = (_sr * 0.008).round().clamp(1, n);
    final out = List<int>.filled(n, 0);
    for (int i = 0; i < n; i++) {
      double a = sin(2 * pi * freq * i / _sr);
      if (i < fi) a *= i / fi;
      if (i > n - fo) a *= (n - i) / fo;
      out[i] = (a * vol * 32767).round().clamp(-32768, 32767);
    }
    return out;
  }

  // Arpège C5 → E5 → G5 (style Question pour un champion)
  List<int> _arpeggio() => [
    ..._tone(523.25, 0.09, vol: 0.45, fadeMs: 25),
    ..._tone(659.25, 0.09, vol: 0.55, fadeMs: 25),
    ..._tone(783.99, 0.22, vol: 0.65, fadeMs: 60),
  ];

  // Buzzer descendant (mauvaise réponse)
  List<int> _buzzer() {
    const dur = 0.22;
    final n   = (_sr * dur).round();
    final out = List<int>.filled(n, 0);
    for (int i = 0; i < n; i++) {
      final t    = i / _sr;
      final freq = (350.0 - 700.0 * t).clamp(150.0, 350.0);
      final env  = (1.0 - t / dur * 1.4).clamp(0.0, 1.0);
      out[i] = (sin(2 * pi * freq * t) * env * 0.65 * 32767)
          .round()
          .clamp(-32768, 32767);
    }
    return out;
  }

  // Gong multi-harmonique avec décroissance exponentielle
  List<int> _buildGong() {
    const dur       = 2.0;
    final n         = (_sr * dur).round();
    const harmonics = [110.0, 176.0, 297.0, 473.0];
    const weights   = [0.50,  0.26,  0.14,  0.10];
    const decays    = [1.2,   2.0,   3.5,   5.5];
    final out = List<int>.filled(n, 0);
    for (int i = 0; i < n; i++) {
      final t = i / _sr;
      double s = 0;
      for (int h = 0; h < harmonics.length; h++) {
        s += weights[h] * sin(2 * pi * harmonics[h] * t) * exp(-decays[h] * t);
      }
      if (t < 0.005) { s *= t / 0.005; } // attaque 5 ms
      out[i] = (s * 32767).round().clamp(-32768, 32767);
    }
    return out;
  }

  Uint8List _wav(List<int> samples) {
    final ds  = samples.length * 2;
    final buf = ByteData(44 + ds);
    void s4(int off, String s) {
      for (int i = 0; i < 4; i++) { buf.setUint8(off + i, s.codeUnitAt(i)); }
    }
    s4(0, 'RIFF'); buf.setUint32(4, 36 + ds, Endian.little);
    s4(8, 'WAVE'); s4(12, 'fmt ');
    buf.setUint32(16, 16, Endian.little);
    buf.setUint16(20, 1, Endian.little);        // PCM
    buf.setUint16(22, 1, Endian.little);        // mono
    buf.setUint32(24, _sr, Endian.little);
    buf.setUint32(28, _sr * 2, Endian.little);  // byte rate
    buf.setUint16(32, 2, Endian.little);
    buf.setUint16(34, 16, Endian.little);
    s4(36, 'data'); buf.setUint32(40, ds, Endian.little);
    for (int i = 0; i < samples.length; i++) {
      buf.setInt16(44 + i * 2, samples[i], Endian.little);
    }
    return buf.buffer.asUint8List();
  }
}
