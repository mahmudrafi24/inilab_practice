import 'package:get/get.dart';
import 'package:inilab_practice/services/github_service.dart';
import 'package:inilab_practice/services/exceptions/exceptions.dart';
import 'package:inilab_practice/app/app_route/app_route.dart';

class AuthController extends GetxController {
  final GitHubService _gitHubService;

  AuthController(this._gitHubService);

  final _username = ''.obs;
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;

  String get username => _username.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  /// Validates username input
  /// Returns error message if invalid, null if valid
  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a GitHub username';
    }
    return null;
  }

  /// Validates the username and navigates to HomeScreen if successful
  Future<void> validateAndNavigate(String username) async {
    // Clear previous error
    _errorMessage.value = '';

    // Validate input
    final validationError = validateUsername(username);
    if (validationError != null) {
      _errorMessage.value = validationError;
      return;
    }

    // Set loading state
    _isLoading.value = true;

    try {
      // Call GitHub API to validate user exists
      await _gitHubService.getUser(username.trim());

      // If successful, navigate to HomeScreen
      Get.offNamed(AppRoute.home, arguments: {'username': username.trim()});
    } on NotFoundException {
      _errorMessage.value =
          'User \'$username\' not found. Please check the username.';
    } on RateLimitException catch (e) {
      _errorMessage.value = e.message;
    } on NetworkException catch (e) {
      _errorMessage.value = e.message;
    } on ApiException catch (e) {
      _errorMessage.value = e.message;
    } catch (e) {
      _errorMessage.value = 'An unexpected error occurred. Please try again.';
    } finally {
      _isLoading.value = false;
    }
  }

  /// Updates the username value
  void setUsername(String value) {
    _username.value = value;
    // Clear error when user starts typing
    if (_errorMessage.value.isNotEmpty) {
      _errorMessage.value = '';
    }
  }
}
