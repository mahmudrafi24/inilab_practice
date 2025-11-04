import 'package:flutter/material.dart';
import '../app_text/app_text.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? subtitle;

  const EmptyState({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated icon
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Icon(
                    icon,
                    size: 80,
                    color: theme.colorScheme.primary.withValues(alpha: 0.5),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Animated message
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: AppText.titleLarge(
                    message,
                    textAlign: TextAlign.center,
                    color: theme.textTheme.titleLarge?.color,
                  ),
                );
              },
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: AppText.bodyMedium(
                      subtitle!,
                      textAlign: TextAlign.center,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
