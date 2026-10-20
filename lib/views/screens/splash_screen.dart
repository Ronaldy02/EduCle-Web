import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/quiz_controller.dart';
import '../../services/api_service.dart';
import '../../services/database_helper.dart';
import '../../theme/app_theme.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Map<String, dynamic>> _avancements = [];
  bool _pret = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  Future<void> _init() async {
    final ctrl = context.read<QuizController>();
    final stopwatch = Stopwatch()..start();

    await ctrl.initialiser();

    // Charger l'avancement par matière (seulement sur mobile)
    try {
      final data = await DatabaseHelper.instance.getAvancementParMatiere();
      if (mounted) setState(() => _avancements = data);
    } catch (_) {}

    // Afficher au moins 1.5 s pour que l'utilisateur voie ses stats
    final elapsed = stopwatch.elapsedMilliseconds;
    if (elapsed < 1500) {
      await Future.delayed(Duration(milliseconds: 1500 - elapsed));
    }

    if (!mounted) return;

    if (ApiService.instance.estConnecte) {
      ApiService.instance.syncVersServeur();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
      return;
    }

    if (ctrl.profilConfigure) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B3E),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Logo
            Center(
              child: Column(
                children: [
                  Image.asset('assets/logo/educle_cle_or.png', width: 64),
                  const SizedBox(height: 12),
                  const Text(
                    'EduClé',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            if (_avancements.isEmpty)
              const Expanded(
                child: Center(
                  child: SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white38,
                    ),
                  ),
                ),
              )
            else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    const Text(
                      'Ton avancement',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _avancements.length,
                  itemBuilder: (context, i) {
                    final row = _avancements[i];
                    final nom = row['nom'] as String;
                    final total = (row['nb_questions'] as int? ?? 0);
                    final correctes = (row['nb_correctes'] as int? ?? 0);
                    final pct = total > 0 ? (correctes / total).clamp(0.0, 1.0) : 0.0;
                    final pctTexte = total > 0
                        ? '${(pct * 100).round()}%'
                        : '—';

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  nom,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                total > 0
                                    ? '$correctes / $total  $pctTexte'
                                    : '0 question',
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: pct,
                              minHeight: 5,
                              backgroundColor: Colors.white12,
                              color: pct > 0.7
                                  ? const Color(0xFF10B981)
                                  : pct > 0.4
                                      ? const Color(0xFFF59E0B)
                                      : EduCleColors.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}
