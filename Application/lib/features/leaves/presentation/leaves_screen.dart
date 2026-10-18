import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/features/leaves/application/leave_controller.dart';
import 'package:right_ads/features/leaves/domain/leave_models.dart';
import 'package:right_ads/features/leaves/presentation/widgets/apply_leave_bottom_sheet.dart';
import 'package:right_ads/features/leaves/presentation/widgets/cancel_leave_dialog.dart';
import 'package:right_ads/features/leaves/presentation/widgets/holiday_list_tile.dart';
import 'package:right_ads/features/leaves/presentation/widgets/leave_balance_card.dart';
import 'package:right_ads/features/leaves/presentation/widgets/leave_request_card.dart';

enum LeavesInitialTab {
  myLeaves,
  holidays,
}

class LeavesScreen extends ConsumerStatefulWidget {
  const LeavesScreen({
    this.initialTab = LeavesInitialTab.myLeaves,
    super.key,
  });

  final LeavesInitialTab initialTab;

  @override
  ConsumerState<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends ConsumerState<LeavesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab == LeavesInitialTab.holidays ? 1 : 0,
    );

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      unawaited(ref.read(leaveRequestsControllerProvider.notifier).loadMore());
    }
  }

  Future<void> _handleCancel(LeaveRequestModel request) async {
    final result = await CancelLeaveDialog.show(context, request: request);
    if (result != null && result.confirmed) {
      final success = await ref
          .read(leaveRequestsControllerProvider.notifier)
          .cancelLeave(request, reason: result.reason);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.leaveCancelSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final selectedYear = ref.watch(selectedLeaveYearControllerProvider);
    final balancesAsync = ref.watch(leaveBalancesProvider());
    final requestsState = ref.watch(leaveRequestsControllerProvider);
    final holidaysAsync = ref.watch(holidaysProvider());

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.leavesTitle),
        actions: [
          // Year Selector
          PopupMenuButton<int>(
            tooltip: selectedYear.toString(),
            initialValue: selectedYear,
            onSelected: (year) {
              ref
                  .read(selectedLeaveYearControllerProvider.notifier)
                  .setYear(year);
              unawaited(
                ref.read(leaveRequestsControllerProvider.notifier).refresh(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                children: [
                  Text(
                    selectedYear.toString(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
            ),
            itemBuilder: (ctx) {
              final currentYear = DateTime.now().year;
              return [
                currentYear - 1,
                currentYear,
                currentYear + 1,
              ].map((y) {
                return PopupMenuItem<int>(
                  value: y,
                  child: Text(y.toString()),
                );
              }).toList();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l10n.leavesTabMyLeaves),
            Tab(text: l10n.leavesTabHolidays),
          ],
        ),
      ),
      floatingActionButton: ref.can(PermissionCodes.leaveApply)
          ? FloatingActionButton.extended(
              onPressed: () async {
                final applied = await ApplyLeaveBottomSheet.show(context);
                if (applied == true && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.leaveApplySuccess),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              icon: const Icon(Icons.add),
              label: Text(l10n.leavesApplyButton),
            )
          : null,
      body: TabBarView(
        controller: _tabController,
        children: [
          // -------------------------------------------------------------
          // Tab 1: My Leaves & Balances
          // -------------------------------------------------------------
          RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(leaveBalancesProvider);
              await ref
                  .read(leaveRequestsControllerProvider.notifier)
                  .refresh();
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // 1. Leave Balances Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: AppSpacing.md,
                      right: AppSpacing.md,
                      top: AppSpacing.md,
                      bottom: AppSpacing.xs,
                    ),
                    child: Text(
                      l10n.leavesBalancesHeader,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 200,
                    child: balancesAsync.when(
                      data: (balances) {
                        if (balances.isEmpty) {
                          return Center(
                            child: Text(
                              l10n.leavesEmptyBalances,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          itemCount: balances.length,
                          itemBuilder: (context, index) {
                            return LeaveBalanceCard(balance: balances[index]);
                          },
                        );
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (err, _) => Center(
                        child: Text(
                          err.toString(),
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ),
                    ),
                  ),
                ),

                // 2. Filter Tabs
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip(
                            context: context,
                            label: l10n.leavesFilterAll,
                            filterKey: 'all',
                            currentFilter:
                                requestsState.value?.statusFilter ?? 'all',
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          _buildFilterChip(
                            context: context,
                            label: l10n.leavesFilterPending,
                            filterKey: 'pending',
                            currentFilter:
                                requestsState.value?.statusFilter ?? 'all',
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          _buildFilterChip(
                            context: context,
                            label: l10n.leavesFilterApproved,
                            filterKey: 'approved',
                            currentFilter:
                                requestsState.value?.statusFilter ?? 'all',
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          _buildFilterChip(
                            context: context,
                            label: l10n.leavesFilterRejected,
                            filterKey: 'rejected',
                            currentFilter:
                                requestsState.value?.statusFilter ?? 'all',
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          _buildFilterChip(
                            context: context,
                            label: l10n.leavesFilterCancelled,
                            filterKey: 'cancelled',
                            currentFilter:
                                requestsState.value?.statusFilter ?? 'all',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // 3. Requests List Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    child: Text(
                      l10n.leavesRequestsHeader,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // 4. Requests List Items
                requestsState.when(
                  data: (state) {
                    if (state.items.isEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.event_busy_outlined,
                                size: 48,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                l10n.leavesEmptyRequests,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index == state.items.length) {
                              return const Padding(
                                padding: EdgeInsets.all(AppSpacing.md),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            final request = state.items[index];
                            return LeaveRequestCard(
                              request: request,
                              onTap: () {
                                unawaited(
                                  context.push(
                                    RoutePaths.leaveDetail.replaceFirst(
                                      ':id',
                                      request.id,
                                    ),
                                  ),
                                );
                              },
                              onCancel: () => unawaited(_handleCancel(request)),
                            );
                          },
                          childCount:
                              state.items.length +
                              (state.isLoadingMore ? 1 : 0),
                        ),
                      ),
                    );
                  },
                  loading: () => const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (err, _) => SliverFillRemaining(
                    child: Center(
                      child: Text(
                        err.toString(),
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -------------------------------------------------------------
          // Tab 2: Company Holidays
          // -------------------------------------------------------------
          RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(holidaysProvider);
            },
            child: holidaysAsync.when(
              data: (holidays) {
                if (holidays.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.celebration_outlined,
                          size: 48,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          l10n.leavesEmptyHolidays,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: holidays.length,
                  itemBuilder: (context, index) {
                    return HolidayListTile(holiday: holidays[index]);
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (err, _) => Center(
                child: Text(
                  err.toString(),
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required BuildContext context,
    required String label,
    required String filterKey,
    required String currentFilter,
  }) {
    final isSelected = currentFilter.toLowerCase() == filterKey.toLowerCase();
    return FilterChip(
      selected: isSelected,
      label: Text(label),
      onSelected: (_) {
        unawaited(
          ref
              .read(leaveRequestsControllerProvider.notifier)
              .setStatusFilter(filterKey),
        );
      },
    );
  }
}
