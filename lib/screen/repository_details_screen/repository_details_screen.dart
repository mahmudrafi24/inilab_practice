import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:inilab_practice/screen/repository_details_screen/controller/repository_details_controller.dart';
import 'package:inilab_practice/widgets/app_text/app_text.dart';
import 'package:inilab_practice/utils/app_color/app_color.dart';
import 'package:sizer/sizer.dart';

class RepositoryDetailsScreen extends GetView<RepositoryDetailsController> {
  const RepositoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = controller.repository;

    if (repository == null) {
      return Scaffold(
        appBar: AppBar(
          title: const AppText.titleLarge('Repository Details'),
        ),
        body: const Center(
          child: AppText.bodyLarge('No repository data available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const AppText.titleLarge('Repository Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          tooltip: 'Back',
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive layout for larger screens
          final maxWidth = constraints.maxWidth > 800 ? 800.0 : double.infinity;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Repository Header with animation
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 400),
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
                      child: _buildRepositoryHeader(context, repository),
                    ),

                    SizedBox(height: 24.h),

                    // Statistics Section with animation
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
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
                      child: _buildStatisticsSection(context, repository),
                    ),

                    SizedBox(height: 24.h),

                    // Information Section with animation
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
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
                      child: _buildInformationSection(context, repository),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRepositoryHeader(BuildContext context, repository) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? AppColor.lightSurface
            : AppColor.darkSurface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Repository Name
          AppText.headlineMedium(
            repository.name,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 8.h),

          // Description
          if (repository.description != null)
            AppText.bodyMedium(
              repository.description!,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColor.lightTextSecondary
                  : AppColor.darkTextSecondary,
            ),
          SizedBox(height: 16.h),

          // Owner Information
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: repository.owner.avatarUrl,
                  width: 40.w,
                  height: 40.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 40.w,
                    height: 40.h,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800]
                        : Colors.grey[300],
                    child: Center(
                      child: SizedBox(
                        width: 16.w,
                        height: 16.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 40.w,
                    height: 40.h,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800]
                        : Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: 24.sp,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[600]
                          : Colors.grey[500],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.bodyMedium(
                    repository.owner.name ?? repository.owner.login,
                    fontWeight: FontWeight.w600,
                  ),
                  AppText.bodySmall(
                    '@${repository.owner.login}',
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColor.lightTextSecondary
                        : AppColor.darkTextSecondary,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection(BuildContext context, repository) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText.titleLarge(
            'Statistics',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.star,
                  label: 'Stars',
                  value: _formatNumber(repository.stargazersCount),
                  color: Colors.amber,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.call_split,
                  label: 'Forks',
                  value: _formatNumber(repository.forksCount),
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.visibility,
                  label: 'Watchers',
                  value: _formatNumber(repository.watchersCount),
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? AppColor.lightSurface
            : AppColor.darkSurface,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32.sp),
          SizedBox(height: 8.h),
          AppText.headlineMedium(
            value,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 4.h),
          AppText.bodySmall(
            label,
            color: Theme.of(context).brightness == Brightness.light
                ? AppColor.lightTextSecondary
                : AppColor.darkTextSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildInformationSection(BuildContext context, repository) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText.titleLarge(
            'Information',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 12.h),

          // Language
          if (repository.language != null)
            _buildInfoRow(
              context,
              icon: Icons.code,
              label: 'Language',
              value: repository.language!,
            ),

          // Created Date
          _buildInfoRow(
            context,
            icon: Icons.calendar_today,
            label: 'Created',
            value: dateFormat.format(repository.createdAt),
          ),

          // Updated Date
          _buildInfoRow(
            context,
            icon: Icons.update,
            label: 'Last Updated',
            value: dateFormat.format(repository.updatedAt),
          ),

          // Repository URL
          _buildInfoRow(
            context,
            icon: Icons.link,
            label: 'URL',
            value: repository.htmlUrl,
            isUrl: true,
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    bool isUrl = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: Theme.of(context).brightness == Brightness.light
                ? AppColor.lightTextSecondary
                : AppColor.darkTextSecondary,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.bodySmall(
                  label,
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColor.lightTextSecondary
                      : AppColor.darkTextSecondary,
                ),
                SizedBox(height: 4.h),
                AppText.bodyMedium(
                  value,
                  fontWeight: FontWeight.w500,
                  color: isUrl
                      ? (Theme.of(context).brightness == Brightness.light
                          ? AppColor.lightPrimary
                          : AppColor.darkPrimary)
                      : null,
                  decoration: isUrl ? TextDecoration.underline : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
