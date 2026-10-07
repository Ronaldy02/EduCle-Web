import 'dart:convert';

class Realisation {
  final String id;
  final int rarete; // 1=Commune 2=PeuCommune 3=Rare 4=Épique 5=Légendaire
  final String groupe;
  final String nom;
  final String description;
  final String metrique;
  final int cible;
  final bool secret;
  final Map<String, dynamic> filtres;

  const Realisation({
    required this.id,
    required this.rarete,
    required this.groupe,
    required this.nom,
    required this.description,
    required this.metrique,
    required this.cible,
    this.secret = false,
    this.filtres = const {},
  });

  factory Realisation.fromMap(Map<String, dynamic> m) => Realisation(
        id: m['id'] as String,
        rarete: m['rarete'] as int,
        groupe: m['groupe'] as String,
        nom: m['nom'] as String,
        description: m['description'] as String,
        metrique: m['metrique'] as String,
        cible: m['cible'] as int,
        secret: (m['secret'] as int) == 1,
        filtres: m['filtres'] != null
            ? (jsonDecode(m['filtres'] as String) as Map<String, dynamic>)
            : {},
      );

  static const Map<int, String> _rareteLabels = {
    1: 'Commune',
    2: 'Peu commune',
    3: 'Rare',
    4: 'Épique',
    5: 'Légendaire',
  };

  static const Map<int, int> _rareteCouleurs = {
    1: 0xFF9CA3AF,
    2: 0xFF10B981,
    3: 0xFF3B82F6,
    4: 0xFF8B5CF6,
    5: 0xFFF0A000,
  };

  String get rareteLabel => _rareteLabels[rarete] ?? '?';
  int get rareteCouleur => _rareteCouleurs[rarete] ?? 0xFF9CA3AF;
}

class RealisationProgres {
  final String realisationId;
  final int progres;
  final bool debloquee;
  final String? debloqueLe;

  const RealisationProgres({
    required this.realisationId,
    required this.progres,
    required this.debloquee,
    this.debloqueLe,
  });

  factory RealisationProgres.fromMap(Map<String, dynamic> m) =>
      RealisationProgres(
        realisationId: m['realisation_id'] as String,
        progres: m['progres'] as int,
        debloquee: (m['debloquee'] as int) == 1,
        debloqueLe: m['debloque_le'] as String?,
      );
}
