import 'package:flutter/material.dart';

import '../../models/realisation.dart';
import '../../services/defis_service.dart';

class RealisationScreen extends StatefulWidget {
  const RealisationScreen({super.key});

  @override
  State<RealisationScreen> createState() => _RealisationScreenState();
}

class _RealisationScreenState extends State<RealisationScreen> {
  final _svc = DefisService();
  List<RealisationProgres> _progres = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await _svc.init();
    final p = await _svc.getRealisationsProgres();
    if (mounted) {
      setState(() {
        _progres = p;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Réalisation')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _RealisationsList(
              realisations: _svc.toutesLesRealisations,
              progres: _progres,
            ),
    );
  }
}

// ── Liste ────────────────────────────────────────────────────────────────────

class _RealisationsList extends StatelessWidget {
  final List<Realisation> realisations;
  final List<RealisationProgres> progres;

  const _RealisationsList({
    required this.realisations,
    required this.progres,
  });

  @override
  Widget build(BuildContext context) {
    final progresById = {for (final p in progres) p.realisationId: p};
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      itemCount: realisations.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (ctx, i) {
        final r = realisations[i];
        final p = progresById[r.id];
        return _RealisationCard(realisation: r, progres: p);
      },
    );
  }
}

class _RealisationCard extends StatelessWidget {
  final Realisation realisation;
  final RealisationProgres? progres;

  const _RealisationCard({required this.realisation, this.progres});

  @override
  Widget build(BuildContext context) {
    final debloquee = progres?.debloquee ?? false;
    final current = progres?.progres ?? 0;
    final pct = (current / realisation.cible).clamp(0.0, 1.0);
    final couleur = Color(realisation.rareteCouleur);
    final secret = realisation.secret && !debloquee;
    final theme = Theme.of(context);

    return Card(
      elevation: debloquee ? 2 : 0,
      color: debloquee
          ? theme.cardColor
          : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      shape: debloquee
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: couleur.withValues(alpha: 0.4)),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: debloquee
                    ? couleur.withValues(alpha: 0.15)
                    : theme.colorScheme.surfaceContainerHighest,
                border: Border.all(
                    color: debloquee ? couleur : Colors.transparent),
              ),
              child: Center(
                child: secret
                    ? Icon(Icons.lock,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                        size: 20)
                    : Text(
                        realisation.nom.split(' ').first,
                        style: const TextStyle(fontSize: 22),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          secret ? '???' : realisation.nom,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: debloquee
                                ? null
                                : theme.colorScheme.onSurface
                                    .withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                      _RareteBadge(label: realisation.rareteLabel, couleur: couleur),
                    ],
                  ),
                  if (!secret) ...[
                    const SizedBox(height: 2),
                    Text(
                      realisation.description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    if (!debloquee) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: LinearProgressIndicator(
                                value: pct,
                                minHeight: 4,
                                backgroundColor:
                                    theme.colorScheme.surfaceContainerHighest,
                                color: couleur,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text('$current/${realisation.cible}',
                              style: theme.textTheme.labelSmall),
                        ],
                      ),
                    ],
                    if (debloquee && progres?.debloqueLe != null)
                      Text(
                        'Débloquée le ${_formatDate(progres!.debloqueLe!)}',
                        style: theme.textTheme.labelSmall
                            ?.copyWith(color: couleur),
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String iso) {
    try {
      final d = DateTime.parse(iso);
      return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
    } catch (_) {
      return iso;
    }
  }
}

class _RareteBadge extends StatelessWidget {
  final String label;
  final Color couleur;

  const _RareteBadge({required this.label, required this.couleur});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: couleur.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 10, color: couleur, fontWeight: FontWeight.w700),
      ),
    );
  }
}
