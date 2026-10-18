import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/widgets/status_chip.dart';
import 'package:right_ads/features/tasks/application/task_list_controller.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';

/// Modal bottom sheet allowing employees to filter and sort their tasks
/// across priority, department, client, project, due range, and overdue state.
class TaskFilterBottomSheet extends ConsumerStatefulWidget {
  const TaskFilterBottomSheet({
    required this.initialFilter,
    required this.onApply,
    super.key,
  });

  final TaskFilterState initialFilter;
  final ValueChanged<TaskFilterState> onApply;

  @override
  ConsumerState<TaskFilterBottomSheet> createState() =>
      _TaskFilterBottomSheetState();
}

class _TaskFilterBottomSheetState extends ConsumerState<TaskFilterBottomSheet> {
  late String? _priorityId;
  late String? _departmentId;
  late String? _clientId;
  late String? _projectId;
  late bool? _isOverdue;
  late DateTime? _dueFrom;
  late DateTime? _dueTo;
  late String _sortBy;
  late bool _sortDesc;

  @override
  void initState() {
    super.initState();
    _priorityId = widget.initialFilter.priorityId;
    _departmentId = widget.initialFilter.departmentId;
    _clientId = widget.initialFilter.clientId;
    _projectId = widget.initialFilter.projectId;
    _isOverdue = widget.initialFilter.isOverdue;
    _dueFrom = widget.initialFilter.dueFrom;
    _dueTo = widget.initialFilter.dueTo;
    _sortBy = widget.initialFilter.sortBy;
    _sortDesc = widget.initialFilter.sortDesc;
  }

  void _reset() {
    setState(() {
      _priorityId = null;
      _departmentId = null;
      _clientId = null;
      _projectId = null;
      _isOverdue = null;
      _dueFrom = null;
      _dueTo = null;
      _sortBy = 'created_at';
      _sortDesc = true;
    });
  }

