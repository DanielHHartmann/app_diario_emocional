import 'dart:developer';

import 'package:diario_emocional/data/emotion.dart';
import 'package:diario_emocional/services/database_service.dart';
import 'package:diario_emocional/services/gemini_service.dart';
import 'package:get/get.dart';
import 'package:diario_emocional/data/model/journal_entry.dart';

class HomeController extends GetxController {
  final Rxn<JournalEntry> todayEntry = Rxn<JournalEntry>();
  final RxString phrase = ''.obs;
  final RxList<JournalEntry> weeklyEntries = <JournalEntry>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTodayEntry();
    loadWeeklyEntries();
  }
  Future<void> loadWeeklyEntries() async {
    final entries = await DatabaseService().getEntriesForLast7Days();
    weeklyEntries.assignAll(entries);
    log(entries.toString());

  }
  Future<void> loadTodayEntry() async {
    final entry = await DatabaseService().getTodayEntry();
    if (entry != null) {
      todayEntry.value = entry;
      await generatePhrase();
    }
  }



  bool get hasEntryToday => todayEntry.value != null;

  Emotion? get todayEmotion => todayEntry.value?.emotion;

  Future<void> generatePhrase() async {
    phrase.value = '';
    final entry = todayEntry.value;
    if (entry == null) return;

    final prompt = '''
      Você é um companheiro encorajador de diário emocional. Responda com uma frase motivacional para este usuário.
      
      Humor: ${emotionLabels[entry.emotion]}
      Anotação: "${entry.note}"
    ''';
    final gemini = GeminiService();
    phrase.value = await gemini.getPhrase(prompt);
  }


}