import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_provider.dart';
import '../../leaves/domain/leave_models.dart';
import '../../work_reports/domain/work_report_models.dart';
import '../domain/admin_operations_models.dart';

part 'admin_operations_repository.g.dart';

class AdminOperationsRepository {
  AdminOperationsRepository(this._dio);

  final Dio _dio;

  // Tasks Analytics & Bulk Assignment
  Future<TaskSummaryReportsResponse> getTaskReportsSummary() async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.tasksReportsSummary,
    );
    return TaskSummaryReportsResponse.fromJson(response.data!);
  }

  Future<void> assignTask(
    String taskId,
    List<String> assigneeIds, {
    bool replace = false,
  }) async {
    await _dio.post<dynamic>(
      ApiEndpoints.taskAssign(taskId),
      data: TaskAssignRequest(
        assigneeIds: assigneeIds,
        replace: replace,
      ).toJson(),
    );
  }

  Future<void> archiveTask(String taskId) async {
    await _dio.delete<dynamic>(ApiEndpoints.taskDetail(taskId));
  }

  // Leave Approvals
  Future<List<LeaveRequestModel>> getLeavesAdmin({
    String? status,
    String? departmentId,
  }) async {
    final response = await _dio.get<dynamic>(
      ApiEndpoints.leaveApply, // Maps to GET /api/v1/leaves in router
      queryParameters: <String, dynamic>{
        if (status != null && status.isNotEmpty) 'status': status,
        if (departmentId != null && departmentId.isNotEmpty)
          'department_id': departmentId,
      },
    );

    final raw = response.data;
    final List<dynamic> items;
    if (raw is List) {
      items = raw;
    } else if (raw is Map<String, dynamic> && raw['items'] is List) {
      items = raw['items'] as List<dynamic>;
    } else {
      items = <dynamic>[];
    }

    return items
        .map((e) => LeaveRequestModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> approveLeave(String leaveId, {String? reviewNote}) async {
    await _dio.post<dynamic>(
      ApiEndpoints.leaveApprove(leaveId),
      data: LeaveReviewRequest(reviewNote: reviewNote).toJson(),
    );
  }

  Future<void> rejectLeave(String leaveId, {required String reviewNote}) async {
    await _dio.post<dynamic>(
      ApiEndpoints.leaveReject(leaveId),
      data: LeaveRejectRequest(reviewNote: reviewNote).toJson(),
    );
  }

  // Announcements
  Future<void> publishAnnouncement(AnnouncementCreateRequest request) async {
    await _dio.post<dynamic>(
      ApiEndpoints.announcements,
      data: request.toJson(),
    );
  }

  // Work Reports Review
  Future<List<WorkReportModel>> getWorkReportsAdmin({
    String? date,
    String? departmentId,
    String? employeeId,
  }) async {
    final response = await _dio.get<dynamic>(
      ApiEndpoints.workReports,
      queryParameters: <String, dynamic>{
        if (date != null && date.isNotEmpty) 'date': date,
        if (departmentId != null && departmentId.isNotEmpty)
          'department_id': departmentId,
        if (employeeId != null && employeeId.isNotEmpty)
          'employee_id': employeeId,
      },
    );

    final raw = response.data;
    final List<dynamic> items;
    if (raw is List) {
      items = raw;
    } else if (raw is Map<String, dynamic> && raw['items'] is List) {
      items = raw['items'] as List<dynamic>;
    } else {
      items = <dynamic>[];
    }

    return items
        .map((e) => WorkReportModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<MissingWorkReportListResponse> getMissingWorkReports({
    required String date,
    String? departmentId,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.workReportsMissing,
      queryParameters: <String, dynamic>{
        'date': date,
        if (departmentId != null && departmentId.isNotEmpty)
          'department_id': departmentId,
      },
    );
    return MissingWorkReportListResponse.fromJson(response.data!);
  }

  Future<void> reviewWorkReport(
    String reportId, {
    required String reviewNote,
    String status = 'reviewed',
  }) async {
    await _dio.post<dynamic>(
      ApiEndpoints.workReportReview(reportId),
      data: WorkReportReviewRequest(
        reviewNote: reviewNote,
        status: status,
      ).toJson(),
    );
  }
}

@riverpod
AdminOperationsRepository adminOperationsRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AdminOperationsRepository(dio);
}
