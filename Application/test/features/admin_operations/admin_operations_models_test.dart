import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/admin_operations/domain/admin_operations_models.dart';

void main() {
  group('Admin Operations Models Tests', () {
    test('TaskReportItem & TaskSummaryReportsResponse JSON serialization', () {
      final json = {
        'total_tasks': 42,
        'completed_tasks': 30,
        'pending_tasks': 12,
        'overdue_tasks': 5,
        'on_time_completion_rate': 71.4,
        'by_employee': [
          {
            'id': 'emp-1',
            'name': 'John Doe',
            'total_tasks': 10,
            'completed_tasks': 8,
            'pending_tasks': 2,
            'overdue_tasks': 0,
          },
        ],
        'by_department': <Map<String, dynamic>>[],
        'by_client': <Map<String, dynamic>>[],
      };

      final response = TaskSummaryReportsResponse.fromJson(json);
      expect(response.totalTasks, 42);
      expect(response.completedTasks, 30);
      expect(response.pendingTasks, 12);
      expect(response.overdueTasks, 5);
      expect(response.onTimeCompletionRate, 71.4);
      expect(response.byEmployee.length, 1);
      expect(response.byEmployee.first.name, 'John Doe');

      final serialized = response.toJson();
      expect(serialized['total_tasks'], 42);
      expect(serialized['overdue_tasks'], 5);
    });

    test('TaskAssignRequest JSON serialization', () {
      const request = TaskAssignRequest(
        assigneeIds: ['usr-456'],
        replace: true,
      );
      final json = request.toJson();
      expect(json['assignee_ids'], ['usr-456']);
      expect(json['replace'], true);
    });

    test('LeaveReviewRequest and LeaveRejectRequest JSON serialization', () {
      const approve = LeaveReviewRequest(
        reviewNote: 'Approved for vacation',
      );
      expect(approve.toJson()['review_note'], 'Approved for vacation');

      const reject = LeaveRejectRequest(reviewNote: 'Insufficient quota');
      expect(reject.toJson()['review_note'], 'Insufficient quota');
    });

    test('AnnouncementCreateRequest JSON serialization', () {
      const request = AnnouncementCreateRequest(
        title: 'Office Townhall',
        body: 'All hands gathering at 4 PM.',
        targetDepartmentId: 'dep-123',
        expiresAt: '2026-12-31T23:59:59Z',
      );
      final json = request.toJson();
      expect(json['title'], 'Office Townhall');
      expect(json['body'], 'All hands gathering at 4 PM.');
      expect(json['target_department_id'], 'dep-123');
      expect(json['expires_at'], '2026-12-31T23:59:59Z');
    });

    test('WorkReportReviewRequest and MissingWorkReportListResponse JSON', () {
      const review = WorkReportReviewRequest(
        reviewNote: 'Well documented progress.',
      );
      expect(review.toJson()['review_note'], 'Well documented progress.');
      expect(review.toJson()['status'], 'reviewed');

      final missingJson = {
        'report_date': '2026-10-22',
        'missing_count': 1,
        'users': [
          {
            'id': 'usr-789',
            'employee_code': 'EMP001',
            'full_name': 'Jane Doe',
            'email': 'jane@example.com',
            'department_name': 'Design',
          },
        ],
      };

      final missingResponse = MissingWorkReportListResponse.fromJson(
        missingJson,
      );
      expect(missingResponse.reportDate, '2026-10-22');
      expect(missingResponse.missingCount, 1);
      expect(missingResponse.users.first.id, 'usr-789');
      expect(missingResponse.users.first.fullName, 'Jane Doe');
      expect(missingResponse.users.first.departmentName, 'Design');
    });
  });
}
