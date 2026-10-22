// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_operations_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminTaskReportsController)
final adminTaskReportsControllerProvider =
    AdminTaskReportsControllerProvider._();

final class AdminTaskReportsControllerProvider
    extends
        $NotifierProvider<AdminTaskReportsController, AdminTaskReportsState> {
  AdminTaskReportsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminTaskReportsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminTaskReportsControllerHash();

  @$internal
  @override
  AdminTaskReportsController create() => AdminTaskReportsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminTaskReportsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminTaskReportsState>(value),
    );
  }
}

String _$adminTaskReportsControllerHash() =>
    r'bb54c665b29f2ec028a5101e8bfd3d9f16f593ea';

abstract class _$AdminTaskReportsController
    extends $Notifier<AdminTaskReportsState> {
  AdminTaskReportsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AdminTaskReportsState, AdminTaskReportsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminTaskReportsState, AdminTaskReportsState>,
              AdminTaskReportsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(AdminLeaveApprovalsController)
final adminLeaveApprovalsControllerProvider =
    AdminLeaveApprovalsControllerProvider._();

final class AdminLeaveApprovalsControllerProvider
    extends
        $NotifierProvider<
          AdminLeaveApprovalsController,
          AdminLeaveApprovalsState
        > {
  AdminLeaveApprovalsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminLeaveApprovalsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminLeaveApprovalsControllerHash();

  @$internal
  @override
  AdminLeaveApprovalsController create() => AdminLeaveApprovalsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminLeaveApprovalsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminLeaveApprovalsState>(value),
    );
  }
}

String _$adminLeaveApprovalsControllerHash() =>
    r'd7f76c5d677e79e002d4b39a58387a39f0a577cf';

abstract class _$AdminLeaveApprovalsController
    extends $Notifier<AdminLeaveApprovalsState> {
  AdminLeaveApprovalsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AdminLeaveApprovalsState, AdminLeaveApprovalsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdminLeaveApprovalsState, AdminLeaveApprovalsState>,
              AdminLeaveApprovalsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(AdminWorkReportsReviewController)
final adminWorkReportsReviewControllerProvider =
    AdminWorkReportsReviewControllerProvider._();

final class AdminWorkReportsReviewControllerProvider
    extends
        $NotifierProvider<
          AdminWorkReportsReviewController,
          AdminWorkReportsReviewState
        > {
  AdminWorkReportsReviewControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminWorkReportsReviewControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminWorkReportsReviewControllerHash();

  @$internal
  @override
  AdminWorkReportsReviewController create() =>
      AdminWorkReportsReviewController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminWorkReportsReviewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminWorkReportsReviewState>(value),
    );
  }
}

String _$adminWorkReportsReviewControllerHash() =>
    r'8540a4830046471c4fee803a2cdec53702b56606';

abstract class _$AdminWorkReportsReviewController
    extends $Notifier<AdminWorkReportsReviewState> {
  AdminWorkReportsReviewState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AdminWorkReportsReviewState, AdminWorkReportsReviewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AdminWorkReportsReviewState,
                AdminWorkReportsReviewState
              >,
              AdminWorkReportsReviewState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
