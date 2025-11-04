import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilab_practice/screen/auth_screen/controller/auth_controller.dart';
import 'package:inilab_practice/widgets/app_textfield/app_textfield.dart';
import 'package:inilab_practice/widgets/app_button/app_button.dart';
import 'package:inilab_practice/app/app_theme/theme_controller.dart';

import '../../utils/app_size/app_size.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final themeController = Get.find<ThemeController>();
    final usernameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repo Viewer'),
        actions: [
          Obx(
            () => IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(
                    turns:
                        Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: Icon(
                  themeController.isDarkMode
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                  key: ValueKey(themeController.isDarkMode),
                ),
              ),
              onPressed: themeController.toggleTheme,
              tooltip: themeController.isDarkMode
                  ? 'Switch to light mode'
                  : 'Switch to dark mode',
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive padding based on screen width
            final horizontalPadding = constraints.maxWidth > 600 ? 48.0 : 24.0;
            final maxWidth =
                constraints.maxWidth > 600 ? 500.0 : double.infinity;

            return Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxWidth: maxWidth,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding, vertical: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // App Icon or Logo with animation
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutBack,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Icon(
                                Icons.code,
                                size: 80,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),

                        // Title with fade-in animation
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 800),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Text(
                                'Welcome',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),

                        // Subtitle with fade-in animation
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 1000),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Text(
                                'Enter a GitHub username to view repositories',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: AppSize.height(40.0)),

                        // Username TextField
                        Obx(
                          () => AppTextField(
                            controller: usernameController,
                            hintText: 'Enter GitHub username',
                            labelText: 'Username',
                            prefixIcon: const Icon(Icons.person_outline),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            errorText: authController.errorMessage.isEmpty
                                ? null
                                : authController.errorMessage,
                            onChanged: authController.setUsername,
                            onSubmitted: (value) {
                              if (!authController.isLoading) {
                                authController.validateAndNavigate(value);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Submit Button
                        Obx(
                          () => AppButton(
                            text: 'Continue',
                            isLoading: authController.isLoading,
                            onPressed: () {
                              authController
                                  .validateAndNavigate(usernameController.text);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
