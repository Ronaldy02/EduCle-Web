import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/quiz_controller.dart';
import 'services/supabase_service.dart';
import 'theme/app_theme.dart';
import 'views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialiser();
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