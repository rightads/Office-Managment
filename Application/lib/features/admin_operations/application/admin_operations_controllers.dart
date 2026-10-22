import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/features/admin_operations/data/admin_operations_repository.dart';
import 'package:right_ads/features/admin_operations/domain/admin_operations_models.dart';
import 'package:right_ads/features/leaves/domain/leave_models.dart';
import 'package:right_ads/features/work_reports/domain/work_report_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_operations_controllers.freezed.dart';
part 'admin_operations_controllers.g.dart';

@freezed
abstract class AdminTaskReportsState with _$AdminTaskReportsState {
  const factory AdminTaskReportsState({
    TaskSummaryReportsResponse? summary,
    @Default(true) bool isLoading,
    String? errorMessage,
  }) = _AdminTaskReportsState;
}

@riverpod
class AdminTaskReportsController extends _$AdminTaskReportsController {
  @override
  AdminTaskReportsState build() {
    state = const AdminTaskReportsState();
    loadReports();
    return state;
  }

  Future<void> loadReports() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminOperationsRepositoryProvider);
      final res = await repo.getTaskReportsSummary();
      state = state.copyWith(summary: res, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

@freezed
abstract class AdminLeaveApprovalsState with _$AdminLeaveApprovalsState {
  const factory AdminLeaveApprovalsState({
    @Default(<LeaveRequestModel>[]) List<LeaveRequestModel> requests,
    @Default(true) bool isLoading,
    @Default(false) bool isActionLoading,
    String? departmentId,
    String? statusFilter,
    String? errorMessage,
  }) = _AdminLeaveApprovalsState;
}

@riverpod
class AdminLeaveApprovalsController extends _$AdminLeaveApprovalsController {
  @override
  AdminLeaveApprovalsState build() {
    state = const AdminLeaveApprovalsState();
    loadRequests();
    return state;
  }

  Future<void> loadRequests() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminOperationsRepositoryProvider);
      final list = await repo.getLeavesAdmin(
        status: state.statusFilter,
        departmentId: state.departmentId,
      );
      state = state.copyWith(requests: list, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void onDepartmentChanged(String? deptId) {
    state = state.copyWith(departmentId: deptId);
    loadRequests();
  }

  void onStatusChanged(String? status) {
    state = state.copyWith(statusFilter: status);
    loadRequests();
  }

  Future<bool> approve(String leaveId, {String? reviewNote}) async {
    state = state.copyWith(isActionLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminOperationsRepositoryProvider);
      await repo.approveLeave(leaveId, reviewNote: reviewNote);
      await loadRequests();
      state = state.copyWith(isActionLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isActionLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> reject(String leaveId, {required String reviewNote}) async {
    state = state.copyWith(isActionLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminOperationsRepositoryProvider);
      await repo.rejectLeave(leaveId, reviewNote: reviewNote);
      await loadRequests();
      state = state.copyWith(isActionLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isActionLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
}

@freezed
abstract class AdminWorkReportsReviewState with _$AdminWorkReportsReviewState {
  const factory AdminWorkReportsReviewState({
    required String selectedDate,
    @Default(<WorkReportModel>[]) List<WorkReportModel> reports,
    MissingWorkReportListResponse? missingReports,
    @Default(true) bool isLoading,
    @Default(false) bool isActionLoading,
    String? departmentId,
    String? errorMessage,
  }) = _AdminWorkReportsReviewState;
}

@riverpod
class AdminWorkReportsReviewController
    extends _$AdminWorkReportsReviewController {
  @override
  AdminWorkReportsReviewState build() {
    final today = DateTime.now().toIso8601String().split('T').first;
    state = AdminWorkReportsReviewState(selectedDate: today);
    loadData();
    return state;
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminOperationsRepositoryProvider);
      final reports = await repo.getWorkReportsAdmin(
        date: state.selectedDate,
        departmentId: state.departmentId,
      );
      final missing = await repo.getMissingWorkReports(
        date: state.selectedDate,
        departmentId: state.departmentId,
      );
      state = state.copyWith(
        reports: reports,
        missingReports: missing,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void setDate(String date) {
    state = state.copyWith(selectedDate: date);
    loadData();
  }

  void onDepartmentChanged(String? deptId) {
    state = state.copyWith(departmentId: deptId);
    loadData();
  }

  Future<bool> submitReview(
    String reportId, {
    required String reviewNote,
  }) async {
    state = state.copyWith(isActionLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminOperationsRepositoryProvider);
      await repo.reviewWorkReport(reportId, reviewNote: reviewNote);
      await loadData();
      state = state.copyWith(isActionLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isActionLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
}
