import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/features/dynamic_modules/application/dynamic_module_controller.dart';
import 'package:right_ads/features/dynamic_modules/data/dynamic_module_repository.dart';
import 'package:right_ads/features/dynamic_modules/domain/dynamic_module_models.dart';

class _FakeDynamicModuleRepository implements DynamicModuleRepository {
  DynamicModuleDefinition? definitionToReturn;
  DynamicModuleSummary? summaryToReturn;
  DynamicRecordPageResponse? recordPageToReturn;
  DynamicRecordDetailModel? recordDetailToReturn;

  bool changeStatusCalled = false;
  bool addCommentCalled = false;
  bool addAttachmentCalled = false;

  @override
  Future<(DynamicModuleDefinition?, AppFailure?)> getDefinition(
    String code,
  ) async => (definitionToReturn, null);

  @override
  Future<(DynamicModuleSummary?, AppFailure?)> getSummary(String code) async =>
      (summaryToReturn, null);

  @override
  Future<(DynamicRecordPageResponse?, AppFailure?)> listRecords(
    String code, {
    int page = 1,
    int pageSize = 20,
    String? search,
    String? status,
    String? sortBy,
    bool sortDesc = true,
    Map<String, dynamic>? dynamicFilters,
  }) async => (recordPageToReturn, null);

  @override
  Future<(DynamicRecordDetailModel?, AppFailure?)> getRecord(
    String code,
    String id,
  ) async => (recordDetailToReturn, null);

  @override
  Future<(DynamicRecordModel?, AppFailure?)> changeStatus(
    String code,
    String id, {
    required String toStatusId,
    String? note,
  }) async {
    changeStatusCalled = true;
    final updated = recordDetailToReturn?.copyWith(statusId: toStatusId);
    recordDetailToReturn = updated;
    return (
      DynamicRecordModel(
        id: id,
        moduleId: code,
        statusId: toStatusId,
        createdBy: 'u-1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      null,
    );
  }

  @override
  Future<(DynamicRecordComment?, AppFailure?)> addComment(
    String code,
    String id,
    String comment,
  ) async {
    addCommentCalled = true;
    return (
      DynamicRecordComment(
        id: 'c-1',
        recordId: id,
        userId: 'u-1',
        userName: 'Admin',
        comment: comment,
        createdAt: DateTime.now(),
      ),
      null,
    );
  }

  @override
  Future<(DynamicRecordAttachment?, AppFailure?)> addAttachment(
    String code,
    String id, {
    required String fileUrl,
    required String fileName,
    int fileSize = 0,
    String? mimeType,
  }) async {
    addAttachmentCalled = true;
    return (
      DynamicRecordAttachment(
        id: 'a-1',
        recordId: id,
        userId: 'u-1',
        userName: 'Admin',
        fileUrl: fileUrl,
        fileName: fileName,
        fileSize: fileSize,
        mimeType: mimeType,
        createdAt: DateTime.now(),
      ),
      null,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const sampleDef = DynamicModuleDefinition(
    id: 'm-1',
    code: 'clients',
    label: 'Clients',
    recordLabelSingular: 'Client',
    recordLabelPlural: 'Clients',
  );

  const sampleSummary = DynamicModuleSummary(
    totalRecords: 100,
    countsByStatus: {'active': 80, 'archived': 20},
  );

  final sampleRecord = DynamicRecordModel(
    id: 'rec-1',
    moduleId: 'clients',
    data: {'client_name': 'Acme Corp'},
    statusId: 'active',
    createdBy: 'u-1',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  group('Dynamic Modules Controllers Suite', () {
    test(
      'ModuleDefinitionCache caches and invalidates schema definitions',
      () async {
        final fakeRepo = _FakeDynamicModuleRepository()
          ..definitionToReturn = sampleDef;

        final container = ProviderContainer(
          overrides: [
            dynamicModuleRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        addTearDown(container.dispose);

        final cache = container.read(moduleDefinitionCacheProvider.notifier);
        final fetched = await cache.getOrFetch('clients');
        expect(fetched?.code, 'clients');

        cache.invalidate('clients');
        expect(
          container.read(moduleDefinitionCacheProvider)['clients'],
          isNull,
        );
      },
    );

    test('moduleSummary provider retrieves aggregate data', () async {
      final fakeRepo = _FakeDynamicModuleRepository()
        ..summaryToReturn = sampleSummary;

      final container = ProviderContainer(
        overrides: [
          dynamicModuleRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);

      final summary = await container.read(
        moduleSummaryProvider('clients').future,
      );
      expect(summary?.totalRecords, 100);
      expect(summary?.countsByStatus['active'], 80);
    });

    test(
      'DynamicRecordListController manages search, pagination, and sorting',
      () async {
        final pageResponse = DynamicRecordPageResponse(
          items: [sampleRecord],
          total: 1,
        );

        final fakeRepo = _FakeDynamicModuleRepository()
          ..recordPageToReturn = pageResponse;

        final container = ProviderContainer(
          overrides: [
            dynamicModuleRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        addTearDown(container.dispose);

        final controller = container.read(
          dynamicRecordListControllerProvider('clients').notifier,
        );
        await controller.loadInitial();

        var state = container.read(
          dynamicRecordListControllerProvider('clients'),
        );
        expect(state.isLoading, isFalse);
        expect(state.records.length, 1);

        controller.setSearch('Acme');
        controller.setStatusFilter('active');
        controller.setSorting(sortBy: 'created_at', sortDesc: false);

        state = container.read(dynamicRecordListControllerProvider('clients'));
        expect(state.search, 'Acme');
        expect(state.statusFilter, 'active');
        expect(state.sortBy, 'created_at');
      },
    );

    test(
      'DynamicRecordDetailController changes status, adds comments and attachments',
      () async {
        final detail = DynamicRecordDetailModel(
          id: 'rec-1',
          moduleId: 'clients',
          data: {'client_name': 'Acme Corp'},
          statusId: 'active',
          createdBy: 'u-1',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final fakeRepo = _FakeDynamicModuleRepository()
          ..recordDetailToReturn = detail;

        final container = ProviderContainer(
          overrides: [
            dynamicModuleRepositoryProvider.overrideWithValue(fakeRepo),
          ],
        );
        addTearDown(container.dispose);

        final controller = container.read(
          dynamicRecordDetailControllerProvider('clients', 'rec-1').notifier,
        );
        await controller.load();

        final statusSuccess = await controller.changeStatus('archived');
        expect(statusSuccess, isTrue);
        expect(fakeRepo.changeStatusCalled, isTrue);

        final commentSuccess = await controller.addComment(
          'New engagement contract signed',
        );
        expect(commentSuccess, isTrue);
        expect(fakeRepo.addCommentCalled, isTrue);

        final attSuccess = await controller.addAttachment(
          fileUrl: 'https://cdn.example.com/contract.pdf',
          fileName: 'contract.pdf',
          fileSize: 1024,
        );
        expect(attSuccess, isTrue);
        expect(fakeRepo.addAttachmentCalled, isTrue);
      },
    );
  });
}
