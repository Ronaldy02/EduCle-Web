import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// Logo EduClé (clé-livre blanche sur carré bleu ciel, créé sur Canva),
/// identique à celui du site web pour garder une identité visuelle cohérente.
class EduCleLogo extends StatelessWidget {
  final double taille;
  final bool afficherTexte;

  /// Bleu ciel du logo Canva.
  static const Color bleuLogo = Color(0xFF06A1F1);

  const EduCleLogo({super.key, this.taille = 28, this.afficherTexte = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: taille,
          height: taille,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bleuLogo,
            borderRadius: BorderRadius.circular(taille * 0.28),
          ),
          child: Image.asset(
            'assets/logo/educle_cle_blanc.png',
            height: taille * 0.72,
            filterQuality: FilterQuality.medium,
          ),
        ),
        if (afficherTexte) ...[
          const SizedBox(width: 8),
          Text(
            'EduClé',
            style: TextStyle(
              fontSize: taille * 0.6,
              fontWeight: FontWeight.w800,
              color: EduCleColors.textPrimary,
            ),
          ),
        ],
      ],
    );
  }
}
