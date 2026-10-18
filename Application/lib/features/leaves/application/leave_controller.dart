import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/features/leaves/data/leave_repository.dart';
import 'package:right_ads/features/leaves/domain/leave_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'leave_controller.freezed.dart';
part 'leave_controller.g.dart';

/// Currently selected calendar year for leave queries.
@Riverpod(keepAlive: true)
class SelectedLeaveYearController extends _$SelectedLeaveYearController {
  @override
  int build() => DateTime.now().year;

  void setYear(int year) {
    if (state != year) {
      state = year;
    }
  }
}

/// Provider for active leave categories.
@riverpod
Future<List<LeaveTypeModel>> leaveTypes(Ref ref) async {
  final repo = ref.watch(leaveRepositoryProvider);
  final (types, failure) = await repo.getLeaveTypes();
  if (failure != null) {
    throw Exception(failure.message ?? failure.toString());
  }
  return types ?? const [];
}

/// Provider for employee leave balances for a specific or current year.
@riverpod
Future<List<LeaveBalanceModel>> leaveBalances(Ref ref, {int? year}) async {
  final selectedYear = year ?? ref.watch(selectedLeaveYearControllerProvider);
  final repo = ref.watch(leaveRepositoryProvider);
  final (balances, failure) = await repo.getMyBalances(year: selectedYear);
  if (failure != null) {
    throw Exception(failure.message ?? failure.toString());
  }
  return balances ?? const [];
}

/// Provider for calendar holidays for a specific or current year.
@riverpod
Future<List<HolidayModel>> holidays(Ref ref, {int? year}) async {
  final selectedYear = year ?? ref.watch(selectedLeaveYearControllerProvider);
  final repo = ref.watch(leaveRepositoryProvider);
  final (holidayPage, failure) = await repo.getHolidays(year: selectedYear);
  if (failure != null) {
    throw Exception(failure.message ?? failure.toString());
  }
  return holidayPage?.items ?? const [];
}

/// State for the employee leave request history list.
@freezed
abstract class LeaveRequestsState with _$LeaveRequestsState {
  const factory LeaveRequestsState({
    @Default([]) List<LeaveRequestModel> items,
    @Default(0) int total,
    @Default(1) int page,
    @Default(false) bool hasMore,
    @Default('all') String statusFilter,
    @Default(false) bool isLoadingMore,
    String? errorMessage,
  }) = _LeaveRequestsState;
}

@riverpod
class LeaveRequestsController extends _$LeaveRequestsController {
  static const int _pageSize = 20;

  @override
  FutureOr<LeaveRequestsState> build() async {
    return _fetchPage(
      page: 1,
      status: 'all',
      year: ref.watch(selectedLeaveYearControllerProvider),
    );
  }

  Future<LeaveRequestsState> _fetchPage({
    required int page,
    required String status,
    required int year,
  }) async {
    final repo = ref.read(leaveRepositoryProvider);
    final (result, failure) = await repo.getMyRequests(
      status: status == 'all' ? null : status,
      year: year,
      page: page,
    );

    if (failure != null) {
      throw Exception(failure.message ?? failure.toString());
    }

    final items = result?.items ?? const [];
    final total = result?.total ?? 0;
    final hasMore = items.length >= _pageSize && (page * _pageSize) < total;

    return LeaveRequestsState(
      items: items,
      total: total,
      page: page,
      hasMore: hasMore,
      statusFilter: status,
    );
  }

