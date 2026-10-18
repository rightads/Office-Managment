// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller managing Today's attendance status, effective policy, live
/// geofence distance check, and check-in/check-out mutations.

@ProviderFor(TodayAttendanceController)
final todayAttendanceControllerProvider = TodayAttendanceControllerProvider._();

/// Controller managing Today's attendance status, effective policy, live
/// geofence distance check, and check-in/check-out mutations.
final class TodayAttendanceControllerProvider
    extends $NotifierProvider<TodayAttendanceController, TodayAttendanceState> {
  /// Controller managing Today's attendance status, effective policy, live
  /// geofence distance check, and check-in/check-out mutations.
  TodayAttendanceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayAttendanceControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayAttendanceControllerHash();

  @$internal
  @override
  TodayAttendanceController create() => TodayAttendanceController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodayAttendanceState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodayAttendanceState>(value),
    );
  }
}

String _$todayAttendanceControllerHash() =>
    r'4b2d4bbbab7fb49d8a864b2c8f8fad3b095823be';

/// Controller managing Today's attendance status, effective policy, live
/// geofence distance check, and check-in/check-out mutations.

abstract class _$TodayAttendanceController
    extends $Notifier<TodayAttendanceState> {
  TodayAttendanceState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TodayAttendanceState, TodayAttendanceState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TodayAttendanceState, TodayAttendanceState>,
              TodayAttendanceState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Fetches the monthly calendar (`/attendance/me`) and detailed monthly report
/// (`/reports/attendance/employee/{id}/monthly`) for `(month, year)`.

@ProviderFor(monthlyAttendance)
final monthlyAttendanceProvider = MonthlyAttendanceFamily._();

/// Fetches the monthly calendar (`/attendance/me`) and detailed monthly report
/// (`/reports/attendance/employee/{id}/monthly`) for `(month, year)`.

final class MonthlyAttendanceProvider
    extends
        $FunctionalProvider<
          AsyncValue<MonthlyAttendanceData>,
          MonthlyAttendanceData,
          FutureOr<MonthlyAttendanceData>
        >
    with
        $FutureModifier<MonthlyAttendanceData>,
        $FutureProvider<MonthlyAttendanceData> {
  /// Fetches the monthly calendar (`/attendance/me`) and detailed monthly report
  /// (`/reports/attendance/employee/{id}/monthly`) for `(month, year)`.
  MonthlyAttendanceProvider._({
    required MonthlyAttendanceFamily super.from,
    required ({int month, int year}) super.argument,
  }) : super(
         retry: null,
         name: r'monthlyAttendanceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$monthlyAttendanceHash();

  @override
  String toString() {
    return r'monthlyAttendanceProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<MonthlyAttendanceData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MonthlyAttendanceData> create(Ref ref) {
    final argument = this.argument as ({int month, int year});
    return monthlyAttendance(ref, month: argument.month, year: argument.year);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthlyAttendanceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$monthlyAttendanceHash() => r'7908d50d6044c4650ae4d0cd123e0e2d27f6d39a';

/// Fetches the monthly calendar (`/attendance/me`) and detailed monthly report
/// (`/reports/attendance/employee/{id}/monthly`) for `(month, year)`.

final class MonthlyAttendanceFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<MonthlyAttendanceData>,
          ({int month, int year})
        > {
  MonthlyAttendanceFamily._()
    : super(
        retry: null,
        name: r'monthlyAttendanceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fetches the monthly calendar (`/attendance/me`) and detailed monthly report
  /// (`/reports/attendance/employee/{id}/monthly`) for `(month, year)`.

  MonthlyAttendanceProvider call({required int month, required int year}) =>
      MonthlyAttendanceProvider._(
        argument: (month: month, year: year),
        from: this,
      );

  @override
  String toString() => r'monthlyAttendanceProvider';
}

/// Fetches the yearly month-wise attendance summary report
/// (`/reports/attendance/employee/{id}/yearly?year=`).

@ProviderFor(yearlyAttendance)
final yearlyAttendanceProvider = YearlyAttendanceFamily._();

/// Fetches the yearly month-wise attendance summary report
/// (`/reports/attendance/employee/{id}/yearly?year=`).

final class YearlyAttendanceProvider
    extends
        $FunctionalProvider<
          AsyncValue<EmployeeYearlyReportModel>,
          EmployeeYearlyReportModel,
          FutureOr<EmployeeYearlyReportModel>
        >
    with
        $FutureModifier<EmployeeYearlyReportModel>,
        $FutureProvider<EmployeeYearlyReportModel> {
  /// Fetches the yearly month-wise attendance summary report
  /// (`/reports/attendance/employee/{id}/yearly?year=`).
  YearlyAttendanceProvider._({
    required YearlyAttendanceFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'yearlyAttendanceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$yearlyAttendanceHash();

  @override
  String toString() {
    return r'yearlyAttendanceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EmployeeYearlyReportModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EmployeeYearlyReportModel> create(Ref ref) {
    final argument = this.argument as int;
    return yearlyAttendance(ref, year: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is YearlyAttendanceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$yearlyAttendanceHash() => r'28f511a4525d1628d62026d95c598296996a5e11';

/// Fetches the yearly month-wise attendance summary report
/// (`/reports/attendance/employee/{id}/yearly?year=`).

final class YearlyAttendanceFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EmployeeYearlyReportModel>, int> {
  YearlyAttendanceFamily._()
    : super(
        retry: null,
        name: r'yearlyAttendanceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fetches the yearly month-wise attendance summary report
  /// (`/reports/attendance/employee/{id}/yearly?year=`).

  YearlyAttendanceProvider call({required int year}) =>
      YearlyAttendanceProvider._(argument: year, from: this);

  @override
  String toString() => r'yearlyAttendanceProvider';
}
