import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/l10n/generated/app_localizations.dart';
import 'package:right_ads/features/communication/application/announcements_controller.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';
import 'package:right_ads/features/communication/presentation/announcement_detail_screen.dart';
import 'package:right_ads/features/communication/presentation/announcements_screen.dart';
import 'package:right_ads/features/communication/presentation/widgets/announcement_card.dart';
import 'package:right_ads/features/tasks/domain/task_models.dart';

class _FakeAnnouncementsListController extends AnnouncementsListController {
  _FakeAnnouncementsListController(this._state);
  final AnnouncementsListState _state;

  @override
  AnnouncementsListState build() => _state;

  @override
  Future<void> loadAnnouncements() async {}

  @override
  Future<void> refresh() async {}
}

Widget _buildTestApp({
  required Widget child,
  required AnnouncementsListState listState,
  AnnouncementModel? detailModel,
  String? detailId,
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
      announcementsListControllerProvider.overrideWith(
        () => _FakeAnnouncementsListController(listState),
      ),
      if (detailId != null && detailModel != null)
        announcementDetailProvider(
          detailId,
        ).overrideWith((ref) => Future.value(detailModel)),
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}

void main() {
  group('AnnouncementsScreen & Detail Widget Tests', () {
    testWidgets('renders announcement cards with department badges', (
      tester,
    ) async {
      final now = DateTime.now();
      final announcements = [
        AnnouncementModel(
          id: 'ann-1',
          title: 'Office Townhall Q4',
          body: 'Quarterly review and team updates on Thursday.',
          creator: const UserBriefModel(
            id: 'u-admin',
            employeeCode: 'ADMIN01',
            fullName: 'Rajesh Sharma',
            email: 'rajesh@rightads.com',
          ),
          createdAt: now,
        ),
        AnnouncementModel(
          id: 'ann-2',
          title: 'Design Team Brainstorm',
          body: 'Brainstorm session for Diwali creative campaigns.',
          targetDepartmentId: 'dept-design',
          targetDepartmentName: 'Creative Design',
          creator: const UserBriefModel(
            id: 'u-lead',
            employeeCode: 'DES01',
            fullName: 'Ananya Verma',
            email: 'ananya@rightads.com',
          ),
          createdAt: now.subtract(const Duration(days: 1)),
        ),
      ];

      final state = AnnouncementsListState(
        items: announcements,
      );

      await tester.pumpWidget(
        _buildTestApp(
          child: const AnnouncementsScreen(),
          listState: state,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Announcements'), findsOneWidget);
      expect(find.byType(AnnouncementCard), findsNWidgets(2));
      expect(find.text('Office Townhall Q4'), findsOneWidget);
      expect(find.text('Design Team Brainstorm'), findsOneWidget);
      expect(find.text('Company-wide'), findsOneWidget);
      expect(find.text('Creative Design'), findsOneWidget);
    });

    testWidgets('renders empty state when no active announcements exist', (
      tester,
    ) async {
      const state = AnnouncementsListState();

      await tester.pumpWidget(
        _buildTestApp(
          child: const AnnouncementsScreen(),
          listState: state,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No active announcements'), findsOneWidget);
    });

    testWidgets('renders AnnouncementDetailScreen content correctly', (
      tester,
    ) async {
      final announcement = AnnouncementModel(
        id: 'ann-100',
        title: 'Policy Update Notice',
        body: 'Please review the updated attendance policy guidelines.',
        creator: const UserBriefModel(
          id: 'u-hr',
          employeeCode: 'HR007',
          fullName: 'Pooja Mehta',
          email: 'pooja@rightads.com',
        ),
        createdAt: DateTime(2026, 10, 19, 10),
      );

      await tester.pumpWidget(
        _buildTestApp(
          child: const AnnouncementDetailScreen(announcementId: 'ann-100'),
          listState: const AnnouncementsListState(),
          detailId: 'ann-100',
          detailModel: announcement,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Announcement Details'), findsOneWidget);
      expect(find.text('Policy Update Notice'), findsOneWidget);
      expect(
        find.text('Please review the updated attendance policy guidelines.'),
        findsOneWidget,
      );
      expect(find.text('Pooja Mehta'), findsOneWidget);
      expect(find.text('HR007'), findsOneWidget);
      expect(find.text('Company-wide'), findsOneWidget);
    });
  });
}
