import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inilab_practice/app/app_theme/app_theme.dart';
import 'package:inilab_practice/app/app_theme/theme_controller.dart';
import 'package:inilab_practice/app/app_route/app_route.dart';
import 'package:inilab_practice/app/app_bindings/app_bindings.dart';
import 'package:inilab_practice/screen/splash_screen/splash_screen.dart';
import 'package:inilab_practice/screen/auth_screen/auth_screen.dart';
import 'package:inilab_practice/screen/home_screen/home_screen.dart';
import 'package:inilab_practice/screen/repository_details_screen/repository_details_screen.dart';
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

    return Obx(
      () => GetMaterialApp(
        
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
        getPages: [
          GetPage(
            name: AppRoute.splash,
            page: () => const SplashScreen(),
            binding: SplashBinding(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 300),
          ),
          GetPage(
            name: AppRoute.auth,
            page: () => const AuthScreen(),
            binding: AuthBinding(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 300),
          ),
          GetPage(
            name: AppRoute.home,
            page: () => const HomeScreen(),
            binding: HomeBinding(),
            transition: Transition.rightToLeft,
            transitionDuration: const Duration(milliseconds: 300),
          ),
          GetPage(
            name: AppRoute.repositoryDetails,
            page: () => const RepositoryDetailsScreen(),
            binding: RepositoryDetailsBinding(),
            transition: Transition.rightToLeft,
            transitionDuration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
