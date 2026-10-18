import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/services/location_service.dart';
import 'package:right_ads/core/services/photo_picker_service.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/theme/dynamic_color_parser.dart';
import 'package:right_ads/core/utils/app_formatters.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/app_text_field.dart';
import 'package:right_ads/core/widgets/error_state.dart';
import 'package:right_ads/core/widgets/loading_skeleton.dart';
import 'package:right_ads/core/widgets/status_chip.dart';
import 'package:right_ads/features/attendance/application/attendance_controller.dart';
import 'package:right_ads/features/attendance/domain/attendance_models.dart';

enum AttendanceViewTab {
  today,
  monthly,
  yearly,
}

/// Employee Attendance screen (`route_key: 'attendance'`).
///
/// Renders:
/// 1. Today Card + Policy-driven Check-In / Check-Out flow
/// 2. Monthly Calendar view with server-driven `status_label` + `status_color`
/// 3. Yearly Summary view (month-wise breakdown)
class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({
    this.initialTab = AttendanceViewTab.today,
    this.enableLiveTimer = true,
    super.key,
  });

  final AttendanceViewTab initialTab;
  final bool enableLiveTimer;

  @override
  ConsumerState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen>
    with WidgetsBindingObserver {
  late AttendanceViewTab _selectedTab;
  late int _selectedMonth;
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _selectedTab = widget.initialTab;
    final now = DateTime.now();
    _selectedMonth = now.month;
    _selectedYear = now.year;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Restore server truth when returning from background or lock screen.
      unawaited(
        ref
            .read(todayAttendanceControllerProvider.notifier)
            .loadTodayAndPolicy(silent: true),
      );
    }
  }

  void _jumpToMonth(int month, int year) {
    setState(() {
      _selectedMonth = month;
      _selectedYear = year;
      _selectedTab = AttendanceViewTab.monthly;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSpacing.maxWideContentWidth,
              ),
              child: SegmentedButton<AttendanceViewTab>(
                segments: <ButtonSegment<AttendanceViewTab>>[
                  ButtonSegment<AttendanceViewTab>(
                    value: AttendanceViewTab.today,
                    icon: const Icon(Icons.today_outlined),
                    label: Text(l10n.attendanceTabToday),
                  ),
                  ButtonSegment<AttendanceViewTab>(
                    value: AttendanceViewTab.monthly,
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: Text(l10n.attendanceTabMonthly),
                  ),
                  ButtonSegment<AttendanceViewTab>(
                    value: AttendanceViewTab.yearly,
                    icon: const Icon(Icons.bar_chart_outlined),
                    label: Text(l10n.attendanceTabYearly),
                  ),
                ],
                selected: <AttendanceViewTab>{_selectedTab},
                onSelectionChanged: (selection) {
                  if (selection.isNotEmpty) {
                    setState(() {
                      _selectedTab = selection.first;
                    });
                  }
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: switch (_selectedTab) {
            AttendanceViewTab.today => TodayAttendanceView(
              enableLiveTimer: widget.enableLiveTimer,
            ),
            AttendanceViewTab.monthly => MonthlyAttendanceCalendarView(
              month: _selectedMonth,
              year: _selectedYear,
              onMonthChanged: (month, year) {
                setState(() {
                  _selectedMonth = month;
                  _selectedYear = year;
                });
              },
            ),
            AttendanceViewTab.yearly => YearlyAttendanceSummaryView(
              year: _selectedYear,
              onYearChanged: (year) {
                setState(() {
                  _selectedYear = year;
                });
              },
              onSelectMonth: _jumpToMonth,
            ),
          },
        ),
      ],
    );
  }
}

/// Today tab showing current attendance status, check-in/out times, live worked
/// duration from server `check_in_at`, shift policy card, and geofence status.
class TodayAttendanceView extends ConsumerStatefulWidget {
  const TodayAttendanceView({
    this.enableLiveTimer = true,
    super.key,
  });

  final bool enableLiveTimer;

  @override
  ConsumerState<TodayAttendanceView> createState() =>
      _TodayAttendanceViewState();
}

class _TodayAttendanceViewState extends ConsumerState<TodayAttendanceView> {
  Timer? _elapsedTimer;
  DateTime _nowUtc = DateTime.now().toUtc();

