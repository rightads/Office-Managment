import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/offline/local_cache_service.dart';
import 'package:right_ads/core/offline/offline_draft_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Offline Storage & Cache Tests', () {
    late SharedPreferences prefs;
    late LocalCacheService cacheService;
    late OfflineDraftRepository draftRepository;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      cacheService = LocalCacheService(prefs);
      draftRepository = OfflineDraftRepository(prefs);
    });

    test('LocalCacheService saves, reads, and removes JSON', () async {
      const key = 'test.cache.key';
      final sampleData = {
        'id': 1,
        'name': 'Test Item',
        'tags': ['a', 'b'],
      };

      expect(cacheService.has(key), isFalse);
      expect(cacheService.readJson(key), isNull);

      await cacheService.saveJson(key, sampleData);
      expect(cacheService.has(key), isTrue);

      final retrieved = cacheService.readJson(key) as Map<String, dynamic>;
      expect(retrieved['id'], 1);
      expect(retrieved['name'], 'Test Item');
      expect(retrieved['tags'], ['a', 'b']);

      await cacheService.remove(key);
      expect(cacheService.has(key), isFalse);
    });

    test(
      'OfflineDraftRepository creates, retrieves, and deletes drafts',
      () async {
        final now = DateTime.utc(2026, 10, 22, 12);
        final draft = OfflineDraft(
          id: 'draft_1',
          draftType: 'work_report',
          targetId: '2026-10-22',
          data: {'summary': 'Completed prompt 17 implementation'},
          updatedAt: now,
        );

        await draftRepository.saveDraft(draft);

        final retrieved = draftRepository.getDraft('work_report', '2026-10-22');
        expect(retrieved, isNotNull);
        expect(retrieved!.id, 'draft_1');
        expect(retrieved.data['summary'], 'Completed prompt 17 implementation');

        expect(draftRepository.getAllDrafts().length, 1);

        await draftRepository.removeDraft('draft_1');
        expect(draftRepository.getAllDrafts(), isEmpty);
        expect(draftRepository.getDraft('work_report', '2026-10-22'), isNull);
      },
    );
  });
}
