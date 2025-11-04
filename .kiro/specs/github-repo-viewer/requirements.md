# Requirements Document

## Introduction

This document specifies the requirements for a GitHub Repository Viewer application built with Flutter. The application enables users to search for GitHub users, view their repositories in multiple layouts, filter and sort repositories, and view detailed repository information. The application uses GetX for state management, Dio for API communication, and supports theme switching between light and dark modes.

## Glossary

- **GitHub_Repo_Viewer**: The Flutter application system that retrieves and displays GitHub repository information
- **Auth_Screen**: The initial screen where users input a GitHub username
- **Home_Screen**: The screen displaying the list of repositories for a given user
- **Repository_Details_Screen**: The screen showing detailed information about a selected repository
- **Theme_Controller**: The component managing light and dark theme switching
- **Repository_Service**: The service layer handling GitHub API communication using Dio
- **List_View_Mode**: A vertical list display format for repositories
- **Grid_View_Mode**: A grid-based display format for repositories
- **Filter_Options**: Sorting criteria including date, name, and stars
- **GitHub_API**: The external REST API at api.github.com providing user and repository data

## Requirements

### Requirement 1

**User Story:** As a user, I want to enter a GitHub username on the first screen, so that I can view that user's repositories

#### Acceptance Criteria

1. THE GitHub_Repo_Viewer SHALL display an Auth_Screen with a text input field for username entry
2. WHEN the user enters a valid username AND taps the submit button, THE GitHub_Repo_Viewer SHALL navigate to the Home_Screen
3. WHEN the user submits an empty username, THE GitHub_Repo_Viewer SHALL display a validation error message
4. THE GitHub_Repo_Viewer SHALL send a GET request to "https://api.github.com/users/{userName}" to validate the username
5. IF the GitHub_API returns a 404 error, THEN THE GitHub_Repo_Viewer SHALL display an error message indicating the user does not exist

### Requirement 2

**User Story:** As a user, I want to toggle between light and dark themes, so that I can use the app comfortably in different lighting conditions

#### Acceptance Criteria

1. THE GitHub_Repo_Viewer SHALL provide a theme toggle control accessible from the Auth_Screen
2. THE GitHub_Repo_Viewer SHALL provide a theme toggle control accessible from the Home_Screen
3. WHEN the user activates the theme toggle, THE GitHub_Repo_Viewer SHALL switch between light mode and dark mode within 300 milliseconds
4. THE GitHub_Repo_Viewer SHALL persist the selected theme preference using local storage
5. WHEN the application launches, THE GitHub_Repo_Viewer SHALL apply the previously selected theme preference

### Requirement 3

**User Story:** As a user, I want to view all repositories for a GitHub user on the home screen, so that I can browse their projects

#### Acceptance Criteria

1. WHEN the Home_Screen loads, THE GitHub_Repo_Viewer SHALL send a GET request to "https://api.github.com/users/{userName}/repos"
2. THE GitHub_Repo_Viewer SHALL display a loading indicator WHILE fetching repository data from the GitHub_API
3. WHEN the GitHub_API returns repository data, THE GitHub_Repo_Viewer SHALL display all repositories in the current view mode
4. THE GitHub_Repo_Viewer SHALL display repository name, description, star count, and programming language for each repository
5. IF the GitHub_API returns an error, THEN THE GitHub_Repo_Viewer SHALL display an error message with a retry option

### Requirement 4

**User Story:** As a user, I want to switch between list view and grid view for repositories, so that I can choose my preferred browsing layout

#### Acceptance Criteria

1. THE GitHub_Repo_Viewer SHALL provide a view mode toggle button on the Home_Screen
2. WHEN the user taps the view mode toggle, THE GitHub_Repo_Viewer SHALL switch between List_View_Mode and Grid_View_Mode
3. THE GitHub_Repo_Viewer SHALL display repositories in a vertical list format WHILE in List_View_Mode
4. THE GitHub_Repo_Viewer SHALL display repositories in a grid format with 2 columns WHILE in Grid_View_Mode
5. THE GitHub_Repo_Viewer SHALL persist the selected view mode preference using local storage

### Requirement 5

**User Story:** As a user, I want to filter and sort repositories by different criteria, so that I can find specific repositories more easily

#### Acceptance Criteria

1. THE GitHub_Repo_Viewer SHALL provide filter controls on the Home_Screen with options for date, name, and stars
2. WHEN the user selects "sort by name", THE GitHub_Repo_Viewer SHALL display repositories in alphabetical order by repository name
3. WHEN the user selects "sort by date", THE GitHub_Repo_Viewer SHALL display repositories ordered by creation date with newest first
4. WHEN the user selects "sort by stars", THE GitHub_Repo_Viewer SHALL display repositories ordered by star count with highest first
5. THE GitHub_Repo_Viewer SHALL apply the selected sort order to repositories within 100 milliseconds of selection

### Requirement 6

**User Story:** As a user, I want to tap on a repository to view its detailed information, so that I can learn more about the project

#### Acceptance Criteria

1. WHEN the user taps on a repository item, THE GitHub_Repo_Viewer SHALL navigate to the Repository_Details_Screen
2. THE GitHub_Repo_Viewer SHALL display repository name, description, owner information, star count, fork count, watchers count, and primary language on the Repository_Details_Screen
3. THE GitHub_Repo_Viewer SHALL display the repository creation date and last update date on the Repository_Details_Screen
4. THE GitHub_Repo_Viewer SHALL display the repository URL on the Repository_Details_Screen
5. THE GitHub_Repo_Viewer SHALL provide a back navigation button to return to the Home_Screen

### Requirement 7

**User Story:** As a developer, I want the application to use GetX for state management, so that the codebase follows reactive programming patterns

#### Acceptance Criteria

1. THE GitHub_Repo_Viewer SHALL implement all controllers using GetX Controller classes
2. THE GitHub_Repo_Viewer SHALL use GetX dependency injection for all service and controller instances
3. THE GitHub_Repo_Viewer SHALL use GetX reactive state management with Obx or GetBuilder widgets
4. THE GitHub_Repo_Viewer SHALL implement navigation using GetX routing methods
5. THE GitHub_Repo_Viewer SHALL use GetX bindings to initialize controllers for each route

### Requirement 8

**User Story:** As a developer, I want the application to use Dio for API communication, so that HTTP requests are handled efficiently with proper error handling

#### Acceptance Criteria

1. THE GitHub_Repo_Viewer SHALL implement the Repository_Service using Dio client
2. THE GitHub_Repo_Viewer SHALL configure Dio with base URL "https://api.github.com"
3. THE GitHub_Repo_Viewer SHALL implement request timeout of 30 seconds for all API calls
4. THE GitHub_Repo_Viewer SHALL handle network errors and return appropriate error messages
5. THE GitHub_Repo_Viewer SHALL parse JSON responses into Dart model classes