  Future<void> setStatusFilter(String status) async {
    final current = state.value;
    if (current != null && current.statusFilter == status) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return _fetchPage(
        page: 1,
        status: status,
        year: ref.read(selectedLeaveYearControllerProvider),
      );
    });
  }

  Future<void> refresh() async {
    final current = state.value;
    final status = current?.statusFilter ?? 'all';
    final year = ref.read(selectedLeaveYearControllerProvider);

    state = await AsyncValue.guard(() async {
      return _fetchPage(page: 1, status: status, year: year);
    });
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    final nextPage = current.page + 1;
    final repo = ref.read(leaveRepositoryProvider);
    final year = ref.read(selectedLeaveYearControllerProvider);

    final (result, failure) = await repo.getMyRequests(
      status: current.statusFilter == 'all' ? null : current.statusFilter,
      year: year,
      page: nextPage,
    );

    if (failure != null) {
      state = AsyncData(
        current.copyWith(
          isLoadingMore: false,
          errorMessage: failure.message,
        ),
      );
      return;
    }

    final newItems = result?.items ?? const [];
    final updatedList = [...current.items, ...newItems];
    final total = result?.total ?? current.total;
    final hasMore =
        newItems.length >= _pageSize && (nextPage * _pageSize) < total;

    state = AsyncData(
      current.copyWith(
        items: updatedList,
        total: total,
        page: nextPage,
        hasMore: hasMore,
        isLoadingMore: false,
      ),
    );
  }

  /// Cancels a leave request (pending or approved) with optimistic rollback on failure.
  Future<bool> cancelLeave(LeaveRequestModel request, {String? reason}) async {
    final current = state.value;
    if (current == null) return false;

    // Snapshot for rollback
    final previousItems = List<LeaveRequestModel>.from(current.items);

    // Apply optimistic cancellation
    final optimisticItems = current.items.map((item) {
      if (item.id == request.id) {
        return item.copyWith(status: 'cancelled');
      }
      return item;
    }).toList();

    state = AsyncData(current.copyWith(items: optimisticItems));

    final repo = ref.read(leaveRepositoryProvider);
    final (updated, failure) = request.status.toLowerCase() == 'approved'
        ? await repo.cancelApprovedLeave(request.id, reason: reason)
        : await repo.cancelPendingLeave(request.id);

    if (failure != null) {
      // Rollback on failure
      state = AsyncData(
        current.copyWith(
          items: previousItems,
          errorMessage: failure.message,
        ),
      );
      return false;
    }

    if (updated != null) {
      final finalizedItems = current.items.map((item) {
        return item.id == request.id ? updated : item;
      }).toList();
      state = AsyncData(current.copyWith(items: finalizedItems));
    }

    // Invalidate leave balances to refresh available days
    ref.invalidate(leaveBalancesProvider);
    return true;
  }
}

/// State for the Apply Leave form.
@freezed
abstract class LeaveApplyState with _$LeaveApplyState {
  const factory LeaveApplyState({
    String? leaveTypeId,
    DateTime? fromDate,
    DateTime? toDate,
    @Default(false) bool isHalfDay,
    @Default('first_half') String halfDaySession,
    @Default('') String reason,
    LeavePreviewResponse? preview,
    @Default(false) bool isPreviewLoading,
    @Default(false) bool isSubmitting,
    String? submissionError,
    @Default({}) Map<String, String> fieldErrors,
  }) = _LeaveApplyState;
}

@riverpod
class LeaveApplyController extends _$LeaveApplyController {
  Timer? _debounceTimer;
  final DateFormat _apiDateFormat = DateFormat('yyyy-MM-dd');

