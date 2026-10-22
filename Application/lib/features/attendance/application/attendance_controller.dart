import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/network/connectivity_provider.dart';
import 'package:right_ads/core/services/location_service.dart';
import 'package:right_ads/core/storage/device_identity_service.dart';
import 'package:right_ads/features/attendance/data/attendance_repository.dart';
import 'package:right_ads/features/attendance/domain/attendance_models.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attendance_controller.g.dart';

/// Outcome of a check-in or check-out action, distinguishing policy/GPS/device
/// conditions so the UI can show actionable feedback.
sealed class AttendanceActionOutcome {
  const AttendanceActionOutcome();
}

final class AttendanceActionSuccess extends AttendanceActionOutcome {
  const AttendanceActionSuccess(this.record);

  final AttendanceRecordModel record;
}

final class AttendanceActionSelfieRequired extends AttendanceActionOutcome {
  const AttendanceActionSelfieRequired();
}

final class AttendanceActionLocationProblem extends AttendanceActionOutcome {
  const AttendanceActionLocationProblem(this.locationResult);

  final LocationAcquisitionResult locationResult;
}

final class AttendanceActionOutsideGeofence extends AttendanceActionOutcome {
  const AttendanceActionOutsideGeofence(this.evaluation);

  final GeofenceEvaluation evaluation;
}

final class AttendanceActionDeviceMismatch extends AttendanceActionOutcome {
  const AttendanceActionDeviceMismatch(this.serverMessage);

  final String serverMessage;
}

final class AttendanceActionAlreadyCheckedIn extends AttendanceActionOutcome {
  const AttendanceActionAlreadyCheckedIn(this.serverMessage);

  final String serverMessage;
}

final class AttendanceActionAlreadyCheckedOut extends AttendanceActionOutcome {
  const AttendanceActionAlreadyCheckedOut(this.serverMessage);

  final String serverMessage;
}

final class AttendanceActionOfflineProhibited extends AttendanceActionOutcome {
  const AttendanceActionOfflineProhibited();
}

final class AttendanceActionFailure extends AttendanceActionOutcome {
  const AttendanceActionFailure(this.failure);

  final AppFailure failure;
}

/// Immutable state for the Today Attendance card and check-in/out workflow.
class TodayAttendanceState {
  const TodayAttendanceState({
    this.policy,
    this.todayRecord,
    this.isLoading = true,
    this.isSubmitting = false,
    this.isLocating = false,
    this.locationResult,
    this.geofenceEvaluation,
    this.error,
  });

  final EffectiveAttendancePolicyModel? policy;
  final AttendanceRecordModel? todayRecord;
  final bool isLoading;
  final bool isSubmitting;
  final bool isLocating;
  final LocationAcquisitionResult? locationResult;
  final GeofenceEvaluation? geofenceEvaluation;
  final AppFailure? error;

  bool get hasCheckedIn => todayRecord?.checkInAt != null;
  bool get hasCheckedOut => todayRecord?.checkOutAt != null;
  bool get canCheckIn => !hasCheckedIn;
  bool get canCheckOut => hasCheckedIn && !hasCheckedOut;

