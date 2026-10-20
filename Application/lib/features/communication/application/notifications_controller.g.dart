// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Unread notification count badge provider.

@ProviderFor(UnreadNotificationCountController)
final unreadNotificationCountControllerProvider =
    UnreadNotificationCountControllerProvider._();

/// Unread notification count badge provider.
final class UnreadNotificationCountControllerProvider
    extends $NotifierProvider<UnreadNotificationCountController, int> {
  /// Unread notification count badge provider.
  UnreadNotificationCountControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadNotificationCountControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$unreadNotificationCountControllerHash();

  @$internal
  @override
  UnreadNotificationCountController create() =>
      UnreadNotificationCountController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$unreadNotificationCountControllerHash() =>
    r'7139352e0e5a25465669759396fcf942bd98b1fd';

/// Unread notification count badge provider.

abstract class _$UnreadNotificationCountController extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Controller managing the notifications inbox list, pagination, and read actions.

@ProviderFor(NotificationsListController)
final notificationsListControllerProvider =
    NotificationsListControllerProvider._();

/// Controller managing the notifications inbox list, pagination, and read actions.
final class NotificationsListControllerProvider
    extends
        $NotifierProvider<NotificationsListController, NotificationsListState> {
  /// Controller managing the notifications inbox list, pagination, and read actions.
  NotificationsListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsListControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsListControllerHash();

  @$internal
  @override
  NotificationsListController create() => NotificationsListController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationsListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationsListState>(value),
    );
  }
}

String _$notificationsListControllerHash() =>
    r'661dda512b4ae19e16adc111a12633b6f08ccc55';

/// Controller managing the notifications inbox list, pagination, and read actions.

abstract class _$NotificationsListController
    extends $Notifier<NotificationsListState> {
  NotificationsListState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<NotificationsListState, NotificationsListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NotificationsListState, NotificationsListState>,
              NotificationsListState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
