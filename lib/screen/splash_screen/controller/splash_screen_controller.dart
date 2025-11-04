import 'package:get/get.dart';
import 'package:inilab_practice/app/app_route/app_route.dart';
import 'package:inilab_practice/app/app_theme/theme_controller.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  /// Initialize app by loading theme and navigating to AuthScreen
  Future<void> _initializeApp() async {
    // Ensure ThemeController is initialized and theme is loaded
    final themeController = Get.find<ThemeController>();
    themeController.loadTheme();

    // Wait for 2-3 seconds before navigating
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to AuthScreen
    Get.offNamed(AppRoute.auth);
  }
}
