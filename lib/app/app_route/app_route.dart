import 'package:get/get.dart';

import '../../screen/auth_screen/auth_screen.dart';
import '../../screen/home_screen/home_screen.dart';
import '../../screen/repository_details_screen/repository_details_screen.dart';
import '../../screen/splash_screen/splash_screen.dart';
import '../app_bindings/app_bindings.dart';

class AppRoute {
  AppRoute._();

  static const String splash = '/';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String repositoryDetails = '/repository-details';

  static List<GetPage> appRoutes = [
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
  ];
}
