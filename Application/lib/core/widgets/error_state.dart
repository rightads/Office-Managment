import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/app_button.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    required this.onRetry,
    this.title,
    this.message,
    this.icon = Icons.error_outline,
    super.key,
  });

  final VoidCallback onRetry;
  final String? title;
  final String? message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveTitle = title ?? l10n.errorStateDefaultTitle;
    final effectiveMessage = message ?? l10n.errorStateDefaultMessage;

    return Semantics(
      container: true,
      label: effectiveTitle,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSpacing.maxContentWidth,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                  size: AppSpacing.xxl,
                  color: colorScheme.error,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  effectiveTitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  effectiveMessage,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppButton(
                  label: l10n.commonRetry,
                  icon: Icons.refresh,
                  onPressed: onRetry,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
