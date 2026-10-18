import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/app_button.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    this.title,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String? title;
  final String? subtitle;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveTitle = title ?? l10n.emptyStateDefaultTitle;
    final effectiveSubtitle = subtitle ?? l10n.emptyStateDefaultSubtitle;

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
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  effectiveTitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  effectiveSubtitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                if (actionLabel != null && onAction != null) ...<Widget>[
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: actionLabel!,
                    onPressed: onAction,
                    variant: AppButtonVariant.tonal,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
