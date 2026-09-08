import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/quiz_controller.dart';
import '../../models/parametre_partie.dart';
import '../../models/quiz.dart';
import '../../services/sound_service.dart';
import '../../theme/app_theme.dart';
import 'resultat_screen.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;
  final ParametrePartie mode;

  const QuizScreen({super.key, required this.quiz, required this.mode});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  Timer? _timer;
  bool _repondu = false;
  String? _reponseChoisie;
  bool? _correcte;
  bool _termine = false;
  bool _tempsEcoule = false;
  List<String> _choixMelanges = [];
  int _serie = 0;

  late AnimationController _shakeCtrl;
  late AnimationController _questionCtrl;
  late Animation<double> _questionFade;
  late Animation<Offset> _questionSlide;

  int _dernierDelta = 0;
  bool _montrerDelta = false;

  final _sound = SoundService.instance;

  @override
  void initState() {
    super.initState();
    _melangerChoix();

    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _questionCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _questionFade =
        CurvedAnimation(parent: _questionCtrl, curve: Curves.easeOut);
    _questionSlide = Tween<Offset>(
      begin: const Offset(0.07, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _questionCtrl, curve: Curves.easeOut));

    _questionCtrl.forward();
    _sound.initialiser().then((_) {
      _sound.pauseMusiqueFond();
      final tempsMax =
          widget.mode.dureeTotale != null ? 0 : widget.mode.tempsParQuestion;
      _sound.jouerTickQuestion(tempsMax);
    });
    _demarrerTimer();
  }

  void _melangerChoix() {
    final q = widget.quiz.questionCourante;
    if (q == null) return;
    _choixMelanges = List.of(q.choix)..shuffle(Random());
  }

  void _demarrerTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final quiz = widget.quiz;
      if (quiz.tempsRestant > 0) {
        setState(() => quiz.tempsRestant--);
        if (quiz.tempsRestant == 0) _surTempsEcoule();
      }
    });
  }

  void _surTempsEcoule() {
    _tempsEcoule = true;
    _sound.jouerGong();
    final modeGlobal = widget.mode.dureeTotale != null;
    if (modeGlobal) {
      widget.quiz.forcerFin();
      _finir();
    } else if (!_repondu) {
      _traiterReponse(null);
    }
  }

  void _traiterReponse(String? reponse) {
    if (_repondu) return;
    final controller = context.read<QuizController>();
    final quiz = widget.quiz;
    final question = quiz.questionCourante;
    if (question == null) return;

    final scoreBefore = quiz.score;
    final tempsRestantAuClic = quiz.tempsRestant;
    final correcte =
        controller.repondre(quiz, question, reponse ?? '', tempsRestantAuClic);
    final delta = quiz.score - scoreBefore;

    if (correcte) {
      _serie++;
      _sound.jouerBonneReponse();
      _afficherDelta(delta);
    } else {
      _serie = 0;
      if (!_tempsEcoule) {
        _sound.jouerMauvaiseReponse();
        _shakeCtrl.forward(from: 0);
      }
    }
    _tempsEcoule = false;

    if (widget.mode.feedbackImmediat) {
      setState(() {
        _repondu = true;
        _reponseChoisie = reponse;
        _correcte = correcte;
      });
    } else {
      _passerQuestionSuivante();
    }
  }

  void _afficherDelta(int delta) {
    setState(() {
      _dernierDelta = delta;
      _montrerDelta = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) setState(() => _montrerDelta = false);
    });
  }

  void _passerQuestionSuivante() {
    final controller = context.read<QuizController>();
    final quiz = widget.quiz;
    controller.questionSuivante(quiz);
    _melangerChoix();
    setState(() {
      _repondu = false;
      _reponseChoisie = null;
      _correcte = null;
      _montrerDelta = false;
      _tempsEcoule = false;
    });
    if (quiz.termine) {
      _finir();
    } else {
      _questionCtrl.forward(from: 0);
      if (widget.mode.dureeTotale == null) {
        _sound.jouerTickQuestion(widget.mode.tempsParQuestion);
      }
    }
  }

  Future<void> _finir() async {
    if (_termine) return;
    _termine = true;
    _timer?.cancel();
    _sound.stopTick();
    _sound.reprendreMusiqueFond();
    final controller = context.read<QuizController>();
    final resultat = await controller.terminerQuiz(widget.quiz);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ResultatScreen(
          resultat: resultat,
          chapitre: widget.quiz.chapitre,
          mode: widget.mode,
        ),
      ),
    );
  }

  Future<void> _confirmerQuitter() async {
    final quitter = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quitter le quiz ?'),
        content: const Text('Ta progression sur cette question sera perdue.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Quitter'),
          ),
        ],
      ),
    );
    if (quitter == true && mounted) {
      _timer?.cancel();
      _sound.stopTick();
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _sound.stopTick();
    _shakeCtrl.dispose();
    _questionCtrl.dispose();
    super.dispose();
  }

  int get _seuilCritique {
    if (widget.mode.dureeTotale != null) return 15;
    return widget.mode.tempsParQuestion <= 10 ? 5 : 8;
  }

  Color get _modeCouleur {
    switch (widget.mode.nom) {
      case 'Rush':
        return EduCleColors.rush;
      case 'Bombardement':
        return EduCleColors.bombardement;
      default:
        return EduCleColors.primary;
    }
  }

  Widget _buildChoixBtn(int index, dynamic question, List<String> lettres) {
    if (index >= _choixMelanges.length) return const SizedBox();
    final choix = _choixMelanges[index];
    final estBonne = choix == question.bonneReponse;
    final estMauvaiseSelectionnee =
        _repondu && !(_correcte ?? true) && _reponseChoisie == choix;

    Widget btn = _BoutonChoix(
      lettre: lettres[index % lettres.length],
      texte: choix,
      selectionne: _reponseChoisie == choix,
      estBonneReponse: estBonne,
      montrerCorrection: _repondu,
      onPressed: _repondu ? null : () => _traiterReponse(choix),
    );

    if (_repondu && estBonne) {
      btn = TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.06, end: 1.0),
        duration: const Duration(milliseconds: 450),
        curve: Curves.elasticOut,
        builder: (_, scale, child) =>
            Transform.scale(scale: scale, child: child),
        child: btn,
      );
    }

    if (estMauvaiseSelectionnee) {
      btn = AnimatedBuilder(
        animation: _shakeCtrl,
        builder: (_, child) {
          final v = _shakeCtrl.value;
          final dx = sin(v * pi * 5) * 8 * exp(-v * 4);
          return Transform.translate(offset: Offset(dx, 0), child: child);
        },
        child: btn,
      );
    }

    return btn;
  }

  @override
  Widget build(BuildContext context) {
    final quiz = widget.quiz;
    final question = quiz.questionCourante;
    final utilisateur = context.read<QuizController>().utilisateur;

    if (question == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    final estModeGlobal = widget.mode.dureeTotale != null;
    final tempsMax = estModeGlobal
        ? (widget.mode.dureeTotale ?? 60)
        : widget.mode.tempsParQuestion;
    final lettres = ['A', 'B', 'C', 'D', 'E', 'F'];
    final estCritique = quiz.tempsRestant <= _seuilCritique;
    final couleurTimer = estCritique ? EduCleColors.error : _modeCouleur;
    final matiere = utilisateur.matiereSelectionnee;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── App bar ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 8, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    onPressed: _confirmerQuitter,
                    color: const Color(0xFF1A1D24),
                  ),
                  const Expanded(
                    child: Text(
                      'EduClé',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                        color: Color(0xFF1A1D24),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {},
                    color: EduCleColors.textSecondary,
                  ),
                ],
              ),
            ),

            // ── Context sub-bar ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 12, 8),
              child: Row(
                children: [
                  _QuizChip('EduClé', primary: true),
                  const SizedBox(width: 6),
                  _QuizChip(widget.mode.nom),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      matiere != null
                          ? '${matiere.nom} · ${quiz.chapitre.titre}'
                          : quiz.chapitre.titre,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: EduCleColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.star_rounded,
                      color: Colors.amber, size: 15),
                  const SizedBox(width: 2),
                  Text(
                    '${quiz.score}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 13),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _confirmerQuitter,
                    child: const Text(
                      'Quitter',
                      style: TextStyle(
                        color: Color(0xFFBA1A1A),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, thickness: 1, color: Color(0xFFECECF0)),
            const SizedBox(height: 12),

            // ── Stats row ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: const Icon(Icons.star_rounded,
                          color: Colors.amber, size: 22),
                      value: '${quiz.score}',
                      label: 'Score',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _CircularTimerCard(
                      tempsRestant: quiz.tempsRestant,
                      tempsMax: tempsMax,
                      couleur: couleurTimer,
                      critique: estCritique,
                      montrerDelta: _montrerDelta,
                      delta: _dernierDelta,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatCard(
                      icon: const Icon(Icons.local_fire_department_rounded,
                          color: Colors.orange, size: 22),
                      value: '$_serie',
                      label: 'Série',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Question nav ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    estModeGlobal
                        ? 'Question ${quiz.indexCourant + 1}'
                        : 'Question ${quiz.indexCourant + 1} / ${quiz.questions.length}',
                    style: TextStyle(
                      color: _modeCouleur,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: null,
                    icon: const Text('🎁',
                        style: TextStyle(fontSize: 14)),
                    label: const Text('Bonus',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    style: TextButton.styleFrom(
                      foregroundColor: EduCleColors.primary,
                      disabledForegroundColor:
                          EduCleColors.primary.withValues(alpha: 0.6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            // ── Contenu scrollable ─────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Question card
                    FadeTransition(
                      opacity: _questionFade,
                      child: SlideTransition(
                        position: _questionSlide,
                        child: Container(
                          key: ValueKey(quiz.indexCourant),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: const Color(0xFFD8E2FF), width: 2),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0D000000),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            question.enonce,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF151C27),
                              height: 1.35,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Grille 2 × 2
                    ...List.generate(
                      (_choixMelanges.length / 2).ceil(),
                      (row) {
                        final i1 = row * 2;
                        final i2 = i1 + 1;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildChoixBtn(i1, question, lettres),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: i2 < _choixMelanges.length
                                    ? _buildChoixBtn(i2, question, lettres)
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    // Feedback (mode Révision)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      transitionBuilder: (child, anim) => SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                            parent: anim, curve: Curves.easeOut)),
                        child: FadeTransition(opacity: anim, child: child),
                      ),
                      child: (_repondu && widget.mode.feedbackImmediat)
                          ? KeyedSubtree(
                              key: ValueKey(quiz.indexCourant),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: (_correcte ?? false)
                                          ? EduCleColors.successBg
                                          : EduCleColors.errorBg,
                                      borderRadius:
                                          BorderRadius.circular(14),
                                      border: Border.all(
                                        color: (_correcte ?? false)
                                            ? EduCleColors.success
                                            : EduCleColors.error,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (_correcte ?? false)
                                              ? 'Bonne réponse !'
                                              : 'Réponse incorrecte',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: (_correcte ?? false)
                                                ? EduCleColors.success
                                                : EduCleColors.error,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(question.explication),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  FilledButton(
                                    onPressed: _passerQuestionSuivante,
                                    child: const Text('Suivant'),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(key: ValueKey('vide')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Widgets internes ─────────────────────────────────────────────────────────

class _QuizChip extends StatelessWidget {
  final String label;
  final bool primary;
  const _QuizChip(this.label, {this.primary = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: primary
            ? EduCleColors.primary
            : EduCleColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: primary ? Colors.white : EduCleColors.primary,
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final Widget icon;
  final String value;
  final String label;
  const _StatCard(
      {required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: EduCleColors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: EduCleColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularTimerCard extends StatelessWidget {
  final int tempsRestant;
  final int tempsMax;
  final Color couleur;
  final bool critique;
  final bool montrerDelta;
  final int delta;

  const _CircularTimerCard({
    required this.tempsRestant,
    required this.tempsMax,
    required this.couleur,
    required this.critique,
    required this.montrerDelta,
    required this.delta,
  });

  @override
  Widget build(BuildContext context) {
    final progress =
        tempsMax > 0 ? (tempsRestant / tempsMax).clamp(0.0, 1.0) : 1.0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: critique ? couleur.withValues(alpha: 0.08) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: critique
              ? couleur.withValues(alpha: 0.4)
              : EduCleColors.border,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 52,
            height: 52,
            child: CustomPaint(
              painter:
                  _ArcPainter(progress: progress, couleur: couleur),
              child: Center(
                child: Text(
                  '${tempsRestant}s',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: couleur,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: AnimatedOpacity(
              opacity: montrerDelta ? 1.0 : 0.0,
              duration:
                  Duration(milliseconds: montrerDelta ? 100 : 500),
              child: AnimatedSlide(
                offset: montrerDelta
                    ? const Offset(0, -0.8)
                    : Offset.zero,
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOut,
                child: Text(
                  '+$delta',
                  style: const TextStyle(
                    color: EduCleColors.success,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  final Color couleur;
  _ArcPainter({required this.progress, required this.couleur});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 3;
    const strokeWidth = 4.5;

    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = const Color(0xFFE8ECF4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth);

    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        2 * pi * progress,
        false,
        Paint()
          ..color = couleur
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.progress != progress || old.couleur != couleur;
}

class _BoutonChoix extends StatelessWidget {
  final String lettre;
  final String texte;
  final bool selectionne;
  final bool estBonneReponse;
  final bool montrerCorrection;
  final VoidCallback? onPressed;

  const _BoutonChoix({
    required this.lettre,
    required this.texte,
    required this.selectionne,
    required this.estBonneReponse,
    required this.montrerCorrection,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Color fond = EduCleColors.surface;
    Color bordure = EduCleColors.border;
    Color couleurLettre = EduCleColors.textSecondary;

    if (montrerCorrection) {
      if (estBonneReponse) {
        fond = EduCleColors.successBg;
        bordure = EduCleColors.success;
        couleurLettre = EduCleColors.success;
      } else if (selectionne) {
        fond = EduCleColors.errorBg;
        bordure = EduCleColors.error;
        couleurLettre = EduCleColors.error;
      }
    } else if (selectionne) {
      bordure = EduCleColors.primary;
      couleurLettre = EduCleColors.primary;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: fond,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: bordure, width: 1.4),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: couleurLettre.withValues(alpha: 0.10),
                    border: Border.all(color: couleurLettre, width: 1.4),
                  ),
                  child: Text(
                    lettre,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: couleurLettre,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      texte,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
