import 'dart:async';
import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/utils/app_formatters.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';
import 'package:right_ads/features/tasks/data/task_repository.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';
import 'package:right_ads/features/work_reports/data/work_report_repository.dart';
import 'package:right_ads/features/work_reports/domain/work_report_models.dart';
import 'package:right_ads/features/work_reports/domain/work_report_rules.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'work_report_controller.freezed.dart';
part 'work_report_controller.g.dart';

/// Minimum characters the server requires for an item description.
const int kWorkReportMinDescriptionLength = 2;

/// Today's calendar date in the app's configured timezone.
///
/// Matches the server's `get_local_today()`, which the API uses to reject
/// future-dated reports and to evaluate the editable window.
@riverpod
DateTime workReportToday(Ref ref) =>
    ref.watch(appFormattersProvider).todayDate();

/// Work-report limits (max minutes/day, editable window, edit-after-submit)
/// derived from the server-driven runtime config.
@riverpod
WorkReportRules workReportRules(Ref ref) {
  return WorkReportRules.fromConfig(
    ref.watch(runtimeAppConfigControllerProvider),
  );
}

/// UUID of the signed-in employee, or `null` when unauthenticated.
@riverpod
String? workReportCurrentUserId(Ref ref) {
  final authState = ref.watch(sessionControllerProvider);
  if (authState is AuthAuthenticated && authState.user.id.isNotEmpty) {
    return authState.user.id;
  }
  return null;
}

/// Today's report for the signed-in user, or `null` if none exists yet.
///
/// Drives the reminder (skipped once today's report is handed in).
@riverpod
Future<WorkReportModel?> todayWorkReport(Ref ref) async {
  final repo = ref.watch(workReportRepositoryProvider);
  final today = ref.watch(workReportTodayProvider);
  final (report, failure) = await repo.getByDate(today);
  if (failure != null) {
    throw Exception(failure.message ?? failure.toString());
  }
  return report;
}

/// Tasks the employee can attribute time to (assigned tasks).
@riverpod
Future<List<TaskItemModel>> workReportTaskOptions(Ref ref) async {
  final repo = ref.watch(taskRepositoryProvider);
  final config = ref.watch(runtimeAppConfigControllerProvider);
  final maxPageSize = config.maxPageSize;
  final (page, failure) = await repo.getMyTasks(
    filter: const TaskFilterState(),
    pageSize: math.max(1, maxPageSize),
  );
  if (failure != null) {
    throw Exception(failure.message ?? failure.toString());
  }
  return page?.items ?? const <TaskItemModel>[];
}

/// Calendar date (as `yyyy-MM-dd`) currently shown in the editor tab.
/// `null` means "today".
@riverpod
class SelectedWorkReportDate extends _$SelectedWorkReportDate {
  @override
  String? build() => null;

  // Notifier state updates use methods rather than property setters.
  // ignore: use_setters_to_change_properties
  void select(String? isoDate) {
    state = isoDate;
  }
}

/// Form-level problems surfaced by the editor (mapped to l10n in the UI).
enum WorkReportFormError {
  futureDate,
  outsideEditableWindow,
  alreadySubmitted,
  alreadyReviewed,
  noItems,
  totalExceedsMax,
}

/// Row-level problems surfaced next to a specific activity row.
enum WorkReportItemError {
  descriptionTooShort,
  minutesInvalid,
}

/// State of the create/edit report form for one date.
@freezed
abstract class WorkReportEditorState with _$WorkReportEditorState {
  const factory WorkReportEditorState({
    required DateTime date,

    /// The server copy for [date]; `null` until the first save.
    WorkReportModel? report,
    @Default('') String summary,
    @Default(<WorkReportItemDraft>[]) List<WorkReportItemDraft> items,
    @Default(false) bool isSaving,
    @Default(false) bool isSubmitting,
    @Default(false) bool isDirty,
    WorkReportFormError? formError,
    @Default(<String, WorkReportItemError>{})
    Map<String, WorkReportItemError> itemErrors,

    /// Message returned by the server when a save/submit call fails.
    String? serverError,
  }) = _WorkReportEditorState;

  const WorkReportEditorState._();

  /// Sum of all logged minutes (rows with an empty minutes field count 0).
  int get totalMinutes => items.fold(0, (sum, i) => sum + (i.minutes ?? 0));

  bool get isBusy => isSaving || isSubmitting;
}

