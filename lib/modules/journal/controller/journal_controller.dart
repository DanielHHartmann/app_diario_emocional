import 'package:diario_emocional/data/model/journal_entry.dart';
import 'package:diario_emocional/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:diario_emocional/data/emotion.dart';

class JournalController extends GetxController {
  final Rx<Emotion> selectedEmotion = Emotion.good.obs;
  final TextEditingController noteController = TextEditingController();

  late final String formattedDate;
  late final String formattedTime;

  void selectEmotion(Emotion emotion) {
    selectedEmotion.value = emotion;
  }

  Future<void> saveEntry() async {
    final db = DatabaseService();
    final existingEntry = await db.getTodayEntry();

    final entry = JournalEntry(
      id: existingEntry?.id,
      emotion: selectedEmotion.value,
      note: noteController.text.trim(),
      timestamp: DateTime.now(),
    );

    if (existingEntry != null) {
      await db.updateEntry(entry);
    } else {
      await db.insertEntry(entry);
    }
  }
  @override
  void onInit() async {
    final now = DateTime.now();
    formattedDate = DateFormat('EEE, d MMM', 'pt_BR').format(now);
    formattedTime = DateFormat('HH:mm', 'pt_BR').format(now);

    final existingEntry = await DatabaseService().getTodayEntry();
    if (existingEntry != null) {
      selectedEmotion.value = existingEntry.emotion;
      noteController.text = existingEntry.note;
    }

    super.onInit();
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
