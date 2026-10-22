import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/theme/app_colors.dart';
import '../application/admin_attendance_controllers.dart';
import '../domain/attendance_report_models.dart';
import 'widgets/attendance_correction_dialog.dart';

class AdminEmployeeMonthlyScreen extends ConsumerStatefulWidget {
  const AdminEmployeeMonthlyScreen({required this.employeeId, super.key});

  final String employeeId;

  @override
  ConsumerState<AdminEmployeeMonthlyScreen> createState() =>
      _AdminEmployeeMonthlyScreenState();
}

class _AdminEmployeeMonthlyScreenState
    extends ConsumerState<AdminEmployeeMonthlyScreen> {
  Color _parseBadgeColor(String? hex) {
    if (hex == null) return Colors.grey;
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
    final state = ref.watch(
      adminEmployeeMonthlyControllerProvider(widget.employeeId),
    );
    final controller = ref.read(
      adminEmployeeMonthlyControllerProvider(widget.employeeId).notifier,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(state.data?.employeeName ?? l10n.adminAttendanceTodayTab),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.loadReport(widget.employeeId),
          ),
        ],
      ),
      body: _buildBody(state, controller, l10n),
    );
  }

  Widget _buildBody(
    AdminEmployeeMonthlyState state,
    AdminEmployeeMonthlyController controller,
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
              onPressed: () => controller.loadReport(widget.employeeId),
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildMonthSelector(state, controller),
          const SizedBox(height: 16),
          _buildSummaryCard(data, l10n),
          const SizedBox(height: 20),
          Text(
            l10n.adminAttendanceDayDetails,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...data.dailyRecords.map((record) => _buildDayTile(record, l10n)),
        ],
      ),
    );
  }

  Widget _buildMonthSelector(
    AdminEmployeeMonthlyState state,
    AdminEmployeeMonthlyController controller,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
            controller.setDate(widget.employeeId, month: m, year: y);
          },
        ),
        Text(
          '${state.month}/${state.year}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            controller.setDate(widget.employeeId, month: m, year: y);
          },
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    EmployeeMonthlyReportResponse data,
    AppLocalizations l10n,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.adminAttendancePercentage,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${data.attendancePercentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  l10n.adminAttendanceWorkingDays,
                  data.workingDays.toString(),
                ),
                _buildStatItem(
                  l10n.adminAttendancePresent,
                  data.presentDays.toString(),
                ),
                _buildStatItem(
                  l10n.adminAttendanceAbsent,
                  data.absentDays.toString(),
                ),
                _buildStatItem(
                  l10n.adminAttendanceHoursWorked,
                  data.totalHoursWorked.toStringAsFixed(1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String val) {
    return Column(
      children: [
        Text(
          val,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDayTile(AttendanceDayDetail record, AppLocalizations l10n) {
    final color = _parseBadgeColor(record.badgeColor);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        title: Text(
          l10n.adminAttendanceDateWithDay(record.date, record.dayOfWeek),
        ),
        subtitle: Text(
          '${record.statusName ?? '-'} • In: ${record.firstCheckIn ?? '-'} Out: ${record.lastCheckOut ?? '-'} (${record.totalHoursWorked.toStringAsFixed(1)}h)',
        ),
        trailing: ref.can(PermissionCodes.attendanceCorrect)
            ? IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () => _openCorrection(record, l10n),
              )
            : null,
      ),
    );
  }

  Future<void> _openCorrection(
    AttendanceDayDetail record,
    AppLocalizations l10n,
  ) async {
    final req = await showDialog<AttendanceCorrectionRequest>(
      context: context,
      builder: (_) => AttendanceCorrectionDialog(
        recordId: record.date,
        initialCheckIn: record.firstCheckIn,
        initialCheckOut: record.lastCheckOut,
      ),
    );

    if (req != null && mounted) {
      final success = await ref
          .read(attendanceCorrectionControllerProvider.notifier)
          .submitCorrection(recordId: record.date, request: req);
      if (success && mounted) {
        ref
            .read(
              adminEmployeeMonthlyControllerProvider(
                widget.employeeId,
              ).notifier,
            )
            .loadReport(widget.employeeId);
      }
    }
  }
}
