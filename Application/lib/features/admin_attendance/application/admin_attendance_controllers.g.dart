// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_attendance_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminAttendanceTodayController)
final adminAttendanceTodayControllerProvider =
    AdminAttendanceTodayControllerProvider._();

final class AdminAttendanceTodayControllerProvider
    extends
        $NotifierProvider<
          AdminAttendanceTodayController,
          AdminAttendanceTodayState
        > {
  AdminAttendanceTodayControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminAttendanceTodayControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminAttendanceTodayControllerHash();

  @$internal
  @override
  AdminAttendanceTodayController create() => AdminAttendanceTodayController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminAttendanceTodayState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminAttendanceTodayState>(value),
    );
  }
}

String _$adminAttendanceTodayControllerHash() =>
    r'4dc08ff7b76543c30e15757b0d33a61f9b28ae0b';

abstract class _$AdminAttendanceTodayController
    extends $Notifier<AdminAttendanceTodayState> {
  AdminAttendanceTodayState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AdminAttendanceTodayState, AdminAttendanceTodayState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminAttendanceTodayState, AdminAttendanceTodayState>,
              AdminAttendanceTodayState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(AdminMonthlyOverviewController)
final adminMonthlyOverviewControllerProvider =
    AdminMonthlyOverviewControllerProvider._();

final class AdminMonthlyOverviewControllerProvider
    extends
        $NotifierProvider<
          AdminMonthlyOverviewController,
          AdminMonthlyOverviewState
        > {
  AdminMonthlyOverviewControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminMonthlyOverviewControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminMonthlyOverviewControllerHash();

  @$internal
  @override
  AdminMonthlyOverviewController create() => AdminMonthlyOverviewController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminMonthlyOverviewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminMonthlyOverviewState>(value),
    );
  }
}

String _$adminMonthlyOverviewControllerHash() =>
    r'981857e9f75cc41f8d395d991e32a47332885031';

abstract class _$AdminMonthlyOverviewController
    extends $Notifier<AdminMonthlyOverviewState> {
  AdminMonthlyOverviewState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AdminMonthlyOverviewState, AdminMonthlyOverviewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminMonthlyOverviewState, AdminMonthlyOverviewState>,
              AdminMonthlyOverviewState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(AdminEmployeeMonthlyController)
final adminEmployeeMonthlyControllerProvider =
    AdminEmployeeMonthlyControllerFamily._();

final class AdminEmployeeMonthlyControllerProvider
    extends
        $NotifierProvider<
          AdminEmployeeMonthlyController,
          AdminEmployeeMonthlyState
        > {
  AdminEmployeeMonthlyControllerProvider._({
    required AdminEmployeeMonthlyControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'adminEmployeeMonthlyControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminEmployeeMonthlyControllerHash();

  @override
  String toString() {
    return r'adminEmployeeMonthlyControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AdminEmployeeMonthlyController create() => AdminEmployeeMonthlyController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminEmployeeMonthlyState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminEmployeeMonthlyState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AdminEmployeeMonthlyControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminEmployeeMonthlyControllerHash() =>
    r'f92176c496037925a83b8a84ba86962c07d45e72';

final class AdminEmployeeMonthlyControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          AdminEmployeeMonthlyController,
          AdminEmployeeMonthlyState,
          AdminEmployeeMonthlyState,
          AdminEmployeeMonthlyState,
          String
        > {
  AdminEmployeeMonthlyControllerFamily._()
    : super(
        retry: null,
        name: r'adminEmployeeMonthlyControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminEmployeeMonthlyControllerProvider call(String employeeId) =>
      AdminEmployeeMonthlyControllerProvider._(
        argument: employeeId,
        from: this,
      );

  @override
  String toString() => r'adminEmployeeMonthlyControllerProvider';
}

abstract class _$AdminEmployeeMonthlyController
    extends $Notifier<AdminEmployeeMonthlyState> {
  late final _$args = ref.$arg as String;
  String get employeeId => _$args;

  AdminEmployeeMonthlyState build(String employeeId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AdminEmployeeMonthlyState, AdminEmployeeMonthlyState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminEmployeeMonthlyState, AdminEmployeeMonthlyState>,
              AdminEmployeeMonthlyState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(AdminEmployeeYearlyController)
final adminEmployeeYearlyControllerProvider =
    AdminEmployeeYearlyControllerFamily._();

final class AdminEmployeeYearlyControllerProvider
    extends
        $NotifierProvider<
          AdminEmployeeYearlyController,
          AdminEmployeeYearlyState
        > {
  AdminEmployeeYearlyControllerProvider._({
    required AdminEmployeeYearlyControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'adminEmployeeYearlyControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminEmployeeYearlyControllerHash();

  @override
  String toString() {
    return r'adminEmployeeYearlyControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AdminEmployeeYearlyController create() => AdminEmployeeYearlyController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminEmployeeYearlyState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminEmployeeYearlyState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AdminEmployeeYearlyControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminEmployeeYearlyControllerHash() =>
    r'a9bca6813ea903daf12e5dc6900b5d90531c800c';

final class AdminEmployeeYearlyControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          AdminEmployeeYearlyController,
          AdminEmployeeYearlyState,
          AdminEmployeeYearlyState,
          AdminEmployeeYearlyState,
          String
        > {
  AdminEmployeeYearlyControllerFamily._()
    : super(
        retry: null,
        name: r'adminEmployeeYearlyControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminEmployeeYearlyControllerProvider call(String employeeId) =>
      AdminEmployeeYearlyControllerProvider._(argument: employeeId, from: this);

  @override
  String toString() => r'adminEmployeeYearlyControllerProvider';
}

abstract class _$AdminEmployeeYearlyController
    extends $Notifier<AdminEmployeeYearlyState> {
  late final _$args = ref.$arg as String;
  String get employeeId => _$args;

  AdminEmployeeYearlyState build(String employeeId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AdminEmployeeYearlyState, AdminEmployeeYearlyState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminEmployeeYearlyState, AdminEmployeeYearlyState>,
              AdminEmployeeYearlyState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(AttendanceCorrectionController)
final attendanceCorrectionControllerProvider =
    AttendanceCorrectionControllerProvider._();

final class AttendanceCorrectionControllerProvider
    extends
        $NotifierProvider<
          AttendanceCorrectionController,
          AttendanceCorrectionState
        > {
  AttendanceCorrectionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'attendanceCorrectionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$attendanceCorrectionControllerHash();

  @$internal
  @override
  AttendanceCorrectionController create() => AttendanceCorrectionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AttendanceCorrectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AttendanceCorrectionState>(value),
    );
  }
}

String _$attendanceCorrectionControllerHash() =>
    r'd8a1f5dbb299b2fb1c2b800e70de6822a133d36e';

abstract class _$AttendanceCorrectionController
    extends $Notifier<AttendanceCorrectionState> {
  AttendanceCorrectionState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AttendanceCorrectionState, AttendanceCorrectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AttendanceCorrectionState, AttendanceCorrectionState>,
              AttendanceCorrectionState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
