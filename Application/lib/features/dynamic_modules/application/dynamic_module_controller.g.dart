// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_module_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ModuleDefinitionCache)
final moduleDefinitionCacheProvider = ModuleDefinitionCacheProvider._();

final class ModuleDefinitionCacheProvider
    extends
        $NotifierProvider<
          ModuleDefinitionCache,
          Map<String, DynamicModuleDefinition>
        > {
  ModuleDefinitionCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'moduleDefinitionCacheProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$moduleDefinitionCacheHash();

  @$internal
  @override
  ModuleDefinitionCache create() => ModuleDefinitionCache();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, DynamicModuleDefinition> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<Map<String, DynamicModuleDefinition>>(value),
    );
  }
}

String _$moduleDefinitionCacheHash() =>
    r'1dfdd819d33c8381c282de7fee65a87cf1ecdb9b';

abstract class _$ModuleDefinitionCache
    extends $Notifier<Map<String, DynamicModuleDefinition>> {
  Map<String, DynamicModuleDefinition> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              Map<String, DynamicModuleDefinition>,
              Map<String, DynamicModuleDefinition>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, DynamicModuleDefinition>,
                Map<String, DynamicModuleDefinition>
              >,
              Map<String, DynamicModuleDefinition>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(moduleSummary)
final moduleSummaryProvider = ModuleSummaryFamily._();

final class ModuleSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<DynamicModuleSummary?>,
          DynamicModuleSummary?,
          FutureOr<DynamicModuleSummary?>
        >
    with
        $FutureModifier<DynamicModuleSummary?>,
        $FutureProvider<DynamicModuleSummary?> {
  ModuleSummaryProvider._({
    required ModuleSummaryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'moduleSummaryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$moduleSummaryHash();

  @override
  String toString() {
    return r'moduleSummaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<DynamicModuleSummary?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DynamicModuleSummary?> create(Ref ref) {
    final argument = this.argument as String;
    return moduleSummary(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ModuleSummaryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$moduleSummaryHash() => r'1dff3a7716ad29f5cfec3f724db8a83d4ab9cded';

final class ModuleSummaryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<DynamicModuleSummary?>, String> {
  ModuleSummaryFamily._()
    : super(
        retry: null,
        name: r'moduleSummaryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ModuleSummaryProvider call(String moduleCode) =>
      ModuleSummaryProvider._(argument: moduleCode, from: this);

  @override
  String toString() => r'moduleSummaryProvider';
}

@ProviderFor(DynamicRecordListController)
final dynamicRecordListControllerProvider =
    DynamicRecordListControllerFamily._();

final class DynamicRecordListControllerProvider
    extends
        $NotifierProvider<DynamicRecordListController, DynamicRecordListState> {
  DynamicRecordListControllerProvider._({
    required DynamicRecordListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'dynamicRecordListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dynamicRecordListControllerHash();

  @override
  String toString() {
    return r'dynamicRecordListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DynamicRecordListController create() => DynamicRecordListController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DynamicRecordListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DynamicRecordListState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DynamicRecordListControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dynamicRecordListControllerHash() =>
    r'1730383b849ab8ee4fb8348c7b382dc1e090dd3f';

final class DynamicRecordListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          DynamicRecordListController,
          DynamicRecordListState,
          DynamicRecordListState,
          DynamicRecordListState,
          String
        > {
  DynamicRecordListControllerFamily._()
    : super(
        retry: null,
        name: r'dynamicRecordListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DynamicRecordListControllerProvider call(String moduleCode) =>
      DynamicRecordListControllerProvider._(argument: moduleCode, from: this);

  @override
  String toString() => r'dynamicRecordListControllerProvider';
}

abstract class _$DynamicRecordListController
    extends $Notifier<DynamicRecordListState> {
  late final _$args = ref.$arg as String;
  String get moduleCode => _$args;

  DynamicRecordListState build(String moduleCode);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<DynamicRecordListState, DynamicRecordListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DynamicRecordListState, DynamicRecordListState>,
              DynamicRecordListState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(DynamicRecordDetailController)
final dynamicRecordDetailControllerProvider =
    DynamicRecordDetailControllerFamily._();

final class DynamicRecordDetailControllerProvider
    extends
        $NotifierProvider<
          DynamicRecordDetailController,
          DynamicRecordDetailState
        > {
  DynamicRecordDetailControllerProvider._({
    required DynamicRecordDetailControllerFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'dynamicRecordDetailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dynamicRecordDetailControllerHash();

  @override
  String toString() {
    return r'dynamicRecordDetailControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  DynamicRecordDetailController create() => DynamicRecordDetailController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DynamicRecordDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DynamicRecordDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DynamicRecordDetailControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dynamicRecordDetailControllerHash() =>
    r'a83155e48cdff267877ff1e41dfab2f23bfb35e2';

final class DynamicRecordDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          DynamicRecordDetailController,
          DynamicRecordDetailState,
          DynamicRecordDetailState,
          DynamicRecordDetailState,
          (String, String)
        > {
  DynamicRecordDetailControllerFamily._()
    : super(
        retry: null,
        name: r'dynamicRecordDetailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DynamicRecordDetailControllerProvider call(
    String moduleCode,
    String recordId,
  ) => DynamicRecordDetailControllerProvider._(
    argument: (moduleCode, recordId),
    from: this,
  );

  @override
  String toString() => r'dynamicRecordDetailControllerProvider';
}

abstract class _$DynamicRecordDetailController
    extends $Notifier<DynamicRecordDetailState> {
  late final _$args = ref.$arg as (String, String);
  String get moduleCode => _$args.$1;
  String get recordId => _$args.$2;

  DynamicRecordDetailState build(String moduleCode, String recordId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<DynamicRecordDetailState, DynamicRecordDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DynamicRecordDetailState, DynamicRecordDetailState>,
              DynamicRecordDetailState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
