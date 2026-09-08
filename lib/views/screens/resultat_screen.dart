import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/quiz_controller.dart';
import '../../models/chapitre.dart';
import '../../models/parametre_partie.dart';
import '../../models/resultat.dart';
import '../../services/sound_service.dart';
import '../../theme/app_theme.dart';
import '../widgets/educle_logo.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';
import 'revision_reponses_screen.dart';

// ── Feux d'artifice ───────────────────────────────────────────────────────────

class _Particle {
  final Offset origin;
  final double angle;
  final double speed;
  final Color color;
  final double size;
  _Particle({
    required this.origin,
    required this.angle,
    required this.speed,
    required this.color,
    required this.size,
  });
}

class _FireworksPainter extends CustomPainter {
  final List<_Particle> particles;
  final double t; // 0..1

  _FireworksPainter({required this.particles, required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (final p in particles) {
      final tt = (t - p.origin.dy / 1000).clamp(0.0, 1.0); // décalage par burst
      final x = p.origin.dx + cos(p.angle) * p.speed * tt * size.width;
      final y = p.origin.dy * size.height
              + sin(p.angle) * p.speed * tt * size.height
              + 0.5 * 9.8 * tt * tt * size.height * 0.25; // gravité
      final opacity = (1.0 - tt * 1.4).clamp(0.0, 1.0);
      paint.color = p.color.withValues(alpha: opacity);
      canvas.drawCircle(Offset(x, y), p.size * (1 - tt * 0.5), paint);
    }
  }

  @override
  bool shouldRepaint(_FireworksPainter old) => old.t != t;
}

List<_Particle> _buildParticles(Size size) {
  final rng = Random(42);
  final colors = [
    Colors.amber, Colors.orangeAccent, Colors.pink,
    Colors.cyanAccent, Colors.greenAccent, Colors.purpleAccent,
    Colors.redAccent, Colors.yellowAccent,
  ];
  // 3 bursts à des positions et moments différents
  final bursts = [
    Offset(size.width * 0.25, 0.25),
    Offset(size.width * 0.75, 0.20),
    Offset(size.width * 0.50, 0.15),
  ];
  final particles = <_Particle>[];
  for (final burst in bursts) {
    for (int i = 0; i < 40; i++) {
      final angle = rng.nextDouble() * 2 * pi;
      particles.add(_Particle(
        origin: burst,
        angle: angle,
        speed: 0.15 + rng.nextDouble() * 0.25,
        color: colors[rng.nextInt(colors.length)],
        size: 3 + rng.nextDouble() * 4,
      ));
    }
  }
  return particles;
}

// ── Écran résultat ────────────────────────────────────────────────────────────

class ResultatScreen extends StatefulWidget {
  final Resultat resultat;
  final Chapitre? chapitre;
  final ParametrePartie? mode;

  const ResultatScreen({
    super.key,
    required this.resultat,
    this.chapitre,
    this.mode,
  });

