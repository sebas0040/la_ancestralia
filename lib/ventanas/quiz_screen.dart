import 'package:flutter/material.dart';
import '../data/vocabulary_data.dart';

// ============= QUIZ SCREEN =============
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  bool answered = false;
  int? selectedAnswer;

  List <Map<String, dynamic>> questions = [
    {
      'question': '¿Cuál es la traducción de "Alpa"?',
      'options': ['Agua', 'Tierra', 'Fuego', 'Aire'],
      'correct': 1,
    },
    {
      'question': '¿Cuál es la traducción de "Yaku"?',
      'options': ['Sol', 'Luna', 'Agua', 'Estrella'],
      'correct': 2,
    },
    {
      'question': '¿Cuál es la traducción de "Inti"?',
      'options': ['Sol', 'Luna', 'Estrella', 'Cielo'],
      'correct': 0,
    },
  ];

  void checkAnswer(int selected) {
    setState(() {
      answered = true;
      selectedAnswer = selected;
      if (selected == questions[currentQuestion]['correct']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
        answered = false;
        selectedAnswer = null;
      } else {
        currentQuestion = questions.length;
      }
    });
  }

  void restartQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      answered = false;
      selectedAnswer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (VocabularyData.words.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF8B4513),
          foregroundColor: Colors.white,
          title: const Text('Quiz'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.quiz_outlined,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 20),
                Text(
                  'Agrega palabras al vocabulario para comenzar el quiz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (currentQuestion >= questions.length) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF8B4513),
          foregroundColor: Colors.white,
          title: const Text('Resultados'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  score >= questions.length * 0.7
                      ? Icons.emoji_events
                      : Icons.thumb_up,
                  size: 100,
                  color: const Color(0xFF8B4513),
                ),
                const SizedBox(height: 30),
                Text(
                  '¡Quiz Completado!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B4513),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Puntuación: $score / ${questions.length}',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: restartQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B4513),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: const Text('Reintentar'),
                ),
                const SizedBox(height: 15),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: const Text('Volver al inicio'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B4513),
        foregroundColor: Colors.white,
        title: Text('Pregunta ${currentQuestion + 1}/${questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (currentQuestion + 1) / questions.length,
              backgroundColor: Colors.grey[300],
              color: const Color(0xFF8B4513),
              minHeight: 8,
            ),
            const SizedBox(height: 30),
            Text(
              'Puntos: $score',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B4513),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  questions[currentQuestion]['question'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ...List.generate(
              questions[currentQuestion]['options'].length,
              (index) {
                final isCorrect =
                    index == questions[currentQuestion]['correct'];
                final isSelected = index == selectedAnswer;
                Color? buttonColor;

                if (answered) {
                  if (isSelected) {
                    buttonColor = isCorrect ? Colors.green : Colors.red;
                  } else if (isCorrect) {
                    buttonColor = Colors.green;
                  }
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ElevatedButton(
                    onPressed: answered ? null : () => checkAnswer(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor ?? const Color(0xFFD2691E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      questions[currentQuestion]['options'][index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            if (answered)
              ElevatedButton(
                onPressed: nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B4513),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  currentQuestion < questions.length - 1
                      ? 'Siguiente'
                      : 'Ver Resultados',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}