import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_colors.dart';
import 'package:right_ads/features/admin/application/employee_list_controller.dart';

class EmployeeListScreen extends ConsumerWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(employeeListControllerProvider);
    final controller = ref.read(employeeListControllerProvider.notifier);
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminEmployeesTitle),
        actions: [
          if (ref.can(PermissionCodes.userCreate)) ...[
            IconButton(
              icon: const Icon(Icons.upload_file),
              tooltip: l10n.adminBulkImport,
              onPressed: () =>
                  context.push(RoutePaths.adminEmployeesBulkImport),
            ),
          ],
        ],
      ),
      floatingActionButton: ref.can(PermissionCodes.userCreate)
          ? FloatingActionButton.extended(
              onPressed: () => context.push(RoutePaths.adminEmployeeCreate),
              icon: const Icon(Icons.person_add),
              label: Text(l10n.adminCreateEmployee),
            )
          : null,
      body: Column(
        children: [
          _buildFilterBar(context, ref, controller, state, l10n),
          Expanded(
            child: _buildContent(
              context,
              ref,
              state,
              controller,
              isDesktop,
              l10n,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(
    BuildContext context,
    WidgetRef ref,
    EmployeeListController controller,
    EmployeeListState state,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: l10n.adminSearchEmployees,
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            onChanged: controller.onSearchChanged,
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ActionChip(
                  label: Text(
                    state.isActive == null
                        ? '${l10n.adminFilterAll} Status'
                        : state.isActive!
                        ? l10n.adminStatusActive
                        : l10n.adminStatusInactive,
                  ),
                  onPressed: () {
                    if (state.isActive == null) {
                      controller.onActiveFilterChanged(true);
                    } else if (state.isActive == true) {
                      controller.onActiveFilterChanged(false);
                    } else {
                      controller.onActiveFilterChanged(null);
                    }
                  },
                ),
                const SizedBox(width: 8),
                if (state.roles.isNotEmpty)
                  DropdownButton<String?>(
                    value: state.roleId,
                    hint: Text(l10n.adminRole),
                    items: [
                      DropdownMenuItem<String?>(
                        child: Text('${l10n.adminFilterAll} ${l10n.adminRole}'),
                      ),
                      ...state.roles.map(
                        (r) => DropdownMenuItem<String?>(
                          value: r.id,
                          child: Text(r.name),
                        ),
                      ),
                    ],
                    onChanged: controller.onRoleFilterChanged,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    EmployeeListState state,
    EmployeeListController controller,
    bool isDesktop,
    AppLocalizations l10n,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.errorMessage!),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: controller.loadInitial,
              child: Text(l10n.adminClose),
            ),
          ],
        ),
      );
    }

    if (state.employees.isEmpty) {
      return Center(child: Text(l10n.adminNoItemsFound));
    }

    return RefreshIndicator(
      onRefresh: controller.loadInitial,
      child: isDesktop
          ? _buildDataTable(context, state, controller, l10n)
          : _buildCardList(context, state, controller, l10n),
    );
  }

  Widget _buildDataTable(
    BuildContext context,
    EmployeeListState state,
    EmployeeListController controller,
    AppLocalizations l10n,
  ) {
    return NotificationListener<ScrollNotification>(
      onNotification: (sn) {
        if (sn.metrics.pixels >= sn.metrics.maxScrollExtent - 200) {
          controller.fetchNextPage();
        }
        return false;
      },
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showCheckboxColumn: false,
            columns: [
              DataColumn(label: Text(l10n.adminEmployeeCode)),
              DataColumn(label: Text(l10n.adminFullName)),
              DataColumn(label: Text(l10n.adminEmail)),
              DataColumn(label: Text(l10n.adminRole)),
              DataColumn(label: Text(l10n.adminDepartment)),
              DataColumn(label: Text(l10n.adminDesignation)),
              DataColumn(label: Text(l10n.adminStatusActive)),
            ],
            rows: state.employees.map((e) {
              return DataRow(
                onSelectChanged: (_) {
                  context.push(RoutePaths.adminEmployeeDetail(e.id));
                },
                cells: [
                  DataCell(Text(e.employeeCode)),
                  DataCell(Text(e.fullName)),
                  DataCell(Text(e.email)),
                  DataCell(Text(e.roleName ?? '-')),
                  DataCell(Text(e.departmentName ?? '-')),
                  DataCell(Text(e.designation ?? '-')),
                  DataCell(
                    Icon(
                      e.isActive ? Icons.check_circle : Icons.cancel,
                      color: e.isActive ? AppColors.success : AppColors.error,
                      size: 20,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildCardList(
    BuildContext context,
    EmployeeListState state,
    EmployeeListController controller,
    AppLocalizations l10n,
  ) {
    return ListView.builder(
      itemCount: state.employees.length + (state.isPaginating ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.employees.length) {
          controller.fetchNextPage();
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final employee = state.employees[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                employee.fullName.isNotEmpty
                    ? employee.fullName[0].toUpperCase()
                    : '?',
              ),
            ),
            title: Text(employee.fullName),
            subtitle: Text(
              '${employee.employeeCode} • ${employee.roleName ?? '-'} • ${employee.departmentName ?? '-'}',
            ),
            trailing: Icon(
              employee.isActive ? Icons.check_circle : Icons.cancel,
              color: employee.isActive ? AppColors.success : AppColors.error,
              size: 20,
            ),
            onTap: () {
              context.push(RoutePaths.adminEmployeeDetail(employee.id));
            },
          ),
        );
      },
    );
  }
}
