// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_report_reminder_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(workReportReminderService)
final workReportReminderServiceProvider = WorkReportReminderServiceProvider._();

final class WorkReportReminderServiceProvider
    extends
        $FunctionalProvider<
          WorkReportReminderService,
          WorkReportReminderService,
          WorkReportReminderService
        >
    with $Provider<WorkReportReminderService> {
  WorkReportReminderServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workReportReminderServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workReportReminderServiceHash();

  @$internal
  @override
  $ProviderElement<WorkReportReminderService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WorkReportReminderService create(Ref ref) {
    return workReportReminderService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkReportReminderService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkReportReminderService>(value),
    );
  }
}

String _$workReportReminderServiceHash() =>
    r'49b581b4cd6f23489cf773d80ec781a753849b90';

@ProviderFor(workReportReminderSync)
final workReportReminderSyncProvider = WorkReportReminderSyncProvider._();

final class WorkReportReminderSyncProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  WorkReportReminderSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workReportReminderSyncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workReportReminderSyncHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return workReportReminderSync(ref);
  }
}

String _$workReportReminderSyncHash() =>
    r'004460fadb56b4600ebf2ee97c505972e1c222c6';
