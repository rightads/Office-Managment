import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/config/app_config.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/app_environment.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/l10n/generated/app_localizations.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/storage/preferences_storage.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';
import 'package:right_ads/features/auth/domain/entities/auth_user.dart';
import 'package:right_ads/features/navigation/application/navigation_controller.dart';
import 'package:right_ads/features/navigation/domain/navigation_models.dart';
import 'package:right_ads/features/navigation/presentation/adaptive_shell_screen.dart';
import 'package:right_ads/features/navigation/presentation/forbidden_screen.dart';
import 'package:right_ads/features/navigation/presentation/force_update_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeSessionController extends SessionController {
  _FakeSessionController(this._initialState);
  final AuthState _initialState;

  @override
  AuthState build() => _initialState;
}

class _FakeNavigationController extends NavigationController {
  _FakeNavigationController(this._initialState);
  final NavigationState _initialState;

  @override
  NavigationState build() => _initialState;
}

class _FakeRuntimeConfigController extends RuntimeAppConfigController {
  _FakeRuntimeConfigController(this._config);
  final RuntimeAppConfig _config;

  @override
  RuntimeAppConfig build() => _config;
}

void main() {
  group('AdaptiveShellScreen, ModuleRegistry & Permission Navigation Tests', () {
    late SharedPreferences prefs;

    const testAppConfig = AppConfig(
      environment: AppEnvironment.dev,
      apiBaseUrl: 'http://localhost:8000/api/v1',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
      sendTimeout: Duration(seconds: 5),
    );

    const testUser = AuthUser(
      id: '11111111-1111-1111-1111-111111111111',
      employeeCode: 'EMP-001',
      email: 'emp@rightads.com',
      fullName: 'Aarav Sharma',
      roleLabel: 'Tele sales',
      mustChangePassword: false,
      permissions: <String>[
        PermissionCodes.attendanceViewOwn,
        PermissionCodes.taskViewAssigned,
      ],
    );

    setUp(() async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      prefs = await SharedPreferences.getInstance();
    });

    Widget buildHarness({
      required NavigationState navState,
      Size surfaceSize = const Size(400, 840),
      Widget child = const AdaptiveShellScreen(),
      RuntimeAppConfig runtimeConfig = const RuntimeAppConfig(),
      String appVersion = '1.0.0',
    }) {
      return ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          appConfigProvider.overrideWithValue(testAppConfig),
          runtimeAppConfigControllerProvider.overrideWith(
            () => _FakeRuntimeConfigController(runtimeConfig),
          ),
          currentAppVersionProvider.overrideWithValue(appVersion),
          sessionControllerProvider.overrideWith(
            () => _FakeSessionController(
              const AuthState.authenticated(
                user: testUser,
              ),
            ),
          ),
          navigationControllerProvider.overrideWith(
            () => _FakeNavigationController(navState),
          ),
        ],
        child: MediaQuery(
          data: MediaQueryData(size: surfaceSize),
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: child,
          ),
        ),
      );
    }

    testWidgets(
      'renders different navigation items for different permission/module sets and handles unknown route_key safely',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 840));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        const restrictedNav = NavigationState(
          data: UserNavigationData(
            roleName: 'Minimal Role',
            roleLabel: 'Minimal Role',
            permissions: <String>[PermissionCodes.attendanceViewOwn],
            modules: <AppModuleItem>[
              AppModuleItem(
                id: '1',
                code: 'attendance',
                label: 'Attendance',
                iconKey: 'attendance',
                routeKey: 'attendance',
                sortOrder: 10,
                requiredPermission: PermissionCodes.attendanceViewOwn,
                isBase: true,
              ),
              AppModuleItem(
                id: '2',
                code: 'future_crm',
                label: 'Future CRM Module',
                iconKey: 'unknown_icon',
                routeKey: 'future_crm_route_v99',
                sortOrder: 20,
              ),
            ],
          ),
        );

        await tester.pumpWidget(buildHarness(navState: restrictedNav));
        await tester.pumpAndSettle();

        // Bottom NavigationBar has Home + Attendance + Future CRM Module (3 items <= 5)
        expect(find.byType(NavigationBar), findsOneWidget);
        expect(find.text('Attendance'), findsWidgets);
        expect(find.text('Future CRM Module'), findsWidgets);

        // Unknown route_key shows "Update the app to use this module" tile on Home
        expect(
          find.text('Update the app to use this module'),
          findsOneWidget,
        );

        // Tapping the unknown module destination in the bottom NavigationBar opens UnknownModuleView without crashing
        await tester.tap(
          find.descendant(
            of: find.byType(NavigationBar),
            matching: find.text('Future CRM Module'),
          ),
        );
        await tester.pumpAndSettle();
        expect(
          find.text('Update the app to use this module'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'caps phone bottom NavigationBar at 5 destinations with More sheet and renders NavigationRail on tablet/web',
      (tester) async {
        final sevenModules = <AppModuleItem>[
          const AppModuleItem(
            id: '1',
            code: 'attendance',
            label: 'Attendance',
            iconKey: 'attendance',
            routeKey: 'attendance',
            sortOrder: 10,
            isBase: true,
          ),
          const AppModuleItem(
            id: '2',
            code: 'tasks',
            label: 'Tasks',
            iconKey: 'tasks',
            routeKey: 'tasks',
            sortOrder: 20,
            isBase: true,
          ),
          const AppModuleItem(
            id: '3',
            code: 'leave',
            label: 'Leave',
            iconKey: 'leave',
            routeKey: 'leave',
            sortOrder: 30,
            isBase: true,
          ),
          const AppModuleItem(
            id: '4',
            code: 'work_reports',
            label: 'Daily Work Report',
            iconKey: 'work_reports',
            routeKey: 'work_reports',
            sortOrder: 40,
            isBase: true,
          ),
          const AppModuleItem(
            id: '5',
            code: 'announcements',
            label: 'Announcements',
            iconKey: 'announcements',
            routeKey: 'announcements',
            sortOrder: 50,
            isBase: true,
          ),
          const AppModuleItem(
            id: '6',
            code: 'notifications',
            label: 'Notifications',
            iconKey: 'notifications',
            routeKey: 'notifications',
            sortOrder: 60,
            isBase: true,
            showOnHome: false,
          ),
          const AppModuleItem(
            id: '7',
            code: 'profile',
            label: 'Profile',
            iconKey: 'profile',
            routeKey: 'profile',
            sortOrder: 70,
            isBase: true,
            showOnHome: false,
          ),
        ];

        final fullNavState = NavigationState(
          data: UserNavigationData(
            roleName: 'Admin',
            roleLabel: 'Admin',
            modules: sevenModules,
          ),
        );

        // 1. Phone layout (width 400 < 600): NavigationBar with max 5 items + More
        await tester.binding.setSurfaceSize(const Size(400, 840));
        await tester.pumpWidget(
          buildHarness(
            navState: fullNavState,
          ),
        );
        await tester.pumpAndSettle();

        final navBar = tester.widget<NavigationBar>(find.byType(NavigationBar));
        expect(navBar.destinations.length, 5);
        expect(find.text('More'), findsOneWidget);

        // 2. Tablet/Web layout (width 1100 >= 1024): NavigationRail sidebar
        await tester.binding.setSurfaceSize(const Size(1100, 840));
        await tester.pumpWidget(
          buildHarness(
            navState: fullNavState,
            surfaceSize: const Size(1100, 840),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(NavigationRail), findsOneWidget);
        await tester.binding.setSurfaceSize(null);
      },
    );

    testWidgets(
      'ForbiddenScreen and ForceUpdateScreen render localized messages cleanly',
      (tester) async {
        await tester.pumpWidget(
          buildHarness(
            navState: const NavigationState(),
            child: const ForbiddenScreen(),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('No Access'), findsWidgets);

        await tester.pumpWidget(
          buildHarness(
            navState: const NavigationState(),
            runtimeConfig: const RuntimeAppConfig(
              minSupportedAppVersion: '2.5.0',
              forceUpdate: true,
            ),
            child: const ForceUpdateScreen(),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('App Update Required'), findsOneWidget);
        expect(
          find.textContaining('Minimum required: 2.5.0'),
          findsOneWidget,
        );
      },
    );
  });
}
