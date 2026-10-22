// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_data_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MasterDataController)
final masterDataControllerProvider = MasterDataControllerFamily._();

final class MasterDataControllerProvider
    extends $NotifierProvider<MasterDataController, MasterDataState> {
  MasterDataControllerProvider._({
    required MasterDataControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'masterDataControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$masterDataControllerHash();

  @override
  String toString() {
    return r'masterDataControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MasterDataController create() => MasterDataController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MasterDataState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MasterDataState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MasterDataControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$masterDataControllerHash() =>
    r'fcdeab14b5c2b82b1e255e5837f2fef3561c4c5d';

final class MasterDataControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          MasterDataController,
          MasterDataState,
          MasterDataState,
          MasterDataState,
          String
        > {
  MasterDataControllerFamily._()
    : super(
        retry: null,
        name: r'masterDataControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MasterDataControllerProvider call(String basePath) =>
      MasterDataControllerProvider._(argument: basePath, from: this);

  @override
  String toString() => r'masterDataControllerProvider';
}

abstract class _$MasterDataController extends $Notifier<MasterDataState> {
  late final _$args = ref.$arg as String;
  String get basePath => _$args;

  MasterDataState build(String basePath);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MasterDataState, MasterDataState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MasterDataState, MasterDataState>,
              MasterDataState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
