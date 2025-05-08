import 'package:diario_emocional/core/app_colors.dart';
import 'package:diario_emocional/data/emotion.dart';
import 'package:diario_emocional/modules/home/controller/home_controller.dart';
import 'package:diario_emocional/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JournalPageCard extends StatelessWidget {
  const JournalPageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      final hasEntry = homeController.hasEntryToday;
      final emotion = homeController.todayEmotion;

      final color =
          hasEntry
              ? emotionColors[emotion]!
              : isDark
              ? AppColors.green
              : AppColors.lightGreen;

      final label =
          hasEntry
              ? "Você está se sentindo ${emotionLabels[emotion]!}. Quer atualizar?"
              : "Como você está se sentindo?";

      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Get.toNamed(AppRoutes.journal),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
  }
}
