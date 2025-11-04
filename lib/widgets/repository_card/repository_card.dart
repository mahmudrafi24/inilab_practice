import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../services/models/repository.dart';
import '../app_text/app_text.dart';

class RepositoryCard extends StatelessWidget {
  final Repository repository;
  final VoidCallback? onTap;

  const RepositoryCard({
    super.key,
    required this.repository,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Owner avatar with shadow
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: repository.owner.avatarUrl,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 48,
                      height: 48,
                      color: theme.brightness == Brightness.dark
                          ? Colors.grey[800]
                          : Colors.grey[300],
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
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
                      width: 48,
                      height: 48,
                      color: theme.brightness == Brightness.dark
                          ? Colors.grey[800]
                          : Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        size: 28,
                        color: theme.brightness == Brightness.dark
                            ? Colors.grey[600]
                            : Colors.grey[500],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Repository details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Repository name with icon
                    Row(
                      children: [
                        Expanded(
                          child: AppText.titleLarge(
                            repository.name,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Description
                    if (repository.description != null &&
                        repository.description!.isNotEmpty)
                      AppText.bodyMedium(
                        repository.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        color: theme.textTheme.bodyMedium?.color,
                        height: 1.4,
                      ),
                    if (repository.description != null &&
                        repository.description!.isNotEmpty)
                      const SizedBox(height: 12),

                    // Language and stars row
                    Row(
                      children: [
                        // Language
                        if (repository.language != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getLanguageColor(repository.language!)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color:
                                      _getLanguageColor(repository.language!),
                                ),
                                const SizedBox(width: 6),
                                AppText.bodySmall(
                                  repository.language!,
                                  color: theme.textTheme.bodySmall?.color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        if (repository.language != null)
                          const SizedBox(width: 12),

                        // Stars
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.amber[700],
                              ),
                              const SizedBox(width: 4),
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
