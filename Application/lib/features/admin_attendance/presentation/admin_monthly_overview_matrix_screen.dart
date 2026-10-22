import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_colors.dart';
import 'package:right_ads/features/admin/data/admin_repository.dart';
import 'package:right_ads/features/admin/domain/admin_models.dart';
import 'package:right_ads/features/admin_attendance/application/admin_attendance_controllers.dart';

class AdminMonthlyOverviewMatrixScreen extends ConsumerStatefulWidget {
  const AdminMonthlyOverviewMatrixScreen({super.key});

  @override
  ConsumerState<AdminMonthlyOverviewMatrixScreen> createState() =>
      _AdminMonthlyOverviewMatrixScreenState();
}

class _AdminMonthlyOverviewMatrixScreenState
    extends ConsumerState<AdminMonthlyOverviewMatrixScreen> {
  List<MasterDataItem> _departments = [];

  @override
  void initState() {
    super.initState();
    _loadDepartments();
  }

  Future<void> _loadDepartments() async {
    try {
      final repo = ref.read(adminRepositoryProvider);
      final depts = await repo.getMasterDataList('/departments');
      if (mounted) setState(() => _departments = depts);
    } catch (_) {}
  }

  Color _getStatusColor(String? code, ColorScheme colorScheme) {
    if (code == null) return Colors.transparent;
    switch (code.toUpperCase()) {
      case 'PRESENT':
        return AppColors.success;
      case 'ABSENT':
        return AppColors.error;
      case 'HALF_DAY':
        return AppColors.warning;
      case 'LATE':
        return colorScheme.tertiary;
      case 'ON_LEAVE':
        return colorScheme.primary;
      case 'HOLIDAY':
        return AppColors.info;
      case 'WEEK_OFF':
        return colorScheme.outlineVariant;
      default:
        return colorScheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(adminMonthlyOverviewControllerProvider);
    final controller = ref.read(
      adminMonthlyOverviewControllerProvider.notifier,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminAttendanceMatrixTab),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.loadOverview,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeaderControls(state, controller, l10n),
          Expanded(child: _buildMatrixBody(state, controller, l10n)),
        ],
      ),
    );
  }

  Widget _buildHeaderControls(
    AdminMonthlyOverviewState state,
    AdminMonthlyOverviewController controller,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              var m = state.month - 1;
              var y = state.year;
              if (m < 1) {
                m = 12;
                y--;
              }
              controller.setDate(month: m, year: y);
            },
          ),
          Text(
            '${state.month}/${state.year}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              var m = state.month + 1;
              var y = state.year;
              if (m > 12) {
                m = 1;
                y++;
              }
              controller.setDate(month: m, year: y);
            },
          ),
          const Spacer(),
          if (_departments.isNotEmpty)
            DropdownButton<String?>(
              value: state.departmentId,
              hint: Text(l10n.adminAttendanceFilterDept),
              items: [
                DropdownMenuItem<String?>(
                  child: Text('${l10n.adminFilterAll} Depts'),
                ),
                ..._departments.map(
                  (d) => DropdownMenuItem<String?>(
                    value: d.id,
                    child: Text(d.name ?? d.id),
                  ),
                ),
              ],
              onChanged: controller.onDepartmentChanged,
            ),
        ],
      ),
    );
  }

  Widget _buildMatrixBody(
    AdminMonthlyOverviewState state,
    AdminMonthlyOverviewController controller,
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
            Text(
              state.errorMessage!,
              style: const TextStyle(color: AppColors.error),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: controller.loadOverview,
              child: Text(l10n.adminClose),
            ),
          ],
        ),
      );
    }

    final data = state.data;
    if (data == null || data.rows.isEmpty) {
      return Center(child: Text(l10n.adminAttendanceNoRecords));
    }

    // Number of days in month
    final daysInMonth = DateUtils.getDaysInMonth(state.year, state.month);

    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 10,
          horizontalMargin: 12,
          headingRowHeight: 40,
          dataRowMinHeight: 42,
          dataRowMaxHeight: 42,
          columns: [
            DataColumn(label: Text(l10n.adminFullName)),
            ...List.generate(daysInMonth, (i) {
              return DataColumn(label: Text('${i + 1}'));
            }),
            DataColumn(label: Text(l10n.adminAttendancePercentage)),
          ],
          rows: data.rows.map((row) {
            return DataRow(
              cells: [
                DataCell(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        row.employeeName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        row.employeeCode,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                ...List.generate(daysInMonth, (i) {
                  final dayKey = (i + 1).toString().padLeft(2, '0');
                  final status = row.days[dayKey];
                  return DataCell(
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          status,
                          Theme.of(context).colorScheme,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          status != null && status.isNotEmpty ? status[0] : '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                DataCell(
                  Text(
                    '${row.attendancePercentage.toStringAsFixed(1)}%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
