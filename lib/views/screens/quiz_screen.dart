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

  // Shake de la mauvaise réponse sélectionnée
  late AnimationController _shakeCtrl;

  // Slide + fade à chaque nouvelle question
  late AnimationController _questionCtrl;
  late Animation<double> _questionFade;
  late Animation<Offset> _questionSlide;

  // Pop "+N" score
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
    _questionFade = CurvedAnimation(parent: _questionCtrl, curve: Curves.easeOut);
    _questionSlide = Tween<Offset>(
      begin: const Offset(0.07, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _questionCtrl, curve: Curves.easeOut));

    _questionCtrl.forward();
    _sound.initialiser().then((_) {
      _sound.pauseMusiqueFond();
      final tempsMax = widget.mode.dureeTotale != null ? 0 : widget.mode.tempsParQuestion;
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
    final correcte = controller.repondre(quiz, question, reponse ?? '', tempsRestantAuClic);
    final delta = quiz.score - scoreBefore;

    if (correcte) {
      _sound.jouerBonneReponse();
      _afficherDelta(delta);
    } else if (!_tempsEcoule) {
      // Le gong a déjà été joué si le temps s'est écoulé
      _sound.jouerMauvaiseReponse();
      _shakeCtrl.forward(from: 0);
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
      // Redémarre le son pour la nouvelle question (sauf Bombardement : boucle continue)
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

  // Seuil visuel de criticité selon le mode
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

  @override
  Widget build(BuildContext context) {
    final quiz = widget.quiz;
    final question = quiz.questionCourante;
    final utilisateur = context.read<QuizController>().utilisateur;

    if (question == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final estModeGlobal = widget.mode.dureeTotale != null;
    final progression = estModeGlobal
        ? null
        : (quiz.indexCourant + 1) / quiz.questions.length;
    final lettres = ['A', 'B', 'C', 'D', 'E', 'F'];
    final estCritique = quiz.tempsRestant <= _seuilCritique;
    final couleurTimer = estCritique ? EduCleColors.error : _modeCouleur;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── En-tête ──────────────────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: _confirmerQuitter,
                    style: TextButton.styleFrom(
                      foregroundColor: EduCleColors.textSecondary,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text('Quitter'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          estModeGlobal
                              ? 'Question ${quiz.indexCourant + 1}'
                              : 'Question ${quiz.indexCourant + 1} / ${quiz.questions.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            child: LinearProgressIndicator(
                              value: progression,
                              minHeight: 6,
                              backgroundColor: EduCleColors.border,
                              color: couleurTimer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // ── Zone timer + score ──
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.mode.nom,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          // Badge timer avec pulse élastique à chaque tick critique
                          TweenAnimationBuilder<double>(
                            key: ValueKey(quiz.tempsRestant),
                            tween: Tween(
                              begin: estCritique ? 1.20 : 1.0,
                              end: 1.0,
                            ),
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.elasticOut,
                            builder: (_, scale, child) =>
                                Transform.scale(scale: scale, child: child),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: couleurTimer.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${quiz.tempsRestant}s',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                  color: couleurTimer,
                                ),
                              ),
                            ),
                          ),
                          // "+N" score delta flottant
                          Positioned(
                            top: -18,
                            right: 0,
                            child: AnimatedOpacity(
                              opacity: _montrerDelta ? 1.0 : 0.0,
                              duration: Duration(
                                  milliseconds: _montrerDelta ? 100 : 500),
                              child: AnimatedSlide(
                                offset: _montrerDelta
                                    ? const Offset(0, -0.8)
                                    : Offset.zero,
                                duration: const Duration(milliseconds: 900),
                                curve: Curves.easeOut,
                                child: Text(
                                  '+$_dernierDelta',
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
                      const SizedBox(height: 2),
                      Text(
                        '${quiz.score} pts',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: EduCleColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                children: [
                  _Badge(
                      texte: utilisateur.matiereSelectionnee?.nom ??
                          quiz.chapitre.titre),
                  if (utilisateur.niveau != null)
                    _Badge(texte: utilisateur.niveau!, claire: true),
                ],
              ),
              const SizedBox(height: 16),
              // ── Énoncé avec slide-in à chaque changement de question ──────
              FadeTransition(
                opacity: _questionFade,
                child: SlideTransition(
                  position: _questionSlide,
                  child: Text(
                    question.enonce,
                    key: ValueKey(quiz.indexCourant),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ── Choix de réponse ─────────────────────────────────────────
              Expanded(
                child: ListView.separated(
                  itemCount: _choixMelanges.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final choix = _choixMelanges[index];
                    final estBonne = choix == question.bonneReponse;
                    final estMauvaiseSelectionnee =
                        _repondu && !(_correcte ?? true) &&
                            _reponseChoisie == choix;

                    Widget btn = _BoutonChoix(
                      lettre: lettres[index % lettres.length],
                      texte: choix,
                      selectionne: _reponseChoisie == choix,
                      estBonneReponse: estBonne,
                      montrerCorrection: _repondu,
                      onPressed: _repondu ? null : () => _traiterReponse(choix),
                    );

                    // Pop élastique sur la bonne réponse quand révélée
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

                    // Shake horizontal sur la mauvaise réponse choisie
                    if (estMauvaiseSelectionnee) {
                      btn = AnimatedBuilder(
                        animation: _shakeCtrl,
                        builder: (_, child) {
                          final v  = _shakeCtrl.value;
                          final dx = sin(v * pi * 5) * 8 * exp(-v * 4);
                          return Transform.translate(
                              offset: Offset(dx, 0), child: child);
                        },
                        child: btn,
                      );
                    }

                    return btn;
                  },
                ),
              ),
              // ── Feedback (mode Révision) avec slide-up animé ─────────────
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, anim) => SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(
                      CurvedAnimation(parent: anim, curve: Curves.easeOut)),
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: (_repondu && widget.mode.feedbackImmediat)
                    ? KeyedSubtree(
                        key: ValueKey(quiz.indexCourant),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: (_correcte ?? false)
                                    ? EduCleColors.successBg
                                    : EduCleColors.errorBg,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: (_correcte ?? false)
                                      ? EduCleColors.success
                                      : EduCleColors.error,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}

// ─── Widgets internes ─────────────────────────────────────────────────────────

class _Badge extends StatelessWidget {
  final String texte;
  final bool claire;

  const _Badge({required this.texte, this.claire = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: claire
            ? EduCleColors.border.withValues(alpha: 0.5)
            : EduCleColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texte,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: claire ? EduCleColors.textSecondary : EduCleColors.primary,
        ),
      ),
    );
  }
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
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
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    texte,
                    style: const TextStyle(fontWeight: FontWeight.w600),
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
