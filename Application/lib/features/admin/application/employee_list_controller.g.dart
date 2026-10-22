// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EmployeeListController)
final employeeListControllerProvider = EmployeeListControllerProvider._();

final class EmployeeListControllerProvider
    extends $NotifierProvider<EmployeeListController, EmployeeListState> {
  EmployeeListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'employeeListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$employeeListControllerHash();

  @$internal
  @override
  EmployeeListController create() => EmployeeListController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmployeeListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmployeeListState>(value),
    );
  }
}

String _$employeeListControllerHash() =>
    r'ee28d74419012dc16d2a4d2566afeb5514ce5b34';

abstract class _$EmployeeListController extends $Notifier<EmployeeListState> {
  EmployeeListState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<EmployeeListState, EmployeeListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EmployeeListState, EmployeeListState>,
              EmployeeListState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
