import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/theme/app_brand_colors.dart';
import 'package:right_ads/core/theme/app_theme.dart';
import 'package:right_ads/core/utils/validators.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/core/widgets/app_scaffold.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/app_text_field.dart';
import 'package:right_ads/core/widgets/avatar_with_initials.dart';
import 'package:right_ads/core/widgets/confirm_dialog.dart';
import 'package:right_ads/core/widgets/date_range_picker_field.dart';
import 'package:right_ads/core/widgets/paged_list_view.dart';
import 'package:right_ads/core/widgets/permission_gate.dart';
import 'package:right_ads/core/widgets/status_chip.dart';

Widget _buildTestHarness(
  Widget child, {
  Set<String> permissions = const <String>{},
}) {
  return ProviderScope(
    overrides: [
      userPermissionsControllerProvider.overrideWith(
        () => _TestPermissionsController(permissions),
      ),
    ],
    child: MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}

class _TestPermissionsController extends UserPermissionsController {
  _TestPermissionsController(this._initial);
  final Set<String> _initial;

  @override
  PermissionSet build() => PermissionSet(_initial);
}

void main() {
  group('Shared Widgets Suite (Prompt 02)', () {
    testWidgets('AppButton triggers onPressed and disables when isLoading', (
      tester,
    ) async {
      var tapped = false;

      await tester.pumpWidget(
        _buildTestHarness(
          Scaffold(
            body: Column(
              children: <Widget>[
                AppButton(
                  label: 'Save',
                  onPressed: () => tapped = true,
                ),
                AppButton(
                  label: 'Saving',
                  isLoading: true,
                  onPressed: () => tapped = true,
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Save'));
      expect(tapped, isTrue);

      tapped = false;
      await tester.tap(find.text('Saving'));
      expect(tapped, isFalse);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
      'AppTextField validates required & email and toggles password obscurity',
      (tester) async {
        final formKey = GlobalKey<FormState>();

        await tester.pumpWidget(
          _buildTestHarness(
            Builder(
              builder: (context) {
                final l10n = context.l10n;
                return Scaffold(
                  body: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        AppTextField(
                          label: l10n.devGalleryEmailLabel,
                          validator: AppValidators.compose(
                            <FormFieldValidator<String>>[
                              AppValidators.required(l10n),
                              AppValidators.email(l10n),
                            ],
                          ),
                        ),
                        AppTextField(
                          label: l10n.devGalleryPasswordLabel,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(find.text('This field is required.'), findsOneWidget);

        await tester.enterText(find.byType(TextFormField).first, 'bad-email');
        expect(formKey.currentState!.validate(), isFalse);
        await tester.pump();
        expect(find.text('Enter a valid email address.'), findsOneWidget);

        await tester.enterText(
          find.byType(TextFormField).first,
          'employee@rightads.com',
        );
        expect(formKey.currentState!.validate(), isTrue);

        // Toggle password visibility icon
        expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
        await tester.tap(find.byIcon(Icons.visibility_outlined));
        await tester.pump();
        expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
      },
    );

    testWidgets(
      'StatusChip renders API label and contrast-safe foreground color',
      (tester) async {
        await tester.pumpWidget(
          _buildTestHarness(
            const Scaffold(
              body: Column(
                children: <Widget>[
                  StatusChip(label: 'High Priority', hexColor: '#FDE047'),
                  StatusChip(label: 'In Progress', hexColor: '#1E3A8A'),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final lightBgText = tester.widget<Text>(find.text('High Priority'));
        final darkBgText = tester.widget<Text>(find.text('In Progress'));

        expect(lightBgText.style?.color, AppBrandColors.highContrastDarkText);
        expect(darkBgText.style?.color, AppBrandColors.highContrastLightText);
      },
    );

    testWidgets(
      'PermissionGate shows child when permitted and fallback when not',
      (
        tester,
      ) async {
        await tester.pumpWidget(
          _buildTestHarness(
            const Scaffold(
              body: Column(
                children: <Widget>[
                  PermissionGate(
                    permission: PermissionCodes.userCreate,
                    fallback: Text('Allowed-Fallback'),
                    child: Text('Allowed-Child'),
                  ),
                  PermissionGate(
                    permission: PermissionCodes.systemManageSettings,
                    fallback: Text('Denied-Fallback'),
                    child: Text('Denied-Child'),
                  ),
                ],
              ),
            ),
            permissions: <String>{PermissionCodes.userCreate},
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Allowed-Child'), findsOneWidget);
        expect(find.text('Allowed-Fallback'), findsNothing);
        expect(find.text('Denied-Child'), findsNothing);
        expect(find.text('Denied-Fallback'), findsOneWidget);
      },
    );

    testWidgets(
      'AppScaffold adapts between NavigationBar (<600px) with More overflow and NavigationRail (>=600px)',
      (tester) async {
        final destinations = List<AppNavDestination>.generate(
          6,
          (i) => AppNavDestination(
            key: 'tab_$i',
            label: 'Tab $i',
            icon: Icons.folder_outlined,
          ),
        );

        // Phone viewport: 400 x 800
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          _buildTestHarness(
            AppScaffold(
              title: 'Adaptive Test',
              destinations: destinations,
              isOfflineOverride: true,
              body: const Text('Body Content'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(NavigationBar), findsOneWidget);
        expect(find.byType(NavigationRail), findsNothing);
        expect(find.text('More'), findsOneWidget);
        expect(
          find.text(
            'You are offline. Changes will sync when connection is restored.',
          ),
          findsOneWidget,
        );

        // Tablet/Desktop viewport: 1100 x 800
        tester.view.physicalSize = const Size(1100, 800);
        await tester.pumpAndSettle();

        expect(find.byType(NavigationRail), findsOneWidget);
        expect(find.byType(NavigationBar), findsNothing);
      },
    );

    testWidgets('PagedListView renders EmptyState, ErrorState, and items', (
      tester,
    ) async {
      var retried = false;

      // 1. Empty state
      await tester.pumpWidget(
        _buildTestHarness(
          Scaffold(
            body: PagedListView<String>(
              items: const <String>[],
              onRefresh: () async {},
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Nothing here yet'), findsOneWidget);

      // 2. Error state with retry
      await tester.pumpWidget(
        _buildTestHarness(
          Scaffold(
            body: PagedListView<String>(
              items: const <String>[],
              errorMessage: 'Server unavailable',
              onRefresh: () async {
                retried = true;
              },
              itemBuilder: (context, item, index) => Text(item),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Server unavailable'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      expect(retried, isTrue);

      // 3. Populated list
      await tester.pumpWidget(
        _buildTestHarness(
          Scaffold(
            body: PagedListView<String>(
              items: const <String>['Record A', 'Record B'],
              onRefresh: () async {},
              itemBuilder: (context, item, index) =>
                  ListTile(title: Text(item)),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Record A'), findsOneWidget);
      expect(find.text('Record B'), findsOneWidget);
    });

    testWidgets(
      'AvatarWithInitials, ConfirmDialog, AppSnackbar, and AppDateRangePickerField work as expected',
      (tester) async {
        expect(AvatarWithInitials.extractInitials('Aarav Sharma'), 'AS');
        expect(AvatarWithInitials.extractInitials('Priya'), 'P');

        bool? dialogConfirmed;

        await tester.pumpWidget(
          _buildTestHarness(
            Builder(
              builder: (context) => Scaffold(
                body: Column(
                  children: <Widget>[
                    const AvatarWithInitials(name: 'Aarav Sharma'),
                    AppDateRangePickerField(
                      label: 'Period',
                      selectedRange: DateTimeRange(
                        start: DateTime.utc(2026, 5),
                        end: DateTime.utc(2026, 5, 10),
                      ),
                      onChanged: (_) {},
                    ),
                    AppButton(
                      label: 'Open Dialog',
                      onPressed: () async {
                        dialogConfirmed = await ConfirmDialog.show(
                          context,
                          title: 'Delete Record?',
                          message: 'This cannot be undone.',
                          isDestructive: true,
                        );
                      },
                    ),
                    AppButton(
                      label: 'Trigger Snackbar',
                      onPressed: () =>
                          AppSnackbar.showInfo(context, 'Saved changes'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('AS'), findsOneWidget);
        expect(find.text('01 May 2026 - 10 May 2026'), findsOneWidget);

        await tester.tap(find.text('Trigger Snackbar'));
        await tester.pump();
        expect(find.text('Saved changes'), findsOneWidget);

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();
        expect(find.text('Delete Record?'), findsOneWidget);
        await tester.tap(find.text('Confirm'));
        await tester.pumpAndSettle();
        expect(dialogConfirmed, isTrue);
      },
    );
  });
}
