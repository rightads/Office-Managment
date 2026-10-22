import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/attendance/domain/attendance_models.dart';

Map<String, dynamic> _roundtrip(Map<String, dynamic> m) =>
    jsonDecode(jsonEncode(m)) as Map<String, dynamic>;

void main() {
  group('Attendance Models JSON Serialization Tests', () {
    test(
      'OfficeLocationModel and EffectiveAttendancePolicyModel serialize and deserialize',
      () {
        const office = OfficeLocationModel(
          id: 'off-1',
          name: 'Headquarters',
          latitude: 19.0760,
          longitude: 72.8777,
        );
        final officeJson = office.toJson();
        final fromOffice = OfficeLocationModel.fromJson(_roundtrip(officeJson));
        expect(fromOffice.id, 'off-1');
        expect(fromOffice.latitude, 19.0760);

        const policy = EffectiveAttendancePolicyModel(
          id: 'pol-1',
          name: 'HQ Shift',
          requireSelfie: true,
          allowedLocations: [office],
        );
        final polJson = policy.toJson();
        final fromPol = EffectiveAttendancePolicyModel.fromJson(
          _roundtrip(polJson),
        );
        expect(fromPol.id, 'pol-1');
        expect(fromPol.requireGeofence, isTrue);
        expect(fromPol.allowedLocations.length, 1);
      },
    );

    test('AttendanceRecordModel and payloads serialize and deserialize', () {
      final record = AttendanceRecordModel(
        id: 'att-1',
        employeeId: 'emp-1',
        attendanceDate: '2026-10-22',
        checkInAt: DateTime.utc(2026, 10, 22, 4, 30),
        status: 'PRESENT',
        statusLabel: 'Present',
        statusColor: '#10B981',
      );
      expect(
        AttendanceRecordModel.fromJson(_roundtrip(record.toJson())).id,
        'att-1',
      );

      const checkInPayload = CheckInRequestPayload(
        latitude: 19.0760,
        longitude: 72.8777,
        deviceId: 'dev-1',
      );
      expect(
        CheckInRequestPayload.fromJson(
          _roundtrip(checkInPayload.toJson()),
        ).deviceId,
        'dev-1',
      );

      const checkOutPayload = CheckOutRequestPayload(
        latitude: 19.0760,
        longitude: 72.8777,
        deviceId: 'dev-1',
      );
      expect(
        CheckOutRequestPayload.fromJson(
          _roundtrip(checkOutPayload.toJson()),
        ).deviceId,
        'dev-1',
      );
    });

    test(
      'AttendanceCalendarModel and DailyAttendanceRecordModel serialize and deserialize',
      () {
        const day = AttendanceCalendarDayModel(
          date: '2026-10-22',
          status: 'PRESENT',
          statusLabel: 'Present',
          statusColor: '#10B981',
          workHours: 8,
        );
        expect(
          AttendanceCalendarDayModel.fromJson(_roundtrip(day.toJson())).status,
          'PRESENT',
        );

        const calendar = AttendanceCalendarModel(
          year: 2026,
          month: 10,
          totalWorkingDays: 20,
          totalPresentDays: 18,
          totalHalfDays: 1,
          totalAbsentDays: 1,
          totalHolidays: 2,
          days: [day],
        );
        expect(
          AttendanceCalendarModel.fromJson(
            _roundtrip(calendar.toJson()),
          ).totalWorkingDays,
          20,
        );

        final daily = DailyAttendanceRecordModel(
          date: '2026-10-22',
          status: 'PRESENT',
          statusLabel: 'Present',
          statusColor: '#10B981',
          checkInAt: DateTime.utc(2026, 10, 22, 9, 30),
          checkOutAt: DateTime.utc(2026, 10, 22, 18, 30),
          workHours: 9,
        );
        expect(
          DailyAttendanceRecordModel.fromJson(
            _roundtrip(daily.toJson()),
          ).workHours,
          9.0,
        );
      },
    );

    test('Reports and summary models serialize and deserialize', () {
      const summaryItem = MonthSummaryItemModel(
        month: 10,
        monthName: 'October',
        presentDays: 18,
        workingDays: 20,
        lateDays: 1,
        halfDays: 1,
      );
      expect(
        MonthSummaryItemModel.fromJson(_roundtrip(summaryItem.toJson())).month,
        10,
      );

      const monthlyReport = EmployeeMonthlyReportModel(
        employeeId: 'emp-1',
        fullName: 'Jane Doe',
        employeeCode: 'EMP001',
        month: 10,
        year: 2026,
        workingDays: 20,
        presentDays: 18,
        halfDays: 1,
        absentDays: 1,
        holidayDays: 2,
      );
      expect(
        EmployeeMonthlyReportModel.fromJson(
          _roundtrip(monthlyReport.toJson()),
        ).employeeId,
        'emp-1',
      );

      const yearlyReport = EmployeeYearlyReportModel(
        employeeId: 'emp-1',
        employeeCode: 'EMP001',
        fullName: 'Jane Doe',
        year: 2026,
        annualWorkingDays: 240,
        annualPresentDays: 220,
        annualLeaveDays: 10,
        annualAbsentDays: 10,
        months: [summaryItem],
      );
      expect(
        EmployeeYearlyReportModel.fromJson(
          _roundtrip(yearlyReport.toJson()),
        ).year,
        2026,
      );
    });
  });
}
