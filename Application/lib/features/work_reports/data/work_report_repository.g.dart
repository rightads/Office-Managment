// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_report_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(workReportRepository)
final workReportRepositoryProvider = WorkReportRepositoryProvider._();

final class WorkReportRepositoryProvider
    extends
        $FunctionalProvider<
          WorkReportRepository,
          WorkReportRepository,
          WorkReportRepository
        >
    with $Provider<WorkReportRepository> {
  WorkReportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workReportRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workReportRepositoryHash();

  @$internal
  @override
  $ProviderElement<WorkReportRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WorkReportRepository create(Ref ref) {
    return workReportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkReportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkReportRepository>(value),
    );
  }
}

String _$workReportRepositoryHash() =>
    r'c356d31d51a8e7155588d8113df22646be41af4f';
