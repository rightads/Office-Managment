// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communication_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(communicationRepository)
final communicationRepositoryProvider = CommunicationRepositoryProvider._();

final class CommunicationRepositoryProvider
    extends
        $FunctionalProvider<
          CommunicationRepository,
          CommunicationRepository,
          CommunicationRepository
        >
    with $Provider<CommunicationRepository> {
  CommunicationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communicationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communicationRepositoryHash();

  @$internal
  @override
  $ProviderElement<CommunicationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommunicationRepository create(Ref ref) {
    return communicationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommunicationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommunicationRepository>(value),
    );
  }
}

String _$communicationRepositoryHash() =>
    r'ff7067b4e1a4cdc76e0207bdf3a5485c011bfe6b';
