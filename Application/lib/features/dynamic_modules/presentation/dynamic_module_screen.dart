import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/error_state.dart';
import 'package:right_ads/core/widgets/loading_skeleton.dart';
import 'package:right_ads/features/dynamic_modules/application/dynamic_module_controller.dart';
import 'package:right_ads/features/dynamic_modules/data/dynamic_module_repository.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';
import 'package:right_ads/features/dynamic_modules/presentation/widgets/dynamic_module_summary_strip.dart';
import 'package:right_ads/features/dynamic_modules/presentation/widgets/dynamic_record_card.dart';
import 'package:right_ads/features/dynamic_modules/presentation/widgets/dynamic_record_detail_screen.dart';
import 'package:right_ads/features/dynamic_modules/presentation/widgets/dynamic_record_form_screen.dart';

/// Top-level dynamic module screen rendering records, search, filter chips,
/// summary aggregates, infinite scroll, exports, and creation FAB.
class DynamicModuleScreen extends ConsumerStatefulWidget {
  const DynamicModuleScreen({
    required this.moduleCode,
    this.initialLabel,
    super.key,
  });

  final String moduleCode;
  final String? initialLabel;

  @override
  ConsumerState<DynamicModuleScreen> createState() =>
      _DynamicModuleScreenState();
}

class _DynamicModuleScreenState extends ConsumerState<DynamicModuleScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  DynamicModuleDefinition? _definition;
  bool _isLoadingDefinition = true;
  String? _definitionError;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadDefinition();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(dynamicRecordListControllerProvider(widget.moduleCode).notifier)
          .loadNextPage();
    }
  }

  Future<void> _loadDefinition() async {
    setState(() {
      _isLoadingDefinition = true;
      _definitionError = null;
    });

    final def = await ref
        .read(moduleDefinitionCacheProvider.notifier)
        .getOrFetch(widget.moduleCode);

    if (!mounted) return;

    if (def != null) {
      setState(() {
        _definition = def;
        _isLoadingDefinition = false;
      });
    } else {
      setState(() {
        _isLoadingDefinition = false;
        _definitionError =
            'Failed to load module schema for ${widget.moduleCode}.';
      });
    }
  }

  Future<void> _handleExport(String format) async {
    final repo = ref.read(dynamicModuleRepositoryProvider);
    AppSnackbar.showSuccess(context, 'Exporting $format...');
    final (bytes, _, failure) = await repo.exportRecords(
      widget.moduleCode,
      format: format,
    );
    if (!mounted) return;
    if (failure != null || bytes == null) {
      AppSnackbar.showError(context, 'Export failed');
    } else {
      AppSnackbar.showSuccess(
        context,
        'Export ready (${bytes.length} bytes downloaded)',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    if (_isLoadingDefinition) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.initialLabel ?? widget.moduleCode)),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: LoadingSkeletonList(itemCount: 4),
        ),
      );
    }

    if (_definitionError != null || _definition == null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.initialLabel ?? widget.moduleCode)),
        body: ErrorState(
          message: _definitionError ?? 'Schema unavailable',
          onRetry: _loadDefinition,
        ),
      );
    }

    final def = _definition!;
    final listState = ref.watch(dynamicRecordListControllerProvider(def.code));
    final summaryAsync = ref.watch(moduleSummaryProvider(def.code));

    // Permission checks
    final canManage = ref.can('modules.manage');
    final canCreate = canManage || ref.can('module.${def.code}.create');
    final canExport = canManage || ref.can('module.${def.code}.export');

    return Scaffold(
      appBar: AppBar(
        title: Text(def.label),
        actions: <Widget>[
          if (canExport)
            PopupMenuButton<String>(
              icon: const Icon(Icons.file_download_outlined),
              tooltip: 'Export',
              onSelected: _handleExport,
              itemBuilder: (ctx) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'csv',
                  child: Text(l10n.dynamicModuleExportCsv),
                ),
                PopupMenuItem<String>(
                  value: 'xlsx',
                  child: Text(l10n.dynamicModuleExportXlsx),
                ),
              ],
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              ref
                  .read(dynamicRecordListControllerProvider(def.code).notifier)
                  .refresh();
              ref.invalidate(moduleSummaryProvider(def.code));
            },
          ),
        ],
      ),
      floatingActionButton: canCreate
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              label: Text(l10n.dynamicModuleNewRecord(def.recordLabelSingular)),
              onPressed: () async {
                final created = await Navigator.of(context).push<bool>(
                  MaterialPageRoute<bool>(
                    builder: (ctx) => DynamicRecordFormScreen(definition: def),
                  ),
                );
                if (created == true) {
                  await ref
                      .read(
                        dynamicRecordListControllerProvider(def.code).notifier,
                      )
                      .refresh();
                  ref.invalidate(moduleSummaryProvider(def.code));
                }
              },
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(dynamicRecordListControllerProvider(def.code).notifier)
              .refresh();
          ref.invalidate(moduleSummaryProvider(def.code));
        },
        child: Column(
          children: <Widget>[
            // Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: l10n.dynamicModuleSearchHint(def.recordLabelPlural),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            ref
                                .read(
                                  dynamicRecordListControllerProvider(
                                    def.code,
                                  ).notifier,
                                )
                                .setSearch('');
                          },
                        )
                      : null,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (query) {
                  ref
                      .read(
                        dynamicRecordListControllerProvider(def.code).notifier,
                      )
                      .setSearch(query);
                },
              ),
            ),

            // Summary Strip & Filter chips
            summaryAsync.when(
              data: (summary) {
                if (summary == null) return const SizedBox.shrink();
                return DynamicModuleSummaryStrip(
                  summary: summary,
                  definition: def,
                  selectedStatus: listState.statusFilter,
                  onStatusSelected: (status) {
                    ref
                        .read(
                          dynamicRecordListControllerProvider(
                            def.code,
                          ).notifier,
                        )
                        .setStatusFilter(status);
                  },
                );
              },
              loading: () => const SizedBox(height: 48),
              error: (_, _) => const SizedBox.shrink(),
            ),

            const SizedBox(height: 4),

            // Records List
            Expanded(
              child: Builder(
                builder: (context) {
                  if (listState.isLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: LoadingSkeletonList(itemCount: 4),
                    );
                  }

                  if (listState.failure != null) {
                    return ErrorState(
                      message:
                          listState.failure?.message ??
                          'Failed to load records',
                      onRetry: () => ref
                          .read(
                            dynamicRecordListControllerProvider(
                              def.code,
                            ).notifier,
                          )
                          .refresh(),
                    );
                  }

                  if (listState.records.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.folder_open_outlined,
                            size: 48,
                            color: colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.dynamicModuleNoRecordsFound(
                              def.recordLabelPlural,
                            ),
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    itemCount:
                        listState.records.length +
                        (listState.isFetchingNextPage ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == listState.records.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final record = listState.records[index];
                      return DynamicRecordCard(
                        record: record,
                        definition: def,
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (ctx) => DynamicRecordDetailScreen(
                                definition: def,
                                recordId: record.id,
                              ),
                            ),
                          );
                          await ref
                              .read(
                                dynamicRecordListControllerProvider(
                                  def.code,
                                ).notifier,
                              )
                              .refresh();
                          ref.invalidate(moduleSummaryProvider(def.code));
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
