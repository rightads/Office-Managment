import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';

void main() {
  group('OpenAPI & Backend Contract Verification', () {
    test('All ApiEndpoints paths exist in docs/backend/openapi.json', () {
      final openapiFile = File('docs/backend/openapi.json');
      expect(
        openapiFile.existsSync(),
        isTrue,
        reason: 'docs/backend/openapi.json must exist in the project root',
      );

      final decoded =
          jsonDecode(openapiFile.readAsStringSync()) as Map<String, dynamic>;
      final paths = decoded['paths'] as Map<String, dynamic>;

      final endpointsToCheck = <String>[
        ApiEndpoints.health,
        ApiEndpoints.appConfig,
        ApiEndpoints.meNavigation,
        ApiEndpoints.meAttendancePolicy,
        ApiEndpoints.appModules,
        ApiEndpoints.authLogin,
        ApiEndpoints.authRefresh,
        ApiEndpoints.authLogout,
        ApiEndpoints.authLogoutAll,
        ApiEndpoints.authChangePassword,
        ApiEndpoints.authForgotPassword,
        ApiEndpoints.authResetPassword,
        ApiEndpoints.authMe,
        ApiEndpoints.employeesMe,
        ApiEndpoints.attendanceToday,
        ApiEndpoints.attendanceCheckIn,
        ApiEndpoints.attendanceCheckOut,
        ApiEndpoints.attendanceMe,
        ApiEndpoints.employeeMonthlyAttendanceReport('{id}'),
        ApiEndpoints.employeeYearlyAttendanceReport('{id}'),
        ApiEndpoints.workReports,
        ApiEndpoints.workReportsMe,
        ApiEndpoints.workReportByDate('{date}'),
        ApiEndpoints.workReportDetail('{id}'),
        ApiEndpoints.workReportSubmit('{id}'),
      ];

      for (final endpoint in endpointsToCheck) {
        final fullOpenApiPath = '/api/v1$endpoint';
        expect(
          paths.containsKey(fullOpenApiPath),
          isTrue,
          reason:
              'Expected $fullOpenApiPath to exist in docs/backend/openapi.json',
        );
      }

      final employeesMeSpec =
          paths['/api/v1/employees/me'] as Map<String, dynamic>;
      expect(employeesMeSpec.containsKey('get'), isTrue);
      expect(employeesMeSpec.containsKey('patch'), isTrue);
    });

    test('PermissionCodes catalog matches backend seed permissions', () {
      expect(PermissionCodes.all.length, 38);
      expect(PermissionCodes.all.contains(PermissionCodes.wildcard), isFalse);

      final registryFile = File('../Backend/app/core/permissions_registry.py');
      if (registryFile.existsSync()) {
        final content = registryFile.readAsStringSync();
        for (final code in PermissionCodes.all) {
          expect(
            content.contains('"$code"'),
            isTrue,
            reason:
                'Permission code "$code" not found in Backend/app/core/permissions_registry.py',
          );
        }
      }
    });
  });
}
