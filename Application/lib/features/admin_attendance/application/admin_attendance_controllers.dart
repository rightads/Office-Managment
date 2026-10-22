import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/features/admin_attendance/data/admin_attendance_repository.dart';
import 'package:right_ads/features/admin_attendance/domain/attendance_report_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_attendance_controllers.freezed.dart';
part 'admin_attendance_controllers.g.dart';

@freezed
abstract class AdminAttendanceTodayState with _$AdminAttendanceTodayState {
  const factory AdminAttendanceTodayState({
    AttendanceTodayReportResponse? data,
    @Default(true) bool isLoading,
    String? departmentId,
    String? errorMessage,
  }) = _AdminAttendanceTodayState;
}

@riverpod
class AdminAttendanceTodayController extends _$AdminAttendanceTodayController {
  @override
  AdminAttendanceTodayState build() {
    state = const AdminAttendanceTodayState();
    loadDashboard();
    return state;
  }

  Future<void> loadDashboard() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminAttendanceRepositoryProvider);
      final res = await repo.getTodayDashboard(
        departmentId: state.departmentId,
      );
      state = state.copyWith(data: res, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void onDepartmentChanged(String? deptId) {
    state = state.copyWith(departmentId: deptId);
    loadDashboard();
  }
}

@freezed
abstract class AdminMonthlyOverviewState with _$AdminMonthlyOverviewState {
  const factory AdminMonthlyOverviewState({
    required int month,
    required int year,
    MonthlyOverviewResponse? data,
    @Default(true) bool isLoading,
    String? departmentId,
    String? errorMessage,
  }) = _AdminMonthlyOverviewState;
}

@riverpod
class AdminMonthlyOverviewController extends _$AdminMonthlyOverviewController {
  @override
  AdminMonthlyOverviewState build() {
    final now = DateTime.now();
    state = AdminMonthlyOverviewState(month: now.month, year: now.year);
    loadOverview();
    return state;
  }

  Future<void> loadOverview() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminAttendanceRepositoryProvider);
      final res = await repo.getMonthlyOverview(
        month: state.month,
        year: state.year,
        departmentId: state.departmentId,
      );
      state = state.copyWith(data: res, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void setDate({required int month, required int year}) {
    state = state.copyWith(month: month, year: year);
    loadOverview();
  }

  void onDepartmentChanged(String? deptId) {
    state = state.copyWith(departmentId: deptId);
    loadOverview();
  }
}

@freezed
abstract class AdminEmployeeMonthlyState with _$AdminEmployeeMonthlyState {
  const factory AdminEmployeeMonthlyState({
    required int month,
    required int year,
    EmployeeMonthlyReportResponse? data,
    @Default(true) bool isLoading,
    String? errorMessage,
  }) = _AdminEmployeeMonthlyState;
}

@riverpod
class AdminEmployeeMonthlyController extends _$AdminEmployeeMonthlyController {
  @override
  AdminEmployeeMonthlyState build(String employeeId) {
    final now = DateTime.now();
    state = AdminEmployeeMonthlyState(month: now.month, year: now.year);
    loadReport(employeeId);
    return state;
  }

  Future<void> loadReport(String employeeId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminAttendanceRepositoryProvider);
      final res = await repo.getEmployeeMonthly(
        employeeId,
        month: state.month,
        year: state.year,
      );
      state = state.copyWith(data: res, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void setDate(String employeeId, {required int month, required int year}) {
    state = state.copyWith(month: month, year: year);
    loadReport(employeeId);
  }
}

@freezed
abstract class AdminEmployeeYearlyState with _$AdminEmployeeYearlyState {
  const factory AdminEmployeeYearlyState({
    required int year,
    EmployeeYearlyReportResponse? data,
    @Default(true) bool isLoading,
    String? errorMessage,
  }) = _AdminEmployeeYearlyState;
}

@riverpod
class AdminEmployeeYearlyController extends _$AdminEmployeeYearlyController {
  @override
  AdminEmployeeYearlyState build(String employeeId) {
    final now = DateTime.now();
    state = AdminEmployeeYearlyState(year: now.year);
    loadReport(employeeId);
    return state;
  }

  Future<void> loadReport(String employeeId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminAttendanceRepositoryProvider);
      final res = await repo.getEmployeeYearly(employeeId, year: state.year);
      state = state.copyWith(data: res, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void setYear(String employeeId, int year) {
    state = state.copyWith(year: year);
    loadReport(employeeId);
  }
}

@freezed
abstract class AttendanceCorrectionState with _$AttendanceCorrectionState {
  const factory AttendanceCorrectionState({
    @Default(false) bool isSubmitting,
    String? errorMessage,
    String? successMessage,
  }) = _AttendanceCorrectionState;
}

@riverpod
class AttendanceCorrectionController extends _$AttendanceCorrectionController {
  @override
  AttendanceCorrectionState build() {
    return const AttendanceCorrectionState();
  }

  Future<bool> submitCorrection({
    required String recordId,
    required AttendanceCorrectionRequest request,
  }) async {
    state = state.copyWith(isSubmitting: true, errorMessage: null);
    try {
      final repo = ref.read(adminAttendanceRepositoryProvider);
      await repo.submitCorrection(recordId, request);
      state = state.copyWith(
        isSubmitting: false,
        successMessage: 'Correction applied successfully',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
}