class _ValidationResult {
  const _ValidationResult({
    required this.payloadItems,
    required this.itemErrors,
    this.formError,
  });

  final List<WorkReportItemPayload> payloadItems;
  final Map<String, WorkReportItemError> itemErrors;
  final WorkReportFormError? formError;

  bool get isValid => formError == null && itemErrors.isEmpty;
}

@riverpod
class WorkReportEditorController extends _$WorkReportEditorController {
  int _idSeed = 0;

  String _newLocalId() => 'row-${_idSeed++}';

  @override
  FutureOr<WorkReportEditorState> build(String dateKey) async {
    final date = WorkReportRules.tryParseIsoDate(dateKey);
    if (date == null) {
      throw ArgumentError.value(dateKey, 'dateKey', 'Expected yyyy-MM-dd');
    }

    final repo = ref.watch(workReportRepositoryProvider);
    final (report, failure) = await repo.getByDate(date);
    if (failure != null) {
      throw Exception(failure.message ?? failure.toString());
    }
    return _stateFromReport(date, report);
  }

  WorkReportEditorState _stateFromReport(
    DateTime date,
    WorkReportModel? report,
  ) {
    final rows = <WorkReportItemDraft>[
      for (final item in report?.items ?? const <WorkReportItemModel>[])
        WorkReportItemDraft.fromItem(item, localId: _newLocalId()),
    ];
    if (rows.isEmpty) {
      rows.add(WorkReportItemDraft(localId: _newLocalId()));
    }
    return WorkReportEditorState(
      date: date,
      report: report,
      summary: report?.summary ?? '',
      items: rows,
    );
  }

  // ---------------------------------------------------------------------------
  // Form mutations
  // ---------------------------------------------------------------------------

  void _mutate(
    WorkReportEditorState Function(WorkReportEditorState s) change, {
    String? clearItemError,
  }) {
    final current = state.value;
    if (current == null || current.isBusy) return;
    final next = change(current);
    final errors = Map<String, WorkReportItemError>.from(next.itemErrors);
    if (clearItemError != null) errors.remove(clearItemError);
    state = AsyncData(
      next.copyWith(
        isDirty: true,
        formError: null,
        serverError: null,
        itemErrors: errors,
      ),
    );
  }

  void _mutateRow(
    String localId,
    WorkReportItemDraft Function(WorkReportItemDraft row) change,
  ) {
    _mutate(
      (s) => s.copyWith(
        items: [
          for (final row in s.items)
            if (row.localId == localId) change(row) else row,
        ],
      ),
      clearItemError: localId,
    );
  }

  void setSummary(String value) {
    _mutate((s) => s.copyWith(summary: value));
  }

  void addItem() {
    _mutate(
      (s) => s.copyWith(
        items: [
          ...s.items,
          WorkReportItemDraft(localId: _newLocalId()),
        ],
      ),
    );
  }

  void removeItem(String localId) {
    _mutate((s) {
      final remaining = s.items.where((r) => r.localId != localId).toList();
      if (remaining.isEmpty) {
        remaining.add(WorkReportItemDraft(localId: _newLocalId()));
      }
      return s.copyWith(items: remaining);
    }, clearItemError: localId);
  }

  void setDescription(String localId, String value) {
    _mutateRow(localId, (r) => r.copyWith(description: value));
  }

  void updateDraftRow(String localId, WorkReportItemDraft updated) {
    _mutateRow(localId, (_) => updated);
  }

  /// Sets minutes from a form field; `null` when empty/unparsable.
  void setMinutes(String localId, int? minutes) {
    _mutateRow(localId, (r) => r.copyWith(minutes: minutes));
  }

  /// Links an assigned task, auto-filling its client and project.
  void setTask(String localId, TaskItemModel? task) {
    _mutateRow(localId, (r) {
      if (task == null) {
        return r.copyWith(taskId: null, taskTitle: null);
      }
      return r.copyWith(
        taskId: task.id,
        taskTitle: task.title,
        clientId: task.clientId ?? r.clientId,
        clientName: task.clientName ?? r.clientName,
        projectId: task.projectId ?? r.projectId,
        projectName: task.projectName ?? r.projectName,
      );
    });
  }

  /// Sets the client. The project is cleared because projects belong to a
  /// single client.
  void setClient(String localId, ClientBriefModel? client) {
    _mutateRow(
      localId,
      (r) => r.copyWith(
        clientId: client?.id,
        clientName: client?.name,
        projectId: null,
        projectName: null,
      ),
    );
  }

