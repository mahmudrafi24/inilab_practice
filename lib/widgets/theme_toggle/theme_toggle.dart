import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilab_practice/app/app_theme/theme_controller.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => IconButton(
        icon: Icon(
          themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        ),
        onPressed: () {
          themeController.toggleTheme();
        },
        tooltip: themeController.isDarkMode
            ? 'Switch to Light Mode'
            : 'Switch to Dark Mode',
      ),
    );
  }
}
