// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EmployeeDetailController)
final employeeDetailControllerProvider = EmployeeDetailControllerFamily._();

final class EmployeeDetailControllerProvider
    extends $NotifierProvider<EmployeeDetailController, EmployeeDetailState> {
  EmployeeDetailControllerProvider._({
    required EmployeeDetailControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'employeeDetailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$employeeDetailControllerHash();

  @override
  String toString() {
    return r'employeeDetailControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EmployeeDetailController create() => EmployeeDetailController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmployeeDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmployeeDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EmployeeDetailControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$employeeDetailControllerHash() =>
    r'e27ac9fe32ab378b4801f2cd1e0e745f68076da2';

final class EmployeeDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          EmployeeDetailController,
          EmployeeDetailState,
          EmployeeDetailState,
          EmployeeDetailState,
          String
        > {
  EmployeeDetailControllerFamily._()
    : super(
        retry: null,
        name: r'employeeDetailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EmployeeDetailControllerProvider call(String employeeId) =>
      EmployeeDetailControllerProvider._(argument: employeeId, from: this);

  @override
  String toString() => r'employeeDetailControllerProvider';
}

abstract class _$EmployeeDetailController
    extends $Notifier<EmployeeDetailState> {
  late final _$args = ref.$arg as String;
  String get employeeId => _$args;

  EmployeeDetailState build(String employeeId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<EmployeeDetailState, EmployeeDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EmployeeDetailState, EmployeeDetailState>,
              EmployeeDetailState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
