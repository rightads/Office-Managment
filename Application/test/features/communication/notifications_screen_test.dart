import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/l10n/generated/app_localizations.dart';
import 'package:right_ads/features/communication/application/notifications_controller.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';
import 'package:right_ads/features/communication/presentation/notifications_screen.dart';
import 'package:right_ads/features/communication/presentation/widgets/notification_tile.dart';

class _FakeNotificationsListController extends NotificationsListController {
  _FakeNotificationsListController(this._state);
  final NotificationsListState _state;

  @override
  NotificationsListState build() => _state;

  @override
  Future<void> loadInitial({bool? unreadOnly}) async {}

  @override
  Future<void> loadMore() async {}

  @override
  Future<void> setUnreadFilter({required bool unreadOnly}) async {}

  @override
  Future<void> markAsRead(String notificationId) async {}
}

class _FakeUnreadCountController extends UnreadNotificationCountController {
  _FakeUnreadCountController(this._count);
  final int _count;

  @override
  int build() => _count;

  @override
  Future<void> loadCount() async {}
}

Widget _buildTestApp({
  required Widget child,
  required NotificationsListState listState,
  int unreadCount = 0,
}) {
  const config = AppConfig(
    apiBaseUrl: 'https://test.api.com',
    environment: AppEnvironment.dev,
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
    sendTimeout: Duration(seconds: 5),
  );

  return ProviderScope(
    overrides: [
      appConfigProvider.overrideWithValue(config),
      notificationsListControllerProvider.overrideWith(
        () => _FakeNotificationsListController(listState),
      ),
      unreadNotificationCountControllerProvider.overrideWith(
        () => _FakeUnreadCountController(unreadCount),
      ),
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}

void main() {
  group('NotificationsScreen Widget Tests', () {
    testWidgets('renders notification tiles and filter chips', (tester) async {
      final now = DateTime.now();
      final notifications = [
        NotificationItemModel(
          id: 'notif-1',
          title: 'New Task Assigned',
          body: 'You have been assigned to prepare banner ads.',
          type: 'task',
          isRead: false,
          createdAt: now,
        ),
        NotificationItemModel(
          id: 'notif-2',
          title: 'Leave Approved',
          body: 'Your leave application was approved by manager.',
          type: 'leave',
          isRead: true,
          createdAt: now.subtract(const Duration(hours: 2)),
        ),
      ];

      final state = NotificationsListState(
        items: notifications,
      );

      await tester.pumpWidget(
        _buildTestApp(
          child: const NotificationsScreen(),
          listState: state,
          unreadCount: 1,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Unread Only'), findsOneWidget);
      expect(find.text('1'), findsOneWidget); // unread badge

      expect(find.byType(NotificationTile), findsNWidgets(2));
      expect(find.text('New Task Assigned'), findsOneWidget);
      expect(find.text('Leave Approved'), findsOneWidget);
    });

    testWidgets('renders empty state when inbox has no notifications', (
      tester,
    ) async {
      const state = NotificationsListState();

      await tester.pumpWidget(
        _buildTestApp(
          child: const NotificationsScreen(),
          listState: state,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No notifications yet'), findsOneWidget);
    });
  });
}
