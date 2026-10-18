// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileController)
final profileControllerProvider = ProfileControllerProvider._();

final class ProfileControllerProvider
    extends $NotifierProvider<ProfileController, ProfileViewState> {
  ProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileControllerHash();

  @$internal
  @override
  ProfileController create() => ProfileController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileViewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileViewState>(value),
    );
  }
}

String _$profileControllerHash() => r'7bce2c9e81403d003dc517ca303f00af2016c1b4';

abstract class _$ProfileController extends $Notifier<ProfileViewState> {
  ProfileViewState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ProfileViewState, ProfileViewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProfileViewState, ProfileViewState>,
              ProfileViewState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
