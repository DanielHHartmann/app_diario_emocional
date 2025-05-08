import 'package:diario_emocional/data/emotion.dart';
import 'package:diario_emocional/data/model/journal_entry.dart';
import 'package:diario_emocional/modules/home/controller/home_controller.dart';
import 'package:diario_emocional/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeeklySummaryCard extends StatelessWidget {
  const WeeklySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      builder: (controller) {
        final now = DateTime.now();
        final yesterday = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));
        final days = List.generate(7, (index) => yesterday.subtract(Duration(days: 6 - index)));

        Map<String, JournalEntry?> dailyEntries = {
          for (var date in days)
            _dateKey(date): controller.weeklyEntries.firstWhereOrNull(
                  (entry) =>
              entry.timestamp.day == date.day &&
                  entry.timestamp.month == date.month &&
                  entry.timestamp.year == date.year,
            ),
        };

        return GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.history),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(13),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Emoções da Semana',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: days.map((day) {
                    final entry = dailyEntries[_dateKey(day)];
                    final color = entry != null
                        ? emotionColors[entry.emotion] ?? Colors.grey
                        : Colors.grey.withAlpha(50);

                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: color,
                          child: Icon(
                            entry != null ? emotionIcons[entry.emotion] : Icons.remove,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),

                        const SizedBox(height: 6),
                        Text(
                          _shortDayName(day.weekday),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Ver histórico',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _shortDayName(int weekday) {
    const names = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
    return names[(weekday - 1) % 7];
  }

  String _dateKey(DateTime date) =>
      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}
