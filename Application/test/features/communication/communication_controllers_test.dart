import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/features/communication/application/announcements_controller.dart';
import 'package:right_ads/features/communication/application/notifications_controller.dart';
import 'package:right_ads/features/communication/data/communication_repository.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';

class _FakeCommunicationRepository implements CommunicationRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<(int?, AppFailure?)> getUnreadNotificationCount() async {
    return (3, null);
  }

  @override
  Future<(NotificationPageResponse?, AppFailure?)> getNotifications({
    int page = 1,
    int pageSize = 20,
    bool unreadOnly = false,
  }) async {
    return (
      NotificationPageResponse(
        items: [
          NotificationItemModel(
            id: 'notif-1',
            title: 'Task Assigned',
            body: 'Task #101',
            type: 'task',
            isRead: false,
            createdAt: DateTime.now(),
          ),
          NotificationItemModel(
            id: 'notif-2',
            title: 'Leave Approved',
            body: 'Casual Leave Approved',
            type: 'leave',
            isRead: false,
            createdAt: DateTime.now(),
          ),
        ],
        total: 2,
        page: 1,
        pageSize: 20,
        totalPages: 1,
      ),
      null,
    );
  }

  @override
  Future<(NotificationItemModel?, AppFailure?)> markNotificationAsRead(
    String notificationId,
  ) async {
    return (
      NotificationItemModel(
        id: notificationId,
        title: 'Task Assigned',
        body: 'Task #101',
        type: 'task',
        isRead: true,
        createdAt: DateTime.now(),
      ),
      null,
    );
  }

  @override
  Future<(String?, AppFailure?)> markAllNotificationsAsRead() async {
    return ('All marked as read', null);
  }

  @override
  Future<(List<AnnouncementModel>?, AppFailure?)> getAnnouncements() async {
    return (
      [
        AnnouncementModel(
          id: 'ann-1',
          title: 'Annual Meet',
          body: 'Join in auditorium',
          creator: const UserBriefModel(
            id: 'u-1',
            employeeCode: 'EMP01',
            fullName: 'HR Manager',
            email: 'hr@example.com',
          ),
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        AnnouncementModel(
          id: 'ann-expired',
          title: 'Past Event',
          body: 'Already done',
          creator: const UserBriefModel(
            id: 'u-1',
            employeeCode: 'EMP01',
            fullName: 'HR Manager',
            email: 'hr@example.com',
          ),
          expiresAt: DateTime.now().subtract(const Duration(days: 1)),
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
      ],
      null,
    );
  }
}

void main() {
  group('Communication Controllers Tests', () {
    late _FakeCommunicationRepository fakeRepo;
    late ProviderContainer container;

    setUp(() {
      fakeRepo = _FakeCommunicationRepository();
      container = ProviderContainer(
        overrides: [
          communicationRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test(
      'UnreadNotificationCountController loads count and decrements',
      () async {
        final notifier = container.read(
          unreadNotificationCountControllerProvider.notifier,
        );
        await notifier.loadCount();

        expect(container.read(unreadNotificationCountControllerProvider), 3);

        notifier.decrement();
        expect(container.read(unreadNotificationCountControllerProvider), 2);

        notifier.reset();
        expect(container.read(unreadNotificationCountControllerProvider), 0);
      },
    );

    test(
      'NotificationsListController loads initial items and marks read',
      () async {
        final notifier = container.read(
          notificationsListControllerProvider.notifier,
        );
        await notifier.loadInitial();

        final state = container.read(notificationsListControllerProvider);
        expect(state.items.length, 2);
        expect(state.items.first.isRead, isFalse);

        await notifier.markAsRead('notif-1');
        final updatedState = container.read(
          notificationsListControllerProvider,
        );
        expect(updatedState.items.first.isRead, isTrue);
      },
    );

    test(
      'NotificationsListController markAllAsRead updates all items',
      () async {
        final notifier = container.read(
          notificationsListControllerProvider.notifier,
        );
        await notifier.loadInitial();

        final failure = await notifier.markAllAsRead();
        expect(failure, isNull);

        final state = container.read(notificationsListControllerProvider);
        expect(state.items.every((n) => n.isRead), isTrue);
        expect(container.read(unreadNotificationCountControllerProvider), 0);
      },
    );

    test('AnnouncementsListController filters expired items', () async {
      final notifier = container.read(
        announcementsListControllerProvider.notifier,
      );
      await notifier.loadAnnouncements();

      final state = container.read(announcementsListControllerProvider);
      // The expired announcement should be filtered out
      expect(state.items.length, 1);
      expect(state.items.first.id, 'ann-1');

      // Check hasNewAnnouncements
      final hasNew = container.read(hasNewAnnouncementsProvider);
      expect(hasNew, isTrue);
    });
  });
}
