import 'package:get/get.dart';
import 'package:inilab_practice/screen/splash_screen/controller/splash_screen_controller.dart';
import 'package:inilab_practice/screen/auth_screen/controller/auth_controller.dart';
import 'package:inilab_practice/screen/home_screen/controller/home_controller.dart';
import 'package:inilab_practice/screen/repository_details_screen/controller/repository_details_controller.dart';
import 'package:inilab_practice/services/github_service.dart';
import 'package:inilab_practice/services/dio_client.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize GitHubService if not already initialized
    if (!Get.isRegistered<GitHubService>()) {
      Get.lazyPut<GitHubService>(() => GitHubService(DioClient.createDio()));
    }

    // Initialize AuthController
    Get.lazyPut<AuthController>(
        () => AuthController(Get.find<GitHubService>()));
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize GitHubService if not already initialized
    if (!Get.isRegistered<GitHubService>()) {
      Get.lazyPut<GitHubService>(() => GitHubService(DioClient.createDio()));
    }

    // Initialize HomeController
    Get.lazyPut<HomeController>(
        () => HomeController(Get.find<GitHubService>()));
  }
}

class RepositoryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RepositoryDetailsController>(
        () => RepositoryDetailsController());
  }
}
