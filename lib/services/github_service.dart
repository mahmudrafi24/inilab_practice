import 'package:dio/dio.dart';
import 'models/github_user.dart';
import 'models/repository.dart';
import 'exceptions/exceptions.dart';

class GitHubService {
  final Dio _dio;

  GitHubService(this._dio);

  /// Fetches a GitHub user by username
  /// Throws [NotFoundException] if user doesn't exist
  /// Throws [RateLimitException] if rate limit is exceeded
  /// Throws [NetworkException] for connection issues
  /// Throws [ApiException] for other API errors
  Future<GitHubUser> getUser(String username) async {
    try {
      final response = await _dio.get('/users/$username');
      return GitHubUser.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleDioException(e, 'Failed to fetch user');
    } catch (e) {
      throw ApiException('Unexpected error: ${e.toString()}');
    }
  }

  /// Fetches all repositories for a GitHub user
  /// Throws [NotFoundException] if user doesn't exist
  /// Throws [RateLimitException] if rate limit is exceeded
  /// Throws [NetworkException] for connection issues
  /// Throws [ApiException] for other API errors
  Future<List<Repository>> getUserRepositories(String username) async {
    try {
      final response = await _dio.get('/users/$username/repos');
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => Repository.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleDioException(e, 'Failed to fetch repositories');
    } catch (e) {
      throw ApiException('Unexpected error: ${e.toString()}');
    }
  }

  /// Maps DioException to appropriate custom exceptions
  Exception _handleDioException(DioException e, String context) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
            'Connection timeout. Please check your internet connection.');

      case DioExceptionType.connectionError:
        return NetworkException(
            'Unable to connect. Please check your internet connection.');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return NotFoundException('Resource not found');
        } else if (statusCode == 403) {
          return RateLimitException(
              'GitHub API rate limit exceeded. Please try again later.');
        } else if (statusCode != null && statusCode >= 500) {
          return ApiException('GitHub service is temporarily unavailable');
        } else {
          return ApiException(
              '$context: ${e.response?.statusMessage ?? "Unknown error"}');
        }

      case DioExceptionType.cancel:
        return ApiException('Request was cancelled');

      default:
        return ApiException('$context: ${e.message ?? "Unknown error"}');
    }
  }
}
