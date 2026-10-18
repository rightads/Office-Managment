import 'package:flutter/material.dart';

abstract final class AppTypography {
  static TextTheme buildTextTheme(ColorScheme colorScheme) {
    final base = Typography.material2021().black.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    return base.copyWith(
      headlineLarge: base.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.28,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.35,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.35,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        height: 1.45,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        height: 1.45,
      ),
      bodySmall: base.bodySmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
        height: 1.4,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
    );
  }
}
