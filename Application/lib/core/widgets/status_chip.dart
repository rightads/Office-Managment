import 'package:flutter/material.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/theme/dynamic_color_parser.dart';

/// Displays a status or priority badge where both [label] and [hexColor]
/// come strictly from API data. Never hardcodes status names or colors.
class StatusChip extends StatelessWidget {
  const StatusChip({
    required this.label,
    this.hexColor,
    this.icon,
    super.key,
  });

  final String label;
  final String? hexColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolved = DynamicColorParser.resolve(
      rawHex: hexColor,
      fallbackScheme: theme.colorScheme,
    );

    return Semantics(
      container: true,
      label: label,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        decoration: BoxDecoration(
          color: resolved.backgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: resolved.borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Icon(
                icon,
                size: AppSpacing.iconSm,
                color: resolved.foregroundColor,
              ),
              const SizedBox(width: AppSpacing.xxs),
            ],
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: resolved.foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
