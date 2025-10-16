
// ============= DASHBOARD SCREEN (Versión Moderna) =============
import 'package:flutter/material.dart';
import 'add_word_screen.dart';
import 'vocabulary_screen.dart';
import 'quiz_screen.dart';
import 'about_screen.dart';
import 'welcome_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String userName;
  const DashboardScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final brown = const Color(0xFF8B4513);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8B4513),
              Color(0xFFD2B48C),
              Color(0xFFF5E6CA),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------- Encabezado moderno ----------
                const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: Icon(Icons.person, color: brown, size: 35),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        'Hola, $userName 👋',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Bienvenido a la plataforma Lengua Inga',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 35),

                // ---------- Tarjetas de opciones ----------
                _DashboardCard(
                  icon: Icons.add_circle_outline_rounded,
                  title: 'Agregar palabra',
                  description: 'Registra nuevas palabras en Inga',
                  color: const Color(0xFF8B4513),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddWordScreen()),
                    );
                  },
                ),
                const SizedBox(height: 15),

                _DashboardCard(
                  icon: Icons.book_outlined,
                  title: 'Ver vocabulario',
                  description: 'Explora tus palabras guardadas',
                  color: const Color(0xFFD2691E),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const VocabularyScreen()),
                    );
                  },
                ),
                const SizedBox(height: 15),

                _DashboardCard(
                  icon: Icons.extension_rounded,
                  title: 'Juegos / Quiz',
                  description: 'Pon a prueba tus conocimientos',
                  color: const Color(0xFFCD853F),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizScreen()),
                    );
                  },
                ),
                const SizedBox(height: 15),

                _DashboardCard(
                  icon: Icons.info_outline,
                  title: 'Acerca de',
                  description: 'Descubre más sobre la cultura Inga',
                  color: const Color(0xFFA0522D),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- Tarjeta de dashboard con animación ----------
class _DashboardCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  State<_DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<_DashboardCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      transform: _isHovered
          ? (Matrix4.identity()..scale(1.03))
          : Matrix4.identity(),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Card(
          elevation: _isHovered ? 10 : 5,
          shadowColor: widget.color.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(widget.icon, size: 40, color: widget.color),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: widget.color,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,
                      color: widget.color, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
