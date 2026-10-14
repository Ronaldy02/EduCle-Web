import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/quiz_controller.dart';
import '../../services/api_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _inscription = false;
  bool _chargement = false;
  String? _erreur;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _soumettre() async {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;
    if (email.isEmpty || pass.isEmpty) return;

    setState(() { _chargement = true; _erreur = null; });

    try {
      if (_inscription) {
        await ApiService.instance.inscription(email, pass);
      } else {
        await ApiService.instance.connexion(email, pass);
      }
      if (!mounted) return;
      await _finLogin(pullDuServeur: !_inscription);
    } on ApiException catch (e) {
      setState(() => _erreur = e.message);
    } catch (_) {
      setState(() => _erreur = 'Erreur de connexion. Vérifie ta connexion internet.');
    } finally {
      if (mounted) setState(() => _chargement = false);
    }
  }

  Future<void> _continuerSansCompte() async {
    setState(() => _chargement = true);
    final ctrl = context.read<QuizController>();
    await ctrl.marquerProfilConfigure();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  Future<void> _finLogin({required bool pullDuServeur}) async {
    final ctrl = context.read<QuizController>();
    if (pullDuServeur) {
      await ApiService.instance.syncDepuisServeur();
    }
    await ctrl.marquerProfilConfigure();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F6FED),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  // ── Logo ──────────────────────────────────────────────────
                  const SizedBox(height: 48),
                  Image.asset('assets/logo/educle_cle_or.png', width: 80),
                  const SizedBox(height: 12),
                  const Text(
                    'EduClé',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'La clé de ta réussite scolaire',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const Spacer(),

                  // ── Carte ─────────────────────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _inscription ? 'Créer un compte' : 'Se connecter',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _inscription
                              ? 'Pour sauvegarder tes stats sur tous tes appareils'
                              : 'Retrouve ta progression où que tu sois',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF8A8A8A),
                          ),
                        ),
                        const SizedBox(height: 20),

                        _Champ(
                          ctrl: _emailCtrl,
                          label: 'Email',
                          icone: Icons.email_outlined,
                          clavier: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 12),
                        _Champ(
                          ctrl: _passCtrl,
                          label: 'Mot de passe',
                          icone: Icons.lock_outline,
                          masque: true,
                        ),

                        if (_erreur != null) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEEEE),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline,
                                    color: Color(0xFFD32F2F), size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(_erreur!,
                                      style: const TextStyle(
                                          color: Color(0xFFD32F2F),
                                          fontSize: 13)),
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _chargement ? null : _soumettre,
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF2F6FED),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            child: _chargement
                                ? const SizedBox(
                                    width: 20, height: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.white))
                                : Text(
                                    _inscription ? 'Créer mon compte' : 'Se connecter',
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.w700)),
                          ),
                        ),

                        const SizedBox(height: 12),
                        Center(
                          child: TextButton(
                            onPressed: _chargement
                                ? null
                                : () => setState(() {
                                      _inscription = !_inscription;
                                      _erreur = null;
                                    }),
                            child: Text(
                              _inscription
                                  ? 'Déjà un compte ? Se connecter'
                                  : 'Pas de compte ? Créer un compte',
                              style: const TextStyle(
                                  color: Color(0xFF2F6FED),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),

                        const Divider(height: 28, color: Color(0xFFE0E0E0)),

                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: _chargement ? null : _continuerSansCompte,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(color: Color(0xFFE0E0E0)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            child: const Text(
                              'Continuer sans compte',
                              style: TextStyle(
                                  color: Color(0xFF8A8A8A),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Champ extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final IconData icone;
  final bool masque;
  final TextInputType clavier;

  const _Champ({
    required this.ctrl,
    required this.label,
    required this.icone,
    this.masque = false,
    this.clavier = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      obscureText: masque,
      keyboardType: clavier,
      style: const TextStyle(fontSize: 15, color: Color(0xFF1A1A2E)),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icone, color: const Color(0xFF8A8A8A), size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2F6FED), width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFFF9F9F9),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
