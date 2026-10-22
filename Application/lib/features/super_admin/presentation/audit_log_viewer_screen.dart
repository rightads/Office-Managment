import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/utils/app_formatters.dart';
import 'package:right_ads/features/super_admin/application/super_admin_controllers.dart';
import 'package:right_ads/features/super_admin/domain/super_admin_models.dart';

class AuditLogViewerScreen extends ConsumerStatefulWidget {
  const AuditLogViewerScreen({super.key});

  @override
  ConsumerState<AuditLogViewerScreen> createState() =>
      _AuditLogViewerScreenState();
}

class _AuditLogViewerScreenState extends ConsumerState<AuditLogViewerScreen> {
  final TextEditingController _actionController = TextEditingController();
  final TextEditingController _entityTypeController = TextEditingController();

  @override
  void dispose() {
    _actionController.dispose();
    _entityTypeController.dispose();
    super.dispose();
  }

  void _applyFilter() {
    ref
        .read(superAdminAuditControllerProvider.notifier)
        .setFilter(
          action: _actionController.text.trim().isEmpty
              ? null
              : _actionController.text.trim(),
          entityType: _entityTypeController.text.trim().isEmpty
              ? null
              : _entityTypeController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(superAdminAuditControllerProvider);
    final formatters = ref.watch(appFormattersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.superAdminAuditTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _actionController,
                    decoration: InputDecoration(
                      labelText: l10n.actionLabel,
                      isDense: true,
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _applyFilter(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _entityTypeController,
                    decoration: InputDecoration(
                      labelText: l10n.entityTypeLabel,
                      isDense: true,
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _applyFilter(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  icon: const Icon(Icons.search),
                  onPressed: _applyFilter,
                ),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(l10n.errorLoadingData),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => ref
                              .read(superAdminAuditControllerProvider.notifier)
                              .loadLogs(),
                          child: Text(l10n.retry),
                        ),
                      ],
                    ),
                  );
                }

                final logs = state.logs;
                if (logs.isEmpty) {
                  return Center(child: Text(l10n.noDataAvailable));
                }

                return ListView.separated(
                  itemCount: logs.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final log = logs[index];
                    final logTitle =
                        '${log.action} - ${log.entityType} #${log.entityId}';
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          log.action.isNotEmpty
                              ? log.action.substring(0, 1).toUpperCase()
                              : '?',
                        ),
                      ),
                      title: Text(logTitle),
                      subtitle: Text(
                        '${log.actorEmail ?? log.actorId} • ${formatters.formatDateTime(log.createdAt)}',
                      ),
                      trailing: (log.oldData != null || log.newData != null)
                          ? IconButton(
                              icon: const Icon(Icons.difference_outlined),
                              onPressed: () => _showDiffDialog(context, log),
                            )
                          : null,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDiffDialog(BuildContext context, AuditLogItemModel log) {
    final l10n = context.l10n;
    const encoder = JsonEncoder.withIndent('  ');
    final oldJson = log.oldData != null ? encoder.convert(log.oldData) : '';
    final newJson = log.newData != null ? encoder.convert(log.newData) : '';

    final diffTitle = '${l10n.auditDiffTitle} #${log.id}';

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(diffTitle),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.auditOldState,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      oldJson.isEmpty ? l10n.none : oldJson,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.auditNewState,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      newJson.isEmpty ? l10n.none : newJson,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(l10n.close),
            ),
          ],
        );
      },
    );
  }
}
