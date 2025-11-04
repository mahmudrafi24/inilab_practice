# Implementation Plan

- [x] 1. Set up core architecture and configuration





  - Configure Dio client with base URL, timeouts, and headers for GitHub API in lib/services
  - Initialize GetStorage in main.dart before runApp
  - Create custom exception classes in lib/services/exceptions (NetworkException, NotFoundException, RateLimitException, ApiException)
  - _Requirements: 8.1, 8.2, 8.3, 8.4_

- [x] 2. Implement data models





  - Create GitHubUser model in lib/services/models with fromJson and toJson methods
  - Create Repository model in lib/services/models with fromJson and toJson methods
  - Create ViewMode enum (list, grid) in lib/services/models
  - Create SortOption enum (name, date, stars) in lib/services/models
  - _Requirements: 8.5_

- [x] 3. Implement GitHub API service layer





  - Create GitHubService class in lib/services with Dio dependency
  - Implement getUser(username) method with error handling
  - Implement getUserRepositories(username) method with error handling
  - Add proper exception mapping for different HTTP status codes (404, 403, 500+, timeout)
  - _Requirements: 1.4, 1.5, 3.1, 3.5, 8.1, 8.2, 8.3, 8.4, 8.5_

- [x] 4. Implement theme management





  - Create ThemeController with GetX in lib/app/app_theme
  - Implement light and dark ThemeData configurations in lib/app/app_theme/app_theme.dart
  - Add toggleTheme() method with GetStorage persistence
  - Add loadTheme() method to restore saved preference on app start
  - Create theme toggle widget component in lib/widgets
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5_

- [x] 5. Set up routing and navigation





  - Define AppRoutes constants in lib/app/app_route/app_route.dart (splash, auth, home, repositoryDetails)
  - Configure GetX pages with routes in main.dart using GetMaterialApp
  - Create bindings in lib/app/app_bindings for each screen (SplashBinding, AuthBinding, HomeBinding, RepositoryDetailsBinding)
  - Update main.dart to use GetMaterialApp with routes and initial binding
  - _Requirements: 7.4, 7.5_

- [x] 6. Implement reusable widgets





  - Implement AppButton widget in lib/widgets/app_button with loading state support
  - Implement AppTextField widget in lib/widgets/app_textfield with validation support
  - Implement AppText widget in lib/widgets/app_text for consistent typography
  - Complete AppColor class in lib/utils/app_color with light and dark theme colors
  - _Requirements: 1.1, 1.2, 2.3_

- [x] 7. Implement AuthScreen and controller





  - Create AuthController in lib/screen/auth_screen/controller with username validation logic
  - Implement validateAndNavigate() method that calls GitHubService.getUser()
  - Build AuthScreen UI with AppTextField for username input
  - Add AppButton for form submission with loading state
  - Integrate theme toggle widget in AppBar
  - Add error message display for validation and API errors
  - Implement navigation to HomeScreen on successful validation
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 2.1, 7.1, 7.2, 7.3_

- [x] 8. Implement HomeController with repository management





  - Create HomeController in lib/screen/home_screen/controller with repository list state
  - Implement fetchRepositories(username) method
  - Add loading and error state management
  - Implement sorting logic for name, date, and stars
  - Add view mode toggle functionality with GetStorage persistence
  - Implement loadViewMode() to restore saved preference
  - _Requirements: 3.1, 3.2, 3.3, 3.5, 4.2, 4.5, 5.2, 5.3, 5.4, 5.5, 7.1, 7.2, 7.3_

- [x] 9. Build HomeScreen UI with list view





  - Implement HomeScreen in lib/screen/home_screen with AppBar containing theme toggle and view mode toggle
  - Implement repository list view using ListView.builder
  - Create repository card widget in lib/widgets displaying name, description, language, and stars
  - Add pull-to-refresh functionality
  - Implement loading indicator during data fetch
  - Add empty state widget when no repositories exist
  - Add error state widget with retry button
  - _Requirements: 3.2, 3.3, 3.4, 3.5, 4.1, 4.3, 7.3_

- [x] 10. Implement grid view mode for repositories





  - Create grid layout using GridView.builder with 2 columns in HomeScreen
  - Design grid card widget with repository name, language, and stars
  - Implement view mode toggle button functionality
  - Add smooth transition between list and grid views
  - _Requirements: 4.1, 4.2, 4.4, 4.5_

- [x] 11. Implement filter and sort functionality





  - Create filter UI component (dropdown or bottom sheet) in lib/widgets
  - Add sort options: by name, by date, by stars
  - Implement visual indicator for current sort option
  - Connect filter UI to HomeController.setSortOption()
  - Add smooth animation when sort order changes
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_

- [x] 12. Implement RepositoryDetailsScreen and controller





  - Create RepositoryDetailsController in lib/screen/repository_details_screen/controller to receive repository data
  - Create RepositoryDetailsScreen in lib/screen/repository_details_screen
  - Build UI with repository header
  - Display repository name, description, and owner information
  - Create statistics section showing stars, forks, and watchers
  - Display language, creation date, and last update date
  - Show repository URL
  - Add back navigation button
  - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5, 7.1_
-

- [x] 13. Implement navigation from HomeScreen to RepositoryDetailsScreen




  - Add onTap handler to repository cards in list view
  - Add onTap handler to repository cards in grid view
  - Pass repository data to RepositoryDetailsScreen using Get.toNamed with arguments
  - Ensure back navigation returns to HomeScreen with preserved state
  - _Requirements: 6.1, 6.5, 7.4_
-

- [x] 14. Add image caching for avatars




  - Integrate cached_network_image package for user avatars in repository cards
  - Add placeholder widgets for loading states
  - Add error widgets for failed image loads
  - Implement caching for repository owner avatars in RepositoryDetailsScreen
  - _Requirements: 3.4, 6.2_
-

- [x] 15. Update SplashScreen to initialize app




  - Update SplashScreenController in lib/screen/splash_screen/controller to load theme preference
  - Add navigation logic to AuthScreen after 2-3 second delay
  - Ensure ThemeController is initialized before navigation
  - Update SplashScreen to use GetX controller
  - _Requirements: 2.5_





- [x] 16. Polish UI and add final touches






  - Ensure consistent spacing and padding across all screens
  - Verify theme colors are applied correctly in light and dark modes
  - Add appropriate icons for view mode toggle and theme toggle
  - Ensure all text uses proper typography from theme
  - Add loading animations and transitions
  - Test responsive layout on different screen sizes
  - _Requirements: 2.3, 4.2_

- [x] 17. Write unit tests for controllers







  - Write tests for ThemeController toggle and persistence
  - Write tests for AuthController username validation
  - Write tests for HomeController sorting algorithms
  - Write tests for view mode switching logic
  - _Requirements: 7.1, 7.2, 7.3_

- [x] 18. Write unit tests for services and models








  - Write tests for GitHubService with mocked Dio responses
  - Test successful API call scenarios
  - Test error scenarios (404, 403, timeout, 500+)
  - Write tests for GitHubUser and Repository JSON parsing
  - _Requirements: 8.4, 8.5_


- [x] 19. Write widget tests







  - Write widget tests for AuthScreen input validation
  - Write widget tests for HomeScreen list and grid rendering
  - Write widget tests for RepositoryDetailsScreen data display
  - Write tests for custom widgets (AppTextField, AppButton)
  - _Requirements: 1.1, 1.2, 1.3, 3.3, 3.4, 4.3, 4.4, 6.2, 6.3_
