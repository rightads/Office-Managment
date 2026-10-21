import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/features/dynamic_modules/data/dynamic_module_repository.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_module_controller.freezed.dart';
part 'dynamic_module_controller.g.dart';

// ---------------------------------------------------------------------------
// Definition Cache
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: true)
class ModuleDefinitionCache extends _$ModuleDefinitionCache {
  @override
  Map<String, DynamicModuleDefinition> build() =>
      <String, DynamicModuleDefinition>{};

  Future<DynamicModuleDefinition?> getOrFetch(String code) async {
    final normalized = code.trim().toLowerCase();
    final cached = state[normalized];
    if (cached != null) return cached;

    final repo = ref.read(dynamicModuleRepositoryProvider);
    final (definition, _) = await repo.getDefinition(normalized);
    if (definition != null) {
      state = <String, DynamicModuleDefinition>{
        ...state,
        normalized: definition,
      };
      return definition;
    }
    return null;
  }

  void updateDefinition(DynamicModuleDefinition definition) {
    state = <String, DynamicModuleDefinition>{
      ...state,
      definition.code.toLowerCase(): definition,
    };
  }

  void invalidate(String code) {
    final next = Map<String, DynamicModuleDefinition>.from(state)
      ..remove(code.trim().toLowerCase());
    state = next;
  }
}

// ---------------------------------------------------------------------------
// Module Summary Provider
// ---------------------------------------------------------------------------

@riverpod
Future<DynamicModuleSummary?> moduleSummary(
  Ref ref,
  String moduleCode,
) async {
  final repo = ref.watch(dynamicModuleRepositoryProvider);
  final (summary, _) = await repo.getSummary(moduleCode);
  return summary;
}

// ---------------------------------------------------------------------------
// Record List State & Controller
// ---------------------------------------------------------------------------

@freezed
abstract class DynamicRecordListState with _$DynamicRecordListState {
  const factory DynamicRecordListState({
    @Default(true) bool isLoading,
    @Default(false) bool isFetchingNextPage,
    @Default(<DynamicRecordModel>[]) List<DynamicRecordModel> records,
    @Default(0) int total,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default('') String search,
    String? statusFilter,
    String? sortBy,
    @Default(true) bool sortDesc,
    AppFailure? failure,
  }) = _DynamicRecordListState;
}

@riverpod
class DynamicRecordListController extends _$DynamicRecordListController {
  @override
  DynamicRecordListState build(String moduleCode) {
    Future.microtask(() => loadInitial());
    return const DynamicRecordListState();
  }

  Future<void> loadInitial() async {
    state = state.copyWith(isLoading: true, failure: null);
    final repo = ref.read(dynamicModuleRepositoryProvider);
    final (page, failure) = await repo.listRecords(
      moduleCode,
      page: 1,
      search: state.search,
      status: state.statusFilter,
      sortBy: state.sortBy,
      sortDesc: state.sortDesc,
    );
    if (failure != null) {
      state = state.copyWith(isLoading: false, failure: failure);
    } else if (page != null) {
      state = state.copyWith(
        isLoading: false,
        records: page.items,
        total: page.total,
        currentPage: page.page,
        totalPages: page.totalPages,
        failure: null,
      );
    }
  }

  Future<void> loadNextPage() async {
    if (state.isFetchingNextPage || state.currentPage >= state.totalPages) {
      return;
    }
    state = state.copyWith(isFetchingNextPage: true);
    final repo = ref.read(dynamicModuleRepositoryProvider);
    final nextPage = state.currentPage + 1;
    final (page, failure) = await repo.listRecords(
      moduleCode,
      page: nextPage,
      search: state.search,
      status: state.statusFilter,
      sortBy: state.sortBy,
      sortDesc: state.sortDesc,
    );
    if (failure != null) {
      state = state.copyWith(isFetchingNextPage: false, failure: failure);
    } else if (page != null) {
      state = state.copyWith(
        isFetchingNextPage: false,
        records: <DynamicRecordModel>[...state.records, ...page.items],
        currentPage: page.page,
        totalPages: page.totalPages,
      );
    }
  }

