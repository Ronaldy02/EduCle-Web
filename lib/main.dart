import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/quiz_controller.dart';
import 'services/database_helper.dart';
import 'theme/app_theme.dart';
import 'views/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Pré-charger le JSON dans un isolate pour ne pas bloquer l'UI au 1er lancement
  await DatabaseHelper.preloadJsonData();
  runApp(const QuizEducatifApp());
}

class QuizEducatifApp extends StatelessWidget {
  const QuizEducatifApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizController(),
      child: MaterialApp(
        title: 'EduClé',
        debugShowCheckedModeBanner: false,
        theme: buildEduCleTheme(),
        home: const HomeScreen(),
      ),
    );
  }
}