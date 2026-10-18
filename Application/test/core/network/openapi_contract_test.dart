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

      const endpointsToCheck = <String>[
        ApiEndpoints.health,
        ApiEndpoints.authLogin,
        ApiEndpoints.authRefresh,
        ApiEndpoints.authLogout,
        ApiEndpoints.authLogoutAll,
        ApiEndpoints.authChangePassword,
        ApiEndpoints.authForgotPassword,
        ApiEndpoints.authResetPassword,
        ApiEndpoints.authMe,
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
    });

    test('PermissionCodes catalog matches backend seed permissions', () {
      expect(PermissionCodes.all.length, 33);
      expect(PermissionCodes.all.contains(PermissionCodes.wildcard), isFalse);

      final seedFile = File('../Backend/app/utils/seed.py');
      if (seedFile.existsSync()) {
        final content = seedFile.readAsStringSync();
        for (final code in PermissionCodes.all) {
          expect(
            content.contains('"$code"'),
            isTrue,
            reason:
                'Permission code "$code" not found in Backend/app/utils/seed.py',
          );
        }
      }
    });
  });
}
