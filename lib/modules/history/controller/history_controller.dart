import 'package:diario_emocional/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:diario_emocional/data/model/journal_entry.dart';
import 'package:diario_emocional/services/database_service.dart';

class HistoryController extends GetxController {
  final entriesMap = <DateTime, JournalEntry>{}.obs;
  final selectedEntry = Rxn<JournalEntry>();

  @override
  void onInit() {
    super.onInit();
    _loadAndSelectToday();
  }

  Future<void> _loadAndSelectToday() async {
    await loadAllEntries();
    final today = DateTime.now();
    final dateKey = DateTime(today.year, today.month, today.day);
    selectedEntry.value = entriesMap[dateKey];
  }

  Future<void> loadAllEntries() async {
    final db = DatabaseService();
    final entries = await db.getAllEntries();
    for (var entry in entries) {
      final date = DateTime(entry.timestamp.year, entry.timestamp.month, entry.timestamp.day);
      entriesMap[date] = entry;
    }
  }

  void onDaySelected(DateTime day, DateTime focusedDay) {
    final dateKey = DateTime(day.year, day.month, day.day);
    selectedEntry.value = entriesMap[dateKey];
  }

  Future<void> deleteEntryForDate(DateTime date) async {
    final dbInstance = DatabaseService();
    final entry = entriesMap[date];
    if (entry != null) {
      await dbInstance.deleteEntry(entry.id!);
      entriesMap.remove(date);
      if (selectedEntry.value?.id == entry.id) {
        selectedEntry.value = null;
      }
    }
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().loadTodayEntry();
      Get.find<HomeController>().loadWeeklyEntries();
    }
  }
}
