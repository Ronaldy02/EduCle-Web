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

enum _AuthEtape { accueil, email }

class _LoginScreenState extends State<LoginScreen> {
  _AuthEtape _etape = _AuthEtape.accueil;
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

    setState(() {
      _chargement = true;
      _erreur = null;
    });

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

  Future<void> _google() async {
    setState(() { _chargement = true; _erreur = null; });
    try {
      await ApiService.instance.connexionGoogle();
      if (!mounted) return;
      await _finLogin(pullDuServeur: true);
    } on ApiException catch (e) {
      if (mounted) setState(() { _erreur = e.message; _chargement = false; });
    } catch (_) {
      if (mounted) setState(() {
        _erreur = 'Connexion Google échouée. Vérifie ta connexion.';
        _chargement = false;
      });
    }
  }

  Future<void> _continuerSansCompte() async {
    setState(() => _chargement = true);
    final ctrl = context.read<QuizController>();
    // profilConfigure = true est déjà positionné en mémoire avant le write DB
    await ctrl.marquerProfilConfigure()
        .timeout(const Duration(seconds: 5), onTimeout: () {});
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  Future<void> _finLogin({required bool pullDuServeur}) async {
    final ctrl = context.read<QuizController>();
    if (pullDuServeur) {
      await ApiService.instance
          .syncDepuisServeur()
          .timeout(const Duration(seconds: 15), onTimeout: () {});
    }
    await ctrl.marquerProfilConfigure()
        .timeout(const Duration(seconds: 5), onTimeout: () {});
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B3E),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Hero ──────────────────────────────────────────────────
                Expanded(child: _buildHero()),

                // ── Carte blanche ──────────────────────────────────────────
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                  child: SafeArea(
                    top: false,
                    child: _etape == _AuthEtape.accueil
                        ? _buildAccueil()
                        : _buildEmail(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo + nom
            Row(
              children: [
                Image.asset('assets/logo/educle_cle_or.png', width: 28),
                const SizedBox(width: 8),
                const Text(
                  'EduClé',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Tagline
            const Text(
              'La clé de ta\nréussite scolaire.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Quiz adaptatifs, suivi de progression et défis par matière — calibrés pour ton niveau et ton programme.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),
            // Stats chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _StatChip(label: '12 matières'),
                _StatChip(label: '500+ questions'),
                _StatChip(label: '8 modes de jeu'),
                _StatChip(label: '🏅 Récompenses', doree: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccueil() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Bienvenue sur EduClé',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Connecte-toi ou crée ton compte pour continuer.',
          style: TextStyle(fontSize: 13, color: Color(0xFF8A8A8A)),
        ),
        const SizedBox(height: 20),

        if (_erreur != null) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEEEE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.error_outline, color: Color(0xFFD32F2F), size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(_erreur!,
                      style: const TextStyle(color: Color(0xFFD32F2F), fontSize: 13)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],

        // Bouton Google
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _chargement ? null : _google,
            icon: const _GoogleLogo(),
            label: const Text('Continuer avec Google'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Color(0xFFE0E0E0)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              foregroundColor: const Color(0xFF1A1A2E),
              textStyle: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),

        const SizedBox(height: 12),
        const _OuDivider(),
        const SizedBox(height: 12),

        // Bouton email
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _chargement
                ? null
                : () => setState(() => _etape = _AuthEtape.email),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Color(0xFFE0E0E0)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              foregroundColor: const Color(0xFF1A1A2E),
              textStyle: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ),
            child: const Text("Continuer avec l'e-mail"),
          ),
        ),

        const SizedBox(height: 16),
        Center(
          child: TextButton(
            onPressed: _chargement ? null : _continuerSansCompte,
            child: const Text(
              'Continuer sans compte',
              style: TextStyle(color: Color(0xFF8A8A8A), fontSize: 13),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Text(
            "En continuant, tu acceptes nos Conditions d'utilisation",
            style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // En-tête avec retour
        Row(
          children: [
            GestureDetector(
              onTap: () => setState(() {
                _etape = _AuthEtape.accueil;
                _erreur = null;
              }),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF1A1A2E), size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              _inscription ? 'Créer un compte' : 'Se connecter',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ],
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
                          color: Color(0xFFD32F2F), fontSize: 13)),
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
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : Text(
                    _inscription ? 'Créer mon compte' : 'Se connecter',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
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
                  color: Color(0xFF2F6FED), fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ── Widgets locaux ──────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final String label;
  final bool doree;

  const _StatChip({required this.label, this.doree = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.18)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: doree ? const Color(0xFFFFD700) : Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _OuDivider extends StatelessWidget {
  const _OuDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFE8E8E8))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OU',
            style: TextStyle(
                color: Color(0xFFBBBBBB),
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFE8E8E8))),
      ],
    );
  }
}

class _GoogleLogo extends StatelessWidget {
  const _GoogleLogo();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'G',
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: Color(0xFF4285F4),
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