  void setSearch(String query) {
    if (state.search == query) return;
    state = state.copyWith(search: query);
    loadInitial();
  }

  void setStatusFilter(String? statusCode) {
    if (state.statusFilter == statusCode) return;
    state = state.copyWith(statusFilter: statusCode);
    loadInitial();
  }

  void setSorting({required String? sortBy, required bool sortDesc}) {
    state = state.copyWith(sortBy: sortBy, sortDesc: sortDesc);
    loadInitial();
  }

  Future<void> refresh() => loadInitial();
}

// ---------------------------------------------------------------------------
// Record Detail Controller
// ---------------------------------------------------------------------------

@freezed
abstract class DynamicRecordDetailState with _$DynamicRecordDetailState {
  const factory DynamicRecordDetailState({
    @Default(true) bool isLoading,
    @Default(false) bool isActionInProgress,
    DynamicRecordDetailModel? detail,
    AppFailure? failure,
  }) = _DynamicRecordDetailState;
}

@riverpod
class DynamicRecordDetailController extends _$DynamicRecordDetailController {
  @override
  DynamicRecordDetailState build(String moduleCode, String recordId) {
    Future.microtask(() => load());
    return const DynamicRecordDetailState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, failure: null);
    final repo = ref.read(dynamicModuleRepositoryProvider);
    final (detail, failure) = await repo.getRecord(moduleCode, recordId);
    state = state.copyWith(
      isLoading: false,
      detail: detail,
      failure: failure,
    );
  }

  Future<bool> changeStatus(String toStatusId, {String? note}) async {
    state = state.copyWith(isActionInProgress: true);
    final repo = ref.read(dynamicModuleRepositoryProvider);
    final (updated, failure) = await repo.changeStatus(
      moduleCode,
      recordId,
      toStatusId: toStatusId,
      note: note,
    );
    if (failure != null) {
      state = state.copyWith(isActionInProgress: false, failure: failure);
      return false;
    }
    await load();
    state = state.copyWith(isActionInProgress: false);
    // Refresh records list and summary
    ref.invalidate(dynamicRecordListControllerProvider(moduleCode));
    ref.invalidate(moduleSummaryProvider(moduleCode));
    return true;
  }

  Future<bool> addComment(String comment) async {
    state = state.copyWith(isActionInProgress: true);
    final repo = ref.read(dynamicModuleRepositoryProvider);
    final (newComment, failure) = await repo.addComment(
      moduleCode,
      recordId,
      comment,
    );
    if (failure != null) {
      state = state.copyWith(isActionInProgress: false, failure: failure);
      return false;
    }
    await load();
    state = state.copyWith(isActionInProgress: false);
    return true;
  }

  Future<bool> addAttachment({
    required String fileUrl,
    required String fileName,
    int fileSize = 0,
    String? mimeType,
  }) async {
    state = state.copyWith(isActionInProgress: true);
    final repo = ref.read(dynamicModuleRepositoryProvider);
    final (newAtt, failure) = await repo.addAttachment(
      moduleCode,
      recordId,
      fileUrl: fileUrl,
      fileName: fileName,
      fileSize: fileSize,
      mimeType: mimeType,
    );
    if (failure != null) {
      state = state.copyWith(isActionInProgress: false, failure: failure);
      return false;
    }
    await load();
    state = state.copyWith(isActionInProgress: false);
    return true;
  }

  Future<bool> deleteRecord() async {
    state = state.copyWith(isActionInProgress: true);
    final repo = ref.read(dynamicModuleRepositoryProvider);
    final failure = await repo.deleteRecord(moduleCode, recordId);
    if (failure != null) {
      state = state.copyWith(isActionInProgress: false, failure: failure);
      return false;
    }
    ref.invalidate(dynamicRecordListControllerProvider(moduleCode));
    ref.invalidate(moduleSummaryProvider(moduleCode));
    return true;
  }
}
