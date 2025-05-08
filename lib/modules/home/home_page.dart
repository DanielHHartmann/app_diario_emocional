import 'package:diario_emocional/modules/common_widgets/app_drawer.dart';
import 'package:diario_emocional/modules/common_widgets/custom_app_bar.dart';
import 'package:diario_emocional/modules/home/controller/home_controller.dart';
import 'package:diario_emocional/modules/home/widgets/day_phrase_card.dart';
import 'package:diario_emocional/modules/home/widgets/journal_page_card.dart';
import 'package:diario_emocional/modules/home/widgets/weekly_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Diário Emocional'),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Bem vindo ao seu diário.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 40),
                const JournalPageCard(),
                const SizedBox(height: 40),
                const WeeklySummaryCard(),
                const SizedBox(height: 40),
                const DayPhraseCard(),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
