import 'package:flutter/material.dart';
import '../app_text/app_text.dart';
import '../app_button/app_button.dart';

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
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
            // Animated error icon
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Icon(
                    icon,
                    size: 80,
                    color: theme.colorScheme.error,
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Animated title
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: AppText.titleLarge(
                    'Oops!',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),

            // Animated message
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1000),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: AppText.bodyMedium(
                    message,
                    textAlign: TextAlign.center,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                );
              },
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1200),
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
                child: AppButton(
                  text: 'Retry',
                  onPressed: onRetry,
                  width: 150,
                  icon: const Icon(Icons.refresh, size: 20),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
