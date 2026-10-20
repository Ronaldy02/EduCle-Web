import 'package:flutter/material.dart';
import '../../models/defi.dart';
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

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
    _load();
  }

  Future<void> _load() async {
    await _svc.init();
    final results = await Future.wait([
      _svc.getProgresJour(),
      _svc.getProgresHebdo(),
      _svc.getProgresMensuel(),
    ]);
    if (mounted) {
      setState(() {
        _progresJour = results[0] as List<DefiProgres>;
        _progresHebdo = results[1] as List<DefiProgres>;
        _progresMensuel = results[2] as List<DefiProgres>;
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
        title: const Text('Défis'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Quotidiens'),
            Tab(text: 'Hebdo'),
            Tab(text: 'Mensuel'),
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
      return const Center(child: Text('Aucun défi pour cette période.'));
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



