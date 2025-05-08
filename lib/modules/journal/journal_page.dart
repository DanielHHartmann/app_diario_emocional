import 'package:diario_emocional/modules/journal/controller/journal_controller.dart';
import 'package:diario_emocional/modules/journal/widgets/emotion_picker.dart';
import 'package:diario_emocional/core/app_colors.dart';
import 'package:diario_emocional/data/emotion.dart';
import 'package:diario_emocional/router/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JournalController>();


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.delete<JournalController>();
            Get.back();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today, size: 16),
            const SizedBox(width: 4),
            Text(controller.formattedDate),
            const SizedBox(width: 16),
            const Icon(Icons.access_time, size: 16),
            const SizedBox(width: 4),
            Text(controller.formattedTime),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Como você está se sentindo hoje?',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // ⬇ Centered icon + toggle
            Expanded(
              child: const Center(
                child: EmotionPicker(),
              ),
            ),

            // ⬇ Bottom button
            Obx(() {
              final emotion = controller.selectedEmotion.value;
              final color = emotionColors[emotion]!;
              final label = emotionLabels[emotion]!.toLowerCase();

              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.journalNote);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Estou me sentindo $label",
                    style: const TextStyle(fontSize: 18, color: AppColors.white),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
