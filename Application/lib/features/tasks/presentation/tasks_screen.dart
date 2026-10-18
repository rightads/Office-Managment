import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/paged_list_view.dart';
import 'package:right_ads/features/tasks/application/task_list_controller.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';
import 'package:right_ads/features/tasks/presentation/widgets/task_card_widget.dart';
import 'package:right_ads/features/tasks/presentation/widgets/task_filter_bottom_sheet.dart';

/// Employee Tasks List Screen providing dynamic workflow status tabs, multi-criteria
/// filtering, search, sorting, infinite scroll pagination, and pull-to-refresh.
class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({
    this.isRootNavigation = true,
    super.key,
  });

  final bool isRootNavigation;

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  TabController? _tabController;
  List<TaskStatusModel> _cachedStatuses = <TaskStatusModel>[];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    ref
        .read(taskListControllerProvider.notifier)
        .setSearch(
          _searchController.text,
        );
  }

  void _updateTabController(List<TaskStatusModel> statuses) {
    if (_cachedStatuses.length == statuses.length &&
        _tabController != null &&
        _tabController!.length == statuses.length + 1) {
      return;
    }

    _cachedStatuses = statuses;
    _tabController?.dispose();
    _tabController = TabController(
      length: statuses.length + 1,
      vsync: this,
    )..addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController == null || _tabController!.indexIsChanging) return;
    final index = _tabController!.index;
    if (index == 0) {
      ref.read(taskListControllerProvider.notifier).selectStatusTab(null);
    } else {
      final status = _cachedStatuses[index - 1];
      ref.read(taskListControllerProvider.notifier).selectStatusTab(status.id);
    }
  }

  int _countActiveFilters(TaskFilterState filter) {
    var count = 0;
    if (filter.priorityId != null) count++;
    if (filter.departmentId != null) count++;
    if (filter.clientId != null) count++;
    if (filter.projectId != null) count++;
    if (filter.isOverdue == true) count++;
    if (filter.dueFrom != null || filter.dueTo != null) count++;
    return count;
  }

  Future<void> _openFilterSheet(
    BuildContext context,
    TaskFilterState currentFilter,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TaskFilterBottomSheet(
        initialFilter: currentFilter,
        onApply: (newFilter) {
          ref.read(taskListControllerProvider.notifier).applyFilter(newFilter);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final statusesAsync = ref.watch(taskStatusesProvider);
    final taskListState = ref.watch(taskListControllerProvider);
    final activeFiltersCount = _countActiveFilters(taskListState.filter);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tasksTitle),
        automaticallyImplyLeading: !widget.isRootNavigation,
        actions: <Widget>[
          // Filter Bottom Sheet Button with Badge
          Badge(
            isLabelVisible: activeFiltersCount > 0,
            label: Text('$activeFiltersCount'),
            child: IconButton(
              icon: const Icon(Icons.filter_list),
              tooltip: l10n.taskFilterTooltip,
              onPressed: () => _openFilterSheet(context, taskListState.filter),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(108),
          child: Column(
            children: <Widget>[
              // Search Field
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: l10n.taskSearchPlaceholder,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              ref
                                  .read(taskListControllerProvider.notifier)
                                  .setSearch('');
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.5,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // Server-Driven Workflow Status Tabs
              statusesAsync.when(
                data: (statuses) {
                  _updateTabController(statuses);
                  if (_tabController == null) {
                    return const SizedBox.shrink();
                  }
                  return TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelColor: colorScheme.primary,
                    unselectedLabelColor: colorScheme.onSurfaceVariant,
                    indicatorColor: colorScheme.primary,
                    tabs: <Widget>[
                      Tab(text: l10n.taskStatusTabAll),
                      for (final st in statuses) Tab(text: st.label),
                    ],
                  );
                },
                loading: () => const SizedBox(
                  height: 48,
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
                error: (_, _) => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
      body: PagedListView<TaskItemModel>(
        items: taskListState.tasks,
        isInitialLoading: taskListState.isLoading,
        isLoadingMore: taskListState.isLoadingNextPage,
        hasMore: taskListState.hasMore,
        errorMessage: taskListState.errorMessage,
        emptyTitle: l10n.taskEmptyStateTitle,
        emptySubtitle: l10n.taskEmptyStateSubtitle,
        emptyIcon: Icons.task_alt_outlined,
        onRefresh: () =>
            ref.read(taskListControllerProvider.notifier).refresh(),
        onLoadMore: () =>
            ref.read(taskListControllerProvider.notifier).loadNextPage(),
        itemBuilder: (context, task, index) {
          return TaskCardWidget(
            task: task,
            onTap: () async {
              await context.push(
                RoutePaths.taskDetail.replaceFirst(':id', task.id),
              );
            },
          );
        },
      ),
    );
  }
}
