import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/utils/app_formatters.dart';

abstract final class AppDateRangePicker {
  static Future<DateTimeRange?> pick(
    BuildContext context, {
    DateTimeRange? initialRange,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    final now = DateTime.now().toUtc();
    return showDateRangePicker(
      context: context,
      initialDateRange: initialRange,
      firstDate: firstDate ?? DateTime.utc(now.year - 5),
      lastDate: lastDate ?? DateTime.utc(now.year + 5, 12, 31),
    );
  }
}

class AppDateRangePickerField extends ConsumerWidget {
  const AppDateRangePickerField({
    required this.label,
    required this.onChanged,
    this.selectedRange,
    this.firstDate,
    this.lastDate,
    this.enabled = true,
    super.key,
  });

  final String label;
  final DateTimeRange? selectedRange;
  final ValueChanged<DateTimeRange?> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final formatters = ref.watch(appFormattersProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final displayText = selectedRange != null
        ? formatters.formatDateRange(selectedRange!)
        : l10n.dateRangePickerPlaceholder;

    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      value: displayText,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        onTap: enabled
            ? () async {
                final picked = await AppDateRangePicker.pick(
                  context,
                  initialRange: selectedRange,
                  firstDate: firstDate,
                  lastDate: lastDate,
                );
                if (picked != null) {
                  onChanged(picked);
                }
              }
            : null,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            enabled: enabled,
            prefixIcon: const Icon(Icons.date_range_outlined),
            suffixIcon: selectedRange != null && enabled
                ? IconButton(
                    tooltip: l10n.commonClear,
                    icon: const Icon(Icons.clear),
                    onPressed: () => onChanged(null),
                  )
                : const Icon(Icons.arrow_drop_down),
          ),
          child: Text(
            displayText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: selectedRange != null
                  ? colorScheme.onSurface
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