  @override
  LeaveApplyState build() {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });

    final now = DateTime.now();
    return LeaveApplyState(
      fromDate: now,
      toDate: now,
    );
  }

  void setLeaveType(String leaveTypeId) {
    state = state.copyWith(
      leaveTypeId: leaveTypeId,
      fieldErrors: Map.from(state.fieldErrors)..remove('leave_type_id'),
    );
    _triggerPreview();
  }

  void setDateRange(DateTime from, DateTime to) {
    state = state.copyWith(
      fromDate: from,
      toDate: state.isHalfDay ? from : to,
      fieldErrors: Map.from(state.fieldErrors)
        ..remove('from_date')
        ..remove('to_date'),
    );
    _triggerPreview();
  }

  void toggleHalfDay({required bool isHalfDay}) {
    state = state.copyWith(
      isHalfDay: isHalfDay,
      toDate: isHalfDay ? state.fromDate : state.toDate,
    );
    _triggerPreview();
  }

  void setHalfDaySession(String session) {
    state = state.copyWith(halfDaySession: session);
    _triggerPreview();
  }

  void setReason(String reason) {
    state = state.copyWith(
      reason: reason,
      fieldErrors: Map.from(state.fieldErrors)..remove('reason'),
    );
  }

  void _triggerPreview() {
    final fromDate = state.fromDate;
    final toDate = state.toDate;
    if (fromDate == null || toDate == null) return;

    _debounceTimer?.cancel();
    state = state.copyWith(isPreviewLoading: true, submissionError: null);

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      final payload = LeavePreviewPayload(
        leaveTypeId: state.leaveTypeId,
        fromDate: _apiDateFormat.format(fromDate),
        toDate: _apiDateFormat.format(toDate),
        isHalfDay: state.isHalfDay,
        halfDaySession: state.isHalfDay ? state.halfDaySession : null,
      );

      final repo = ref.read(leaveRepositoryProvider);
      final (preview, _) = await repo.previewLeave(payload);

      state = state.copyWith(
        preview: preview,
        isPreviewLoading: false,
      );
    });
  }

  Future<bool> submit() async {
    final errors = <String, String>{};

    if (state.leaveTypeId == null || state.leaveTypeId!.isEmpty) {
      errors['leave_type_id'] = 'Please select a leave category';
    }
    if (state.fromDate == null) {
      errors['from_date'] = 'Start date is required';
    }
    if (state.toDate == null) {
      errors['to_date'] = 'End date is required';
    }
    if (state.reason.trim().length < 3) {
      errors['reason'] = 'Reason must be at least 3 characters';
    }

    if (state.preview != null && !state.preview!.isValid) {
      state = state.copyWith(
        submissionError:
            state.preview!.validationError ??
            'Cannot submit invalid leave request',
        fieldErrors: errors,
      );
      return false;
    }

    if (errors.isNotEmpty) {
      state = state.copyWith(fieldErrors: errors);
      return false;
    }

    state = state.copyWith(isSubmitting: true, submissionError: null);

    final payload = LeaveApplyPayload(
      leaveTypeId: state.leaveTypeId!,
      fromDate: _apiDateFormat.format(state.fromDate!),
      toDate: _apiDateFormat.format(state.toDate!),
      isHalfDay: state.isHalfDay,
      halfDaySession: state.isHalfDay ? state.halfDaySession : null,
      reason: state.reason.trim(),
    );

    final repo = ref.read(leaveRepositoryProvider);
    final (created, failure) = await repo.applyLeave(payload);

    if (failure != null) {
      final fieldErrors = <String, String>{};
      if (failure is ValidationFailure) {
        for (final entry in failure.fieldErrors.entries) {
          if (entry.value.isNotEmpty) {
            fieldErrors[entry.key] = entry.value.first;
          }
        }
      }
      state = state.copyWith(
        isSubmitting: false,
        submissionError: failure.message,
        fieldErrors: fieldErrors,
      );
      return false;
    }

    state = state.copyWith(isSubmitting: false);

    // Refresh balances and requests list
    ref
      ..invalidate(leaveBalancesProvider)
      ..invalidate(leaveRequestsControllerProvider);
    return true;
  }
}

/// Controller for single leave request details (for deep link `/leaves/:id`).
@riverpod
class LeaveDetailController extends _$LeaveDetailController {
  @override
  FutureOr<LeaveRequestModel> build(String leaveId) async {
    final repo = ref.watch(leaveRepositoryProvider);
    final (leave, failure) = await repo.getLeaveById(leaveId);
    if (failure != null) {
      throw Exception(failure.message ?? failure.toString());
    }
    if (leave == null) {
      throw Exception('Leave request not found');
    }
    return leave;
  }

  Future<bool> cancel({String? reason}) async {
    final current = state.value;
    if (current == null) return false;

    state = const AsyncLoading();
    final repo = ref.read(leaveRepositoryProvider);

    final (updated, failure) = current.status.toLowerCase() == 'approved'
        ? await repo.cancelApprovedLeave(current.id, reason: reason)
        : await repo.cancelPendingLeave(current.id);

    if (failure != null) {
      state = AsyncError(
        Exception(failure.message ?? failure.toString()),
        StackTrace.current,
      );
      return false;
    }

    if (updated != null) {
      state = AsyncData(updated);
      ref
        ..invalidate(leaveBalancesProvider)
        ..invalidate(leaveRequestsControllerProvider);
      return true;
    }
    return false;
  }
}