  @override
  void initState() {
    super.initState();
    if (widget.enableLiveTimer) {
      _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        final record = ref.read(todayAttendanceControllerProvider).todayRecord;
        if (record != null && record.isCurrentlyCheckedIn) {
          setState(() {
            _nowUtc = DateTime.now().toUtc();
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _elapsedTimer?.cancel();
    super.dispose();
  }

  String _formatWorkedDuration(
    BuildContext context,
    AttendanceRecordModel? record,
  ) {
    final l10n = context.l10n;
    if (record == null || record.checkInAt == null) {
      return '—';
    }
    if (record.workHours != null && record.checkOutAt != null) {
      return l10n.attendanceHoursValue(record.workHours!.toStringAsFixed(2));
    }
    final checkInUtc = record.checkInAt!.toUtc();
    final currentUtc = widget.enableLiveTimer
        ? _nowUtc
        : DateTime.now().toUtc();
    final diff = currentUtc.difference(checkInUtc);
    final safeDiff = diff.isNegative ? Duration.zero : diff;
    final hours = safeDiff.inHours.toString().padLeft(2, '0');
    final minutes = (safeDiff.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (safeDiff.inSeconds % 60).toString().padLeft(2, '0');
    return '${l10n.attendanceElapsedTimerPrefix}: $hours:$minutes:$seconds';
  }

  Future<void> _openCheckInOutSheet({required bool isCheckIn}) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) => CheckInOutBottomSheet(isCheckIn: isCheckIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final state = ref.watch(todayAttendanceControllerProvider);
    final formatters = ref.watch(appFormattersProvider);

    if (state.isLoading && state.policy == null && state.todayRecord == null) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: LoadingSkeletonList(itemCount: 3),
      );
    }

    if (state.error != null && state.policy == null) {
      return ErrorState(
        message: state.error!.message,
        onRetry: () => ref
            .read(todayAttendanceControllerProvider.notifier)
            .loadTodayAndPolicy(),
      );
    }

    final record = state.todayRecord;
    final policy = state.policy;

    return RefreshIndicator(
      onRefresh: () => ref
          .read(todayAttendanceControllerProvider.notifier)
          .loadTodayAndPolicy(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.maxWideContentWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Today Status Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                l10n.attendanceTodayCardTitle,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (record != null)
                              StatusChip(
                                label: record.statusLabel,
                                hexColor: record.statusColor,
                              )
                            else
                              StatusChip(
                                label: l10n.attendanceNotCheckedInStatus,
                                hexColor: '#64748B',
                              ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Wrap(
                          spacing: AppSpacing.md,
                          runSpacing: AppSpacing.md,
                          children: <Widget>[
                            _TimeMetricTile(
                              icon: Icons.login_outlined,
                              label: l10n.attendanceCheckInTimeLabel,
                              value: record?.checkInAt != null
                                  ? formatters.formatTime(record!.checkInAt!)
                                  : '—',
                            ),
                            _TimeMetricTile(
                              icon: Icons.logout_outlined,
                              label: l10n.attendanceCheckOutTimeLabel,
                              value: record?.checkOutAt != null
                                  ? formatters.formatTime(record!.checkOutAt!)
                                  : '—',
                            ),
                            _TimeMetricTile(
                              icon: Icons.timer_outlined,
                              label: l10n.attendanceWorkedDurationLabel,
                              value: _formatWorkedDuration(context, record),
                              highlight: record?.isCurrentlyCheckedIn ?? false,
                            ),
                          ],
                        ),
                        if (record?.remarks != null &&
                            record!.remarks!.trim().isNotEmpty) ...<Widget>[
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            '${l10n.attendanceDayRemarksLabel}: ${record.remarks}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                        const SizedBox(height: AppSpacing.lg),
                        if (state.canCheckIn)
                          AppButton(
                            key: const Key('attendance_check_in_cta'),
                            label: l10n.attendanceCheckInButton,
                            icon: Icons.fingerprint_outlined,
                            expanded: true,
                            onPressed: () =>
                                _openCheckInOutSheet(isCheckIn: true),
                          )
                        else if (state.canCheckOut)
                          AppButton(
                            key: const Key('attendance_check_out_cta'),
                            label: l10n.attendanceCheckOutButton,
                            icon: Icons.exit_to_app_outlined,
                            variant: AppButtonVariant.secondary,
                            expanded: true,
                            onPressed: () =>
                                _openCheckInOutSheet(isCheckIn: false),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(AppRadius.md),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.check_circle_outline,
                                  color: colorScheme.onSecondaryContainer,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Flexible(
                                  child: Text(
                                    l10n.attendanceCompletedForTodayBadge,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      color: colorScheme.onSecondaryContainer,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Effective Shift & Policy Card
                if (policy != null) ...<Widget>[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            l10n.attendancePolicyCardTitle,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _PolicyInfoRow(
                            label: l10n.attendancePolicyNameLabel,
                            value: policy.name,
                          ),
                          _PolicyInfoRow(
                            label: l10n.attendancePolicyShiftLabel,
                            value: '${policy.shiftStart} – ${policy.shiftEnd}',
                          ),
                          _PolicyInfoRow(
                            label: l10n.attendancePolicyGraceLabel,
                            value: l10n.attendancePolicyGraceMinutesValue(
                              policy.graceMinutes,
                            ),
                          ),
                          _PolicyInfoRow(
                            label: l10n.attendancePolicyMinHoursLabel,
                            value: l10n.attendancePolicyMinHoursValue(
                              policy.fullDayMinHours.toStringAsFixed(1),
                              policy.halfDayMinHours.toStringAsFixed(1),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Wrap(
                            spacing: AppSpacing.xs,
                            runSpacing: AppSpacing.xs,
                            children: <Widget>[
                              Chip(
                                avatar: Icon(
                                  policy.requireGeofence
                                      ? Icons.location_on_outlined
                                      : Icons.public_outlined,
                                  size: 18,
                                ),
                                visualDensity: VisualDensity.compact,
                                label: Text(
                                  policy.requireGeofence
                                      ? l10n.attendancePolicyGeofenceRequired
                                      : l10n.attendancePolicyGeofenceOptional,
                                ),
                              ),
                              Chip(
                                avatar: Icon(
                                  policy.requireSelfie
                                      ? Icons.camera_front_outlined
                                      : Icons.no_photography_outlined,
                                  size: 18,
                                ),
                                visualDensity: VisualDensity.compact,
                                label: Text(
                                  policy.requireSelfie
                                      ? l10n.attendancePolicySelfieRequired
                                      : l10n.attendancePolicySelfieOptional,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Office Geofence & GPS Verification Card
                  _GeofenceStatusCard(
                    policy: policy,
                    locationResult: state.locationResult,
                    geofenceEvaluation: state.geofenceEvaluation,
                    isLocating: state.isLocating,
                    onRefreshLocation: () => ref
                        .read(todayAttendanceControllerProvider.notifier)
                        .refreshLocation(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimeMetricTile extends StatelessWidget {
  const _TimeMetricTile({
    required this.icon,
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      constraints: const BoxConstraints(minWidth: 150),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: highlight
            ? colorScheme.primaryContainer.withValues(alpha: 0.45)
            : colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 16,
                color: highlight
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.xxs),
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: highlight ? colorScheme.primary : colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _PolicyInfoRow extends StatelessWidget {
  const _PolicyInfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GeofenceStatusCard extends ConsumerWidget {
  const _GeofenceStatusCard({
    required this.policy,
    required this.locationResult,
    required this.geofenceEvaluation,
    required this.isLocating,
    required this.onRefreshLocation,
  });

  final EffectiveAttendancePolicyModel policy;
  final LocationAcquisitionResult? locationResult;
  final GeofenceEvaluation? geofenceEvaluation;
  final bool isLocating;
  final VoidCallback onRefreshLocation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final locationService = ref.read(locationServiceProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    l10n.attendanceNearestOfficeTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AppButton(
                  label: l10n.attendanceRefreshLocationButton,
                  icon: Icons.my_location_outlined,
                  variant: AppButtonVariant.tonal,
                  isLoading: isLocating,
                  onPressed: onRefreshLocation,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (isLocating)
              Text(
                l10n.attendanceLocatingLabel,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              )
            else if (locationResult != null)
              _LocationResultBanner(
                locationResult: locationResult!,
                geofenceEvaluation: geofenceEvaluation,
                policy: policy,
                onOpenAppSettings: locationService.openAppSettings,
                onOpenLocationSettings: locationService.openLocationSettings,
              )
            else if (policy.allowedLocations.isEmpty)
              Text(
                l10n.attendanceNoAllowedLocationsConfigured,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: policy.allowedLocations
                    .where((loc) => loc.isActive)
                    .map(
                      (office) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.xxs,
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.business_outlined,
                              size: 18,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(
                                '${office.name} (${office.radiusMeters} m)',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _LocationResultBanner extends StatelessWidget {
  const _LocationResultBanner({
    required this.locationResult,
    required this.geofenceEvaluation,
    required this.policy,
    required this.onOpenAppSettings,
    required this.onOpenLocationSettings,
  });

  final LocationAcquisitionResult locationResult;
  final GeofenceEvaluation? geofenceEvaluation;
  final EffectiveAttendancePolicyModel? policy;
  final Future<bool> Function() onOpenAppSettings;
  final Future<bool> Function() onOpenLocationSettings;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (locationResult) {
      case LocationServiceDisabled():
        return _WarningBox(
          icon: Icons.location_disabled_outlined,
          message: l10n.attendanceErrorGpsDisabled,
          actionLabel: l10n.attendanceOpenLocationSettingsButton,
          onAction: onOpenLocationSettings,
        );
      case LocationPermissionDenied():
        return _WarningBox(
          icon: Icons.gps_off_outlined,
          message: l10n.attendanceErrorPermissionDenied,
        );
      case LocationPermissionDeniedForever():
        return _WarningBox(
          icon: Icons.settings_remote_outlined,
          message: l10n.attendanceErrorPermissionDeniedForever,
          actionLabel: l10n.attendanceOpenAppSettingsButton,
          onAction: onOpenAppSettings,
        );
      case LocationMockDetected():
        return _WarningBox(
          icon: Icons.gpp_bad_outlined,
          message: l10n.attendanceErrorMockLocation,
        );
      case final LocationPoorAccuracy poor:
        return _WarningBox(
          icon: Icons.signal_cellular_alt_1_bar_outlined,
          message: l10n.attendanceErrorPoorAccuracy(
            poor.accuracyMeters.round(),
            poor.maxAllowedMeters.round(),
          ),
        );
      case final LocationError err:
        return _WarningBox(
          icon: Icons.error_outline,
          message: err.message,
        );
      case LocationSuccess():
        final eval = geofenceEvaluation;
        if (eval == null || eval.nearestOffice == null) {
          return Text(
            l10n.attendanceNoAllowedLocationsConfigured,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          );
        }
        final office = eval.nearestOffice!;
        final dist = (eval.distanceMeters ?? 0).round();
        final isWithin = eval.isWithinGeofence;
        final text = isWithin
            ? l10n.attendanceDistanceWithinRadius(
                dist,
                office.name,
                office.radiusMeters,
              )
            : l10n.attendanceDistanceOutsideRadius(
                dist,
                office.name,
                office.radiusMeters,
              );

        return Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: isWithin
                ? colorScheme.primaryContainer.withValues(alpha: 0.5)
                : colorScheme.errorContainer.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                isWithin
                    ? Icons.check_circle_outline
                    : Icons.warning_amber_rounded,
                color: isWithin
                    ? colorScheme.primary
                    : colorScheme.onErrorContainer,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  text,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isWithin
                        ? colorScheme.onSurface
                        : colorScheme.onErrorContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
}

class _WarningBox extends StatelessWidget {
  const _WarningBox({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: colorScheme.onErrorContainer),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ],
          ),
          if (actionLabel != null && onAction != null) ...<Widget>[
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: actionLabel!,
              variant: AppButtonVariant.secondary,
              onPressed: onAction,
            ),
          ],
        ],
      ),
    );
  }
}

/// Modal bottom sheet for confirming Check-In or Check-Out, driven by
/// `/me/attendance-policy`.
class CheckInOutBottomSheet extends ConsumerStatefulWidget {
  const CheckInOutBottomSheet({
    required this.isCheckIn,
    super.key,
  });

  final bool isCheckIn;

  @override
  ConsumerState<CheckInOutBottomSheet> createState() =>
      _CheckInOutBottomSheetState();
}

class _CheckInOutBottomSheetState extends ConsumerState<CheckInOutBottomSheet> {
  final TextEditingController _remarksController = TextEditingController();
  PickedPhotoFile? _capturedSelfie;
  String? _inlineError;

  @override
  void initState() {
    super.initState();
    unawaited(
      Future<void>.microtask(() {
        if (mounted) {
          unawaited(
            ref
                .read(todayAttendanceControllerProvider.notifier)
                .refreshLocation(),
          );
        }
      }),
    );
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _captureSelfie() async {
    final picker = ref.read(photoPickerServiceProvider);
    final picked = await picker.pickCompressedPhoto(ImageSource.camera);
    if (!mounted || picked == null) return;

    final runtimeConfig = ref.read(runtimeAppConfigControllerProvider);
    final validationError = PhotoPickerService.validatePickedPhoto(
      picked,
      runtimeConfig,
    );
    if (validationError != null) {
      final l10n = context.l10n;
      setState(() {
        _inlineError = switch (validationError) {
          PhotoValidationError.exceedsMaxSize => l10n.profilePhotoErrorSize(
            runtimeConfig.maxUploadMb,
          ),
          PhotoValidationError.unsupportedMimeType =>
            l10n.profilePhotoErrorMime(
              runtimeConfig.allowedUploadMimeTypes.join(', '),
            ),
        };
      });
      return;
    }

    setState(() {
      _capturedSelfie = picked;
      _inlineError = null;
    });
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    setState(() {
      _inlineError = null;
    });

    final notifier = ref.read(todayAttendanceControllerProvider.notifier);
    final outcome = widget.isCheckIn
        ? await notifier.checkIn(selfieUrl: _capturedSelfie?.pathOrUri)
        : await notifier.checkOut(remarks: _remarksController.text);

    if (!mounted) return;

    switch (outcome) {
      case AttendanceActionSuccess():
        AppSnackbar.showSuccess(
          context,
          widget.isCheckIn
              ? l10n.attendanceCheckInSuccess
              : l10n.attendanceCheckOutSuccess,
        );
        Navigator.of(context).pop();
      case AttendanceActionSelfieRequired():
        setState(() {
          _inlineError = l10n.attendanceSelfieRequiredError;
        });
      case final AttendanceActionLocationProblem locProblem:
        setState(() {
          _inlineError = _describeLocationProblem(
            l10n,
            locProblem.locationResult,
          );
        });
      case final AttendanceActionOutsideGeofence outside:
        final office = outside.evaluation.nearestOffice;
        final dist = (outside.evaluation.distanceMeters ?? 0).round();
        setState(() {
          _inlineError = office != null
              ? l10n.attendanceErrorOutsideGeofence(
                  dist,
                  office.name,
                  office.radiusMeters,
                )
              : l10n.attendanceNoAllowedLocationsConfigured;
        });
      case final AttendanceActionDeviceMismatch mismatch:
        setState(() {
          _inlineError = mismatch.serverMessage.isNotEmpty
              ? mismatch.serverMessage
              : l10n.attendanceErrorDeviceMismatch;
        });
      case AttendanceActionAlreadyCheckedIn():
        AppSnackbar.showInfo(context, l10n.attendanceErrorAlreadyCheckedIn);
        Navigator.of(context).pop();
      case AttendanceActionAlreadyCheckedOut():
        AppSnackbar.showInfo(context, l10n.attendanceErrorAlreadyCheckedOut);
        Navigator.of(context).pop();
      case final AttendanceActionFailure fail:
        setState(() {
          _inlineError = fail.failure.message ?? l10n.errorStateDefaultMessage;
        });
    }
  }

  String _describeLocationProblem(
    AppLocalizations l10n,
    LocationAcquisitionResult result,
  ) {
    return switch (result) {
      LocationServiceDisabled() => l10n.attendanceErrorGpsDisabled,
      LocationPermissionDenied() => l10n.attendanceErrorPermissionDenied,
      LocationPermissionDeniedForever() =>
        l10n.attendanceErrorPermissionDeniedForever,
      LocationMockDetected() => l10n.attendanceErrorMockLocation,
      final LocationPoorAccuracy poor => l10n.attendanceErrorPoorAccuracy(
        poor.accuracyMeters.round(),
        poor.maxAllowedMeters.round(),
      ),
      final LocationError err => err.message,
      LocationSuccess() => '',
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final state = ref.watch(todayAttendanceControllerProvider);
    final policy = state.policy;
    final locationService = ref.read(locationServiceProvider);

    final requireSelfie = widget.isCheckIn && (policy?.requireSelfie ?? false);

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              widget.isCheckIn
                  ? l10n.attendanceCheckInSheetTitle
                  : l10n.attendanceCheckOutSheetTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            if (state.isLocating)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(child: Text(l10n.attendanceLocatingLabel)),
                  ],
                ),
              )
            else if (state.locationResult != null)
              _LocationResultBanner(
                locationResult: state.locationResult!,
                geofenceEvaluation: state.geofenceEvaluation,
                policy: policy,
                onOpenAppSettings: locationService.openAppSettings,
                onOpenLocationSettings: locationService.openLocationSettings,
              ),

            if (requireSelfie) ...<Widget>[
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.attendanceSelfieSectionTitle,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              if (_capturedSelfie != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Text(
                    l10n.attendanceSelfieCapturedLabel(
                      (_capturedSelfie!.sizeBytes / 1024).toStringAsFixed(1),
                    ),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              AppButton(
                key: const Key('attendance_capture_selfie_button'),
                label: _capturedSelfie == null
                    ? l10n.attendanceCaptureSelfieButton
                    : l10n.attendanceRetakeSelfieButton,
                icon: Icons.camera_alt_outlined,
                variant: AppButtonVariant.tonal,
                onPressed: _captureSelfie,
              ),
            ],

            if (!widget.isCheckIn) ...<Widget>[
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _remarksController,
                label: l10n.attendanceRemarksLabel,
                hint: l10n.attendanceRemarksHint,
                maxLines: 2,
              ),
            ],

            if (_inlineError != null && _inlineError!.isNotEmpty) ...<Widget>[
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  _inlineError!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ],

            const SizedBox(height: AppSpacing.lg),
            AppButton(
              key: const Key('attendance_submit_action_button'),
              label: widget.isCheckIn
                  ? l10n.attendanceSubmitCheckInButton
                  : l10n.attendanceSubmitCheckOutButton,
              icon: widget.isCheckIn
                  ? Icons.check_circle_outline
                  : Icons.logout_outlined,
              isLoading: state.isSubmitting,
              expanded: true,
              onPressed: state.isSubmitting ? null : _submit,
            ),
          ],
        ),
      ),
    );
  }
}

/// Monthly Calendar tab consuming `GET /api/v1/attendance/me` and
/// `GET /api/v1/reports/attendance/employee/{id}/monthly`.
class MonthlyAttendanceCalendarView extends ConsumerWidget {
  const MonthlyAttendanceCalendarView({
    required this.month,
    required this.year,
    required this.onMonthChanged,
    super.key,
  });

  final int month;
  final int year;
  final void Function(int month, int year) onMonthChanged;

  void _previousMonth() {
    if (month == 1) {
      onMonthChanged(12, year - 1);
    } else {
      onMonthChanged(month - 1, year);
    }
  }

  void _nextMonth() {
    if (month == 12) {
      onMonthChanged(1, year + 1);
    } else {
      onMonthChanged(month + 1, year);
    }
  }

  void _showDayDetails(BuildContext context, DailyAttendanceRecordModel day) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (sheetContext) => AttendanceDayDetailSheet(day: day),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final asyncMonthly = ref.watch(
      monthlyAttendanceProvider(month: month, year: year),
    );

    final monthHeaderLabel = DateFormat(
      'MMMM yyyy',
    ).format(DateTime(year, month));

    return RefreshIndicator(
      onRefresh: () => ref.refresh(
        monthlyAttendanceProvider(month: month, year: year).future,
      ),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.maxWideContentWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Month Switcher Bar
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          tooltip: l10n.attendanceCalendarPrevMonthTooltip,
                          icon: const Icon(Icons.chevron_left),
                          onPressed: _previousMonth,
                        ),
                        Text(
                          monthHeaderLabel,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          tooltip: l10n.attendanceCalendarNextMonthTooltip,
                          icon: const Icon(Icons.chevron_right),
                          onPressed: _nextMonth,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                asyncMonthly.when(
                  loading: () => const LoadingSkeletonList(itemCount: 4),
                  error: (err, _) => ErrorState(
                    message: err.toString(),
                    onRetry: () => ref.invalidate(
                      monthlyAttendanceProvider(month: month, year: year),
                    ),
                  ),
                  data: (monthlyData) {
                    final days = monthlyData.mergedDays;
                    final firstWeekday = DateTime(year, month).weekday;
                    final leadingBlankCount = firstWeekday - 1;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          l10n.attendanceMonthlySummaryTitle,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          children: <Widget>[
                            _SummaryMetricChip(
                              label: l10n.attendanceMetricWorkingDays,
                              value: '${monthlyData.workingDays}',
                            ),
                            _SummaryMetricChip(
                              label: l10n.attendanceMetricPresent,
                              value: '${monthlyData.presentDays}',
                            ),
                            _SummaryMetricChip(
                              label: l10n.attendanceMetricLate,
                              value: '${monthlyData.lateDays}',
                            ),
                            _SummaryMetricChip(
                              label: l10n.attendanceMetricHalfDay,
                              value: '${monthlyData.halfDays}',
                            ),
                            _SummaryMetricChip(
                              label: l10n.attendanceMetricLeave,
                              value: '${monthlyData.leaveDays}',
                            ),
                            _SummaryMetricChip(
                              label: l10n.attendanceMetricAbsent,
                              value: '${monthlyData.absentDays}',
                            ),
                            _SummaryMetricChip(
                              label: l10n.attendanceMetricHolidays,
                              value: '${monthlyData.holidayDays}',
                            ),
                            _SummaryMetricChip(
                              label: l10n.attendanceMetricTotalHours,
                              value: l10n.attendanceHoursValue(
                                monthlyData.totalHoursWorked.toStringAsFixed(1),
                              ),
                            ),
                            _SummaryMetricChip(
                              label: l10n.attendanceMetricAttendancePct,
                              value: l10n.attendancePercentageValue(
                                monthlyData.attendancePercentage
                                    .toStringAsFixed(1),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // 7-column Calendar Grid
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: List<Widget>.generate(7, (i) {
                                    // 2024-01-01 is a Monday; i = 0..6 -> Mon..Sun
                                    final weekdayLabel = DateFormat.E(
                                      Localizations.localeOf(
                                        context,
                                      ).toLanguageTag(),
                                    ).format(DateTime.utc(2024, 1, i + 1));
                                    return Expanded(
                                      child: Center(
                                        child: Text(
                                          weekdayLabel,
                                          style: theme.textTheme.labelMedium,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 7,
                                        mainAxisSpacing: AppSpacing.xs,
                                        crossAxisSpacing: AppSpacing.xs,
                                        childAspectRatio: 0.88,
                                      ),
                                  itemCount: leadingBlankCount + days.length,
                                  itemBuilder: (context, index) {
                                    if (index < leadingBlankCount) {
                                      return const SizedBox.shrink();
                                    }
                                    final dayRecord =
                                        days[index - leadingBlankCount];
                                    return _CalendarDayCell(
                                      day: dayRecord,
                                      onTap: () =>
                                          _showDayDetails(context, dayRecord),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryMetricChip extends StatelessWidget {
  const _SummaryMetricChip({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarDayCell extends StatelessWidget {
  const _CalendarDayCell({
    required this.day,
    required this.onTap,
  });

  final DailyAttendanceRecordModel day;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor =
        DynamicColorParser.tryParseHex(day.statusColor) ??
        theme.colorScheme.outline;
    final dayNumber = day.date.split('-').last;

    return InkWell(
      key: Key('calendar_day_${day.date}'),
      borderRadius: BorderRadius.circular(AppRadius.sm),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xxs),
        decoration: BoxDecoration(
          color: statusColor.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
            color: statusColor.withValues(alpha: 0.55),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  dayNumber,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (day.isManual || day.correctionApplied) ...<Widget>[
                  const SizedBox(width: 2),
                  Icon(
                    Icons.edit_note,
                    size: 12,
                    color: statusColor,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 2),
            Text(
              day.statusLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 9,
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom sheet displaying full details for a tapped calendar day.
class AttendanceDayDetailSheet extends ConsumerWidget {
  const AttendanceDayDetailSheet({
    required this.day,
    super.key,
  });

  final DailyAttendanceRecordModel day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final formatters = ref.watch(appFormattersProvider);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  l10n.attendanceDayDetailTitle(day.date),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              StatusChip(
                label: day.statusLabel,
                hexColor: day.statusColor,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (day.isManual || day.correctionApplied)
            Wrap(
              spacing: AppSpacing.xs,
              children: <Widget>[
                if (day.isManual)
                  Chip(
                    visualDensity: VisualDensity.compact,
                    avatar: const Icon(Icons.edit_outlined, size: 16),
                    label: Text(l10n.attendanceDayManualBadge),
                  ),
                if (day.correctionApplied)
                  Chip(
                    visualDensity: VisualDensity.compact,
                    avatar: const Icon(Icons.build_circle_outlined, size: 16),
                    label: Text(l10n.attendanceDayCorrectionBadge),
                  ),
              ],
            ),
          const SizedBox(height: AppSpacing.md),
          if (day.checkInAt == null && day.checkOutAt == null)
            Text(
              l10n.attendanceDayNoRecordLabel,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            )
          else ...<Widget>[
            _PolicyInfoRow(
              label: l10n.attendanceCheckInTimeLabel,
              value: day.checkInAt != null
                  ? formatters.formatTime(day.checkInAt!)
                  : '—',
            ),
            _PolicyInfoRow(
              label: l10n.attendanceCheckOutTimeLabel,
              value: day.checkOutAt != null
                  ? formatters.formatTime(day.checkOutAt!)
                  : '—',
            ),
            _PolicyInfoRow(
              label: l10n.attendanceWorkedDurationLabel,
              value: day.workHours != null
                  ? l10n.attendanceHoursValue(day.workHours!.toStringAsFixed(2))
                  : '—',
            ),
          ],
          if (day.holidayName != null && day.holidayName!.isNotEmpty)
            _PolicyInfoRow(
              label: l10n.attendanceDayHolidayLabel,
              value: day.holidayName!,
            ),
          if (day.leaveTypeName != null && day.leaveTypeName!.isNotEmpty)
            _PolicyInfoRow(
              label: l10n.attendanceDayLeaveLabel,
              value: day.leaveTypeName!,
            ),
          if (day.remarks != null && day.remarks!.isNotEmpty)
            _PolicyInfoRow(
              label: l10n.attendanceDayRemarksLabel,
              value: day.remarks!,
            ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

/// Yearly Summary tab consuming
/// `GET /api/v1/reports/attendance/employee/{id}/yearly?year=`.
class YearlyAttendanceSummaryView extends ConsumerWidget {
  const YearlyAttendanceSummaryView({
    required this.year,
    required this.onYearChanged,
    required this.onSelectMonth,
    super.key,
  });

  final int year;
  final ValueChanged<int> onYearChanged;
  final void Function(int month, int year) onSelectMonth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final asyncYearly = ref.watch(yearlyAttendanceProvider(year: year));

    return RefreshIndicator(
      onRefresh: () => ref.refresh(yearlyAttendanceProvider(year: year).future),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.maxWideContentWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Year Switcher Bar
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          tooltip: l10n.attendanceYearlyPrevYearTooltip,
                          icon: const Icon(Icons.chevron_left),
                          onPressed: () => onYearChanged(year - 1),
                        ),
                        Text(
                          '$year',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          tooltip: l10n.attendanceYearlyNextYearTooltip,
                          icon: const Icon(Icons.chevron_right),
                          onPressed: () => onYearChanged(year + 1),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                asyncYearly.when(
                  loading: () => const LoadingSkeletonList(),
                  error: (err, _) => ErrorState(
                    message: err.toString(),
                    onRetry: () =>
                        ref.invalidate(yearlyAttendanceProvider(year: year)),
                  ),
                  data: (report) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        l10n.attendanceYearlySummaryTitle(report.year),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: <Widget>[
                          _SummaryMetricChip(
                            label: l10n.attendanceMetricWorkingDays,
                            value: '${report.annualWorkingDays}',
                          ),
                          _SummaryMetricChip(
                            label: l10n.attendanceMetricPresent,
                            value: '${report.annualPresentDays}',
                          ),
                          _SummaryMetricChip(
                            label: l10n.attendanceMetricLeave,
                            value: '${report.annualLeaveDays}',
                          ),
                          _SummaryMetricChip(
                            label: l10n.attendanceMetricAbsent,
                            value: '${report.annualAbsentDays}',
                          ),
                          _SummaryMetricChip(
                            label: l10n.attendanceMetricTotalHours,
                            value: l10n.attendanceHoursValue(
                              report.annualTotalHours.toStringAsFixed(1),
                            ),
                          ),
                          _SummaryMetricChip(
                            label: l10n.attendanceMetricAttendancePct,
                            value: l10n.attendancePercentageValue(
                              report.annualAttendancePercentage.toStringAsFixed(
                                1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        l10n.attendanceYearlyMonthBreakdownTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        l10n.attendanceYearlyTapMonthHint,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ...report.months.map(
                        (m) => Card(
                          key: Key('yearly_month_row_${m.month}'),
                          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () => onSelectMonth(m.month, report.year),
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          m.monthName,
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        const SizedBox(height: AppSpacing.xxs),
                                        Text(
                                          '${l10n.attendanceMetricPresent}: ${m.presentDays}/${m.workingDays} • '
                                          '${l10n.attendanceMetricLate}: ${m.lateDays} • '
                                          '${l10n.attendanceMetricLeave}: ${m.leaveDays} • '
                                          '${l10n.attendanceMetricAbsent}: ${m.absentDays}',
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        l10n.attendancePercentageValue(
                                          m.attendancePercentage
                                              .toStringAsFixed(1),
                                        ),
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: colorScheme.primary,
                                            ),
                                      ),
                                      Text(
                                        l10n.attendanceHoursValue(
                                          m.totalHoursWorked.toStringAsFixed(1),
                                        ),
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(
                                              color:
                                                  colorScheme.onSurfaceVariant,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: AppSpacing.xs),
                                  Icon(
                                    Icons.chevron_right,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
