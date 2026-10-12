import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/quiz_controller.dart';
import 'theme/app_theme.dart';
import 'views/screens/home_screen.dart';
import 'views/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        home: const SplashScreen(),
      ),
    );
  }
}