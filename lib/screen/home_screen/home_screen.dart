import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/home_controller.dart';
import '../../app/app_theme/theme_controller.dart';
import '../../widgets/repository_card/repository_card.dart';
import '../../widgets/repository_grid_card/repository_grid_card.dart';
import '../../widgets/empty_state/empty_state.dart';
import '../../widgets/error_state/error_state.dart';
import '../../widgets/app_text/app_text.dart';
import '../../widgets/sort_filter/sort_filter.dart';
import '../../services/models/view_mode.dart';
import '../../services/models/sort_option.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = Get.find<HomeController>();
  final ThemeController _themeController = Get.find<ThemeController>();
  String? _username;

  @override
  void initState() {
    super.initState();
    // Get username from navigation arguments
    final args = Get.arguments as Map<String, dynamic>?;
    _username = args?['username'] as String?;

    // Fetch repositories on screen load
    if (_username != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.fetchRepositories(_username!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        title: AppText.titleLarge(
          _username ?? 'Repositories',
          color: theme.appBarTheme.foregroundColor,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: false,
        actions: [
          // Sort filter button
          Obx(() => IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.filter_list),
                    // Visual indicator for active sort
                    if (_controller.sortOption != SortOption.name)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.secondary
                                    .withValues(alpha: 0.5),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () {
                  SortFilter.show(
                    context,
                    currentOption: _controller.sortOption,
                    onOptionSelected: _controller.setSortOption,
                  );
                },
                tooltip: 'Sort repositories',
              )),

          // View mode toggle with animation
          Obx(() => IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: animation,
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Icon(
                    _controller.viewMode.name == 'list'
                        ? Icons.grid_view_rounded
                        : Icons.view_list_rounded,
                    key: ValueKey(_controller.viewMode.name),
                  ),
                ),
                onPressed: _controller.toggleViewMode,
                tooltip: _controller.viewMode.name == 'list'
                    ? 'Switch to grid view'
                    : 'Switch to list view',
              )),

          // Theme toggle with animation
          Obx(() => IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: Tween<double>(begin: 0.5, end: 1.0)
                          .animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Icon(
                    _themeController.isDarkMode
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    key: ValueKey(_themeController.isDarkMode),
                  ),
                ),
                onPressed: _themeController.toggleTheme,
                tooltip: _themeController.isDarkMode
                    ? 'Switch to light mode'
                    : 'Switch to dark mode',
              )),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        // Loading state with animation
        if (_controller.isLoading) {
          return Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.8 + (0.2 * value),
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppText.bodyMedium(
                    'Loading repositories...',
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ],
              ),
            ),
          );
        }

        // Error state
        if (_controller.errorMessage.isNotEmpty) {
          return ErrorState(
            message: _controller.errorMessage,
            onRetry: () {
              if (_username != null) {
                _controller.fetchRepositories(_username!);
              }
            },
          );
        }

        // Empty state
        if (_controller.repositories.isEmpty) {
          return const EmptyState(
            message: 'No repositories found',
            subtitle: 'This user doesn\'t have any public repositories yet.',
            icon: Icons.folder_open,
          );
        }

        // Repository list or grid
        return RefreshIndicator(
          onRefresh: () async {
            if (_username != null) {
              await _controller.fetchRepositories(_username!);
            }
          },
          color: theme.colorScheme.primary,
          backgroundColor: theme.scaffoldBackgroundColor,
          strokeWidth: 3,
          displacement: 40,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: _controller.viewMode == ViewMode.list
                ? _buildListView()
                : _buildGridView(),
          ),
        );
      }),
    );
  }

  /// Builds the list view for repositories
  Widget _buildListView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive padding for larger screens
        final horizontalPadding = constraints.maxWidth > 600 ? 24.0 : 0.0;

        return ListView.builder(
          key: const ValueKey('list_view'),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _controller.sortedRepositories.length,
          padding:
              EdgeInsets.symmetric(vertical: 8, horizontal: horizontalPadding),
          itemBuilder: (context, index) {
            final repository = _controller.sortedRepositories[index];

            // Staggered animation for list items
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration:
                  Duration(milliseconds: 300 + (index * 50).clamp(0, 500)),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: RepositoryCard(
                repository: repository,
                onTap: () {
                  _navigateToRepositoryDetails(repository);
                },
              ),
            );
          },
        );
      },
    );
  }

  /// Builds the grid view for repositories
  Widget _buildGridView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive grid columns based on screen width
        final crossAxisCount = constraints.maxWidth > 900
            ? 4
            : (constraints.maxWidth > 600 ? 3 : 2);
        final padding = constraints.maxWidth > 600 ? 24.0 : 16.0;

        return GridView.builder(
          key: const ValueKey('grid_view'),
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(padding),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.82,
          ),
          itemCount: _controller.sortedRepositories.length,
          itemBuilder: (context, index) {
            final repository = _controller.sortedRepositories[index];

            // Staggered animation for grid items
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration:
                  Duration(milliseconds: 300 + (index * 50).clamp(0, 500)),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.8 + (0.2 * value),
                    child: child,
                  ),
                );
              },
              child: RepositoryGridCard(
                repository: repository,
                onTap: () {
                  _navigateToRepositoryDetails(repository);
                },
              ),
            );
          },
        );
      },
    );
  }

  /// Navigate to repository details screen
  void _navigateToRepositoryDetails(repository) {
    Get.toNamed(
      '/repository-details',
      arguments: repository,
    );
  }
}
