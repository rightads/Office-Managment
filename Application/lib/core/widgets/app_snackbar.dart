import 'package:flutter/material.dart';
import 'package:right_ads/core/theme/app_brand_colors.dart';
import 'package:right_ads/core/theme/app_spacing.dart';

enum AppSnackbarType {
  info,
  success,
  warning,
  error,
}

abstract final class AppSnackbar {
  static void showInfo(BuildContext context, String message) {
    _show(context, message: message, type: AppSnackbarType.info);
  }

  static void showSuccess(BuildContext context, String message) {
    _show(context, message: message, type: AppSnackbarType.success);
  }

  static void showWarning(BuildContext context, String message) {
    _show(context, message: message, type: AppSnackbarType.warning);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message: message, type: AppSnackbarType.error);
  }

  static void _show(
    BuildContext context, {
    required String message,
    required AppSnackbarType type,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final (Color bgColor, Color fgColor, IconData icon) = switch (type) {
      AppSnackbarType.info => (
        colorScheme.inverseSurface,
        colorScheme.onInverseSurface,
        Icons.info_outline,
      ),
      AppSnackbarType.success => (
        AppBrandColors.successSeed,
        AppBrandColors.highContrastLightText,
        Icons.check_circle_outline,
      ),
      AppSnackbarType.warning => (
        AppBrandColors.warningSeed,
        AppBrandColors.highContrastLightText,
        Icons.warning_amber_outlined,
      ),
      AppSnackbarType.error => (
        colorScheme.error,
        colorScheme.onError,
        Icons.error_outline,
      ),
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: bgColor,
          content: Row(
            children: <Widget>[
              Icon(icon, color: fgColor, size: AppSpacing.iconMd),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(color: fgColor),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
