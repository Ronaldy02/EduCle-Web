import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/quiz_controller.dart';
import '../../theme/app_theme.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _chargement = false;

  Future<void> _commencer() async {
    setState(() => _chargement = true);
    final ctrl = context.read<QuizController>();
    await ctrl.marquerProfilConfigure();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<QuizController>();
    final annees = ctrl.niveauScolaire == 'Secondaire'
        ? ['NS1', 'NS2', 'NS3', 'NS4']
        : ['7e AF', '8e AF', '9e AF'];

    return Scaffold(
      backgroundColor: const Color(0xFF2F6FED),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(),

              // Logo
              Image.asset('assets/logo/educle_cle_or.png', width: 90),
              const SizedBox(height: 16),
              const Text(
                'EduClé',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'La clé de ta réussite scolaire',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),

              const Spacer(),

              // Carte de configuration
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ton niveau',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Cycle
                    Row(
                      children: [
                        _BtnCycle(
                          label: 'Fondamental',
                          sousTitre: '7e – 9e AF',
                          actif: ctrl.niveauScolaire == 'Fondamental',
                          onTap: () => context.read<QuizController>().changerNiveauScolaire('Fondamental'),
                        ),
                        const SizedBox(width: 10),
                        _BtnCycle(
                          label: 'Secondaire',
                          sousTitre: 'NS1 – NS4',
                          actif: ctrl.niveauScolaire == 'Secondaire',
                          onTap: () => context.read<QuizController>().changerNiveauScolaire('Secondaire'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      'ANNÉE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8A8A8A),
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: annees.map((a) => _BtnAnnee(
                        label: a,
                        actif: ctrl.annee == a,
                        onTap: () => context.read<QuizController>().changerAnnee(a),
                      )).toList(),
                    ),

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _chargement ? null : _commencer,
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF2F6FED),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: _chargement
                            ? const SizedBox(
                                width: 20, height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Commencer',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _BtnCycle extends StatelessWidget {
  final String label;
  final String sousTitre;
  final bool actif;
  final VoidCallback onTap;

  const _BtnCycle({
    required this.label,
    required this.sousTitre,
    required this.actif,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: actif ? const Color(0xFF2F6FED) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: actif ? const Color(0xFF2F6FED) : const Color(0xFFE0E0E0),
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: actif ? Colors.white : const Color(0xFF1A1A2E),
                ),
              ),
              Text(
                sousTitre,
                style: TextStyle(
                  fontSize: 11,
                  color: actif ? Colors.white70 : const Color(0xFF8A8A8A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BtnAnnee extends StatelessWidget {
  final String label;
  final bool actif;
  final VoidCallback onTap;

  const _BtnAnnee({
    required this.label,
    required this.actif,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        decoration: BoxDecoration(
          color: actif ? const Color(0xFF2F6FED) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: actif ? const Color(0xFF2F6FED) : const Color(0xFFE0E0E0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: actif ? Colors.white : const Color(0xFF1A1A2E),
          ),
        ),
      ),
    );
  }
}
