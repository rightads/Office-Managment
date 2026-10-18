import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';

enum AppButtonVariant {
  primary,
  secondary,
  tonal,
  destructive,
  text,
}

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.expanded = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;
    final effectiveOnPressed = isLoading ? null : onPressed;

    final Widget childContent = Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (isLoading) ...<Widget>[
          SizedBox(
            width: AppSpacing.iconSm,
            height: AppSpacing.iconSm,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _spinnerColor(colorScheme),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
        ] else if (icon != null) ...<Widget>[
          Icon(icon, size: AppSpacing.iconMd),
          const SizedBox(width: AppSpacing.xs),
        ],
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

    final buttonWidget = switch (variant) {
      AppButtonVariant.primary => FilledButton(
        onPressed: effectiveOnPressed,
        child: childContent,
      ),
      AppButtonVariant.secondary => OutlinedButton(
        onPressed: effectiveOnPressed,
        child: childContent,
      ),
      AppButtonVariant.tonal => FilledButton.tonal(
        onPressed: effectiveOnPressed,
        child: childContent,
      ),
      AppButtonVariant.destructive => FilledButton(
        onPressed: effectiveOnPressed,
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.error,
          foregroundColor: colorScheme.onError,
        ),
        child: childContent,
      ),
      AppButtonVariant.text => TextButton(
        onPressed: effectiveOnPressed,
        child: childContent,
      ),
    };

    return Semantics(
      button: true,
      enabled: effectiveOnPressed != null,
      label: isLoading ? l10n.commonLoading : label,
      child: expanded
          ? SizedBox(width: double.infinity, child: buttonWidget)
          : buttonWidget,
    );
  }

  Color _spinnerColor(ColorScheme colorScheme) {
    return switch (variant) {
      AppButtonVariant.primary => colorScheme.onPrimary,
      AppButtonVariant.secondary ||
      AppButtonVariant.text => colorScheme.primary,
      AppButtonVariant.tonal => colorScheme.onSecondaryContainer,
      AppButtonVariant.destructive => colorScheme.onError,
    };
  }
}
