import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/features/admin/domain/admin_models.dart';

void main() {
  group('Admin Models Tests', () {
    test('EmployeeItem fromJson parses correctly', () {
      final json = <String, dynamic>{
        'id': 'emp-123',
        'employee_code': 'RA001',
        'email': 'alice@example.com',
        'full_name': 'Alice Smith',
        'phone_number': '1234567890',
        'designation': 'Lead Architect',
        'is_active': true,
        'must_change_password': false,
        'role_id': 'role-1',
        'role_name': 'Super Admin',
        'created_at': '2026-01-01T00:00:00Z',
      };

      final emp = EmployeeItem.fromJson(json);
      expect(emp.id, 'emp-123');
      expect(emp.employeeCode, 'RA001');
      expect(emp.email, 'alice@example.com');
      expect(emp.fullName, 'Alice Smith');
      expect(emp.roleName, 'Super Admin');
      expect(emp.isActive, true);
      expect(emp.mustChangePassword, false);
    });

    test('EmployeeCreatePayload toJson serializes required fields', () {
      const payload = EmployeeCreatePayload(
        email: 'bob@example.com',
        fullName: 'Bob Builder',
        roleId: 'role-2',
        designation: 'Staff Engineer',
      );

      final json = payload.toJson();
      expect(json['email'], 'bob@example.com');
      expect(json['full_name'], 'Bob Builder');
      expect(json['role_id'], 'role-2');
      expect(json['designation'], 'Staff Engineer');
    });

    test('BulkImportReport parses row errors correctly', () {
      final json = <String, dynamic>{
        'total_rows': 10,
        'successful_imports': 8,
        'failed_rows': 2,
        'dry_run': false,
        'errors': [
          {
            'row': 2,
            'field': 'email',
            'error': 'Duplicate email',
            'value': 'test@example.com',
          },
          {
            'row': 5,
            'field': 'role_id',
            'error': 'Role not found',
            'value': 'bad-role-id',
          },
        ],
      };

      final report = BulkImportReport.fromJson(json);
      expect(report.totalRows, 10);
      expect(report.successfulImports, 8);
      expect(report.failedRows, 2);
      expect(report.dryRun, false);
      expect(report.errors.length, 2);
      expect(report.errors[0].row, 2);
      expect(report.errors[0].field, 'email');
    });

    test('MasterDataItem parses color, coordinates and radius', () {
      final json = <String, dynamic>{
        'id': 'loc-1',
        'name': 'HQ Office',
        'color': '#3B82F6',
        'latitude': 28.6139,
        'longitude': 77.2090,
        'radius_meters': 150.0,
      };

      final item = MasterDataItem.fromJson(json);
      expect(item.id, 'loc-1');
      expect(item.name, 'HQ Office');
      expect(item.color, '#3B82F6');
      expect(item.latitude, 28.6139);
      expect(item.longitude, 77.2090);
      expect(item.radiusMeters, 150.0);
    });
  });
}
