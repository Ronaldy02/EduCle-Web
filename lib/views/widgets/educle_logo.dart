import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// Logo EduClé : clé dorée penchée suivie du nom, identique à l'en-tête
/// du site web pour garder une identité visuelle cohérente.
class EduCleLogo extends StatelessWidget {
  final double taille;
  final bool afficherTexte;

  const EduCleLogo({super.key, this.taille = 28, this.afficherTexte = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/logo/educle_cle_or.png',
          width: taille,
          height: taille,
          filterQuality: FilterQuality.medium,
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
