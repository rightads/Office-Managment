// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_operations_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminOperationsRepository)
final adminOperationsRepositoryProvider = AdminOperationsRepositoryProvider._();

final class AdminOperationsRepositoryProvider
    extends
        $FunctionalProvider<
          AdminOperationsRepository,
          AdminOperationsRepository,
          AdminOperationsRepository
        >
    with $Provider<AdminOperationsRepository> {
  AdminOperationsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminOperationsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminOperationsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdminOperationsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminOperationsRepository create(Ref ref) {
    return adminOperationsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminOperationsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminOperationsRepository>(value),
    );
  }
}

String _$adminOperationsRepositoryHash() =>
    r'cea9235782a0f25cbb375b56d7af4b71f54b612f';
