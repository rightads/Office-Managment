import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/admin_repository.dart';
import '../domain/admin_models.dart';

part 'bulk_import_controller.freezed.dart';
part 'bulk_import_controller.g.dart';

@freezed
abstract class BulkImportState with _$BulkImportState {
  const factory BulkImportState({
    @Default(false) bool isUploading,
    @Default(false) bool dryRun,
    BulkImportReport? report,
    String? errorMessage,
    String? selectedFileName,
    List<int>? selectedFileBytes,
  }) = _BulkImportState;
}

@riverpod
class BulkImportController extends _$BulkImportController {
  @override
  BulkImportState build() {
    return const BulkImportState();
  }

  void setSelectedFile({required String fileName, required List<int> bytes}) {
    state = state.copyWith(
      selectedFileName: fileName,
      selectedFileBytes: bytes,
      errorMessage: null,
      report: null,
    );
  }

  void setDryRun({required bool value}) {
    state = state.copyWith(dryRun: value);
  }

  Future<bool> upload() async {
    final bytes = state.selectedFileBytes;
    final name = state.selectedFileName;
    if (bytes == null || name == null) {
      state = state.copyWith(errorMessage: 'Please select a CSV file first');
      return false;
    }

    state = state.copyWith(isUploading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      final report = await repo.bulkImportEmployees(
        fileBytes: bytes,
        fileName: name,
        dryRun: state.dryRun,
      );
      state = state.copyWith(
        isUploading: false,
        report: report,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isUploading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
}
