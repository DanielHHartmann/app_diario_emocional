import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  void toggleTheme() {
    _themeMode.value = _themeMode.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    Get.changeThemeMode(_themeMode.value);
  }

  bool get isDarkMode => _themeMode.value == ThemeMode.dark;
}
