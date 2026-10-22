import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/admin_repository.dart';
import '../domain/admin_models.dart';

part 'master_data_controller.freezed.dart';
part 'master_data_controller.g.dart';

@freezed
abstract class MasterDataState with _$MasterDataState {
  const factory MasterDataState({
    @Default(<MasterDataItem>[]) List<MasterDataItem> items,
    @Default(true) bool isLoading,
    @Default(false) bool isActionLoading,
    String? errorMessage,
  }) = _MasterDataState;
}

@riverpod
class MasterDataController extends _$MasterDataController {
  @override
  MasterDataState build(String basePath) {
    state = const MasterDataState();
    loadItems(basePath);
    return state;
  }

  Future<void> loadItems(String basePath) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      final items = await repo.getMasterDataList(basePath);
      state = state.copyWith(items: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> createItem(String basePath, Map<String, dynamic> data) async {
    state = state.copyWith(isActionLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      await repo.createMasterDataItem(basePath, data);
      await loadItems(basePath);
      state = state.copyWith(isActionLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isActionLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> updateItem(String itemPath, Map<String, dynamic> data) async {
    state = state.copyWith(isActionLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      await repo.updateMasterDataItem(itemPath, data);
      await loadItems(basePath);
      state = state.copyWith(isActionLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isActionLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> deleteItem(String itemPath) async {
    state = state.copyWith(isActionLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      await repo.deleteMasterDataItem(itemPath);
      await loadItems(basePath);
      state = state.copyWith(isActionLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isActionLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
}