  /// Sets the project, adopting its client when none is chosen yet.
  void setProject(
    String localId,
    ProjectBriefModel? project, {
    String? clientName,
  }) {
    _mutateRow(localId, (r) {
      if (project == null) {
        return r.copyWith(projectId: null, projectName: null);
      }
      return r.copyWith(
        projectId: project.id,
        projectName: project.name,
        clientId: r.clientId ?? project.clientId,
        clientName: r.clientName ?? clientName,
      );
    });
  }

  // ---------------------------------------------------------------------------
  // Persistence
  // ---------------------------------------------------------------------------

  /// Saves the form as a draft (or updates an already-submitted report when
  /// the server allows edits until reviewed).
  Future<bool> save() => _persist(submit: false);

  /// Saves the form and submits it for review.
  Future<bool> submit() => _persist(submit: true);

  WorkReportFormError _lockToError(WorkReportLockReason reason) {
    return switch (reason) {
      WorkReportLockReason.futureDate => WorkReportFormError.futureDate,
      WorkReportLockReason.outsideEditableWindow =>
        WorkReportFormError.outsideEditableWindow,
      WorkReportLockReason.submitted => WorkReportFormError.alreadySubmitted,
      WorkReportLockReason.reviewed => WorkReportFormError.alreadyReviewed,
    };
  }

  _ValidationResult _validate(
    WorkReportEditorState s,
    WorkReportRules rules, {
    required bool requireItems,
  }) {
    final errors = <String, WorkReportItemError>{};
    final payload = <WorkReportItemPayload>[];
    var total = 0;

    for (final row in s.items) {
      final blank = row.description.trim().isEmpty && row.minutes == null;
      if (blank) continue;

      if (row.description.trim().length < kWorkReportMinDescriptionLength) {
        errors[row.localId] = WorkReportItemError.descriptionTooShort;
      } else if ((row.minutes ?? 0) <= 0) {
        errors[row.localId] = WorkReportItemError.minutesInvalid;
      } else {
        payload.add(row.toPayload());
        total += row.minutes!;
      }
    }

    WorkReportFormError? formError;
    if (errors.isEmpty) {
      if (requireItems && payload.isEmpty) {
        formError = WorkReportFormError.noItems;
      } else if (rules.exceedsMax(total)) {
        formError = WorkReportFormError.totalExceedsMax;
      }
    }
    return _ValidationResult(
      payloadItems: payload,
      itemErrors: errors,
      formError: formError,
    );
  }

  Future<bool> _persist({required bool submit}) async {
    final current = state.value;
    if (current == null || current.isBusy) return false;

    final rules = ref.read(workReportRulesProvider);
    final today = ref.read(workReportTodayProvider);

    final lock = rules.lockReason(
      date: current.date,
      today: today,
      existingStatus: current.report?.status,
    );
    if (lock != null) {
      state = AsyncData(current.copyWith(formError: _lockToError(lock)));
      return false;
    }

    final validation = _validate(current, rules, requireItems: submit);
    if (!validation.isValid) {
      state = AsyncData(
        current.copyWith(
          formError: validation.formError,
          itemErrors: validation.itemErrors,
          serverError: null,
        ),
      );
      return false;
    }

    state = AsyncData(
      current.copyWith(
        isSaving: !submit,
        isSubmitting: submit,
        formError: null,
        itemErrors: const <String, WorkReportItemError>{},
        serverError: null,
      ),
    );

    final repo = ref.read(workReportRepositoryProvider);
    final trimmedSummary = current.summary.trim();
    final summary = trimmedSummary.isEmpty ? null : trimmedSummary;
    final existing = current.report;

    // 1. Persist the content (create or update).
    final (saved, saveFailure) = existing == null
        ? await repo.createOrSaveDraft(
            WorkReportCreatePayload(
              reportDate: WorkReportRules.toIsoDate(current.date),
              summary: summary,
              items: validation.payloadItems,
            ),
          )
        : await repo.updateReport(
            existing.id,
            WorkReportUpdatePayload(
              summary: summary,
              items: validation.payloadItems,
            ),
          );

    if (saveFailure != null || saved == null) {
      _finish(
        (s) => s.copyWith(
          isSaving: false,
          isSubmitting: false,
          serverError: saveFailure?.message ?? saveFailure?.toString(),
        ),
      );
      return false;
    }

    var result = saved;

    // 2. Hand the report in (only drafts can be submitted).
    if (submit && result.isDraft) {
      final (submitted, submitFailure) = await repo.submitReport(result.id);
      if (submitFailure != null || submitted == null) {
        // Content is saved; keep the draft so the user can retry submitting.
        _finish(
          (s) => s.copyWith(
            report: result,
            isSaving: false,
            isSubmitting: false,
            isDirty: false,
            serverError: submitFailure?.message ?? submitFailure?.toString(),
          ),
        );
        _refreshDependents();
        return false;
      }
      result = submitted;
    }

    _finish(
      (s) => s.copyWith(
        report: result,
        isSaving: false,
        isSubmitting: false,
        isDirty: false,
        serverError: null,
      ),
    );
    _refreshDependents();
    return true;
  }

