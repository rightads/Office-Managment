// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_attendance_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminAttendanceRepository)
final adminAttendanceRepositoryProvider = AdminAttendanceRepositoryProvider._();

final class AdminAttendanceRepositoryProvider
    extends
        $FunctionalProvider<
          AdminAttendanceRepository,
          AdminAttendanceRepository,
          AdminAttendanceRepository
        >
    with $Provider<AdminAttendanceRepository> {
  AdminAttendanceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminAttendanceRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminAttendanceRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdminAttendanceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminAttendanceRepository create(Ref ref) {
    return adminAttendanceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminAttendanceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminAttendanceRepository>(value),
    );
  }
}

String _$adminAttendanceRepositoryHash() =>
    r'b69c496da6b9cf0f64c6838336526d99c9e6f86c';
