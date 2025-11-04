import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.borderRadius,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? theme.colorScheme.primary,
      foregroundColor: textColor ?? theme.colorScheme.onPrimary,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      minimumSize: Size(width ?? double.infinity, height ?? 48),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          child: isLoading
              ? SizedBox(
                  key: const ValueKey('loading'),
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      textColor ?? theme.colorScheme.onPrimary,
                    ),
                  ),
                )
              : icon != null
                  ? Row(
                      key: const ValueKey('icon_text'),
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon!,
                        const SizedBox(width: 8),
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: fontSize ?? 16,
                            fontWeight: fontWeight ?? FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      text,
                      key: const ValueKey('text'),
                      style: TextStyle(
                        fontSize: fontSize ?? 14,
                        fontWeight: fontWeight ?? FontWeight.w600,
                      ),
                    ),
        ),
      ),
    );
  }
}
