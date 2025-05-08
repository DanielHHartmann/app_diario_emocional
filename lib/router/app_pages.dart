import 'package:diario_emocional/modules/history/binding/history_binding.dart';
import 'package:diario_emocional/modules/history/history_page.dart';
import 'package:diario_emocional/modules/home/binding/home_binding.dart';
import 'package:diario_emocional/modules/home/home_page.dart';
import 'package:diario_emocional/modules/journal/binding/journal_binding.dart';
import 'package:diario_emocional/modules/journal/journal_page.dart';
import 'package:diario_emocional/modules/journal/page/journal_note_page.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding()
    ),
    GetPage(
      name: AppRoutes.journal,
      page: () => const JournalPage(),
      binding: JournalBinding(),
    ),
    GetPage(
      name: AppRoutes.journalNote,
      page: () => const JournalNotePage(),
    ),
    GetPage(
      name: AppRoutes.history,
      page: () => const HistoryPage(
      ),
      binding: HistoryBinding()
    ),
  ];
}