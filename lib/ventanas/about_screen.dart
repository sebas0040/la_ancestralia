import 'package:flutter/material.dart';
// ============= ABOUT SCREEN =============
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B4513),
        foregroundColor: Colors.white,
        title: const Text('Acerca de'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.language,
                size: 80,
                color: Color(0xFF8B4513),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Plataforma de Lengua Inga',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B4513),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _SectionTitle('Descripción del Proyecto'),
            const Text(
              'Esta plataforma tiene como objetivo preservar y promover la lengua Inga, '
              'permitiendo a los jóvenes y la comunidad aprender, compartir y mantener viva '
              'esta importante lengua ancestral.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 25),
            _SectionTitle('Objetivos'),
            const Text(
              '• Facilitar el aprendizaje del idioma Inga\n'
              '• Preservar el vocabulario tradicional\n'
              '• Conectar a las nuevas generaciones con su herencia cultural\n'
              '• Crear una comunidad de aprendizaje colaborativo\n'
              '• Mantener viva la lengua ancestral',
              style: TextStyle(fontSize: 16, height: 1.8),
            ),
            const SizedBox(height: 25),
            _SectionTitle('Importancia'),
            const Text(
              'La lengua Inga es un tesoro cultural que representa la identidad, '
              'cosmovisión y sabiduría ancestral del pueblo Inga. Preservarla es '
              'fundamental para mantener viva nuestra cultura y transmitirla a las '
              'futuras generaciones.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            Card(
              color: Color(0xFF8B4513).withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Color(0xFF8B4513),
                      size: 40,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Gracias por ser parte de esta iniciativa',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B4513),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _SectionTitle('Contacto'),
            const Text(
              'Para más información sobre el proyecto, puedes contactarnos a través de '
              'los canales oficiales de la comunidad Inga.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8B4513),
        ),
      ),
    );
  }
}

