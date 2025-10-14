# laancestralia

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# 📱 Estructura base para proyecto Flutter

Este documento describe la **arquitectura y organización de carpetas** usada en el proyecto Flutter.  
El objetivo es mantener un código limpio, escalable y fácil de mantener, especialmente en proyectos que integran **Firebase**, **API REST** y **múltiples módulos (features)**.

---

## 🧱 Estructura general

```
lib/
├── main.dart
├── core/
│   ├── constants/
│   ├── utils/
│   ├── theme/
│   └── widgets/
│
├── services/
│   ├── firebase/
│   ├── api/
│   ├── local_storage/
│   └── notification/
│
└── features/
    ├── auth/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    ├── home/
    └── profile/
```

---

## ⚙️ main.dart

**Archivo principal del proyecto.**  
Inicializa Firebase, define el tema global y establece el punto de entrada de la aplicación (`MyApp`).

Ejemplo:
```dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: AppTheme.lightTheme,
      home: LoginPage(),
    );
  }
}
```

---

## 🧩 core/

Contiene **recursos reutilizables y globales** que pueden ser usados por cualquier módulo del proyecto.

### 📘 constants/
Constantes globales:
- Rutas (`AppRoutes`)
- URLs de API (`ApiConstants`)
- Colores (`AppColors`)
- Textos fijos (`AppStrings`)

Ejemplo:
```dart
class ApiConstants {
  static const String baseUrl = 'https://api.miapp.com';
  static const String usersEndpoint = '/users';
}
```

### 🧰 utils/
Funciones o clases de utilidad:
- Validadores.
- Formateadores.
- Conversores.

Ejemplo:
```dart
class Validators {
  static String? validateEmail(String? value) {
    if (value == null || !value.contains('@')) {
      return 'Correo inválido';
    }
    return null;
  }
}
```

### 🎨 theme/
Configuración visual global del proyecto:
- Colores base.
- Estilos de texto.
- Temas claro/oscuro.

Ejemplo:
```dart
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: Colors.white,
  );
}
```

### 🧱 widgets/
Widgets reutilizables que pueden usarse en distintas pantallas:
- Botones personalizados.
- Campos de texto.
- Loaders.

Ejemplo:
```dart
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label),
    );
  }
}
```

---

## 🔌 services/

Contiene los **servicios globales** del proyecto:  
Firebase, API REST, almacenamiento local y notificaciones.

### 🔥 firebase/
Manejo de autenticación, base de datos y almacenamiento con Firebase.

Ejemplo:
```dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }
}
```

### 🌐 api/
Conexión con API REST usando `http` o `dio`.

Ejemplo:
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/constants/api_constants.dart';

class ApiService {
  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint));
    return json.decode(response.body);
  }
}
```

### 💾 local_storage/
Manejo de almacenamiento local usando `SharedPreferences`, `Hive` o `SecureStorage`.

Ejemplo:
```dart
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
```

### 🔔 notification/
Configuración y envío de notificaciones:
- Firebase Cloud Messaging (FCM)
- Notificaciones locales (`flutter_local_notifications`)

---

## 🧠 features/

Cada **módulo o funcionalidad** de la aplicación tiene su propia carpeta.  
Esto mantiene la app escalable y modular.

Ejemplo de módulos:
- `auth` → autenticación
- `home` → pantalla principal
- `profile` → perfil del usuario

### 📍 Estructura de un feature
```
auth/
├── data/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   └── usecases/
└── presentation/
    ├── pages/
    ├── providers/
    └── widgets/
```

#### data/
Contiene modelos y fuentes de datos (Firebase, API).

#### domain/
Lógica de negocio pura (entidades y casos de uso).

#### presentation/
Interfaz de usuario, controladores y widgets específicos del módulo.

---

## ✅ Buenas prácticas

- Separa la **lógica de negocio** de la **UI**.
- Centraliza los **temas, rutas y constantes**.
- No accedas directamente a Firebase o API desde los widgets.
- Usa un **State Management** (Provider, Riverpod o Bloc).
- Reutiliza componentes desde `core/widgets` y funciones desde `core/utils`.

---

## 🧠 Créditos y uso

Estructura recomendada por [Rafa & ChatGPT] — ideal para proyectos Flutter con:
- Autenticación Firebase.
- Consumo de APIs externas.
- Escalabilidad modular.

📘 **Licencia:** Uso libre para proyectos personales o académicos.

