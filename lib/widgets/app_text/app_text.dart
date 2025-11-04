import 'package:flutter/material.dart';

enum AppTextStyle {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineMedium,
  titleLarge,
  bodyLarge,
  bodyMedium,
  bodySmall,
}

class AppText extends StatelessWidget {
  final String text;
  final AppTextStyle style;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? height;

  const AppText({
    super.key,
    required this.text,
    this.style = AppTextStyle.bodyLarge,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.height,
  });

  // Convenience constructors for common text styles
  const AppText.displayLarge(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.height,
  }) : style = AppTextStyle.displayLarge;

  const AppText.displayMedium(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.height,
  }) : style = AppTextStyle.displayMedium;

  const AppText.displaySmall(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.height,
  }) : style = AppTextStyle.displaySmall;

  const AppText.headlineMedium(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.height,
  }) : style = AppTextStyle.headlineMedium;

  const AppText.titleLarge(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.height,
  }) : style = AppTextStyle.titleLarge;

  const AppText.bodyLarge(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.height,
  }) : style = AppTextStyle.bodyLarge;

  const AppText.bodyMedium(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.height,
  }) : style = AppTextStyle.bodyMedium;

  const AppText.bodySmall(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.height,
  }) : style = AppTextStyle.bodySmall;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextStyle? baseStyle;

    switch (style) {
      case AppTextStyle.displayLarge:
        baseStyle = theme.textTheme.displayLarge;
        break;
      case AppTextStyle.displayMedium:
        baseStyle = theme.textTheme.displayMedium;
        break;
      case AppTextStyle.displaySmall:
        baseStyle = theme.textTheme.displaySmall;
        break;
      case AppTextStyle.headlineMedium:
        baseStyle = theme.textTheme.headlineMedium;
        break;
      case AppTextStyle.titleLarge:
        baseStyle = theme.textTheme.titleLarge;
        break;
      case AppTextStyle.bodyLarge:
        baseStyle = theme.textTheme.bodyLarge;
        break;
      case AppTextStyle.bodyMedium:
        baseStyle = theme.textTheme.bodyMedium;
        break;
      case AppTextStyle.bodySmall:
        baseStyle = theme.textTheme.bodySmall;
        break;
    }

    return Text(
      text,
      style: baseStyle?.copyWith(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        decoration: decoration,
        letterSpacing: letterSpacing,
        height: height,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
