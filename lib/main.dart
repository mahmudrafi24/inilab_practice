import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inilab_practice/app/app_theme/app_theme.dart';
import 'package:inilab_practice/app/app_theme/theme_controller.dart';
import 'package:inilab_practice/app/app_route/app_route.dart';
import 'package:inilab_practice/app/app_bindings/app_bindings.dart';
import 'package:inilab_practice/utils/app_size/app_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // Initialize ThemeController
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return GetMaterialApp(
      title: 'GitHub Repo Viewer',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.themeMode,
      initialRoute: AppRoute.splash,
      initialBinding: SplashBinding(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        AppSize.init(context);
        return child ?? const SizedBox.shrink();
      },
      getPages: AppRoute.appRoutes,
    );
  }
}
