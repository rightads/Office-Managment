// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Currently selected calendar year for leave queries.

@ProviderFor(SelectedLeaveYearController)
final selectedLeaveYearControllerProvider =
    SelectedLeaveYearControllerProvider._();

/// Currently selected calendar year for leave queries.
final class SelectedLeaveYearControllerProvider
    extends $NotifierProvider<SelectedLeaveYearController, int> {
  /// Currently selected calendar year for leave queries.
  SelectedLeaveYearControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedLeaveYearControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedLeaveYearControllerHash();

  @$internal
  @override
  SelectedLeaveYearController create() => SelectedLeaveYearController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$selectedLeaveYearControllerHash() =>
    r'be7a29fb40f15ff58b0a8932c08ac6140ece35b2';

/// Currently selected calendar year for leave queries.

abstract class _$SelectedLeaveYearController extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Provider for active leave categories.

@ProviderFor(leaveTypes)
final leaveTypesProvider = LeaveTypesProvider._();

/// Provider for active leave categories.

final class LeaveTypesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LeaveTypeModel>>,
          List<LeaveTypeModel>,
          FutureOr<List<LeaveTypeModel>>
        >
    with
        $FutureModifier<List<LeaveTypeModel>>,
        $FutureProvider<List<LeaveTypeModel>> {
  /// Provider for active leave categories.
  LeaveTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'leaveTypesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$leaveTypesHash();

  @$internal
  @override
  $FutureProviderElement<List<LeaveTypeModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LeaveTypeModel>> create(Ref ref) {
    return leaveTypes(ref);
  }
}

String _$leaveTypesHash() => r'f9fac2466cd302488ba13a978491861baf75bb12';

/// Provider for employee leave balances for a specific or current year.

@ProviderFor(leaveBalances)
final leaveBalancesProvider = LeaveBalancesFamily._();

/// Provider for employee leave balances for a specific or current year.

final class LeaveBalancesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LeaveBalanceModel>>,
          List<LeaveBalanceModel>,
          FutureOr<List<LeaveBalanceModel>>
        >
    with
        $FutureModifier<List<LeaveBalanceModel>>,
        $FutureProvider<List<LeaveBalanceModel>> {
  /// Provider for employee leave balances for a specific or current year.
  LeaveBalancesProvider._({
    required LeaveBalancesFamily super.from,
    required int? super.argument,
  }) : super(
         retry: null,
         name: r'leaveBalancesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$leaveBalancesHash();

  @override
  String toString() {
    return r'leaveBalancesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<LeaveBalanceModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LeaveBalanceModel>> create(Ref ref) {
    final argument = this.argument as int?;
    return leaveBalances(ref, year: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LeaveBalancesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$leaveBalancesHash() => r'b51820f8bf6f342c1b4f8a4edeb06b419c43e82e';

/// Provider for employee leave balances for a specific or current year.

final class LeaveBalancesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<LeaveBalanceModel>>, int?> {
  LeaveBalancesFamily._()
    : super(
        retry: null,
        name: r'leaveBalancesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for employee leave balances for a specific or current year.

  LeaveBalancesProvider call({int? year}) =>
      LeaveBalancesProvider._(argument: year, from: this);

  @override
  String toString() => r'leaveBalancesProvider';
}

/// Provider for calendar holidays for a specific or current year.

@ProviderFor(holidays)
final holidaysProvider = HolidaysFamily._();

/// Provider for calendar holidays for a specific or current year.

final class HolidaysProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HolidayModel>>,
          List<HolidayModel>,
          FutureOr<List<HolidayModel>>
        >
    with
        $FutureModifier<List<HolidayModel>>,
        $FutureProvider<List<HolidayModel>> {
  /// Provider for calendar holidays for a specific or current year.
  HolidaysProvider._({
    required HolidaysFamily super.from,
    required int? super.argument,
  }) : super(
         retry: null,
         name: r'holidaysProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$holidaysHash();

  @override
  String toString() {
    return r'holidaysProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<HolidayModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HolidayModel>> create(Ref ref) {
    final argument = this.argument as int?;
    return holidays(ref, year: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HolidaysProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$holidaysHash() => r'14b328d4f121c01d0aa17361f9dd9b593cc7ac83';

/// Provider for calendar holidays for a specific or current year.

final class HolidaysFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<HolidayModel>>, int?> {
  HolidaysFamily._()
    : super(
        retry: null,
        name: r'holidaysProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for calendar holidays for a specific or current year.

  HolidaysProvider call({int? year}) =>
      HolidaysProvider._(argument: year, from: this);

  @override
  String toString() => r'holidaysProvider';
}

@ProviderFor(LeaveRequestsController)
final leaveRequestsControllerProvider = LeaveRequestsControllerProvider._();

final class LeaveRequestsControllerProvider
    extends
        $AsyncNotifierProvider<LeaveRequestsController, LeaveRequestsState> {
  LeaveRequestsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'leaveRequestsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$leaveRequestsControllerHash();

  @$internal
  @override
  LeaveRequestsController create() => LeaveRequestsController();
}

String _$leaveRequestsControllerHash() =>
    r'f349caa93ebbe667013574eb69f70c33ee12d90d';

abstract class _$LeaveRequestsController
    extends $AsyncNotifier<LeaveRequestsState> {
  FutureOr<LeaveRequestsState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<LeaveRequestsState>, LeaveRequestsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LeaveRequestsState>, LeaveRequestsState>,
              AsyncValue<LeaveRequestsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(LeaveApplyController)
final leaveApplyControllerProvider = LeaveApplyControllerProvider._();

final class LeaveApplyControllerProvider
    extends $NotifierProvider<LeaveApplyController, LeaveApplyState> {
  LeaveApplyControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'leaveApplyControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$leaveApplyControllerHash();

  @$internal
  @override
  LeaveApplyController create() => LeaveApplyController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LeaveApplyState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LeaveApplyState>(value),
    );
  }
}

String _$leaveApplyControllerHash() =>
    r'8ffbe9da76a9f80851ba8667bbd430b94a32a2c2';

abstract class _$LeaveApplyController extends $Notifier<LeaveApplyState> {
  LeaveApplyState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<LeaveApplyState, LeaveApplyState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LeaveApplyState, LeaveApplyState>,
              LeaveApplyState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Controller for single leave request details (for deep link `/leaves/:id`).

@ProviderFor(LeaveDetailController)
final leaveDetailControllerProvider = LeaveDetailControllerFamily._();

/// Controller for single leave request details (for deep link `/leaves/:id`).
final class LeaveDetailControllerProvider
    extends $AsyncNotifierProvider<LeaveDetailController, LeaveRequestModel> {
  /// Controller for single leave request details (for deep link `/leaves/:id`).
  LeaveDetailControllerProvider._({
    required LeaveDetailControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'leaveDetailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$leaveDetailControllerHash();

  @override
  String toString() {
    return r'leaveDetailControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LeaveDetailController create() => LeaveDetailController();

  @override
  bool operator ==(Object other) {
    return other is LeaveDetailControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$leaveDetailControllerHash() =>
    r'b30b9a5267a28ed133d0eb930b8153aba13bcbc5';

/// Controller for single leave request details (for deep link `/leaves/:id`).

final class LeaveDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          LeaveDetailController,
          AsyncValue<LeaveRequestModel>,
          LeaveRequestModel,
          FutureOr<LeaveRequestModel>,
          String
        > {
  LeaveDetailControllerFamily._()
    : super(
        retry: null,
        name: r'leaveDetailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Controller for single leave request details (for deep link `/leaves/:id`).

  LeaveDetailControllerProvider call(String leaveId) =>
      LeaveDetailControllerProvider._(argument: leaveId, from: this);

  @override
  String toString() => r'leaveDetailControllerProvider';
}

/// Controller for single leave request details (for deep link `/leaves/:id`).

abstract class _$LeaveDetailController
    extends $AsyncNotifier<LeaveRequestModel> {
  late final _$args = ref.$arg as String;
  String get leaveId => _$args;

  FutureOr<LeaveRequestModel> build(String leaveId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<LeaveRequestModel>, LeaveRequestModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LeaveRequestModel>, LeaveRequestModel>,
              AsyncValue<LeaveRequestModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
