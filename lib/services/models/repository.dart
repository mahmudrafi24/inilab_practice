import 'github_user.dart';

class Repository {
  final int id;
  final String name;
  final String? description;
  final String htmlUrl;
  final int stargazersCount;
  final int forksCount;
  final int watchersCount;
  final String? language;
  final DateTime createdAt;
  final DateTime updatedAt;
  final GitHubUser owner;

  Repository({
    required this.id,
    required this.name,
    this.description,
    required this.htmlUrl,
    required this.stargazersCount,
    required this.forksCount,
    required this.watchersCount,
    this.language,
    required this.createdAt,
    required this.updatedAt,
    required this.owner,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: (json['id'] as int?) ?? 0,
      name: json['name'] as String,
      description: json['description'] as String?,
      htmlUrl: json['html_url'] as String,
      stargazersCount: (json['stargazers_count'] as int?) ?? 0,
      forksCount: (json['forks_count'] as int?) ?? 0,
      watchersCount: (json['watchers_count'] as int?) ?? 0,
      language: json['language'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      owner: GitHubUser.fromJson(json['owner'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'html_url': htmlUrl,
      'stargazers_count': stargazersCount,
      'forks_count': forksCount,
      'watchers_count': watchersCount,
      'language': language,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'owner': owner.toJson(),
    };
  }
}
