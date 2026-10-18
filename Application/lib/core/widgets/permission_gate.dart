import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/permissions/permission_service.dart';

/// Declarative widget that gates [child] based on permission codes from
/// `userPermissionsControllerProvider`.
///
/// Checks permissions strictly via permission code constants (from
/// `PermissionCodes`), never by role names.
class PermissionGate extends ConsumerWidget {
  const PermissionGate({
    required this.child,
    this.permission,
    this.anyOf,
    this.allOf,
    this.fallback = const SizedBox.shrink(),
    super.key,
  }) : assert(
         permission != null || anyOf != null || allOf != null,
         'At least one of permission, anyOf, or allOf must be provided.',
       );

  final String? permission;
  final List<String>? anyOf;
  final List<String>? allOf;
  final Widget child;
  final Widget fallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permSet = ref.watch(userPermissionsControllerProvider);

    var allowed = true;
    if (permission != null) {
      allowed = allowed && permSet.can(permission!);
    }
    if (anyOf != null && anyOf!.isNotEmpty) {
      allowed = allowed && permSet.canAny(anyOf!);
    }
    if (allOf != null && allOf!.isNotEmpty) {
      allowed = allowed && permSet.canAll(allOf!);
    }

    return allowed ? child : fallback;
  }
}
