import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_colors.dart';
import '../application/admin_attendance_controllers.dart';
import '../domain/attendance_report_models.dart';

class AdminEmployeeYearlyScreen extends ConsumerWidget {
  const AdminEmployeeYearlyScreen({required this.employeeId, super.key});

  final String employeeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(adminEmployeeYearlyControllerProvider(employeeId));
    final controller = ref.read(
      adminEmployeeYearlyControllerProvider(employeeId).notifier,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          state.data?.employeeName ?? l10n.adminAttendanceYearlySummary,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.loadReport(employeeId),
          ),
        ],
      ),
      body: _buildBody(state, controller, l10n),
    );
  }

  Widget _buildBody(
    AdminEmployeeYearlyState state,
    AdminEmployeeYearlyController controller,
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
              onPressed: () => controller.loadReport(employeeId),
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
          _buildYearSelector(state, controller),
          const SizedBox(height: 16),
          _buildAnnualSummary(data, l10n),
          const SizedBox(height: 24),
          Text(
            l10n.adminAttendanceYearlyTrend,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildChart(data),
          const SizedBox(height: 24),
          _buildMonthTable(data, l10n),
        ],
      ),
    );
  }

  Widget _buildYearSelector(
    AdminEmployeeYearlyState state,
    AdminEmployeeYearlyController controller,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => controller.setYear(employeeId, state.year - 1),
        ),
        Text(
          '${state.year}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => controller.setYear(employeeId, state.year + 1),
        ),
      ],
    );
  }

  Widget _buildAnnualSummary(
    EmployeeYearlyReportResponse data,
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
                  '${data.annualAttendancePercentage.toStringAsFixed(1)}%',
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
                _buildMetric(
                  l10n.adminAttendanceWorkingDays,
                  data.annualWorkingDays.toString(),
                ),
                _buildMetric(
                  l10n.adminAttendancePresent,
                  data.annualPresentDays.toString(),
                ),
                _buildMetric(
                  l10n.adminAttendanceAbsent,
                  data.annualAbsentDays.toString(),
                ),
                _buildMetric(
                  l10n.adminAttendanceHoursWorked,
                  data.annualTotalHours.toStringAsFixed(0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String val) {
    return Column(
      children: [
        Text(
          val,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _buildChart(EmployeeYearlyReportResponse data) {
    if (data.months.isEmpty) return const SizedBox.shrink();

    final spots = data.months.map((m) {
      return FlSpot(m.month.toDouble(), m.attendancePercentage);
    }).toList();

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          minX: 1,
          maxX: 12,
          minY: 0,
          maxY: 100,
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 32),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (val, meta) {
                  return Text(
                    val.toInt().toString(),
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              dotData: const FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthTable(
    EmployeeYearlyReportResponse data,
    AppLocalizations l10n,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text(l10n.adminMonthHeader)),
          DataColumn(label: Text(l10n.adminAttendanceWorkingDays)),
          DataColumn(label: Text(l10n.adminAttendancePresent)),
          DataColumn(label: Text(l10n.adminAttendanceAbsent)),
          DataColumn(label: Text(l10n.adminAttendancePercentage)),
        ],
        rows: data.months.map((m) {
          return DataRow(
            cells: [
              DataCell(Text(m.monthName)),
              DataCell(Text(m.workingDays.toString())),
              DataCell(Text(m.presentDays.toString())),
              DataCell(Text(m.absentDays.toString())),
              DataCell(Text('${m.attendancePercentage.toStringAsFixed(1)}%')),
            ],
          );
        }).toList(),
      ),
    );
  }
}
