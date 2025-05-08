import 'package:diario_emocional/modules/home/controller/home_controller.dart';
import 'package:diario_emocional/services/database_service.dart'; // ← add this import
import 'package:diario_emocional/services/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Configurações',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          Obx(() => SwitchListTile(
            title: Text(themeController.isDarkMode
                ? 'Dark Mode'
                : 'Light Mode'),
            secondary: Icon(themeController.isDarkMode
                ? Icons.dark_mode
                : Icons.light_mode),
            value: themeController.isDarkMode,
            onChanged: (_) {
              themeController.toggleTheme();
            },
          )),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text('Apagar todos os dados'),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Confirme'),
                  content:
                  const Text('Tem certeza que quer apagar todas os dados?'),
                  actions: [
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () => Navigator.of(ctx).pop(false),
                    ),
                    TextButton(
                      child: const Text('Deletar'),
                      onPressed: () => Navigator.of(ctx).pop(true),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await DatabaseService().deleteAllEntries();

                final homeController = Get.find<HomeController>();
                homeController.weeklyEntries.clear();
                homeController.todayEntry.value = null;

                await homeController.loadWeeklyEntries();
                await homeController.loadTodayEntry();

                Get.snackbar('Dados Apagados', 'Todos dados apagados com sucesso!');
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