  void _finish(
    WorkReportEditorState Function(WorkReportEditorState s) change,
  ) {
    final latest = state.value;
    if (latest == null) return;
    state = AsyncData(change(latest));
  }

  void _refreshDependents() {
    ref
      ..invalidate(workReportHistoryControllerProvider)
      ..invalidate(todayWorkReportProvider);
  }
}

/// State for the report history list.
@freezed
abstract class WorkReportHistoryState with _$WorkReportHistoryState {
  const factory WorkReportHistoryState({
    @Default(<WorkReportModel>[]) List<WorkReportModel> items,
    @Default(0) int total,
    @Default(1) int page,
    @Default(false) bool hasMore,
    @Default('all') String statusFilter,
    @Default(false) bool isLoadingMore,
    String? errorMessage,
  }) = _WorkReportHistoryState;
}

@riverpod
class WorkReportHistoryController extends _$WorkReportHistoryController {
  @override
  FutureOr<WorkReportHistoryState> build() => _fetchPage(
    page: 1,
    status: 'all',
  );

  int get _pageSize =>
      ref.read(runtimeAppConfigControllerProvider).defaultPageSize;

  Future<WorkReportHistoryState> _fetchPage({
    required int page,
    required String status,
  }) async {
    final repo = ref.read(workReportRepositoryProvider);
    final (result, failure) = await repo.getMyReports(
      status: status == 'all' ? null : status,
      page: page,
      pageSize: _pageSize,
    );
    if (failure != null) {
      throw Exception(failure.message ?? failure.toString());
    }
    final items = result?.items ?? const <WorkReportModel>[];
    final totalPages = result?.totalPages ?? 1;
    return WorkReportHistoryState(
      items: items,
      total: result?.total ?? items.length,
      page: page,
      hasMore: page < totalPages,
      statusFilter: status,
    );
  }

  Future<void> setStatusFilter(String status) async {
    final current = state.value;
    if (current != null && current.statusFilter == status) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage(page: 1, status: status));
  }

  Future<void> refresh() async {
    final status = state.value?.statusFilter ?? 'all';
    state = await AsyncValue.guard(() => _fetchPage(page: 1, status: status));
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));
    final nextPage = current.page + 1;
    final repo = ref.read(workReportRepositoryProvider);
    final (result, failure) = await repo.getMyReports(
      status: current.statusFilter == 'all' ? null : current.statusFilter,
      page: nextPage,
      pageSize: _pageSize,
    );

    if (failure != null) {
      state = AsyncData(
        current.copyWith(isLoadingMore: false, errorMessage: failure.message),
      );
      return;
    }

    final newItems = result?.items ?? const <WorkReportModel>[];
    final totalPages = result?.totalPages ?? nextPage;
    state = AsyncData(
      current.copyWith(
        items: [...current.items, ...newItems],
        total: result?.total ?? current.total,
        page: nextPage,
        hasMore: nextPage < totalPages,
        isLoadingMore: false,
        errorMessage: null,
      ),
    );
  }
}

/// A single report by id (deep link `/work-reports/:id`).
@riverpod
Future<WorkReportModel> workReportDetail(Ref ref, String id) async {
  final repo = ref.watch(workReportRepositoryProvider);
  final (report, failure) = await repo.getById(id);
  if (failure != null) {
    throw Exception(failure.message ?? failure.toString());
  }
  if (report == null) {
    throw Exception('Work report not found');
  }
  return report;
}
