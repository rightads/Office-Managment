import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/features/super_admin/application/super_admin_controllers.dart';
import 'package:right_ads/features/super_admin/domain/super_admin_models.dart';

class SystemSettingsScreen extends ConsumerStatefulWidget {
  const SystemSettingsScreen({super.key});

  @override
  ConsumerState<SystemSettingsScreen> createState() =>
      _SystemSettingsScreenState();
}

class _SystemSettingsScreenState extends ConsumerState<SystemSettingsScreen> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(superAdminSettingsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.superAdminSettingsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref
                .read(superAdminSettingsControllerProvider.notifier)
                .loadSettings(),
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
                        .read(superAdminSettingsControllerProvider.notifier)
                        .loadSettings(),
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            );
          }

          final settings = state.settings;
          if (settings.isEmpty) {
            return Center(child: Text(l10n.noDataAvailable));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: settings.length,
            separatorBuilder: (_, __) => const Divider(height: 24),
            itemBuilder: (context, index) {
              final item = settings[index];
              return _buildSettingRow(context, item);
            },
          );
        },
      ),
    );
  }

  Widget _buildSettingRow(BuildContext context, SystemSettingModel item) {
    final l10n = context.l10n;
    final valStr = item.value?.toString() ?? '';
    final isBool =
        valStr.toLowerCase() == 'true' || valStr.toLowerCase() == 'false';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.key,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            if (item.description != null && item.description!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                item.description!,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ],
            const SizedBox(height: 12),
            if (isBool)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  valStr.toLowerCase() == 'true' ? l10n.active : l10n.inactive,
                ),
                value: valStr.toLowerCase() == 'true',
                onChanged: (newVal) {
                  _saveSetting(item.key, newVal.toString());
                },
              )
            else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _getController(item.key, valStr),
                      decoration: InputDecoration(
                        isDense: true,
                        border: const OutlineInputBorder(),
                        hintText: l10n.searchPlaceholder,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final controller = _controllers[item.key];
                      if (controller != null) {
                        _saveSetting(item.key, controller.text);
                      }
                    },
                    child: Text(l10n.save),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  TextEditingController _getController(String key, String initialValue) {
    if (!_controllers.containsKey(key)) {
      _controllers[key] = TextEditingController(text: initialValue);
    }
    return _controllers[key]!;
  }

  Future<void> _saveSetting(String key, String value) async {
    final l10n = context.l10n;
    try {
      await ref
          .read(superAdminSettingsControllerProvider.notifier)
          .updateSetting(key, value);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.actionCompleted)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.error}: $e')),
        );
      }
    }
  }
}
