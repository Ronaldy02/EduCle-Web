import 'dart:convert';

class Defi {
  final String id;
  final String type; // 'd' | 'w' | 'm' | 's'
  final int palier; // 1/2/3 pour quotidiens
  final String nom;
  final String description;
  final String metrique;
  final int cible;
  final Map<String, dynamic> filtres;
  final String? dateSpe; // pour type 's': 'MM-DD' ou plage

  const Defi({
    required this.id,
    required this.type,
    required this.palier,
    required this.nom,
    required this.description,
    required this.metrique,
    required this.cible,
    this.filtres = const {},
    this.dateSpe,
  });

  factory Defi.fromMap(Map<String, dynamic> m) => Defi(
        id: m['id'] as String,
        type: m['type'] as String,
        palier: (m['palier'] as int?) ?? 1,
        nom: m['nom'] as String,
        description: m['description'] as String,
        metrique: m['metrique'] as String,
        cible: m['cible'] as int,
        filtres: m['filtres'] != null
            ? (jsonDecode(m['filtres'] as String) as Map<String, dynamic>)
            : {},
        dateSpe: m['date_spe'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'palier': palier,
        'nom': nom,
        'description': description,
        'metrique': metrique,
        'cible': cible,
        'filtres': filtres.isNotEmpty ? jsonEncode(filtres) : null,
        'date_spe': dateSpe,
      };
}

class DefiProgres {
  final String defiId;
  final String periode; // 'YYYY-MM-DD' | 'YYYY-Www' | 'YYYY-MM'
  final int progres;
  final bool complete;

  const DefiProgres({
    required this.defiId,
    required this.periode,
    required this.progres,
    required this.complete,
  });

  factory DefiProgres.fromMap(Map<String, dynamic> m) => DefiProgres(
        defiId: m['defi_id'] as String,
        periode: m['periode'] as String,
        progres: m['progres'] as int,
        complete: (m['complete'] as int) == 1,
      );
}
