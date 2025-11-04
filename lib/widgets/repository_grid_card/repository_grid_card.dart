import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../services/models/repository.dart';
import '../app_text/app_text.dart';

class RepositoryGridCard extends StatelessWidget {
  final Repository repository;
  final VoidCallback? onTap;

  const RepositoryGridCard({
    super.key,
    required this.repository,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shadowColor: theme.colorScheme.primary.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        highlightColor: theme.colorScheme.primary.withValues(alpha: 0.05),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Owner avatar with shadow
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color:
                            theme.colorScheme.primary.withValues(alpha: 0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: repository.owner.avatarUrl,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 64,
                        height: 64,
                        color: theme.brightness == Brightness.dark
                            ? Colors.grey[800]
                            : Colors.grey[300],
                        child: Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 64,
                        height: 64,
                        color: theme.brightness == Brightness.dark
                            ? Colors.grey[800]
                            : Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          size: 36,
                          color: theme.brightness == Brightness.dark
                              ? Colors.grey[600]
                              : Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Repository name
              Expanded(
                child: Center(
                  child: AppText.bodyLarge(
                    repository.name,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Language and stars with better styling
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Language
                  if (repository.language != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getLanguageColor(repository.language!)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: _getLanguageColor(repository.language!),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: AppText.bodySmall(
                              repository.language!,
                              color: theme.textTheme.bodySmall?.color,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (repository.language != null) const SizedBox(height: 8),

                  // Stars
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber[700],
                        ),
                        const SizedBox(width: 6),
                        AppText.bodySmall(
                          _formatStarCount(repository.stargazersCount),
                          color: theme.textTheme.bodySmall?.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Format star count for display (e.g., 1.2k, 3.4k)
  String _formatStarCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  /// Get color for programming language
  Color _getLanguageColor(String language) {
    switch (language.toLowerCase()) {
      case 'dart':
        return const Color(0xFF00B4AB);
      case 'javascript':
        return const Color(0xFFF7DF1E);
      case 'typescript':
        return const Color(0xFF3178C6);
      case 'python':
        return const Color(0xFF3776AB);
      case 'java':
        return const Color(0xFFB07219);
      case 'kotlin':
        return const Color(0xFFA97BFF);
      case 'swift':
        return const Color(0xFFFA7343);
      case 'go':
        return const Color(0xFF00ADD8);
      case 'rust':
        return const Color(0xFFDEA584);
      case 'c++':
      case 'cpp':
        return const Color(0xFFF34B7D);
      case 'c#':
      case 'csharp':
        return const Color(0xFF178600);
      case 'ruby':
        return const Color(0xFF701516);
      case 'php':
        return const Color(0xFF4F5D95);
      default:
        return Colors.grey;
    }
  }
}
