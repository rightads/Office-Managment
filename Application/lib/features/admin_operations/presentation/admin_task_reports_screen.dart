import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_colors.dart';
import '../application/admin_operations_controllers.dart';
import '../domain/admin_operations_models.dart';

class AdminTaskReportsScreen extends ConsumerWidget {
  const AdminTaskReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(adminTaskReportsControllerProvider);
    final controller = ref.read(adminTaskReportsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminTaskReportsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.loadReports,
          ),
        ],
      ),
      body: _buildBody(state, controller, l10n),
    );
  }

  Widget _buildBody(
    AdminTaskReportsState state,
    AdminTaskReportsController controller,
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
              onPressed: controller.loadReports,
              child: Text(l10n.adminClose),
            ),
          ],
        ),
      );
    }

    final summary = state.summary;
    if (summary == null) {
      return Center(child: Text(l10n.adminNoItemsFound));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildKpis(summary, l10n),
          const SizedBox(height: 24),
          _buildCompletionPieChart(summary, l10n),
          const SizedBox(height: 24),
          _buildBreakdownSection(
            l10n.adminByEmployee,
            summary.byEmployee,
            l10n,
          ),
          const SizedBox(height: 16),
          _buildBreakdownSection(
            l10n.adminByDepartment,
            summary.byDepartment,
            l10n,
          ),
          const SizedBox(height: 16),
          _buildBreakdownSection(
            l10n.adminByClient,
            summary.byClient,
            l10n,
          ),
        ],
      ),
    );
  }

  Widget _buildKpis(
    TaskSummaryReportsResponse summary,
    AppLocalizations l10n,
  ) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _buildKpiCard(
          l10n.adminTotalTasks,
          summary.totalTasks.toString(),
          Colors.blueGrey,
        ),
        _buildKpiCard(
          l10n.adminCompletedTasks,
          summary.completedTasks.toString(),
          AppColors.success,
        ),
        _buildKpiCard(
          l10n.adminPendingTasks,
          summary.pendingTasks.toString(),
          Colors.blue,
        ),
        _buildKpiCard(
          l10n.adminOverdueTasks,
          summary.overdueTasks.toString(),
          AppColors.error,
        ),
        _buildKpiCard(
          l10n.adminOnTimeRate,
          '${summary.onTimeCompletionRate.toStringAsFixed(1)}%',
          AppColors.warning,
        ),
      ],
    );
  }

  Widget _buildKpiCard(String label, String value, Color color) {
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
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionPieChart(
    TaskSummaryReportsResponse summary,
    AppLocalizations l10n,
  ) {
    if (summary.totalTasks == 0) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 160,
          child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 36,
              sections: [
                PieChartSectionData(
                  value: summary.completedTasks.toDouble(),
                  title: '${summary.completedTasks}',
                  color: AppColors.success,
                  radius: 36,
                ),
                PieChartSectionData(
                  value: summary.pendingTasks.toDouble(),
                  title: '${summary.pendingTasks}',
                  color: Colors.blue,
                  radius: 36,
                ),
                PieChartSectionData(
                  value: summary.overdueTasks.toDouble(),
                  title: '${summary.overdueTasks}',
                  color: AppColors.error,
                  radius: 36,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBreakdownSection(
    String title,
    List<TaskReportItem> items,
    AppLocalizations l10n,
  ) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text(l10n.adminItemName)),
                DataColumn(label: Text(l10n.adminTotalTasks)),
                DataColumn(label: Text(l10n.adminCompletedTasks)),
                DataColumn(label: Text(l10n.adminOverdueTasks)),
              ],
              rows: items.map((i) {
                return DataRow(
                  cells: [
                    DataCell(Text(i.name)),
                    DataCell(Text(i.totalTasks.toString())),
                    DataCell(Text(i.completedTasks.toString())),
                    DataCell(
                      Text(
                        i.overdueTasks.toString(),
                        style: TextStyle(
                          color: i.overdueTasks > 0 ? AppColors.error : null,
                          fontWeight: i.overdueTasks > 0
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