  TodayAttendanceState copyWith({
    EffectiveAttendancePolicyModel? policy,
    AttendanceRecordModel? todayRecord,
    bool clearTodayRecord = false,
    bool? isLoading,
    bool? isSubmitting,
    bool? isLocating,
    LocationAcquisitionResult? locationResult,
    bool clearLocationResult = false,
    GeofenceEvaluation? geofenceEvaluation,
    bool clearGeofenceEvaluation = false,
    AppFailure? error,
    bool clearError = false,
  }) {
    return TodayAttendanceState(
      policy: policy ?? this.policy,
      todayRecord: clearTodayRecord ? null : (todayRecord ?? this.todayRecord),
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isLocating: isLocating ?? this.isLocating,
      locationResult: clearLocationResult
          ? null
          : (locationResult ?? this.locationResult),
      geofenceEvaluation: clearGeofenceEvaluation
          ? null
          : (geofenceEvaluation ?? this.geofenceEvaluation),
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Controller managing Today's attendance status, effective policy, live
/// geofence distance check, and check-in/check-out mutations.
@Riverpod(keepAlive: true)
class TodayAttendanceController extends _$TodayAttendanceController {
  @override
  TodayAttendanceState build() {
    unawaited(Future<void>.microtask(loadTodayAndPolicy));
    return const TodayAttendanceState();
  }

  /// Fetches `/me/attendance-policy` and `/attendance/today` from the server.
  ///
  /// Called on initialization, pull-to-refresh, and `AppLifecycleState.resumed`.
  Future<void> loadTodayAndPolicy({bool silent = false}) async {
    if (!silent) {
      state = state.copyWith(isLoading: true, clearError: true);
    }

    final repo = ref.read(attendanceRepositoryProvider);
    final results = await Future.wait<Object?>([
      repo.fetchEffectivePolicy(),
      repo.fetchTodayAttendance(),
    ]);

    if (!ref.mounted) return;

    final (policy, policyFailure) =
        results[0]! as (EffectiveAttendancePolicyModel?, AppFailure?);
    final (today, todayFailure) =
        results[1]! as (AttendanceRecordModel?, AppFailure?);

    final failure = policyFailure ?? todayFailure;
    if (failure != null && policy == null && state.policy == null) {
      state = state.copyWith(
        isLoading: false,
        error: failure,
      );
      return;
    }

    final resolvedPolicy = policy ?? state.policy;
    var updatedGeofence = state.geofenceEvaluation;
    final locResult = state.locationResult;
    if (resolvedPolicy != null && locResult is LocationSuccess) {
      updatedGeofence = ref
          .read(locationServiceProvider)
          .evaluateGeofence(
            latitude: locResult.latitude,
            longitude: locResult.longitude,
            allowedLocations: resolvedPolicy.allowedLocations,
          );
    }

    state = state.copyWith(
      policy: resolvedPolicy,
      todayRecord: today,
      clearTodayRecord: today == null && todayFailure == null,
      geofenceEvaluation: updatedGeofence,
      isLoading: false,
      clearError: true,
    );
  }

  /// Acquires current GPS coordinates and evaluates distance to the nearest
  /// allowed office location in `policy.allowedLocations`.
  Future<LocationAcquisitionResult> refreshLocation({
    double maxAccuracyMeters = LocationService.defaultMaxAccuracyMeters,
  }) async {
    state = state.copyWith(isLocating: true);
    final locationService = ref.read(locationServiceProvider);
    final result = await locationService.acquirePosition(
      maxAccuracyMeters: maxAccuracyMeters,
    );
    if (!ref.mounted) return result;

    GeofenceEvaluation? evaluation;
    final allowedLocations =
        state.policy?.allowedLocations ?? const <OfficeLocationModel>[];
    if (result is LocationSuccess && allowedLocations.isNotEmpty) {
      evaluation = locationService.evaluateGeofence(
        latitude: result.latitude,
        longitude: result.longitude,
        allowedLocations: allowedLocations,
      );
    } else if (result is LocationPoorAccuracy && allowedLocations.isNotEmpty) {
      evaluation = locationService.evaluateGeofence(
        latitude: result.latitude,
        longitude: result.longitude,
        allowedLocations: allowedLocations,
      );
    }

    state = state.copyWith(
      isLocating: false,
      locationResult: result,
      geofenceEvaluation: evaluation,
      clearGeofenceEvaluation: evaluation == null,
    );
    return result;
  }

  /// Executes policy-driven attendance check-in (`POST /api/v1/attendance/check-in`).
  ///
  /// - Never inspects role names.
  /// - Never sends a client timestamp.
  /// - Requires selfie only when `policy.requireSelfie == true`.
  /// - Enforces geofence radius only when `policy.requireGeofence == true`.
  /// - Blocks mock location (`isMockLocation == true`).
  Future<AttendanceActionOutcome> checkIn({
    String? selfieUrl,
    double maxAccuracyMeters = LocationService.defaultMaxAccuracyMeters,
  }) async {
    final policy = state.policy;
    final connectivityAsync = ref.read(connectivityChangesProvider);
    final isOffline = connectivityAsync.maybeWhen(
      data: (results) =>
          results.isNotEmpty &&
          results.every((r) => r == ConnectivityResult.none),
      orElse: () => false,
    );
    if (isOffline) {
      return const AttendanceActionOfflineProhibited();
    }

    if (policy != null &&
        policy.requireSelfie &&
        (selfieUrl == null || selfieUrl.trim().isEmpty)) {
      return const AttendanceActionSelfieRequired();
    }

    state = state.copyWith(isSubmitting: true);

    final locationService = ref.read(locationServiceProvider);
    final locResult = await locationService.acquirePosition(
      maxAccuracyMeters: maxAccuracyMeters,
      enforceAccuracy: policy?.requireGeofence ?? true,
    );
    if (!ref.mounted) {
      return const AttendanceActionFailure(AppFailure.unknown());
    }

    if (locResult is! LocationSuccess) {
      state = state.copyWith(
        isSubmitting: false,
        locationResult: locResult,
      );
      return AttendanceActionLocationProblem(locResult);
    }

    GeofenceEvaluation? evaluation;
    if (policy != null && policy.allowedLocations.isNotEmpty) {
      evaluation = locationService.evaluateGeofence(
        latitude: locResult.latitude,
        longitude: locResult.longitude,
        allowedLocations: policy.allowedLocations,
      );
    }

    if (policy != null && policy.requireGeofence) {
      final eval =
          evaluation ??
          locationService.evaluateGeofence(
            latitude: locResult.latitude,
            longitude: locResult.longitude,
            allowedLocations: policy.allowedLocations,
          );
      if (!eval.isWithinGeofence) {
        state = state.copyWith(
          isSubmitting: false,
          locationResult: locResult,
          geofenceEvaluation: eval,
        );
        return AttendanceActionOutsideGeofence(eval);
      }
    }

    final deviceId = await ref
        .read(deviceIdentityServiceProvider)
        .getOrCreateDeviceId();
    if (!ref.mounted) {
      return const AttendanceActionFailure(AppFailure.unknown());
    }

    final payload = CheckInRequestPayload(
      latitude: locResult.latitude,
      longitude: locResult.longitude,
      deviceId: deviceId,
      isMockLocation: locResult.isMockLocation,
      selfieUrl: (selfieUrl != null && selfieUrl.trim().isNotEmpty)
          ? selfieUrl.trim()
          : null,
    );

    final (record, failure) = await ref
        .read(attendanceRepositoryProvider)
        .checkIn(payload);
    if (!ref.mounted) {
      return const AttendanceActionFailure(AppFailure.unknown());
    }

    if (record != null) {
      state = state.copyWith(
        todayRecord: record,
        isSubmitting: false,
        locationResult: locResult,
        geofenceEvaluation: evaluation,
        clearError: true,
      );
      return AttendanceActionSuccess(record);
    }

    state = state.copyWith(
      isSubmitting: false,
      locationResult: locResult,
      geofenceEvaluation: evaluation,
    );

    final mappedFailure = failure ?? const AppFailure.unknown();
    return _mapServerActionFailure(mappedFailure, isCheckIn: true);
  }

  /// Executes policy-driven attendance check-out (`POST /api/v1/attendance/check-out`).
  ///
  /// - Never inspects role names.
  /// - Never sends a client timestamp.
  /// - Enforces geofence radius only when `policy.requireGeofence == true`.
  /// - Blocks mock location (`isMockLocation == true`).
  Future<AttendanceActionOutcome> checkOut({
    String? remarks,
    double maxAccuracyMeters = LocationService.defaultMaxAccuracyMeters,
  }) async {
    final policy = state.policy;
    final connectivityAsync = ref.read(connectivityChangesProvider);
    final isOffline = connectivityAsync.maybeWhen(
      data: (results) =>
          results.isNotEmpty &&
          results.every((r) => r == ConnectivityResult.none),
      orElse: () => false,
    );
    if (isOffline) {
      return const AttendanceActionOfflineProhibited();
    }
    state = state.copyWith(isSubmitting: true);

    final locationService = ref.read(locationServiceProvider);
    final locResult = await locationService.acquirePosition(
      maxAccuracyMeters: maxAccuracyMeters,
      enforceAccuracy: policy?.requireGeofence ?? true,
    );
    if (!ref.mounted) {
      return const AttendanceActionFailure(AppFailure.unknown());
    }

    if (locResult is! LocationSuccess) {
      state = state.copyWith(
        isSubmitting: false,
        locationResult: locResult,
      );
      return AttendanceActionLocationProblem(locResult);
    }

    GeofenceEvaluation? evaluation;
    if (policy != null && policy.allowedLocations.isNotEmpty) {
      evaluation = locationService.evaluateGeofence(
        latitude: locResult.latitude,
        longitude: locResult.longitude,
        allowedLocations: policy.allowedLocations,
      );
    }

    if (policy != null && policy.requireGeofence) {
      final eval =
          evaluation ??
          locationService.evaluateGeofence(
            latitude: locResult.latitude,
            longitude: locResult.longitude,
            allowedLocations: policy.allowedLocations,
          );
      if (!eval.isWithinGeofence) {
        state = state.copyWith(
          isSubmitting: false,
          locationResult: locResult,
          geofenceEvaluation: eval,
        );
        return AttendanceActionOutsideGeofence(eval);
      }
    }

    final deviceId = await ref
        .read(deviceIdentityServiceProvider)
        .getOrCreateDeviceId();
    if (!ref.mounted) {
      return const AttendanceActionFailure(AppFailure.unknown());
    }

    final payload = CheckOutRequestPayload(
      latitude: locResult.latitude,
      longitude: locResult.longitude,
      deviceId: deviceId,
      isMockLocation: locResult.isMockLocation,
      remarks: (remarks != null && remarks.trim().isNotEmpty)
          ? remarks.trim()
          : null,
    );

    final (record, failure) = await ref
        .read(attendanceRepositoryProvider)
        .checkOut(payload);
    if (!ref.mounted) {
      return const AttendanceActionFailure(AppFailure.unknown());
    }

    if (record != null) {
      state = state.copyWith(
        todayRecord: record,
        isSubmitting: false,
        locationResult: locResult,
        geofenceEvaluation: evaluation,
        clearError: true,
      );
      return AttendanceActionSuccess(record);
    }

    state = state.copyWith(
      isSubmitting: false,
      locationResult: locResult,
      geofenceEvaluation: evaluation,
    );

    final mappedFailure = failure ?? const AppFailure.unknown();
    return _mapServerActionFailure(mappedFailure, isCheckIn: false);
  }

  Future<AttendanceActionOutcome> _mapServerActionFailure(
    AppFailure failure, {
    required bool isCheckIn,
  }) async {
    final msg = failure.message ?? '';
    final lower = msg.toLowerCase();

    if (failure is ForbiddenFailure ||
        lower.contains('device id mismatch') ||
        lower.contains('registered device')) {
      return AttendanceActionDeviceMismatch(msg);
    }

    if (isCheckIn &&
        (failure is ConflictFailure || lower.contains('already checked in'))) {
      await loadTodayAndPolicy(silent: true);
      return AttendanceActionAlreadyCheckedIn(msg);
    }

    if (!isCheckIn && lower.contains('already checked out')) {
      await loadTodayAndPolicy(silent: true);
      return AttendanceActionAlreadyCheckedOut(msg);
    }

    return AttendanceActionFailure(failure);
  }
}

/// Combined monthly calendar + detailed monthly report state for a given
/// `(month, year)`.
class MonthlyAttendanceData {
  const MonthlyAttendanceData({
    required this.year,
    required this.month,
    required this.calendar,
    this.monthlyReport,
  });

  final int year;
  final int month;
  final AttendanceCalendarModel calendar;
  final EmployeeMonthlyReportModel? monthlyReport;

  int get workingDays =>
      monthlyReport?.workingDays ?? calendar.totalWorkingDays;
  int get presentDays =>
      monthlyReport?.presentDays ?? calendar.totalPresentDays;
  int get lateDays => monthlyReport?.lateDays ?? 0;
  int get halfDays => monthlyReport?.halfDays ?? calendar.totalHalfDays;
  int get absentDays => monthlyReport?.absentDays ?? calendar.totalAbsentDays;
  int get leaveDays => monthlyReport?.leaveDays ?? calendar.totalLeaveDays;
  int get holidayDays => monthlyReport?.holidayDays ?? calendar.totalHolidays;
  int get weekOffDays => monthlyReport?.weekOffDays ?? 0;
  double get totalHoursWorked => monthlyReport?.totalHoursWorked ?? 0.0;
  double get averageHoursPerDay => monthlyReport?.averageHoursPerDay ?? 0.0;
  double get attendancePercentage {
    if (monthlyReport != null) {
      return monthlyReport!.attendancePercentage;
    }
    if (workingDays <= 0) return 0;
    final effectivePresent = presentDays + (halfDays * 0.5);
    return (effectivePresent / workingDays) * 100.0;
  }

  /// Merges `/attendance/me` calendar days with `/reports/attendance/employee/{id}/monthly`
  /// daily records so `correctionApplied` and `remarks` are available when present.
  List<DailyAttendanceRecordModel> get mergedDays {
    if (monthlyReport != null && monthlyReport!.dailyRecords.isNotEmpty) {
      return monthlyReport!.dailyRecords;
    }
    return calendar.days
        .map(
          (day) => DailyAttendanceRecordModel(
            date: day.date,
            status: day.status,
            statusLabel: day.statusLabel,
            statusColor: day.statusColor,
            checkInAt: day.checkInAt,
            checkOutAt: day.checkOutAt,
            workHours: day.workHours,
            isManual: day.isManual,
            holidayName: day.holidayName,
            leaveTypeName: day.leaveTypeName,
          ),
        )
        .toList();
  }
}

/// Resolves the currently authenticated employee's UUID from session state.
String? resolveCurrentEmployeeId(Ref ref) {
  final authState = ref.watch(sessionControllerProvider);
  if (authState is AuthAuthenticated && authState.user.id.isNotEmpty) {
    return authState.user.id;
  }
  return null;
}

/// Fetches the monthly calendar (`/attendance/me`) and detailed monthly report
/// (`/reports/attendance/employee/{id}/monthly`) for `(month, year)`.
@riverpod
Future<MonthlyAttendanceData> monthlyAttendance(
  Ref ref, {
  required int month,
  required int year,
}) async {
  final repo = ref.watch(attendanceRepositoryProvider);
  final employeeId = resolveCurrentEmployeeId(ref);

  final calendarFuture = repo.fetchMyCalendar(month: month, year: year);
  Future<(EmployeeMonthlyReportModel?, AppFailure?)>? reportFuture;
  if (employeeId != null && employeeId.isNotEmpty) {
    reportFuture = repo.fetchMonthlyReport(
      employeeId: employeeId,
      month: month,
      year: year,
    );
  }

  final (calendar, calendarFailure) = await calendarFuture;
  final (report, reportFailure) = reportFuture != null
      ? await reportFuture
      : (null, null);

  if (calendar == null && report == null) {
    final err = calendarFailure ?? reportFailure ?? const AppFailure.unknown();
    throw Exception(err.message ?? 'Failed to load monthly attendance');
  }

  final resolvedCalendar =
      calendar ??
      AttendanceCalendarModel(
        year: year,
        month: month,
        totalWorkingDays: report!.workingDays,
        totalPresentDays: report.presentDays,
        totalAbsentDays: report.absentDays,
        totalHalfDays: report.halfDays,
        totalLeaveDays: report.leaveDays,
        totalHolidays: report.holidayDays,
        days: report.dailyRecords
            .map(
              (r) => AttendanceCalendarDayModel(
                date: r.date,
                status: r.status,
                statusLabel: r.statusLabel,
                statusColor: r.statusColor,
                checkInAt: r.checkInAt,
                checkOutAt: r.checkOutAt,
                workHours: r.workHours,
                isManual: r.isManual,
                holidayName: r.holidayName,
                leaveTypeName: r.leaveTypeName,
              ),
            )
            .toList(),
      );

  return MonthlyAttendanceData(
    year: year,
    month: month,
    calendar: resolvedCalendar,
    monthlyReport: report,
  );
}

/// Fetches the yearly month-wise attendance summary report
/// (`/reports/attendance/employee/{id}/yearly?year=`).
@riverpod
Future<EmployeeYearlyReportModel> yearlyAttendance(
  Ref ref, {
  required int year,
}) async {
  final repo = ref.watch(attendanceRepositoryProvider);
  final employeeId = resolveCurrentEmployeeId(ref);
  if (employeeId == null || employeeId.isEmpty) {
    throw Exception('Unable to determine employee identity.');
  }

  final (report, failure) = await repo.fetchYearlyReport(
    employeeId: employeeId,
    year: year,
  );
  if (report != null) {
    return report;
  }
  throw Exception(failure?.message ?? 'Failed to load yearly attendance');
}
