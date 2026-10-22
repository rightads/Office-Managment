import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/features/admin/data/admin_repository.dart';
import 'package:right_ads/features/admin/domain/admin_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_list_controller.freezed.dart';
part 'employee_list_controller.g.dart';

@freezed
abstract class EmployeeListState with _$EmployeeListState {
  const factory EmployeeListState({
    @Default(<EmployeeItem>[]) List<EmployeeItem> employees,
    @Default(<RoleItem>[]) List<RoleItem> roles,
    @Default(true) bool isLoading,
    @Default(false) bool isPaginating,
    @Default(false) bool hasMore,
    @Default(1) int currentPage,
    String? search,
    String? departmentId,
    String? roleId,
    bool? isActive,
    String? errorMessage,
  }) = _EmployeeListState;
}

@riverpod
class EmployeeListController extends _$EmployeeListController {
  @override
  EmployeeListState build() {
    state = const EmployeeListState();
    loadInitial();
    return state;
  }

  Future<void> loadInitial() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final repo = ref.read(adminRepositoryProvider);
      final roles = await repo.getRoles();
      final items = await repo.getEmployees(
        search: state.search,
        departmentId: state.departmentId,
        roleId: state.roleId,
        isActive: state.isActive,
      );

      state = state.copyWith(
        employees: items,
        roles: roles,
        isLoading: false,
        hasMore: items.length >= 20,
        currentPage: 1,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> fetchNextPage() async {
    if (state.isLoading || state.isPaginating || !state.hasMore) return;

    state = state.copyWith(isPaginating: true);
    final nextPage = state.currentPage + 1;
    try {
      final repo = ref.read(adminRepositoryProvider);
      final items = await repo.getEmployees(
        search: state.search,
        departmentId: state.departmentId,
        roleId: state.roleId,
        isActive: state.isActive,
        page: nextPage,
      );

      state = state.copyWith(
        employees: <EmployeeItem>[...state.employees, ...items],
        isPaginating: false,
        hasMore: items.length >= 20,
        currentPage: nextPage,
      );
    } catch (e) {
      state = state.copyWith(isPaginating: false);
    }
  }

  void onSearchChanged(String query) {
    state = state.copyWith(search: query.isEmpty ? null : query);
    loadInitial();
  }

  void onDepartmentFilterChanged(String? deptId) {
    state = state.copyWith(departmentId: deptId);
    loadInitial();
  }

  void onRoleFilterChanged(String? roleId) {
    state = state.copyWith(roleId: roleId);
    loadInitial();
  }

  void onActiveFilterChanged(bool? isActive) {
    state = state.copyWith(isActive: isActive);
    loadInitial();
  }
}
