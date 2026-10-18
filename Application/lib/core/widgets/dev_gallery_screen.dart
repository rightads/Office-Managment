import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/permissions/permission_codes.dart';
import 'package:right_ads/core/permissions/permission_service.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/theme/theme_controller.dart';
import 'package:right_ads/core/utils/app_formatters.dart';
import 'package:right_ads/core/utils/validators.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/core/widgets/app_scaffold.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/app_text_field.dart';
import 'package:right_ads/core/widgets/avatar_with_initials.dart';
import 'package:right_ads/core/widgets/confirm_dialog.dart';
import 'package:right_ads/core/widgets/date_range_picker_field.dart';
import 'package:right_ads/core/widgets/empty_state.dart';
import 'package:right_ads/core/widgets/error_state.dart';
import 'package:right_ads/core/widgets/loading_skeleton.dart';
import 'package:right_ads/core/widgets/paged_list_view.dart';
import 'package:right_ads/core/widgets/permission_gate.dart';
import 'package:right_ads/core/widgets/status_chip.dart';

class _SampleApiBadge {
  const _SampleApiBadge({required this.label, this.hexColor});
  final String label;
  final String? hexColor;
}

class DevGalleryScreen extends ConsumerStatefulWidget {
  const DevGalleryScreen({super.key});

  @override
  ConsumerState<DevGalleryScreen> createState() => _DevGalleryScreenState();
}

