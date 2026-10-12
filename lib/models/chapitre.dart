import 'carte_mentale.dart';
import 'question.dart';

/// Modèle "Chapitre" du diagramme de classes.
class Chapitre {
  final int id;
  final String titre;
  final String? niveauV4;
  final List<CarteMentale> cartesMentales;
  final List<Question> questions;

  Chapitre({
    required this.id,
    required this.titre,
    this.niveauV4,
    this.cartesMentales = const [],
    this.questions = const [],
  });

  factory Chapitre.fromMap(Map<String, dynamic> map) {
    return Chapitre(
      id: map['id'] as int,
      titre: map['titre'] as String,
      niveauV4: map['niveau_v4'] as String?,
    );
  }

  Chapitre copyWith({
    List<CarteMentale>? cartesMentales,
    List<Question>? questions,
  }) {
    return Chapitre(
      id: id,
      titre: titre,
      niveauV4: niveauV4,
      cartesMentales: cartesMentales ?? this.cartesMentales,
      questions: questions ?? this.questions,
    );
  }
}
