import 'package:diario_emocional/core/app_colors.dart';
import 'package:diario_emocional/services/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'router/app_routes.dart';
import 'router/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');
  Get.put(ThemeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Emotion Journal',
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: AppColors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.black,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: AppColors.black),
          ),
          fontFamily: 'Fredoka',
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.black,
            foregroundColor: AppColors.white,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: AppColors.white),
          ),
          fontFamily: 'Fredoka',
        ),
        themeMode: themeController.themeMode,
        initialRoute: AppRoutes.home,
        getPages: AppPages.routes,
      );
    });
  }
}