class _DevGalleryScreenState extends ConsumerState<DevGalleryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _simulateOffline = false;
  int _selectedNavIndex = 0;
  DateTimeRange? _selectedDateRange;
  final List<int> _pagedItems = List<int>.generate(6, (index) => index + 1);

  static const List<_SampleApiBadge> _sampleApiBadges = <_SampleApiBadge>[
    _SampleApiBadge(label: '#10B981', hexColor: '#10B981'),
    _SampleApiBadge(label: '#FDE047', hexColor: '#FDE047'),
    _SampleApiBadge(label: '#1E3A8A', hexColor: '#1E3A8A'),
    _SampleApiBadge(label: '#DC2626', hexColor: '#DC2626'),
    _SampleApiBadge(label: 'FALLBACK', hexColor: 'invalid_hex'),
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeControllerProvider);
    final locale = ref.watch(localeControllerProvider);
    final formatters = ref.watch(appFormattersProvider);
    final hasDemoPermission = ref.can(PermissionCodes.taskCreate);

    final destinations = <AppNavDestination>[
      AppNavDestination(
        key: 'buttons',
        label: l10n.devGalleryPrimaryButton,
        icon: Icons.smart_button_outlined,
      ),
      AppNavDestination(
        key: 'inputs',
        label: l10n.devGalleryEmailLabel,
        icon: Icons.input_outlined,
      ),
      AppNavDestination(
        key: 'chips',
        label: l10n.commonConfirm,
        icon: Icons.label_outline,
        badgeCount: 3,
      ),
      AppNavDestination(
        key: 'states',
        label: l10n.commonRetry,
        icon: Icons.layers_outlined,
      ),
      AppNavDestination(
        key: 'dialogs',
        label: l10n.devGalleryShowSnackbar,
        icon: Icons.chat_bubble_outline,
      ),
      AppNavDestination(
        key: 'overflow',
        label: l10n.devGalleryTitle,
        icon: Icons.widgets_outlined,
      ),
    ];

    final sampleUtcTimestamp = DateTime.utc(2026, 10, 18, 14, 30);
    final formattedDateTime = formatters.formatDateTime(sampleUtcTimestamp);
    final formattedCurrency = formatters.formatCurrency(125400.75);

    return AppScaffold(
      title: l10n.devGalleryTitle,
      isOfflineOverride: _simulateOffline,
      destinations: destinations,
      selectedIndex: _selectedNavIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedNavIndex = index;
        });
      },
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: <Widget>[
          _SectionCard(
            title: l10n.devGalleryThemeSection,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: <Widget>[
                    ChoiceChip(
                      label: Text(l10n.devGalleryThemeSystem),
                      selected: themeMode == ThemeMode.system,
                      onSelected: (_) => ref
                          .read(themeModeControllerProvider.notifier)
                          .setThemeMode(ThemeMode.system),
                    ),
                    ChoiceChip(
                      label: Text(l10n.devGalleryThemeLight),
                      selected: themeMode == ThemeMode.light,
                      onSelected: (_) => ref
                          .read(themeModeControllerProvider.notifier)
                          .setThemeMode(ThemeMode.light),
                    ),
                    ChoiceChip(
                      label: Text(l10n.devGalleryThemeDark),
                      selected: themeMode == ThemeMode.dark,
                      onSelected: (_) => ref
                          .read(themeModeControllerProvider.notifier)
                          .setThemeMode(ThemeMode.dark),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: <Widget>[
                    ChoiceChip(
                      label: Text(l10n.devGalleryLocaleEnglish),
                      selected: (locale?.languageCode ?? 'en') == 'en',
                      onSelected: (_) => ref
                          .read(localeControllerProvider.notifier)
                          .setLocale(const Locale('en')),
                    ),
                    ChoiceChip(
                      label: Text(l10n.devGalleryLocaleHindi),
                      selected: locale?.languageCode == 'hi',
                      onSelected: (_) => ref
                          .read(localeControllerProvider.notifier)
                          .setLocale(const Locale('hi')),
                    ),
                  ],
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.devGalleryOfflineToggle),
                  value: _simulateOffline,
                  onChanged: (value) {
                    setState(() {
                      _simulateOffline = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionCard(
            title: l10n.devGalleryButtonsSection,
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: <Widget>[
                AppButton(
                  label: l10n.devGalleryPrimaryButton,
                  icon: Icons.check,
                  onPressed: () {},
                ),
                AppButton(
                  label: l10n.devGallerySecondaryButton,
                  variant: AppButtonVariant.secondary,
                  onPressed: () {},
                ),
                AppButton(
                  label: l10n.devGalleryTonalButton,
                  variant: AppButtonVariant.tonal,
                  onPressed: () {},
                ),
                AppButton(
                  label: l10n.devGalleryDestructiveButton,
                  variant: AppButtonVariant.destructive,
                  onPressed: () {},
                ),
                AppButton(
                  label: l10n.devGalleryTextButton,
                  variant: AppButtonVariant.text,
                  onPressed: () {},
                ),
                AppButton(
                  label: l10n.devGalleryPrimaryButton,
                  isLoading: true,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionCard(
            title: l10n.devGalleryInputsSection,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  AppTextField(
                    controller: _emailController,
                    label: l10n.devGalleryEmailLabel,
                    hint: l10n.devGalleryEmailHint,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.compose(
                      <FormFieldValidator<String>>[
                        AppValidators.required(l10n),
                        AppValidators.email(l10n),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppTextField(
                    controller: _passwordController,
                    label: l10n.devGalleryPasswordLabel,
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                    validator: AppValidators.compose(
                      <FormFieldValidator<String>>[
                        AppValidators.required(l10n),
                        AppValidators.minLength(l10n, 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppDateRangePickerField(
                    label: l10n.dateRangePickerPlaceholder,
                    selectedRange: _selectedDateRange,
                    onChanged: (range) {
                      setState(() {
                        _selectedDateRange = range;
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppButton(
                      label: l10n.devGalleryValidateFormButton,
                      variant: AppButtonVariant.secondary,
                      onPressed: () => _formKey.currentState?.validate(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionCard(
            title: l10n.devGalleryStatusChipsSection,
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: _sampleApiBadges
                  .map(
                    (badge) => StatusChip(
                      label: badge.label,
                      hexColor: badge.hexColor,
                      icon: Icons.circle,
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionCard(
            title: l10n.devGalleryAvatarsSection,
            child: Wrap(
              spacing: AppSpacing.md,
              children: <Widget>[
                AvatarWithInitials(
                  name: l10n.appTitle,
                  size: AppSpacing.avatarSm,
                ),
                AvatarWithInitials(
                  name: l10n.devGalleryLocaleEnglish,
                ),
                AvatarWithInitials(
                  name: l10n.devGalleryLocaleHindi,
                  size: AppSpacing.avatarLg,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionCard(
            title: l10n.devGalleryFormattersSection,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  formattedDateTime,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  formattedCurrency,
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionCard(
            title: l10n.devGalleryDialogsSection,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: <Widget>[
                    AppButton(
                      label: l10n.devGalleryOpenConfirmDialog,
                      variant: AppButtonVariant.secondary,
                      onPressed: () async {
                        await ConfirmDialog.show(
                          context,
                          title: l10n.devGalleryConfirmDialogTitle,
                          message: l10n.devGalleryConfirmDialogMessage,
                        );
                      },
                    ),
                    AppButton(
                      label: l10n.devGalleryShowSnackbar,
                      variant: AppButtonVariant.tonal,
                      onPressed: () => AppSnackbar.showSuccess(
                        context,
                        l10n.devGallerySnackbarSampleMessage,
                      ),
                    ),
                  ],
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.devGalleryTogglePermission),
                  value: hasDemoPermission,
                  onChanged: (enabled) {
                    final notifier = ref.read(
                      userPermissionsControllerProvider.notifier,
                    );
                    if (enabled) {
                      notifier.setPermissions(<String>[
                        PermissionCodes.taskCreate,
                      ]);
                    } else {
                      notifier.clear();
                    }
                  },
                ),
                PermissionGate(
                  permission: PermissionCodes.taskCreate,
                  fallback: Text(
                    l10n.permissionDeniedFallback,
                    style: theme.textTheme.bodySmall,
                  ),
                  child: Text(
                    l10n.devGalleryPermittedContent,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionCard(
            title: l10n.devGalleryStatesSection,
            child: Column(
              children: <Widget>[
                const LoadingSkeleton(height: AppSpacing.lg),
                const SizedBox(height: AppSpacing.sm),
                const EmptyState(),
                const Divider(),
                ErrorState(onRetry: () {}),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionCard(
            title: l10n.devGalleryPagedListSection,
            child: SizedBox(
              height: 220,
              child: PagedListView<int>(
                items: _pagedItems,
                onRefresh: () async {},
                itemBuilder: (context, item, index) {
                  return ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(l10n.devGallerySampleItemTitle(item)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            child,
          ],
        ),
      ),
    );
  }
}
