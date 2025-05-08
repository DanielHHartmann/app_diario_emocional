import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/emotion.dart';
import '../controller/journal_controller.dart';

class EmotionPicker extends StatelessWidget {
  const EmotionPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JournalController>();

    return Obx(() {
      final emotion = controller.selectedEmotion.value;
      final color = emotionColors[emotion]!;
      final icon = emotionIcons[emotion]!;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 160, color: color),
          const SizedBox(height: 24),
          ToggleButtons(
            borderRadius: BorderRadius.circular(12),
            isSelected:
            Emotion.values.map((e) => e == emotion).toList(),
            onPressed: (index) {
              controller.selectEmotion(Emotion.values[index]);
            },
            selectedColor: Colors.white,
            fillColor: color,
            children: Emotion.values.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  emotionLabels[e]!,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
