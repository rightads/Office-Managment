import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/features/super_admin/data/super_admin_repository.dart';

class DynamicModuleBuilderScreen extends ConsumerStatefulWidget {
  const DynamicModuleBuilderScreen({super.key});

  @override
  ConsumerState<DynamicModuleBuilderScreen> createState() =>
      _DynamicModuleBuilderScreenState();
}

class _DynamicModuleBuilderScreenState
    extends ConsumerState<DynamicModuleBuilderScreen> {
  List<Map<String, dynamic>> _modules = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchModules();
  }

  Future<void> _fetchModules() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final repo = ref.read(superAdminRepositoryProvider);
      final res = await repo.getAppModules();
      setState(() {
        _modules = res;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.superAdminModulesTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchModules,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateModuleDialog(context),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final l10n = context.l10n;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.errorLoadingData),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _fetchModules,
              child: Text(l10n.retry),
            ),
          ],
        ),
      );
    }

    if (_modules.isEmpty) {
      return Center(child: Text(l10n.noDataAvailable));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _modules.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final mod = _modules[index];
        final label = (mod['label'] ?? mod['name'] ?? mod['code'] ?? '').toString();
        final code = (mod['code'] ?? mod['module_key'] ?? '').toString();
        final fields = (mod['fields'] as List<dynamic>?) ?? <dynamic>[];
        final statuses = (mod['statuses'] as List<dynamic>?) ?? <dynamic>[];

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Theme.of(context).dividerColor),
          ),
          child: ExpansionTile(
            title: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '$code • ${fields.length} ${l10n.fieldsLabel}',
            ),
            childrenPadding: const EdgeInsets.all(16),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${l10n.fieldsLabel}:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (fields.isEmpty)
                Text(l10n.noDataAvailable)
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: fields.map((f) {
                    final fMap = f is Map<String, dynamic> ? f : <String, dynamic>{};
                    final fLabel = fMap['label'] ?? fMap['name'] ?? '';
                    final fType = fMap['type'] ?? '';
                    return Chip(
                      label: Text('$fLabel ($fType)'),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 12),
              Text(
                '${l10n.statusesLabel}:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (statuses.isEmpty)
                Text(l10n.noDataAvailable)
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: statuses.map((s) {
                    final sMap = s is Map<String, dynamic> ? s : <String, dynamic>{};
                    final sLabel = sMap['label'] ?? sMap['name'] ?? '';
                    return Chip(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                      label: Text(sLabel.toString()),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.remove_red_eye_outlined),
                label: Text(l10n.previewForm),
                onPressed: () => _showPreviewDialog(context, label, fields),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPreviewDialog(
    BuildContext context,
    String moduleLabel,
    List<dynamic> fields,
  ) {
    final l10n = context.l10n;
    final dialogTitle = '${l10n.previewForm}: $moduleLabel';

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final field in fields) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: field is Map ? (field['label'] ?? '').toString() : '',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
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

  void _showCreateModuleDialog(BuildContext context) {
    final l10n = context.l10n;
    final keyController = TextEditingController();
    final labelController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(l10n.createModuleTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: keyController,
                decoration: InputDecoration(
                  labelText: l10n.moduleKeyLabel,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: labelController,
                decoration: InputDecoration(
                  labelText: l10n.moduleNameLabel,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.actionCompleted)),
                );
              },
              child: Text(l10n.save),
            ),
          ],
        );
      },
    );
  }
}
