import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class DayPhraseCard extends StatelessWidget {
  const DayPhraseCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final hasEntry = controller.hasEntryToday;
      final phrase = controller.phrase.value;

      final text = hasEntry
          ? (phrase.isEmpty ? 'Gerando sua frase...' : phrase)
          : 'Faça o registro de hoje para desbloquear sua frase!';


      final isRegeneratable = hasEntry && phrase.isNotEmpty;

      return GestureDetector(
        onTap: isRegeneratable ? () => controller.generatePhrase() : null,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }
}
