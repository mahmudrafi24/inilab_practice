import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../services/github_service.dart';
import '../../../services/models/repository.dart';
import '../../../services/models/view_mode.dart';
import '../../../services/models/sort_option.dart';
import '../../../services/exceptions/exceptions.dart';

class HomeController extends GetxController {
  final GitHubService _gitHubService;
  final GetStorage _storage = GetStorage();

  HomeController(this._gitHubService);

  // Observable state
  final _repositories = <Repository>[].obs;
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _viewMode = ViewMode.list.obs;
  final _sortOption = SortOption.name.obs;

  // Getters
  List<Repository> get repositories => _repositories;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  ViewMode get viewMode => _viewMode.value;
  SortOption get sortOption => _sortOption.value;

  /// Returns sorted repositories based on current sort option
  List<Repository> get sortedRepositories {
    // Access the observable to trigger reactivity
    final currentSort = _sortOption.value;
    final repos = List<Repository>.from(_repositories);

    switch (currentSort) {
      case SortOption.name:
        repos.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case SortOption.date:
        repos
            .sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Newest first
        break;
      case SortOption.stars:
        repos.sort((a, b) =>
            b.stargazersCount.compareTo(a.stargazersCount)); // Highest first
        break;
    }

    return repos;
  }

  @override
  void onInit() {
    super.onInit();
    loadViewMode();
  }

  /// Fetches repositories for a given username
  Future<void> fetchRepositories(String username) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final repos = await _gitHubService.getUserRepositories(username);
      _repositories.value = repos;
    } on NotFoundException {
      _errorMessage.value = 'User not found. Please check the username.';
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

  /// Toggles between list and grid view modes
  void toggleViewMode() {
    _viewMode.value =
        _viewMode.value == ViewMode.list ? ViewMode.grid : ViewMode.list;
    saveViewMode();
  }

  /// Sets the sort option for repositories
  void setSortOption(SortOption option) {
    _sortOption.value = option;
    // Force refresh of sortedRepositories by triggering observable update
    _repositories.refresh();
  }

  /// Loads the saved view mode preference from storage
  void loadViewMode() {
    final savedMode = _storage.read<String>('view_mode');
    if (savedMode != null) {
      _viewMode.value = savedMode == 'grid' ? ViewMode.grid : ViewMode.list;
    }
  }

  /// Saves the current view mode preference to storage
  void saveViewMode() {
    final modeString = _viewMode.value == ViewMode.list ? 'list' : 'grid';
    _storage.write('view_mode', modeString);
  }
}
