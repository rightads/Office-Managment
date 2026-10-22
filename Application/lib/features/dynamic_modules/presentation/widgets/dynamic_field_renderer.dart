import 'package:flutter/material.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/dynamic_color_parser.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';
import 'package:url_launcher/url_launcher.dart';

/// Renders a single field's read-only value in a record detail view or card.
class DynamicFieldRenderer extends StatelessWidget {
  const DynamicFieldRenderer({
    required this.field,
    required this.value,
    this.compact = false,
    super.key,
  });

  final DynamicModuleField field;
  final dynamic value;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (value == null ||
        (value is String && (value as String).trim().isEmpty)) {
      if (compact) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              field.label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    final contentWidget = _buildTypedWidget(context);

    if (compact) {
      return contentWidget;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            field.label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          contentWidget,
        ],
      ),
    );
  }

  Widget _buildTypedWidget(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (field.type) {
      case DynamicFieldType.text:
      case DynamicFieldType.longText:
      case DynamicFieldType.number:
      case DynamicFieldType.user:
      case DynamicFieldType.client:
      case DynamicFieldType.project:
        return Text(
          value.toString(),
          style: theme.textTheme.bodyMedium,
        );

      case DynamicFieldType.currency:
        final numVal = num.tryParse(value.toString()) ?? 0;
        final formatted = '₹${numVal.toStringAsFixed(2)}';
        return Text(
          formatted,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.primary,
          ),
        );

      case DynamicFieldType.date:
      case DynamicFieldType.datetime:
        final dateStr = value.toString();
        Widget? badge;
        final isFollowUp =
            field.key.toLowerCase().contains('follow_up') ||
            (field.validation?.regexMessage?.toLowerCase().contains('follow') ??
                false);

        if (isFollowUp) {
          final parsedDate = DateTime.tryParse(dateStr);
          if (parsedDate != null) {
            final now = DateTime.now();
            final today = DateTime(now.year, now.month, now.day);
            final target = DateTime(
              parsedDate.year,
              parsedDate.month,
              parsedDate.day,
            );
            final l10n = context.l10n;

            if (target.isBefore(today)) {
              badge = Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.error.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  l10n.fieldActionFollowUpOverdue,
                  style: TextStyle(
                    color: colorScheme.error,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else if (target.isAtSameMomentAs(today)) {
              badge = Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  l10n.fieldActionFollowUpDueToday,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          }
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              field.type == DynamicFieldType.date
                  ? Icons.calendar_today_outlined
                  : Icons.access_time_outlined,
              size: 16,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              dateStr,
              style: theme.textTheme.bodyMedium,
            ),
            ?badge,
          ],
        );

      case DynamicFieldType.phone:
        final phoneStr = value.toString();
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(phoneStr, style: theme.textTheme.bodyMedium),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.call_outlined, size: 16),
              visualDensity: VisualDensity.compact,
              color: colorScheme.primary,
              onPressed: () {
                final uri = Uri.parse('tel:$phoneStr');
                launchUrl(uri);
              },
            ),
            IconButton(
              icon: const Icon(Icons.chat_outlined, size: 16),
              visualDensity: VisualDensity.compact,
              color: Colors.green,
              onPressed: () {
                final cleanPhone = phoneStr.replaceAll(RegExp('[^0-9]'), '');
                final uri = Uri.parse('https://wa.me/$cleanPhone');
                launchUrl(uri, mode: LaunchMode.externalApplication);
              },
            ),
          ],
        );

      case DynamicFieldType.email:
        final emailStr = value.toString();
        return InkWell(
          onTap: () {
            final uri = Uri.parse('mailto:$emailStr');
            launchUrl(uri);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.email_outlined, size: 16, color: colorScheme.primary),
              const SizedBox(width: 6),
              Text(
                emailStr,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        );

      case DynamicFieldType.url:
        final urlStr = value.toString();
        return InkWell(
          onTap: () {
            final uri = Uri.tryParse(urlStr);
            if (uri != null) {
              launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.open_in_new_outlined,
                size: 16,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  urlStr,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );

      case DynamicFieldType.singleSelect:
        final opt = field.options.firstWhere(
          (o) => o.value == value.toString(),
          orElse: () => DynamicSelectOption(
            value: value.toString(),
            label: value.toString(),
          ),
        );
        final color =
            DynamicColorParser.tryParseHex(opt.color) ?? colorScheme.primary;
        return Chip(
          label: Text(opt.label),
          visualDensity: VisualDensity.compact,
          side: BorderSide(color: color.withValues(alpha: 0.4)),
          backgroundColor: color.withValues(alpha: 0.12),
          labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
        );

      case DynamicFieldType.multiSelect:
        final raw = value;
        final list = raw is Iterable ? raw.toList() : <Object?>[raw];
        final chips = <Widget>[];
        for (final item in list) {
          final valStr = item.toString();
          final opt = field.options.firstWhere(
            (o) => o.value == valStr,
            orElse: () => DynamicSelectOption(value: valStr, label: valStr),
          );
          final color =
              DynamicColorParser.tryParseHex(opt.color) ?? colorScheme.primary;
          chips.add(
            Chip(
              label: Text(opt.label),
              visualDensity: VisualDensity.compact,
              side: BorderSide(color: color.withValues(alpha: 0.4)),
              backgroundColor: color.withValues(alpha: 0.12),
              labelStyle: TextStyle(color: color, fontWeight: FontWeight.w500),
            ),
          );
        }
        return Wrap(
          spacing: 6,
          runSpacing: 6,
          children: chips,
        );

      case DynamicFieldType.boolean:
        final isTrue =
            value == true || value.toString().toLowerCase() == 'true';
        final textLabel = isTrue ? 'Yes' : 'No';
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              isTrue ? Icons.check_circle_outline : Icons.cancel_outlined,
              size: 16,
              color: isTrue ? Colors.green : colorScheme.error,
            ),
            const SizedBox(width: 6),
            Text(
              textLabel,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: isTrue ? Colors.green : colorScheme.error,
              ),
            ),
          ],
        );

      case DynamicFieldType.geoPoint:
        var geoStr = value.toString();
        if (value is Map) {
          final m = value as Map<dynamic, dynamic>;
          final Object? lat = m['lat'];
          final Object? lng = m['lng'];
          geoStr = '$lat, $lng';
        }
        return InkWell(
          onTap: () {
            final uri = Uri.parse('https://maps.google.com/?q=$geoStr');
            launchUrl(uri, mode: LaunchMode.externalApplication);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                geoStr,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        );

      case DynamicFieldType.file:
      case DynamicFieldType.image:
        final fileUrl = value.toString();
        return InkWell(
          onTap: () {
            final uri = Uri.tryParse(fileUrl);
            if (uri != null) {
              launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                field.type == DynamicFieldType.image
                    ? Icons.image_outlined
                    : Icons.attach_file_outlined,
                size: 16,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  fileUrl,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );

      default:
        // Unknown field type -> fallback to read-only text, never crash
        return Text(
          value.toString(),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontStyle: FontStyle.italic,
          ),
        );
    }
  }
}
