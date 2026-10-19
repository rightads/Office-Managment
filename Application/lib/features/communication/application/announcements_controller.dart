import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/features/communication/data/communication_repository.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'announcements_controller.freezed.dart';
part 'announcements_controller.g.dart';

/// State for the announcements list.
@freezed
abstract class AnnouncementsListState with _$AnnouncementsListState {
  const factory AnnouncementsListState({
    @Default(<AnnouncementModel>[]) List<AnnouncementModel> items,
    @Default(false) bool isLoading,
    AppFailure? error,
  }) = _AnnouncementsListState;
}

/// Controller managing company & department announcements.
///
/// Respects expiry: expired announcements are filtered out.
@Riverpod(keepAlive: true)
class AnnouncementsListController extends _$AnnouncementsListController {
  @override
  AnnouncementsListState build() {
    unawaited(Future<void>.microtask(loadAnnouncements));
    return const AnnouncementsListState(isLoading: true);
  }

  Future<void> loadAnnouncements() async {
    state = state.copyWith(isLoading: true, error: null);
    final repo = ref.read(communicationRepositoryProvider);
    final (items, failure) = await repo.getAnnouncements();

    if (failure != null) {
      state = state.copyWith(isLoading: false, error: failure);
      return;
    }

    // Client-side expiry safeguard: filter out any announcements that expired
    final active = (items ?? <AnnouncementModel>[])
        .where((a) => a.isActive && !a.isExpired)
        .toList();

    state = state.copyWith(
      items: active,
      isLoading: false,
    );
  }

  Future<void> refresh() async {
    await loadAnnouncements();
  }
}

/// Computes whether there are recent active announcements to show a "New" badge on Home.
@riverpod
bool hasNewAnnouncements(Ref ref) {
  final state = ref.watch(announcementsListControllerProvider);
  if (state.items.isEmpty) return false;

  final now = DateTime.now();
  // Any active announcement created in the last 7 days is considered "New"
  return state.items.any((a) => now.difference(a.createdAt).inDays <= 7);
}

/// Family provider to load details for a single announcement by ID.
@riverpod
Future<AnnouncementModel?> announcementDetail(
  Ref ref,
  String announcementId,
) async {
  final repo = ref.read(communicationRepositoryProvider);
  final (detail, failure) = await repo.getAnnouncementDetail(announcementId);
  if (failure != null) {
    throw Exception(failure.message ?? 'Failed to load announcement');
  }
  return detail;
}
