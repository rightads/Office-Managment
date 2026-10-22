import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_colors.dart';
import 'package:right_ads/features/admin/data/admin_repository.dart';
import 'package:right_ads/features/admin/domain/admin_models.dart';
import 'package:right_ads/features/admin_attendance/application/admin_attendance_controllers.dart';
import 'package:right_ads/features/admin_attendance/data/admin_attendance_repository.dart';
import 'package:right_ads/features/admin_attendance/domain/attendance_report_models.dart';
import 'package:right_ads/features/admin_attendance/presentation/widgets/attendance_export_dialog.dart';

class AdminAttendanceDashboardScreen extends ConsumerStatefulWidget {
  const AdminAttendanceDashboardScreen({super.key});

  @override
  ConsumerState<AdminAttendanceDashboardScreen> createState() =>
      _AdminAttendanceDashboardScreenState();
}

class _AdminAttendanceDashboardScreenState
    extends ConsumerState<AdminAttendanceDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<MasterDataItem> _departments = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadDepartments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadDepartments() async {
    try {
      final repo = ref.read(adminRepositoryProvider);
      final depts = await repo.getMasterDataList('/departments');
      if (mounted) setState(() => _departments = depts);
    } catch (_) {}
  }

  Color _parseBadgeColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    try {
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (_) {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(adminAttendanceTodayControllerProvider);
    final controller = ref.read(
      adminAttendanceTodayControllerProvider.notifier,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminAttendanceDashboardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.table_chart),
            tooltip: l10n.adminAttendanceMatrixTab,
            onPressed: () => context.push(RoutePaths.adminAttendanceMatrix),
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            tooltip: l10n.adminAttendanceExport,
            onPressed: () => _openExportDialog(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l10n.adminAttendanceTodayTab),
            Tab(text: l10n.adminAttendanceMatrixTab),
            Tab(text: l10n.adminAttendanceReportsTab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTodayTab(context, state, controller, l10n),
          _buildMatrixShortcut(context, l10n),
          _buildReportsTab(context, l10n),
        ],
      ),
    );
  }

  Widget _buildTodayTab(
    BuildContext context,
    AdminAttendanceTodayState state,
    AdminAttendanceTodayController controller,
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
              onPressed: controller.loadDashboard,
              child: Text(l10n.adminClose),
            ),
          ],
        ),
      );
    }

    final data = state.data;
    if (data == null) {
      return Center(child: Text(l10n.adminAttendanceNoRecords));
    }

    return RefreshIndicator(
      onRefresh: controller.loadDashboard,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_departments.isNotEmpty) ...[
            DropdownButtonFormField<String?>(
              initialValue: state.departmentId,
              decoration: InputDecoration(
                labelText: l10n.adminAttendanceFilterDept,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              items: [
                DropdownMenuItem<String?>(
                  child: Text('${l10n.adminFilterAll} Departments'),
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
            const SizedBox(height: 16),
          ],
          _buildKpiGrid(data, l10n),
          const SizedBox(height: 20),
          ...data.statusBreakdown.map((breakdown) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ExpansionTile(
                leading: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: _parseBadgeColor(breakdown.badgeColor),
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text(
                  l10n.adminAttendanceStatusCountTitle(
                    breakdown.statusName,
                    breakdown.count,
                  ),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: breakdown.employees.isEmpty
                    ? [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(l10n.adminNoItemsFound),
                        ),
                      ]
                    : breakdown.employees.map((emp) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              emp.fullName.isNotEmpty
                                  ? emp.fullName[0].toUpperCase()
                                  : '?',
                            ),
                          ),
                          title: Text(emp.fullName),
                          subtitle: Text(
                            '${emp.employeeCode} • ${emp.designation ?? '-'}',
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            context.push(
                              RoutePaths.adminEmployeeMonthly(emp.id),
                            );
                          },
                        );
                      }).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildKpiGrid(
    AttendanceTodayReportResponse data,
    AppLocalizations l10n,
  ) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _buildKpiCard(
          l10n.adminAttendanceTotalActive,
          data.totalActiveEmployees.toString(),
          Colors.blueGrey,
        ),
        _buildKpiCard(
          l10n.adminAttendancePresent,
          data.presentCount.toString(),
          AppColors.success,
        ),
        _buildKpiCard(
          l10n.adminAttendanceAbsent,
          data.absentCount.toString(),
          AppColors.error,
        ),
        _buildKpiCard(
          l10n.adminAttendanceLate,
          data.lateCount.toString(),
          AppColors.warning,
        ),
        _buildKpiCard(
          l10n.adminAttendanceHalfDay,
          data.halfDayCount.toString(),
          Colors.orange,
        ),
        _buildKpiCard(
          l10n.adminAttendanceOnLeave,
          data.onLeaveCount.toString(),
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildKpiCard(String title, String count, Color color) {
    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildMatrixShortcut(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.table_chart, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            Text(
              l10n.adminAttendanceMatrixTab,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push(RoutePaths.adminAttendanceMatrix),
              child: Text(l10n.adminAttendanceMatrixTab),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsTab(BuildContext context, AppLocalizations l10n) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.file_download, color: Colors.blue),
            title: Text(l10n.adminAttendanceExport),
            subtitle: Text(l10n.adminAttendanceExportSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openExportDialog(context),
          ),
        ),
      ],
    );
  }

  Future<void> _openExportDialog(BuildContext context) async {
    final state = ref.read(adminAttendanceTodayControllerProvider);
    final res = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => AttendanceExportDialog(departmentId: state.departmentId),
    );

    if (res != null && context.mounted) {
      final l10n = AppLocalizations.of(context);
      try {
        final repo = ref.read(adminAttendanceRepositoryProvider);
        await repo.exportReport(
          reportType: res['reportType'] as String,
          format: res['format'] as String,
          month: res['month'] as int?,
          year: res['year'] as int?,
          departmentId: res['departmentId'] as String?,
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.adminAttendanceDownloadSuccess)),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
    }
  }
}