  @override
  State<ResultatScreen> createState() => _ResultatScreenState();
}

class _ResultatScreenState extends State<ResultatScreen>
    with TickerProviderStateMixin {
  late AnimationController _fwCtrl;
  late Animation<double> _fwAnim;
  List<_Particle> _particles = [];
  bool _parfait = false;

  @override
  void initState() {
    super.initState();
    _fwCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _fwAnim = CurvedAnimation(parent: _fwCtrl, curve: Curves.easeOut);

    final isBombardement = widget.mode?.nom == 'Bombardement';
    final nbCorrectes = widget.resultat.reponsesCorrectes.length;
    final total = widget.resultat.total;
    _parfait = !isBombardement && total > 0 && nbCorrectes == total;

    if (_parfait) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final size = MediaQuery.of(context).size;
        _particles = _buildParticles(size);
        SoundService.instance.initialiser().then((_) {
          SoundService.instance.jouerFanfare();
        });
        _fwCtrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _fwCtrl.dispose();
    super.dispose();
  }

  String _messageSelonScore() {
    if (_parfait) return '🎉 Score parfait ! Félicitations !';
    if (widget.mode?.nom == 'Bombardement') {
      final nb = widget.resultat.historique.length;
      if (nb >= 10) return 'Incroyable, tu voles !';
      if (nb >= 7)  return 'Excellent score sous pression !';
      if (nb >= 4)  return 'Bien joué, continue à t\'entraîner.';
      return 'La prochaine fois, tu iras plus vite !';
    }
    if (widget.resultat.total == 0) return 'Quiz terminé !';
    final ratio = widget.resultat.reponsesCorrectes.length / widget.resultat.total;
    if (widget.mode?.nom == 'Rush') {
      if (ratio >= 0.8) return 'Excellent ! Tu es rapide et précis.';
      if (ratio >= 0.6) return 'Bien joué ! Encore un peu de vitesse.';
      if (ratio >= 0.4) return 'Pas mal, continue à t\'entraîner.';
      return 'Ne lâche pas, la pratique paie.';
    }
    if (ratio >= 0.8) return 'Bravo ! Tu maîtrises bien ces notions.';
    if (ratio >= 0.6) return 'Bien ! Relis les explications des erreurs.';
    if (ratio >= 0.4) return 'Continue, les explications t\'aideront.';
    return 'Prends le temps de revoir tes cartes mentales.';
  }

  @override
  Widget build(BuildContext context) {
    final matiereNom = context
        .read<QuizController>()
        .utilisateur
        .matiereSelectionnee
        ?.nom;
    final sousTitreParties = [
      if (matiereNom != null) matiereNom,
      if (widget.mode != null) widget.mode!.nom,
    ].join(' · ');

    final isBombardement = widget.mode?.nom == 'Bombardement';
    final nbReponses  = widget.resultat.historique.length;
    final nbCorrectes = widget.resultat.reponsesCorrectes.length;
    final ratio = (!isBombardement && widget.resultat.total > 0)
        ? nbCorrectes / widget.resultat.total
        : 0.0;
    final ringValue = isBombardement
        ? (nbReponses / 10.0).clamp(0.0, 1.0)
        : ratio;

    return Scaffold(
      body: Stack(
        children: [
          // ── Feux d'artifice (calque derrière) ─────────────────────────────
          if (_parfait)
            AnimatedBuilder(
              animation: _fwAnim,
              builder: (_, __) => CustomPaint(
                painter: _FireworksPainter(
                  particles: _particles,
                  t: _fwAnim.value,
                ),
                child: const SizedBox.expand(),
              ),
            ),

          // ── Contenu principal ──────────────────────────────────────────────
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              children: [
                const Center(child: EduCleLogo()),
                const SizedBox(height: 32),
                Center(
                  child: SizedBox(
                    width: 160,
                    height: 160,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 160,
                          height: 160,
                          child: CircularProgressIndicator(
                            value: ringValue,
                            strokeWidth: 10,
                            backgroundColor: EduCleColors.border,
                            color: _parfait ? Colors.amber : EduCleColors.primary,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_parfait)
                              const Text('⭐', style: TextStyle(fontSize: 28)),
                            Text(
                              '${widget.resultat.score}',
                              style: TextStyle(
                                fontSize: _parfait ? 28 : 34,
                                fontWeight: FontWeight.w800,
                                color: _parfait ? Colors.amber.shade700 : null,
                              ),
                            ),
                            const Text(
                              'pts',
                              style: TextStyle(
                                color: EduCleColors.textSecondary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  _messageSelonScore(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: _parfait ? Colors.amber.shade700 : null,
                    fontWeight: _parfait ? FontWeight.w800 : null,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isBombardement
                      ? '$nbReponses question${nbReponses > 1 ? 's' : ''} répondues'
                      : '$nbCorrectes / ${widget.resultat.total} bonnes réponses · ${(ratio * 100).round()}%',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: EduCleColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                if (sousTitreParties.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    sousTitreParties,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: EduCleColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
                const SizedBox(height: 28),
                FilledButton(
                  onPressed: widget.resultat.historique.isEmpty
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RevisionReponsesScreen(
                                resultat: widget.resultat,
                                matiereNom: matiereNom,
                              ),
                            ),
                          );
                        },
                  child: const Text('Revoir mes réponses'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: (widget.chapitre == null || widget.mode == null)
                            ? null
                            : () => _rejouer(context),
                        child: const Text('Rejouer'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: EduCleColors.textSecondary,
                          side: const BorderSide(color: EduCleColors.border),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const HomeScreen()),
                            (route) => false,
                          );
                        },
                        child: const Text("Retour à l'accueil"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: EduCleColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: EduCleColors.border),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sauvegarde ton score',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Crée un compte pour suivre tes progrès.',
                              style: TextStyle(
                                color: EduCleColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Bientôt disponible !')),
                          );
                        },
                        child: const Text('Créer un compte'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _rejouer(BuildContext context) {
    final controller = context.read<QuizController>();
    final quiz = controller.lancerQuiz(widget.mode!);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => QuizScreen(quiz: quiz, mode: widget.mode!),
      ),
    );
  }
}