  void _apply() {
    final updated = widget.initialFilter.copyWith(
      priorityId: _priorityId,
      departmentId: _departmentId,
      clientId: _clientId,
      projectId: _projectId,
      isOverdue: _isOverdue,
      dueFrom: _dueFrom,
      dueTo: _dueTo,
      sortBy: _sortBy,
      sortDesc: _sortDesc,
    );
    widget.onApply(updated);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final prioritiesAsync = ref.watch(taskPrioritiesProvider);
    final departmentsAsync = ref.watch(taskDepartmentsProvider);
    final clientsAsync = ref.watch(taskClientsProvider);
    final projectsAsync = ref.watch(taskProjectsProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppRadius.lg),
            ),
          ),
          child: Column(
            children: <Widget>[
              // Sheet Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      l10n.taskFilterSheetTitle,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: _reset,
                      child: Text(l10n.taskFilterResetButton),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // Filter Body
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: <Widget>[
                    // Overdue Only Switch
                    SwitchListTile(
                      title: Text(l10n.taskFilterOverdueOnlyLabel),
                      subtitle: Text(l10n.taskFilterOverdueOnlySubtitle),
                      value: _isOverdue == true,
                      onChanged: (val) {
                        setState(() {
                          _isOverdue = val ? true : null;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Priority Filter
                    Text(
                      l10n.taskPriorityLabel,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    prioritiesAsync.when(
                      data: (priorities) => Wrap(
                        spacing: AppSpacing.xs,
                        runSpacing: AppSpacing.xs,
                        children: <Widget>[
                          ChoiceChip(
                            label: Text(l10n.taskFilterAllPriorities),
                            selected: _priorityId == null,
                            onSelected: (_) =>
                                setState(() => _priorityId = null),
                          ),
                          for (final p in priorities)
                            ChoiceChip(
                              label: StatusChip(
                                label: p.label,
                                hexColor: p.color,
                              ),
                              selected: _priorityId == p.id,
                              onSelected: (selected) => setState(
                                () => _priorityId = selected ? p.id : null,
                              ),
                            ),
                        ],
                      ),
                      loading: () => const LinearProgressIndicator(),
                      error: (_, _) => const SizedBox.shrink(),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Department Filter
                    Text(
                      l10n.taskDepartmentLabel,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    departmentsAsync.when(
                      data: (depts) => DropdownButtonFormField<String?>(
                        initialValue: _departmentId,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          hintText: l10n.taskFilterAllDepartments,
                        ),
                        items: <DropdownMenuItem<String?>>[
                          DropdownMenuItem<String?>(
                            child: Text(l10n.taskFilterAllDepartments),
                          ),
                          for (final d in depts)
                            DropdownMenuItem<String?>(
                              value: d.id,
                              child: Text(d.name),
                            ),
                        ],
                        onChanged: (val) => setState(() => _departmentId = val),
                      ),
                      loading: () => const SizedBox.shrink(),
                      error: (_, _) => const SizedBox.shrink(),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Client Filter
                    Text(
                      l10n.taskClientLabel,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    clientsAsync.when(
                      data: (clients) => DropdownButtonFormField<String?>(
                        initialValue: _clientId,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          hintText: l10n.taskFilterAllClients,
                        ),
                        items: <DropdownMenuItem<String?>>[
                          DropdownMenuItem<String?>(
                            child: Text(l10n.taskFilterAllClients),
                          ),
                          for (final c in clients)
                            DropdownMenuItem<String?>(
                              value: c.id,
                              child: Text(c.name),
                            ),
                        ],
                        onChanged: (val) => setState(() => _clientId = val),
                      ),
                      loading: () => const SizedBox.shrink(),
                      error: (_, _) => const SizedBox.shrink(),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Project Filter
                    Text(
                      l10n.taskProjectLabel,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    projectsAsync.when(
                      data: (projects) => DropdownButtonFormField<String?>(
                        initialValue: _projectId,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          hintText: l10n.taskFilterAllProjects,
                        ),
                        items: <DropdownMenuItem<String?>>[
                          DropdownMenuItem<String?>(
                            child: Text(l10n.taskFilterAllProjects),
                          ),
                          for (final p in projects)
                            DropdownMenuItem<String?>(
                              value: p.id,
                              child: Text(p.name),
                            ),
                        ],
                        onChanged: (val) => setState(() => _projectId = val),
                      ),
                      loading: () => const SizedBox.shrink(),
                      error: (_, _) => const SizedBox.shrink(),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Due Date Range
                    Text(
                      l10n.taskFilterDueRangeLabel,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.calendar_today, size: 16),
                            label: Text(
                              _dueFrom != null
                                  ? DateFormat('d MMM y').format(_dueFrom!)
                                  : l10n.taskFilterDueFrom,
                            ),
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: _dueFrom ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2035),
                              );
                              if (picked != null) {
                                setState(() => _dueFrom = picked);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.event, size: 16),
                            label: Text(
                              _dueTo != null
                                  ? DateFormat('d MMM y').format(_dueTo!)
                                  : l10n.taskFilterDueTo,
                            ),
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: _dueTo ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2035),
                              );
                              if (picked != null) {
                                setState(() => _dueTo = picked);
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Sort By & Direction
                    Text(
                      l10n.taskSortByLabel,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _sortBy,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xs,
                              ),
                            ),
                            items: <DropdownMenuItem<String>>[
                              DropdownMenuItem(
                                value: 'created_at',
                                child: Text(l10n.taskSortCreated),
                              ),
                              DropdownMenuItem(
                                value: 'due_at',
                                child: Text(l10n.taskSortDue),
                              ),
                              DropdownMenuItem(
                                value: 'title',
                                child: Text(l10n.taskSortTitle),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _sortBy = val);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        IconButton.outlined(
                          icon: Icon(
                            _sortDesc
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                          ),
                          tooltip: _sortDesc
                              ? l10n.taskSortDescending
                              : l10n.taskSortAscending,
                          onPressed: () =>
                              setState(() => _sortDesc = !_sortDesc),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom Apply Button
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _apply,
                    child: Text(l10n.taskFilterApplyButton),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
