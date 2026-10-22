import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/admin_attendance/domain/attendance_report_models.dart';

void main() {
  group('Admin Attendance Models Tests', () {
    test('AttendanceTodayReportResponse parses status breakdown correctly', () {
      final json = <String, dynamic>{
        'date': '2026-10-22',
        'total_active_employees': 50,
        'present_count': 42,
        'absent_count': 3,
        'late_count': 2,
        'half_day_count': 1,
        'on_leave_count': 2,
        'status_breakdown': [
          {
            'status_id': 's1',
            'status_name': 'Present',
            'status_code': 'PRESENT',
            'badge_color': '#10B981',
            'count': 42,
            'employees': [
              {
                'id': 'e1',
                'employee_code': 'RA001',
                'full_name': 'Alice Smith',
                'email': 'alice@example.com',
                'department_name': 'Development',
                'designation': 'Software Engineer',
              },
            ],
          },
        ],
      };

      final report = AttendanceTodayReportResponse.fromJson(json);
      expect(report.totalActiveEmployees, 50);
      expect(report.presentCount, 42);
      expect(report.statusBreakdown.length, 1);
      expect(report.statusBreakdown.first.badgeColor, '#10B981');
      expect(
        report.statusBreakdown.first.employees.first.fullName,
        'Alice Smith',
      );
    });

    test(
      'MonthlyOverviewResponse parses virtualized matrix rows correctly',
      () {
        final json = <String, dynamic>{
          'month': 10,
          'year': 2026,
          'total_employees': 2,
          'rows': [
            {
              'employee_id': 'e1',
              'employee_name': 'Alice',
              'employee_code': 'RA01',
              'days': {'01': 'PRESENT', '02': 'PRESENT', '03': 'ABSENT'},
              'present_count': 2,
              'absent_count': 1,
              'attendance_percentage': 66.7,
            },
            {
              'employee_id': 'e2',
              'employee_name': 'Bob',
              'employee_code': 'RA02',
              'days': {'01': 'HALF_DAY', '02': 'LATE'},
              'half_day_count': 1,
              'late_count': 1,
              'attendance_percentage': 50.0,
            },
          ],
        };

        final matrix = MonthlyOverviewResponse.fromJson(json);
        expect(matrix.totalEmployees, 2);
        expect(matrix.rows.length, 2);
        expect(matrix.rows.first.days['01'], 'PRESENT');
        expect(matrix.rows[1].days['02'], 'LATE');
      },
    );

    test('AttendanceCorrectionRequest serializes mandatory reason', () {
      const req = AttendanceCorrectionRequest(
        reason: 'Manager approved correction for field duty',
        checkInAt: '2026-10-22T09:00:00Z',
        checkOutAt: '2026-10-22T18:00:00Z',
      );

      final map = req.toJson();
      expect(map['reason'], 'Manager approved correction for field duty');
      expect(map['check_in_at'], '2026-10-22T09:00:00Z');
      expect(map['check_out_at'], '2026-10-22T18:00:00Z');
    });
  });
}
