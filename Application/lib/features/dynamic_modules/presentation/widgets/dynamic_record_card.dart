import 'package:flutter/material.dart';
import 'package:right_ads/core/theme/dynamic_color_parser.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';
import 'package:right_ads/features/dynamic_modules/presentation/widgets/dynamic_field_renderer.dart';

/// Card item representation for a dynamic module record in the record list.
class DynamicRecordCard extends StatelessWidget {
  const DynamicRecordCard({
    required this.record,
    required this.definition,
    required this.onTap,
    super.key,
  });

  final DynamicRecordModel record;
  final DynamicModuleDefinition definition;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Filter fields marked is_list_visible
    final visibleFields =
        definition.fields.where((f) => f.isActive && f.isListVisible).toList()
          ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    final status = record.status;
    final statusColor =
        DynamicColorParser.tryParseHex(status?.color) ?? colorScheme.primary;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Header row with primary label and status chip
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _findPrimaryTitle(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (status != null) ...<Widget>[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: statusColor.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(
                        status.label,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),

              // Visible fields layout
              if (visibleFields.isNotEmpty) ...<Widget>[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 16,
                  runSpacing: 4,
                  children: visibleFields.take(4).map((f) {
                    final val = record.data[f.key];
                    if (val == null) return const SizedBox.shrink();
                    return DynamicFieldRenderer(
                      field: f,
                      value: val,
                      compact: true,
                    );
                  }).toList(),
                ),
              ],

              const Divider(height: 20),

              // Footer row with Assignee/Creator and Due/Created date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (record.assigneeName != null &&
                      record.assigneeName!.isNotEmpty)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.person_outline,
                          size: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          record.assigneeName!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    )
                  else if (record.creatorName != null)
                    Text(
                      record.creatorName!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    )
                  else
                    const SizedBox.shrink(),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(record.dueAt ?? record.createdAt),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _findPrimaryTitle() {
    // Check for title or name key
    for (final key in <String>['title', 'name', 'subject', 'headline']) {
      final val = record.data[key];
      if (val != null && val.toString().trim().isNotEmpty) {
        return val.toString();
      }
    }
    // Fallback: first visible text field
    for (final f in definition.fields) {
      if (f.type == DynamicFieldType.text) {
        final val = record.data[f.key];
        if (val != null && val.toString().trim().isNotEmpty) {
          return val.toString();
        }
      }
    }
    return '${definition.recordLabelSingular} #${record.id.substring(0, 8)}';
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
