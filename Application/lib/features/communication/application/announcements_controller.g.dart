// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcements_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller managing company & department announcements.
///
/// Respects expiry: expired announcements are filtered out.

@ProviderFor(AnnouncementsListController)
final announcementsListControllerProvider =
    AnnouncementsListControllerProvider._();

/// Controller managing company & department announcements.
///
/// Respects expiry: expired announcements are filtered out.
final class AnnouncementsListControllerProvider
    extends
        $NotifierProvider<AnnouncementsListController, AnnouncementsListState> {
  /// Controller managing company & department announcements.
  ///
  /// Respects expiry: expired announcements are filtered out.
  AnnouncementsListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'announcementsListControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$announcementsListControllerHash();

  @$internal
  @override
  AnnouncementsListController create() => AnnouncementsListController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnnouncementsListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnnouncementsListState>(value),
    );
  }
}

String _$announcementsListControllerHash() =>
    r'92fdb8416c89e1901ebe5df213438015b95ec886';

/// Controller managing company & department announcements.
///
/// Respects expiry: expired announcements are filtered out.

abstract class _$AnnouncementsListController
    extends $Notifier<AnnouncementsListState> {
  AnnouncementsListState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AnnouncementsListState, AnnouncementsListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AnnouncementsListState, AnnouncementsListState>,
              AnnouncementsListState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Computes whether there are recent active announcements to show a "New" badge on Home.

@ProviderFor(hasNewAnnouncements)
final hasNewAnnouncementsProvider = HasNewAnnouncementsProvider._();

/// Computes whether there are recent active announcements to show a "New" badge on Home.

final class HasNewAnnouncementsProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Computes whether there are recent active announcements to show a "New" badge on Home.
  HasNewAnnouncementsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasNewAnnouncementsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasNewAnnouncementsHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return hasNewAnnouncements(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hasNewAnnouncementsHash() =>
    r'f543a627aa30c47265719bbd5d57213b697e95b3';

/// Family provider to load details for a single announcement by ID.

@ProviderFor(announcementDetail)
final announcementDetailProvider = AnnouncementDetailFamily._();

/// Family provider to load details for a single announcement by ID.

final class AnnouncementDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<AnnouncementModel?>,
          AnnouncementModel?,
          FutureOr<AnnouncementModel?>
        >
    with
        $FutureModifier<AnnouncementModel?>,
        $FutureProvider<AnnouncementModel?> {
  /// Family provider to load details for a single announcement by ID.
  AnnouncementDetailProvider._({
    required AnnouncementDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'announcementDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$announcementDetailHash();

  @override
  String toString() {
    return r'announcementDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AnnouncementModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AnnouncementModel?> create(Ref ref) {
    final argument = this.argument as String;
    return announcementDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AnnouncementDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$announcementDetailHash() =>
    r'73a6fa7e72e6ac8deb591ec4649a15ea501329e4';

/// Family provider to load details for a single announcement by ID.

final class AnnouncementDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AnnouncementModel?>, String> {
  AnnouncementDetailFamily._()
    : super(
        retry: null,
        name: r'announcementDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Family provider to load details for a single announcement by ID.

  AnnouncementDetailProvider call(String announcementId) =>
      AnnouncementDetailProvider._(argument: announcementId, from: this);

  @override
  String toString() => r'announcementDetailProvider';
}
