

// ============= VOCABULARY DATA CON PERSISTENCIA =============
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VocabularyData {
  static List<Map<String, String>> words = [];

  static Future<void> loadWords() async {
    final prefs = await SharedPreferences.getInstance();
    final String? wordsJson = prefs.getString('vocabulary_words');
    
    if (wordsJson != null) {
      final List<dynamic> decoded = jsonDecode(wordsJson);
      words = decoded.map((e) => Map<String, String>.from(e)).toList();
    } else {
      // Palabras iniciales por defecto
      words = [
        {'inga': 'Alpa', 'spanish': 'Tierra'},
        {'inga': 'Yaku', 'spanish': 'Agua'},
        {'inga': 'Inti', 'spanish': 'Sol'},
        {'inga': 'Killa', 'spanish': 'Luna'},
        {'inga': 'Allpa mama', 'spanish': 'Madre tierra'},
      ];
      await saveWords();
    }
  }

  static Future<void> saveWords() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(words);
    await prefs.setString('vocabulary_words', encoded);
  }

  static Future<void> addWord(String inga, String spanish) async {
    words.add({'inga': inga, 'spanish': spanish});
    await saveWords();
  }

  static Future<void> updateWord(int index, String inga, String spanish) async {
    if (index >= 0 && index < words.length) {
      words[index] = {'inga': inga, 'spanish': spanish};
      await saveWords();
    }
  }

  static Future<void> deleteWord(int index) async {
    if (index >= 0 && index < words.length) {
      words.removeAt(index);
      await saveWords();
    }
  }
}