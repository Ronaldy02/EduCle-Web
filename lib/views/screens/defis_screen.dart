import 'package:flutter/material.dart';
import '../../models/defi.dart';
import '../../models/realisation.dart';
import '../../services/defis_service.dart';

class DefisScreen extends StatefulWidget {
  const DefisScreen({super.key});

  @override
  State<DefisScreen> createState() => _DefisScreenState();
}

class _DefisScreenState extends State<DefisScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _svc = DefisService();

  List<DefiProgres> _progresJour = [];
  List<DefiProgres> _progresHebdo = [];
  List<DefiProgres> _progresMensuel = [];
  List<RealisationProgres> _progresReal = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
    _load();
  }

  Future<void> _load() async {
    await _svc.init();
    final results = await Future.wait([
      _svc.getProgresJour(),
      _svc.getProgresHebdo(),
      _svc.getProgresMensuel(),
      _svc.getRealisationsProgres(),
    ]);
    if (mounted) {
      setState(() {
        _progresJour = results[0] as List<DefiProgres>;
        _progresHebdo = results[1] as List<DefiProgres>;
        _progresMensuel = results[2] as List<DefiProgres>;
        _progresReal = results[3] as List<RealisationProgres>;
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DÃ©fis & RÃ©alisations'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Quotidiens'),
            Tab(text: 'Hebdo'),
            Tab(text: 'Mensuel'),
            Tab(text: 'RÃ©alisations'),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabs,
              children: [
                _DefisList(
                  defis: _svc.defisQuotidiensForDate(null),
                  progres: _progresJour,
                  periode: DefisService.periodeJour(DateTime.now()),
                  special: _svc.defisSpeciauxForDate(null),
                ),
                _DefisList(
                  defis: _svc.defisHebdoForDate(null),
                  progres: _progresHebdo,
                  periode: DefisService.periodeHebdo(DateTime.now()),
                ),
                _DefisList(
                  defis: _svc.defisMensuelsForDate(null),
                  progres: _progresMensuel,
                  periode: DefisService.periodeMensuel(DateTime.now()),
                ),
                _RealisationsList(
                  realisations: _svc.toutesLesRealisations,
                  progres: _progresReal,
                ),
              ],
            ),
    );
  }
}

// â”€â”€ Liste des dÃ©fis â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _DefisList extends StatelessWidget {
  final List<Defi> defis;
  final List<DefiProgres> progres;
  final String periode;
  final List<Defi> special;

  const _DefisList({
    required this.defis,
    required this.progres,
    required this.periode,
    this.special = const [],
  });

  @override
  Widget build(BuildContext context) {
    final progresByDefiId = {for (final p in progres) p.defiId: p};
    final tous = [...defis, ...special];
    if (tous.isEmpty) {
      return const Center(child: Text('Aucun dÃ©fi pour cette pÃ©riode.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      itemCount: tous.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (ctx, i) {
        final defi = tous[i];
        final p = progresByDefiId[defi.id];
        return _DefiCard(defi: defi, progres: p);
      },
    );
  }
}

class _DefiCard extends StatelessWidget {
  final Defi defi;
  final DefiProgres? progres;

  const _DefiCard({required this.defi, this.progres});

  @override
  Widget build(BuildContext context) {
    final complete = progres?.complete ?? false;
    final current = progres?.progres ?? 0;
    final pct = (current / defi.cible).clamp(0.0, 1.0);
    final theme = Theme.of(context);

    return Card(
      elevation: complete ? 0 : 2,
      color: complete
          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.4)
          : theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    defi.nom,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      decoration: complete ? TextDecoration.lineThrough : null,
                      color: complete
                          ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                          : null,
                    ),
                  ),
                ),
                if (complete)
                  Icon(Icons.check_circle,
                      color: theme.colorScheme.primary, size: 20),
                if (!complete)
                  _PalierBadge(palier: defi.palier),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              defi.description,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: pct,
                      minHeight: 6,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      color: complete
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$current/${defi.cible}',
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PalierBadge extends StatelessWidget {
  final int palier;
  const _PalierBadge({required this.palier});

  static const _labels = {1: 'Facile', 2: 'Moyen', 3: 'Difficile'};
  static const _colors = {
    1: Color(0xFF10B981),
    2: Color(0xFFF59E0B),
    3: Color(0xFFEF4444),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: (_colors[palier] ?? Colors.grey).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: (_colors[palier] ?? Colors.grey).withValues(alpha: 0.5)),
      ),
      child: Text(
        _labels[palier] ?? '',
        style: TextStyle(
            fontSize: 11,
            color: _colors[palier] ?? Colors.grey,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

// â”€â”€ Liste des rÃ©alisations â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

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
                            color: debloquee ? null : theme.colorScheme.onSurface.withValues(alpha: 0.4),
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
                                backgroundColor: theme.colorScheme.surfaceContainerHighest,
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
                        'DÃ©bloquÃ©e le ${_formatDate(progres!.debloqueLe!)}',
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

