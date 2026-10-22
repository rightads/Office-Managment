import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/features/admin/data/admin_repository.dart';
import 'package:right_ads/features/admin/domain/admin_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_detail_controller.freezed.dart';
part 'employee_detail_controller.g.dart';

@freezed
abstract class EmployeeDetailState with _$EmployeeDetailState {
  const factory EmployeeDetailState({
    EmployeeItem? employee,
    @Default(true) bool isLoading,
    @Default(false) bool isActionLoading,
    String? errorMessage,
    String? actionSuccessMessage,
  }) = _EmployeeDetailState;
}

@riverpod
class EmployeeDetailController extends _$EmployeeDetailController {
  @override
  EmployeeDetailState build(String employeeId) {
    state = const EmployeeDetailState();
    loadEmployee(employeeId);
    return state;
  }

  Future<void> loadEmployee(String employeeId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      final item = await repo.getEmployeeDetail(employeeId);
      state = state.copyWith(employee: item, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> activate(String employeeId) async {
    state = state.copyWith(isActionLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      await repo.activateEmployee(employeeId);
      await loadEmployee(employeeId);
      state = state.copyWith(
        isActionLoading: false,
        actionSuccessMessage: 'Employee activated',
      );
      return true;
    } on DioException catch (e) {
      final detail = e.response?.data is Map<String, dynamic>
          ? (e.response?.data as Map<String, dynamic>)['detail']?.toString()
          : e.message;
      state = state.copyWith(
        isActionLoading: false,
        errorMessage: detail ?? e.toString(),
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isActionLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> deactivate(String employeeId) async {
    state = state.copyWith(isActionLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      await repo.deactivateEmployee(employeeId);
      await loadEmployee(employeeId);
      state = state.copyWith(
        isActionLoading: false,
        actionSuccessMessage: 'Employee deactivated',
      );
      return true;
    } on DioException catch (e) {
      final detail = e.response?.data is Map<String, dynamic>
          ? (e.response?.data as Map<String, dynamic>)['detail']?.toString()
          : e.message;
      state = state.copyWith(
        isActionLoading: false,
        errorMessage: detail ?? e.toString(),
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isActionLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> resetPassword(String employeeId, {String? newPassword}) async {
    state = state.copyWith(isActionLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      await repo.resetPassword(employeeId, newPassword: newPassword);
      state = state.copyWith(
        isActionLoading: false,
        actionSuccessMessage: 'Password reset successfully',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isActionLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> resetDevice(String userId) async {
    state = state.copyWith(isActionLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      await repo.resetDevice(userId);
      state = state.copyWith(
        isActionLoading: false,
        actionSuccessMessage: 'Device binding reset successfully',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isActionLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> assignRole(String employeeId, String roleId) async {
    state = state.copyWith(isActionLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      await repo.assignRole(employeeId, roleId);
      await loadEmployee(employeeId);
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

  Future<bool> assignManager(String employeeId, String? managerId) async {
    state = state.copyWith(isActionLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      await repo.assignManager(employeeId, managerId);
      await loadEmployee(employeeId);
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

  Future<bool> assignPolicy(String employeeId, String? policyId) async {
    state = state.copyWith(isActionLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      await repo.assignAttendancePolicy(employeeId, policyId);
      await loadEmployee(employeeId);
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
