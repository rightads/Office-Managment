import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/dynamic_color_parser.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';

/// Horizontal summary strip displaying counts per status and numeric totals.
class DynamicModuleSummaryStrip extends StatelessWidget {
  const DynamicModuleSummaryStrip({
    required this.summary,
    required this.definition,
    this.selectedStatus,
    this.onStatusSelected,
    super.key,
  });

  final DynamicModuleSummary summary;
  final DynamicModuleDefinition definition;
  final String? selectedStatus;
  final ValueChanged<String?>? onStatusSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: Row(
        children: <Widget>[
          // "All" chip
          FilterChip(
            selected: selectedStatus == null,
            label: Text(l10n.dynamicModuleAllStatusCount(summary.totalRecords)),
            onSelected: (_) => onStatusSelected?.call(null),
          ),
          const SizedBox(width: 8),

          // Status chips with counts
          ...definition.statuses.map((s) {
            final count = summary.countsByStatus[s.code] ?? 0;
            final isSelected = selectedStatus == s.code;
            final sColor = DynamicColorParser.tryParseHex(s.color) ?? colorScheme.primary;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                selected: isSelected,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: sColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('${s.label} ($count)'),
                  ],
                ),
                onSelected: (_) {
                  if (isSelected) {
                    onStatusSelected?.call(null);
                  } else {
                    onStatusSelected?.call(s.code);
                  }
                },
              ),
            );
          }),

          // Numeric totals (e.g. Deal Value, Amount)
          if (summary.fieldTotals.isNotEmpty) ...<Widget>[
            const SizedBox(width: 8),
            ...summary.fieldTotals.entries.map((entry) {
              final field = definition.fields.firstWhere(
                (f) => f.key == entry.key,
                orElse: () => DynamicModuleField(
                  id: '',
                  key: entry.key,
                  label: entry.key,
                  type: DynamicFieldType.currency,
                ),
              );

              final formattedVal = field.type == DynamicFieldType.currency
                  ? '₹${entry.value.toStringAsFixed(0)}'
                  : entry.value.toStringAsFixed(0);

              return Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${field.label}: $formattedVal',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}
