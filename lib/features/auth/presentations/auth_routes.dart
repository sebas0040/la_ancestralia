import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/welcome_screen.dart';
import 'pages/login_screen.dart';

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
