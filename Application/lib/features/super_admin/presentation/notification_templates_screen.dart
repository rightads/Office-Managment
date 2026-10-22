import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/features/super_admin/application/super_admin_controllers.dart';
import 'package:right_ads/features/super_admin/domain/super_admin_models.dart';

class NotificationTemplatesScreen extends ConsumerWidget {
  const NotificationTemplatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(superAdminTemplatesControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.superAdminTemplatesTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref
                .read(superAdminTemplatesControllerProvider.notifier)
                .loadTemplates(),
          ),
        ],
      ),
      body: Builder(
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
                        .read(superAdminTemplatesControllerProvider.notifier)
                        .loadTemplates(),
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            );
          }

          final templates = state.templates;
          if (templates.isEmpty) {
            return Center(child: Text(l10n.noDataAvailable));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: templates.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final template = templates[index];
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Theme.of(context).dividerColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              template.code,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            onPressed: () =>
                                _showEditDialog(context, ref, template),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${l10n.templateTitleLabel}: ${template.titleTemplate}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${l10n.templateBodyLabel}: ${template.bodyTemplate}',
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          _buildChannelChip(
                            context: context,
                            label: l10n.channelInApp,
                            active: template.channelPush,
                          ),
                          _buildChannelChip(
                            context: context,
                            label: l10n.channelPush,
                            active: template.channelPush,
                          ),
                          _buildChannelChip(
                            context: context,
                            label: l10n.channelEmail,
                            active: template.channelEmail,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildChannelChip({
    required BuildContext context,
    required String label,
    required bool active,
  }) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: active
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).disabledColor,
        ),
      ),
      backgroundColor: active
          ? Theme.of(
              context,
            ).colorScheme.primaryContainer.withValues(alpha: 0.3)
          : Theme.of(context).dividerColor.withValues(alpha: 0.1),
    );
  }

  void _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    NotificationTemplateModel template,
  ) {
    final l10n = context.l10n;
    final titleController = TextEditingController(text: template.titleTemplate);
    final bodyController = TextEditingController(text: template.bodyTemplate);
    var push = template.channelPush;
    var email = template.channelEmail;

    final editTitle = '${l10n.editTemplate}: ${template.code}';

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(editTitle),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: l10n.templateTitleLabel,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: bodyController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: l10n.templateBodyLabel,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.channelPush),
                      value: push,
                      onChanged: (val) => setState(() => push = val ?? false),
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.channelEmail),
                      value: email,
                      onChanged: (val) => setState(() => email = val ?? false),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(l10n.cancel),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(ctx).pop();
                    try {
                      await ref
                          .read(superAdminTemplatesControllerProvider.notifier)
                          .updateTemplate(
                            template.code,
                            NotificationTemplateUpdateRequest(
                              titleTemplate: titleController.text,
                              bodyTemplate: bodyController.text,
                              channelPush: push,
                              channelEmail: email,
                            ),
                          );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.actionCompleted)),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${l10n.error}: $e')),
                        );
                      }
                    }
                  },
                  child: Text(l10n.save),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
