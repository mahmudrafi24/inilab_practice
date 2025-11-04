class GitHubUser {
  final String login;
  final String avatarUrl;
  final String? name;
  final String? bio;
  final int publicRepos;

  GitHubUser({
    required this.login,
    required this.avatarUrl,
    this.name,
    this.bio,
    required this.publicRepos,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) {
    return GitHubUser(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
      name: json['name'] as String?,
      bio: json['bio'] as String?,
      publicRepos: (json['public_repos'] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'avatar_url': avatarUrl,
      'name': name,
      'bio': bio,
      'public_repos': publicRepos,
    };
  }
}
