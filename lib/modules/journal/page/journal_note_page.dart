import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diario_emocional/core/app_colors.dart';
import '../controller/journal_controller.dart';
import 'package:diario_emocional/data/emotion.dart';

class JournalNotePage extends StatelessWidget {
  const JournalNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JournalController>();
    final emotion = controller.selectedEmotion.value;
    final color = emotionColors[emotion]!;
    final label = emotionLabels[emotion]!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text('Por que você está $label?',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Descreva seu dia',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.noteController,
              maxLines: 8,
              maxLength: 1000,
              decoration: InputDecoration(
                hintText: 'Escreva aqui...',
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await controller.saveEntry();
                Get.back();
                Future.delayed(Duration.zero, () {
                  Get.offAllNamed('/');
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Salvar sentimento',
                style: TextStyle(fontSize: 18, color: AppColors.white),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
