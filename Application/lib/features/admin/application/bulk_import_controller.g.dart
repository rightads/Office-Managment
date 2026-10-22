// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_import_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BulkImportController)
final bulkImportControllerProvider = BulkImportControllerProvider._();

final class BulkImportControllerProvider
    extends $NotifierProvider<BulkImportController, BulkImportState> {
  BulkImportControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bulkImportControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bulkImportControllerHash();

  @$internal
  @override
  BulkImportController create() => BulkImportController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BulkImportState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BulkImportState>(value),
    );
  }
}

String _$bulkImportControllerHash() =>
    r'4065d0218a4794a0560b82f18c361bd25b75fe4c';

abstract class _$BulkImportController extends $Notifier<BulkImportState> {
  BulkImportState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<BulkImportState, BulkImportState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BulkImportState, BulkImportState>,
              BulkImportState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
