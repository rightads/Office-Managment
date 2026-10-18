import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_service.g.dart';

@immutable
class PermissionSet {
  const PermissionSet(this._codes);

  static const PermissionSet empty = PermissionSet(<String>{});

  final Set<String> _codes;

  Set<String> get codes => Set<String>.unmodifiable(_codes);

  bool get hasWildcard => _codes.contains(PermissionCodes.wildcard);

  bool can(String code) {
    if (hasWildcard) return true;
    return _codes.contains(code);
  }

  bool canAny(Iterable<String> requiredCodes) {
    if (hasWildcard) return true;
    for (final code in requiredCodes) {
      if (_codes.contains(code)) return true;
    }
    return false;
  }

  bool canAll(Iterable<String> requiredCodes) {
    if (hasWildcard) return true;
    for (final code in requiredCodes) {
      if (!_codes.contains(code)) return false;
    }
    return true;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PermissionSet && setEquals(_codes, other._codes);

  @override
  int get hashCode => Object.hashAllUnordered(_codes);
}

@Riverpod(keepAlive: true)
class UserPermissionsController extends _$UserPermissionsController {
  @override
  PermissionSet build() => PermissionSet.empty;

  void setPermissions(Iterable<String> codes) {
    state = PermissionSet(codes.toSet());
  }

  void clear() {
    state = PermissionSet.empty;
  }
}

extension WidgetRefPermissionX on WidgetRef {
  bool can(String permissionCode) =>
      watch(userPermissionsControllerProvider).can(permissionCode);

  bool canAny(Iterable<String> permissionCodes) =>
      watch(userPermissionsControllerProvider).canAny(permissionCodes);

  bool canAll(Iterable<String> permissionCodes) =>
      watch(userPermissionsControllerProvider).canAll(permissionCodes);
}

extension RefPermissionX on Ref {
  bool can(String permissionCode) =>
      watch(userPermissionsControllerProvider).can(permissionCode);

  bool canAny(Iterable<String> permissionCodes) =>
      watch(userPermissionsControllerProvider).canAny(permissionCodes);

  bool canAll(Iterable<String> permissionCodes) =>
      watch(userPermissionsControllerProvider).canAll(permissionCodes);
}
