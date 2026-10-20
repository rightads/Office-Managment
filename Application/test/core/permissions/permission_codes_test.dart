import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';

void main() {
  group('PermissionCodes', () {
    test('contains all 38 unique backend permission codes', () {
      expect(PermissionCodes.all.length, 38);
      expect(PermissionCodes.all.toSet().length, 38);
    });

    test('every permission code follows resource.action format', () {
      for (final code in PermissionCodes.all) {
        expect(
          RegExp(r'^[a-z_]+\.[a-z_]+$').hasMatch(code),
          isTrue,
          reason: 'Invalid permission code format: $code',
        );
      }
    });
  });
}
