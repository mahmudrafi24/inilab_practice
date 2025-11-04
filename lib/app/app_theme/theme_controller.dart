import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final _isDarkMode = false.obs;

  static const String _themeKey = 'theme_mode';

  bool get isDarkMode => _isDarkMode.value;
  ThemeMode get themeMode =>
      _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  /// Toggle between light and dark theme with smooth transition
  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    saveTheme();
    // Smooth theme transition
    Get.changeThemeMode(themeMode);
  }

  /// Load saved theme preference from storage
  void loadTheme() {
    final savedTheme = _storage.read<String>(_themeKey);
    if (savedTheme != null) {
      _isDarkMode.value = savedTheme == 'dark';
    }
  }

  /// Save current theme preference to storage
  void saveTheme() {
    _storage.write(_themeKey, _isDarkMode.value ? 'dark' : 'light');
  }
}
