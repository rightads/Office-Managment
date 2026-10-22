import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/admin/domain/admin_models.dart';
import 'package:right_ads/features/admin_attendance/domain/attendance_report_models.dart';
import 'package:right_ads/features/admin_operations/domain/admin_operations_models.dart';
import 'package:right_ads/features/super_admin/domain/super_admin_models.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';

Map<String, dynamic> _roundtrip(Map<String, dynamic> m) =>
    jsonDecode(jsonEncode(m)) as Map<String, dynamic>;

void main() {
  group('Domain Models JSON Serialization Suite', () {
    test('Admin operations models serialize and deserialize', () {
      const taskReport = TaskReportItem(
        id: 'r-1',
        name: 'Design Team',
        totalTasks: 10,
        completedTasks: 8,
        pendingTasks: 1,
        overdueTasks: 1,
      );
      expect(
        TaskReportItem.fromJson(_roundtrip(taskReport.toJson())).name,
        'Design Team',
      );

      const summaryReports = TaskSummaryReportsResponse(
        totalTasks: 10,
        completedTasks: 8,
        pendingTasks: 1,
        overdueTasks: 1,
        onTimeCompletionRate: 80,
        byDepartment: [taskReport],
      );
      expect(
        TaskSummaryReportsResponse.fromJson(
          _roundtrip(summaryReports.toJson()),
        ).totalTasks,
        10,
      );

      const taskAssign = TaskAssignRequest(
        assigneeIds: ['u-1', 'u-2'],
        replace: true,
      );
      expect(
        TaskAssignRequest.fromJson(
          _roundtrip(taskAssign.toJson()),
        ).assigneeIds.length,
        2,
      );

      const leaveReview = LeaveReviewRequest(
        reviewNote: 'Approved for valid reasons',
      );
      expect(
        LeaveReviewRequest.fromJson(
          _roundtrip(leaveReview.toJson()),
        ).reviewNote,
        'Approved for valid reasons',
      );

      const leaveReject = LeaveRejectRequest(
        reviewNote: 'Critical project release',
      );
      expect(
        LeaveRejectRequest.fromJson(
          _roundtrip(leaveReject.toJson()),
        ).reviewNote,
        'Critical project release',
      );

      const annCreate = AnnouncementCreateRequest(
        title: 'Notice',
        body: 'All hands meeting',
      );
      expect(
        AnnouncementCreateRequest.fromJson(
          _roundtrip(annCreate.toJson()),
        ).title,
        'Notice',
      );

      const wrReview = WorkReportReviewRequest(
        reviewNote: 'Good work',
      );
      expect(
        WorkReportReviewRequest.fromJson(_roundtrip(wrReview.toJson())).status,
        'reviewed',
      );

      const missingUser = MissingWorkReportUserResponse(
        id: 'u-1',
        employeeCode: 'EMP001',
        fullName: 'Jane Doe',
        email: 'jane@example.com',
      );
      expect(
        MissingWorkReportUserResponse.fromJson(
          _roundtrip(missingUser.toJson()),
        ).employeeCode,
        'EMP001',
      );

      const missingList = MissingWorkReportListResponse(
        reportDate: '2026-10-22',
        missingCount: 1,
        users: [missingUser],
      );
      expect(
        MissingWorkReportListResponse.fromJson(
          _roundtrip(missingList.toJson()),
        ).missingCount,
        1,
      );
    });

    test('Attendance report models serialize and deserialize', () {
      const empItem = ReportEmployeeItem(
        id: 'u-1',
        employeeCode: 'EMP001',
        fullName: 'Jane Doe',
        email: 'jane@example.com',
      );
      expect(
        ReportEmployeeItem.fromJson(_roundtrip(empItem.toJson())).id,
        'u-1',
      );

      const statusCount = AttendanceSummaryStatusCount(
        statusId: 's-1',
        statusName: 'Present',
        statusCode: 'PRESENT',
        badgeColor: '#10B981',
        count: 10,
        employees: [empItem],
      );
      expect(
        AttendanceSummaryStatusCount.fromJson(
          _roundtrip(statusCount.toJson()),
        ).count,
        10,
      );

      const todayReport = AttendanceTodayReportResponse(
        date: '2026-10-22',
        totalActiveEmployees: 10,
        presentCount: 9,
        absentCount: 1,
        lateCount: 0,
        halfDayCount: 0,
        onLeaveCount: 0,
        statusBreakdown: [statusCount],
      );
      expect(
        AttendanceTodayReportResponse.fromJson(
          _roundtrip(todayReport.toJson()),
        ).presentCount,
        9,
      );

      const dayDetail = AttendanceDayDetail(
        date: '2026-10-22',
        dayOfWeek: 'Thursday',
        isWorkingDay: true,
        isHoliday: false,
      );
      expect(
        AttendanceDayDetail.fromJson(_roundtrip(dayDetail.toJson())).dayOfWeek,
        'Thursday',
      );
    });

    test('Task domain models serialize and deserialize', () {
      const userBrief = UserBriefModel(
        id: 'u-1',
        employeeCode: 'EMP001',
        fullName: 'Jane Doe',
        email: 'jane@example.com',
      );
      expect(UserBriefModel.fromJson(_roundtrip(userBrief.toJson())).id, 'u-1');

      const status = TaskStatusModel(
        id: 'st-1',
        code: 'in_progress',
        label: 'In Progress',
        order: 2,
        isTerminal: false,
        color: '#3B82F6',
      );
      expect(
        TaskStatusModel.fromJson(_roundtrip(status.toJson())).code,
        'in_progress',
      );

      const priority = TaskPriorityModel(
        id: 'pr-1',
        code: 'high',
        label: 'High Priority',
        weight: 3,
        color: '#EF4444',
      );
      expect(
        TaskPriorityModel.fromJson(_roundtrip(priority.toJson())).code,
        'high',
      );

      const transition = TaskStatusTransitionModel(
        id: 'tr-1',
        fromStatusId: 'st-1',
        toStatusId: 'st-2',
      );
      expect(
        TaskStatusTransitionModel.fromJson(_roundtrip(transition.toJson())).id,
        'tr-1',
      );

      final taskItem = TaskItemModel(
        id: 'task-1',
        title: 'Build Feature',
        priority: priority,
        status: status,
        assigner: userBrief,
        createdAt: DateTime(2026, 10, 20),
        updatedAt: DateTime(2026, 10, 21),
      );
      expect(
        TaskItemModel.fromJson(_roundtrip(taskItem.toJson())).title,
        'Build Feature',
      );

      final taskPage = TaskPageResponse(
        items: [taskItem],
        total: 1,
        page: 1,
        pageSize: 20,
      );
      expect(TaskPageResponse.fromJson(_roundtrip(taskPage.toJson())).total, 1);

      final taskComment = TaskCommentModel(
        id: 'tc-1',
        taskId: 'task-1',
        author: userBrief,
        comment: 'Great progress',
        createdAt: DateTime(2026, 10, 20),
      );
      expect(
        TaskCommentModel.fromJson(_roundtrip(taskComment.toJson())).comment,
        'Great progress',
      );

      final taskAttachment = TaskAttachmentModel(
        id: 'ta-1',
        taskId: 'task-1',
        fileName: 'spec.pdf',
        fileSizeBytes: 2048,
        mimeType: 'application/pdf',
        downloadUrl: 'http://localhost/spec.pdf',
        uploader: userBrief,
        createdAt: DateTime(2026, 10, 20),
      );
      expect(
        TaskAttachmentModel.fromJson(
          _roundtrip(taskAttachment.toJson()),
        ).fileName,
        'spec.pdf',
      );
    });

    test('Admin and Super Admin models serialize and deserialize', () {
      const roleItem = RoleItem(
        id: 'r-1',
        name: 'Manager',
        isSystem: false,
        isActive: true,
        createdAt: '2026-10-20',
      );
      expect(RoleItem.fromJson(_roundtrip(roleItem.toJson())).name, 'Manager');

      const bulkError = BulkImportRowError(
        row: 2,
        field: 'email',
        error: 'Invalid email',
      );
      expect(
        BulkImportRowError.fromJson(_roundtrip(bulkError.toJson())).row,
        2,
      );

      const bulkReport = BulkImportReport(
        totalRows: 10,
        successfulImports: 9,
        failedRows: 1,
        dryRun: false,
        errors: [bulkError],
      );
      expect(
        BulkImportReport.fromJson(_roundtrip(bulkReport.toJson())).totalRows,
        10,
      );

      const masterItem = MasterDataItem(
        id: 'md-1',
        name: 'Sales Department',
        code: 'SALES',
      );
      expect(
        MasterDataItem.fromJson(_roundtrip(masterItem.toJson())).code,
        'SALES',
      );

      const perm = PermissionModel(
        id: 'p-1',
        code: 'attendance.view',
        description: 'View attendance',
      );
      expect(
        PermissionModel.fromJson(_roundtrip(perm.toJson())).code,
        'attendance.view',
      );

      const roleDetail = RoleDetailModel(
        id: 'r-1',
        name: 'Manager',
        permissions: [perm],
      );
      expect(
        RoleDetailModel.fromJson(
          _roundtrip(roleDetail.toJson()),
        ).permissions.length,
        1,
      );

      const roleUpsert = RoleUpsertRequest(
        name: 'Manager',
        permissionIds: ['p-1'],
      );
      expect(
        RoleUpsertRequest.fromJson(
          _roundtrip(roleUpsert.toJson()),
        ).permissionIds.first,
        'p-1',
      );

      const systemSetting = SystemSettingModel(
        key: 'company.name',
        value: 'Right Ads',
      );
      expect(
        SystemSettingModel.fromJson(_roundtrip(systemSetting.toJson())).value,
        'Right Ads',
      );

      const updateSetting = SystemSettingUpdateRequest(value: 'New Value');
      expect(
        SystemSettingUpdateRequest.fromJson(
          _roundtrip(updateSetting.toJson()),
        ).value,
        'New Value',
      );

      final auditLog = AuditLogItemModel(
        id: 'log-1',
        action: 'create',
        entityType: 'user',
        entityId: 'u-1',
        createdAt: DateTime(2026, 10, 20),
      );
      expect(
        AuditLogItemModel.fromJson(_roundtrip(auditLog.toJson())).action,
        'create',
      );

      const notifTemplate = NotificationTemplateModel(
        id: 'nt-1',
        code: 'task_assigned',
        titleTemplate: 'New Task: {{title}}',
        bodyTemplate: 'Assigned by {{assigner}}',
      );
      expect(
        NotificationTemplateModel.fromJson(
          _roundtrip(notifTemplate.toJson()),
        ).code,
        'task_assigned',
      );

      const updateTemplate = NotificationTemplateUpdateRequest(
        titleTemplate: 'Updated: {{title}}',
        bodyTemplate: 'Updated: {{body}}',
      );
      expect(
        NotificationTemplateUpdateRequest.fromJson(
          _roundtrip(updateTemplate.toJson()),
        ).titleTemplate,
        'Updated: {{title}}',
      );
    });
  });
}
