import 'package:flutter/material.dart';
import '../../services/models/sort_option.dart';
import '../app_text/app_text.dart';

class SortFilter extends StatelessWidget {
  final SortOption currentOption;
  final Function(SortOption) onOptionSelected;

  const SortFilter({
    super.key,
    required this.currentOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 16),
            child: AppText.titleLarge(
              'Sort by',
              fontWeight: FontWeight.w600,
            ),
          ),

          // Sort options
          _buildSortOption(
            context,
            SortOption.name,
            'Name',
            'Sort repositories alphabetically',
            Icons.sort_by_alpha,
          ),
          _buildSortOption(
            context,
            SortOption.date,
            'Date',
            'Sort by creation date (newest first)',
            Icons.calendar_today,
          ),
          _buildSortOption(
            context,
            SortOption.stars,
            'Stars',
            'Sort by star count (highest first)',
            Icons.star,
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildSortOption(
    BuildContext context,
    SortOption option,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    final isSelected = currentOption == option;

    return InkWell(
      onTap: () {
        onOptionSelected(option);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.dividerColor.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : theme.colorScheme.primary,
              ),
            ),

            const SizedBox(width: 16),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.bodyLarge(
                    title,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  const SizedBox(height: 2),
                  AppText.bodySmall(
                    subtitle,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ],
              ),
            ),

            // Selected indicator
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  /// Shows the sort filter as a bottom sheet
  static void show(
    BuildContext context, {
    required SortOption currentOption,
    required Function(SortOption) onOptionSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 300),
      ),
      builder: (context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: SortFilter(
          currentOption: currentOption,
          onOptionSelected: onOptionSelected,
        ),
      ),
    );
  }
}
