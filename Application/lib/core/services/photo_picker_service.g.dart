// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_picker_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(photoPickerService)
final photoPickerServiceProvider = PhotoPickerServiceProvider._();

final class PhotoPickerServiceProvider
    extends
        $FunctionalProvider<
          PhotoPickerService,
          PhotoPickerService,
          PhotoPickerService
        >
    with $Provider<PhotoPickerService> {
  PhotoPickerServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoPickerServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoPickerServiceHash();

  @$internal
  @override
  $ProviderElement<PhotoPickerService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhotoPickerService create(Ref ref) {
    return photoPickerService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoPickerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoPickerService>(value),
    );
  }
}

String _$photoPickerServiceHash() =>
    r'fd1913a2c4379f6ec45aba0d81291c98e51b5a3e';
