import 'dart:convert';
import 'package:right_ads/core/constants/storage_keys.dart';
import 'package:right_ads/core/storage/preferences_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'offline_draft_repository.g.dart';

/// Models an offline-persisted draft (work report, task comment, dynamic record).
class OfflineDraft {
  const OfflineDraft({
    required this.id,
    required this.draftType,
    required this.targetId,
    required this.data,
    required this.updatedAt,
  });

  factory OfflineDraft.fromJson(Map<String, dynamic> json) {
    return OfflineDraft(
      id: json['id'] as String,
      draftType: json['draft_type'] as String,
      targetId: json['target_id'] as String,
      data: json['data'] as Map<String, dynamic>,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  final String id;
  final String draftType;
  final String targetId;
  final Map<String, dynamic> data;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'draft_type': draftType,
    'target_id': targetId,
    'data': data,
    'updated_at': updatedAt.toIso8601String(),
  };
}

/// Repository responsible for persisting and retrieving user form drafts locally.
class OfflineDraftRepository {
  OfflineDraftRepository(this._prefs);

  final SharedPreferences _prefs;

  List<OfflineDraft> getAllDrafts() {
    final raw = _prefs.getString(StorageKeys.offlineDrafts);
    if (raw == null || raw.isEmpty) return <OfflineDraft>[];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => OfflineDraft.fromJson(e as Map<String, dynamic>))
          .toList();
    } on FormatException catch (_) {
      return <OfflineDraft>[];
    }
  }

  Future<void> saveDraft(OfflineDraft draft) async {
    final drafts = getAllDrafts().where((d) => d.id != draft.id).toList()
      ..add(draft);
    await _prefs.setString(
      StorageKeys.offlineDrafts,
      jsonEncode(drafts.map((d) => d.toJson()).toList()),
    );
  }

  OfflineDraft? getDraft(String draftType, String targetId) {
    final drafts = getAllDrafts();
    final idx = drafts.indexWhere(
      (d) => d.draftType == draftType && d.targetId == targetId,
    );
    if (idx != -1) return drafts[idx];
    return null;
  }

  Future<void> removeDraft(String id) async {
    final drafts = getAllDrafts().where((d) => d.id != id).toList();
    await _prefs.setString(
      StorageKeys.offlineDrafts,
      jsonEncode(drafts.map((d) => d.toJson()).toList()),
    );
  }

  Future<void> clearAll() async {
    await _prefs.remove(StorageKeys.offlineDrafts);
  }
}

@riverpod
OfflineDraftRepository offlineDraftRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return OfflineDraftRepository(prefs);
}
