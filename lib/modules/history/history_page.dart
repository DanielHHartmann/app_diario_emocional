import 'package:diario_emocional/data/model/journal_entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:diario_emocional/data/emotion.dart';
import 'package:diario_emocional/modules/history/controller/history_controller.dart';
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());

    return Scaffold(
      appBar: AppBar(title: const Text("Histórico")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            // 👇 accessing `entriesMap.values` ensures reactivity
            final allEntries = controller.entriesMap.values.toList();

            return Column(
              children: [
                TableCalendar(
                  locale: 'pt_BR',
                  firstDay: DateTime.utc(2023, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: DateTime.now(),
                  calendarFormat: CalendarFormat.month,
                  selectedDayPredicate: (day) {
                    final selected = controller.selectedEntry.value?.timestamp.toLocal();
                    return selected != null &&
                        selected.year == day.year &&
                        selected.month == day.month &&
                        selected.day == day.day;
                  },
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Mês',
                  },
                  onDaySelected: controller.onDaySelected,
                  eventLoader: (date) {
                    final dateKey = DateTime(date.year, date.month, date.day);
                    final entry = controller.entriesMap[dateKey];
                    return entry != null ? [entry] : [];
                  },
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, date, _) =>
                        _buildEmotionDayCell(context, date, controller),

                    todayBuilder: (context, date, _) =>
                        _buildEmotionDayCell(context, date, controller),

                    selectedBuilder: (context, date, _) =>
                        _buildEmotionDayCell(context, date, controller),
                  ),



                ),
                const SizedBox(height: 24),
                Obx(() {
                  final entry = controller.selectedEntry.value;
                  if (entry == null) {
                    return const Text("Selecione um dia.");
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Se sentiu: ${emotionLabels[entry.emotion]}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        entry.note,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                }),
              ],
            );
          }),
        ),
      ),
    );
  }
  void _showDeleteDialog(BuildContext context, HistoryController controller, DateTime dateKey) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir entrada'),
        content: const Text('Tem certeza que deseja excluir esta entrada?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await controller.deleteEntryForDate(dateKey);
              Navigator.pop(context);
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget? _buildEmotionDayCell(
      BuildContext context,
      DateTime date,
      HistoryController controller,
      ) {
    final dateKey = DateTime(date.year, date.month, date.day);
    final entry = controller.entriesMap[dateKey];
    if (entry == null) return null;

    final color = emotionColors[entry.emotion]!.withOpacity(0.3);

    return GestureDetector(
      onLongPress: () => _showDeleteDialog(context, controller, dateKey),
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        alignment: Alignment.center,
        child: Text(
          '${date.day}',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium!.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


}


