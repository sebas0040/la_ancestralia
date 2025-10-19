import 'package:flutter/material.dart';
import 'presentations/splash_screen.dart';
import 'presentations/welcome_screen.dart';
import 'presentations/login_screen.dart';

class AuthRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    welcome: (context) => const WelcomeScreen(),
    login: (context) => const LoginScreen(),
  };
}
