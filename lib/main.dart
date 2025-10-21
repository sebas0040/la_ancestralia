import 'package:flutter/material.dart';
import 'services/data/vocabulary_data.dart';
import 'features/auth/presentations/auth_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await VocabularyData.loadWords();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plataforma Lengua Inga',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B4513),
          primary: const Color(0xFF8B4513),
          secondary: const Color(0xFFD2691E),
        ),
        useMaterial3: true,
      ),
      initialRoute: AuthRoutes.splash,
      routes: AuthRoutes.routes,
    );
  }
}
