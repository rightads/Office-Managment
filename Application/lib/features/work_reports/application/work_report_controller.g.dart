// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_report_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Today's calendar date in the app's configured timezone.
///
/// Matches the server's `get_local_today()`, which the API uses to reject
/// future-dated reports and to evaluate the editable window.

@ProviderFor(workReportToday)
final workReportTodayProvider = WorkReportTodayProvider._();

/// Today's calendar date in the app's configured timezone.
///
/// Matches the server's `get_local_today()`, which the API uses to reject
/// future-dated reports and to evaluate the editable window.

final class WorkReportTodayProvider
    extends $FunctionalProvider<DateTime, DateTime, DateTime>
    with $Provider<DateTime> {
  /// Today's calendar date in the app's configured timezone.
  ///
  /// Matches the server's `get_local_today()`, which the API uses to reject
  /// future-dated reports and to evaluate the editable window.
  WorkReportTodayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workReportTodayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workReportTodayHash();

  @$internal
  @override
  $ProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DateTime create(Ref ref) {
    return workReportToday(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$workReportTodayHash() => r'd2183d7cc5a2973790b4d2bf0aab4d038b462204';

/// Work-report limits (max minutes/day, editable window, edit-after-submit)
/// derived from the server-driven runtime config.

@ProviderFor(workReportRules)
final workReportRulesProvider = WorkReportRulesProvider._();

/// Work-report limits (max minutes/day, editable window, edit-after-submit)
/// derived from the server-driven runtime config.

final class WorkReportRulesProvider
    extends
        $FunctionalProvider<WorkReportRules, WorkReportRules, WorkReportRules>
    with $Provider<WorkReportRules> {
  /// Work-report limits (max minutes/day, editable window, edit-after-submit)
  /// derived from the server-driven runtime config.
  WorkReportRulesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workReportRulesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workReportRulesHash();

  @$internal
  @override
  $ProviderElement<WorkReportRules> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WorkReportRules create(Ref ref) {
    return workReportRules(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkReportRules value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkReportRules>(value),
    );
  }
}

String _$workReportRulesHash() => r'd8009f7671785785b7889425e8674c4121681e3c';

/// UUID of the signed-in employee, or `null` when unauthenticated.

@ProviderFor(workReportCurrentUserId)
final workReportCurrentUserIdProvider = WorkReportCurrentUserIdProvider._();

/// UUID of the signed-in employee, or `null` when unauthenticated.

final class WorkReportCurrentUserIdProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  /// UUID of the signed-in employee, or `null` when unauthenticated.
  WorkReportCurrentUserIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workReportCurrentUserIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workReportCurrentUserIdHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return workReportCurrentUserId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$workReportCurrentUserIdHash() =>
    r'3386c571682aa7624dd3f38e0af3a2d7c6b6cae4';

/// Today's report for the signed-in user, or `null` if none exists yet.
///
/// Drives the reminder (skipped once today's report is handed in).

@ProviderFor(todayWorkReport)
final todayWorkReportProvider = TodayWorkReportProvider._();

/// Today's report for the signed-in user, or `null` if none exists yet.
///
/// Drives the reminder (skipped once today's report is handed in).

final class TodayWorkReportProvider
    extends
        $FunctionalProvider<
          AsyncValue<WorkReportModel?>,
          WorkReportModel?,
          FutureOr<WorkReportModel?>
        >
    with $FutureModifier<WorkReportModel?>, $FutureProvider<WorkReportModel?> {
  /// Today's report for the signed-in user, or `null` if none exists yet.
  ///
  /// Drives the reminder (skipped once today's report is handed in).
  TodayWorkReportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayWorkReportProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayWorkReportHash();

  @$internal
  @override
  $FutureProviderElement<WorkReportModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WorkReportModel?> create(Ref ref) {
    return todayWorkReport(ref);
  }
}

String _$todayWorkReportHash() => r'87d717634fa5e70bb3cc0e99de02ffd2dfb6cd2d';

/// Tasks the employee can attribute time to (assigned tasks).

@ProviderFor(workReportTaskOptions)
final workReportTaskOptionsProvider = WorkReportTaskOptionsProvider._();

/// Tasks the employee can attribute time to (assigned tasks).

final class WorkReportTaskOptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TaskItemModel>>,
          List<TaskItemModel>,
          FutureOr<List<TaskItemModel>>
        >
    with
        $FutureModifier<List<TaskItemModel>>,
        $FutureProvider<List<TaskItemModel>> {
  /// Tasks the employee can attribute time to (assigned tasks).
  WorkReportTaskOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workReportTaskOptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workReportTaskOptionsHash();

  @$internal
  @override
  $FutureProviderElement<List<TaskItemModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TaskItemModel>> create(Ref ref) {
    return workReportTaskOptions(ref);
  }
}

String _$workReportTaskOptionsHash() =>
    r'c6675bf62db0650845a4d6d6da36de1af67d0573';

/// Calendar date (as `yyyy-MM-dd`) currently shown in the editor tab.
/// `null` means "today".

@ProviderFor(SelectedWorkReportDate)
final selectedWorkReportDateProvider = SelectedWorkReportDateProvider._();

/// Calendar date (as `yyyy-MM-dd`) currently shown in the editor tab.
/// `null` means "today".
final class SelectedWorkReportDateProvider
    extends $NotifierProvider<SelectedWorkReportDate, String?> {
  /// Calendar date (as `yyyy-MM-dd`) currently shown in the editor tab.
  /// `null` means "today".
  SelectedWorkReportDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedWorkReportDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedWorkReportDateHash();

  @$internal
  @override
  SelectedWorkReportDate create() => SelectedWorkReportDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedWorkReportDateHash() =>
    r'932d4506a6c39b8086ecf32b438b1f3d576ca2bf';

/// Calendar date (as `yyyy-MM-dd`) currently shown in the editor tab.
/// `null` means "today".

abstract class _$SelectedWorkReportDate extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(WorkReportEditorController)
final workReportEditorControllerProvider = WorkReportEditorControllerFamily._();

final class WorkReportEditorControllerProvider
    extends
        $AsyncNotifierProvider<
          WorkReportEditorController,
          WorkReportEditorState
        > {
  WorkReportEditorControllerProvider._({
    required WorkReportEditorControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'workReportEditorControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$workReportEditorControllerHash();

  @override
  String toString() {
    return r'workReportEditorControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  WorkReportEditorController create() => WorkReportEditorController();

  @override
  bool operator ==(Object other) {
    return other is WorkReportEditorControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$workReportEditorControllerHash() =>
    r'741ddaf8b97d3117d8b3e0e7017c7db3832661ca';

final class WorkReportEditorControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          WorkReportEditorController,
          AsyncValue<WorkReportEditorState>,
          WorkReportEditorState,
          FutureOr<WorkReportEditorState>,
          String
        > {
  WorkReportEditorControllerFamily._()
    : super(
        retry: null,
        name: r'workReportEditorControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WorkReportEditorControllerProvider call(String dateKey) =>
      WorkReportEditorControllerProvider._(argument: dateKey, from: this);

  @override
  String toString() => r'workReportEditorControllerProvider';
}

abstract class _$WorkReportEditorController
    extends $AsyncNotifier<WorkReportEditorState> {
  late final _$args = ref.$arg as String;
  String get dateKey => _$args;

  FutureOr<WorkReportEditorState> build(String dateKey);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<WorkReportEditorState>, WorkReportEditorState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<WorkReportEditorState>,
                WorkReportEditorState
              >,
              AsyncValue<WorkReportEditorState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(WorkReportHistoryController)
final workReportHistoryControllerProvider =
    WorkReportHistoryControllerProvider._();

final class WorkReportHistoryControllerProvider
    extends
        $AsyncNotifierProvider<
          WorkReportHistoryController,
          WorkReportHistoryState
        > {
  WorkReportHistoryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workReportHistoryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workReportHistoryControllerHash();

  @$internal
  @override
  WorkReportHistoryController create() => WorkReportHistoryController();
}

String _$workReportHistoryControllerHash() =>
    r'e7481cec8ec4096b5d3bbd6eda0dabe1a0990c40';

abstract class _$WorkReportHistoryController
    extends $AsyncNotifier<WorkReportHistoryState> {
  FutureOr<WorkReportHistoryState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<WorkReportHistoryState>, WorkReportHistoryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<WorkReportHistoryState>,
                WorkReportHistoryState
              >,
              AsyncValue<WorkReportHistoryState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// A single report by id (deep link `/work-reports/:id`).

@ProviderFor(workReportDetail)
final workReportDetailProvider = WorkReportDetailFamily._();

/// A single report by id (deep link `/work-reports/:id`).

final class WorkReportDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<WorkReportModel>,
          WorkReportModel,
          FutureOr<WorkReportModel>
        >
    with $FutureModifier<WorkReportModel>, $FutureProvider<WorkReportModel> {
  /// A single report by id (deep link `/work-reports/:id`).
  WorkReportDetailProvider._({
    required WorkReportDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'workReportDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$workReportDetailHash();

  @override
  String toString() {
    return r'workReportDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WorkReportModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WorkReportModel> create(Ref ref) {
    final argument = this.argument as String;
    return workReportDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkReportDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$workReportDetailHash() => r'f8ac9ae1108320238e281984b8b1b3da6698ddbe';

/// A single report by id (deep link `/work-reports/:id`).

final class WorkReportDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<WorkReportModel>, String> {
  WorkReportDetailFamily._()
    : super(
        retry: null,
        name: r'workReportDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A single report by id (deep link `/work-reports/:id`).

  WorkReportDetailProvider call(String id) =>
      WorkReportDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'workReportDetailProvider';
}
