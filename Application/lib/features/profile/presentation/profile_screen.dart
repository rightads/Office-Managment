import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:right_ads/core/config/app_config_provider.dart';
import 'package:right_ads/core/config/runtime_app_config.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/services/photo_picker_service.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/theme/theme_controller.dart';
import 'package:right_ads/core/utils/app_formatters.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/app_text_field.dart';
import 'package:right_ads/core/widgets/avatar_with_initials.dart';
import 'package:right_ads/core/widgets/confirm_dialog.dart';
import 'package:right_ads/core/widgets/error_state.dart';
import 'package:right_ads/core/widgets/loading_skeleton.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/navigation/presentation/forbidden_screen.dart';
import 'package:right_ads/features/profile/application/password_policy_validator.dart';
import 'package:right_ads/features/profile/application/profile_controller.dart';
import 'package:right_ads/features/profile/domain/profile_models.dart';

/// Employee Profile & Account screen (`GET/PATCH /api/v1/employees/me`).
///
/// Displays all organizational fields verbatim from the server without role
/// conditionals, allows editing only server-whitelisted self-edit fields
/// (`phone_number` and `avatar_url`), provides password change with dynamic
/// policy hints from `/app/config`, and manages theme, language, biometric
/// unlock, device info, and session logout.
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _profileFormKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  String? _lastSyncedPhone;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final current = ref.read(profileControllerProvider);
      if (current.profile == null && !current.isLoading) {
        unawaited(ref.read(profileControllerProvider.notifier).loadProfile());
      } else if (current.profile != null) {
        _syncPhoneController(current.profile!.phoneNumber);
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _syncPhoneController(String? serverPhone) {
    final normalized = serverPhone ?? '';
    if (_lastSyncedPhone != normalized) {
      _lastSyncedPhone = normalized;
      _phoneController.text = normalized;
    }
  }

  Future<void> _handleSaveProfile(EmployeeProfile profile) async {
    if (!(_profileFormKey.currentState?.validate() ?? false)) {
      return;
    }
    final l10n = context.l10n;
    final phone = _phoneController.text.trim();
    final failure = await ref
        .read(profileControllerProvider.notifier)
        .updateSelfProfile(
          phoneNumber: phone.isEmpty ? null : phone,
          avatarUrl: profile.avatarUrl,
        );
    if (!mounted) return;
    if (failure == null) {
      AppSnackbar.showSuccess(context, l10n.profileSaveSuccess);
    } else if (failure is! ValidationFailure) {
      AppSnackbar.showError(context, _failureMessage(failure));
    }
  }

  Future<void> _showPhotoSourceSheet(RuntimeAppConfig appConfig) async {
    final l10n = context.l10n;
    final allowedTypesText = appConfig.allowedUploadMimeTypes.join(', ');
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              0,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.profilePhotoSourceTitle,
                  style: Theme.of(sheetContext).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  l10n.profilePhotoLimitsHint(
                    allowedTypesText,
                    appConfig.maxUploadMb,
                  ),
                  style: Theme.of(sheetContext).textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                ListTile(
                  key: const ValueKey<String>('photo_source_camera'),
                  leading: const Icon(Icons.photo_camera_outlined),
                  title: Text(l10n.profilePhotoCameraOption),
                  onTap: () => Navigator.of(sheetContext).pop(
                    ImageSource.camera,
                  ),
                ),
                ListTile(
                  key: const ValueKey<String>('photo_source_gallery'),
                  leading: const Icon(Icons.photo_library_outlined),
                  title: Text(l10n.profilePhotoGalleryOption),
                  onTap: () => Navigator.of(sheetContext).pop(
                    ImageSource.gallery,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (source == null || !mounted) return;
    final saved = await ref
        .read(profileControllerProvider.notifier)
        .pickAndUploadPhoto(source);
    if (!mounted) return;
    if (saved) {
      AppSnackbar.showSuccess(context, l10n.profileSaveSuccess);
    }
  }

  Future<void> _showChangePasswordSheet() async {
    ref.read(profileControllerProvider.notifier).clearPasswordFieldErrors();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => const ChangePasswordBottomSheet(),
    );
  }

  Future<void> _handleLogout() async {
    final l10n = context.l10n;
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.profileLogoutConfirmTitle,
      message: l10n.profileLogoutConfirmMessage,
      confirmLabel: l10n.authLogoutButton,
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;
    await ref.read(sessionControllerProvider.notifier).logout();
  }

  Future<void> _handleLogoutAll() async {
    final l10n = context.l10n;
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.authLogoutAllConfirmTitle,
      message: l10n.authLogoutAllConfirmMessage,
      confirmLabel: l10n.authLogoutAllButton,
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;
    final failure = await ref
        .read(sessionControllerProvider.notifier)
        .logoutAll();
    if (!mounted) return;
    if (failure == null) {
      AppSnackbar.showSuccess(context, l10n.authLogoutAllSuccess);
    }
  }

  String _failureMessage(AppFailure failure) {
    final l10n = context.l10n;
    return switch (failure) {
      NetworkFailure(:final message) => message ?? l10n.networkOfflineBanner,
      UnauthorizedFailure(:final message) =>
        message ?? l10n.errorStateDefaultTitle,
      ForbiddenFailure(:final message) => message ?? l10n.forbiddenMessage,
      NotFoundFailure(:final message) => message ?? l10n.errorStateDefaultTitle,
      ConflictFailure(:final message) => message ?? l10n.errorStateDefaultTitle,
      ValidationFailure(:final message) =>
        message ?? l10n.errorStateDefaultTitle,
      ServerFailure(:final message) => message ?? l10n.errorStateDefaultMessage,
      UnknownFailure(:final message) =>
        message ?? l10n.errorStateDefaultMessage,
    };
  }

  String _formatJoiningDate(String? rawIsoDate, AppFormatters formatters) {
    if (rawIsoDate == null || rawIsoDate.trim().isEmpty) {
      return context.l10n.profileNotAssigned;
    }
    final parsed = DateTime.tryParse(rawIsoDate.trim());
    if (parsed == null) {
      return rawIsoDate;
    }
    return formatters.formatDate(
      DateTime.utc(parsed.year, parsed.month, parsed.day),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final profileState = ref.watch(profileControllerProvider);
    final appConfig = ref.watch(runtimeAppConfigControllerProvider);
    final buildEnvConfig = ref.watch(appConfigProvider);
    final currentVersion = ref.watch(currentAppVersionProvider);
    final themeMode = ref.watch(themeModeControllerProvider);
    final locale = ref.watch(localeControllerProvider);
    final formatters = ref.watch(appFormattersProvider);

    final profile = profileState.profile;
    if (profile != null) {
      _syncPhoneController(profile.phoneNumber);
    }

    if (profileState.isLoading && profile == null) {
      return const LoadingSkeletonList();
    }

    if (profileState.failure is ForbiddenFailure && profile == null) {
      return const ForbiddenScreen();
    }

    if (profileState.failure != null && profile == null) {
      return ErrorState(
        title: l10n.errorStateDefaultTitle,
        message: _failureMessage(profileState.failure!),
        onRetry: () =>
            ref.read(profileControllerProvider.notifier).loadProfile(),
      );
    }

    final allowedTypesText = appConfig.allowedUploadMimeTypes.join(', ');
    final photoError = profileState.photoValidationError;
    final serverAvatarError = profileState.profileFieldError('avatar_url');
    String? resolvedPhotoErrorText;
    if (photoError == PhotoValidationError.exceedsMaxSize) {
      resolvedPhotoErrorText = l10n.profilePhotoErrorSize(
        appConfig.maxUploadMb,
      );
    } else if (photoError == PhotoValidationError.unsupportedMimeType) {
      resolvedPhotoErrorText = l10n.profilePhotoErrorMime(allowedTypesText);
    } else if (serverAvatarError != null) {
      resolvedPhotoErrorText = serverAvatarError;
    }

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(profileControllerProvider.notifier).loadProfile(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (profile != null) ...<Widget>[
              // 1. Header Card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  side: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: <Widget>[
                      AvatarWithInitials(
                        name: profile.fullName,
                        imageUrl: profile.avatarUrl,
                        size: AppSpacing.avatarLg,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        profile.fullName,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        profile.employeeCode,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Wrap(
                        spacing: AppSpacing.xs,
                        runSpacing: AppSpacing.xs,
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          if (profile.roleName != null &&
                              profile.roleName!.isNotEmpty)
                            Chip(
                              avatar: const Icon(
                                Icons.badge_outlined,
                                size: 16,
                              ),
                              label: Text(profile.roleName!),
                              visualDensity: VisualDensity.compact,
                            ),
                          if (profile.departmentName != null &&
                              profile.departmentName!.isNotEmpty)
                            Chip(
                              avatar: const Icon(
                                Icons.apartment_outlined,
                                size: 16,
                              ),
                              label: Text(profile.departmentName!),
                              visualDensity: VisualDensity.compact,
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      AppButton(
                        key: const ValueKey<String>('profile_change_photo_btn'),
                        label: l10n.profileChangePhotoButton,
                        icon: Icons.add_a_photo_outlined,
                        variant: AppButtonVariant.tonal,
                        isLoading: profileState.isSavingProfile,
                        onPressed: () => _showPhotoSourceSheet(appConfig),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        l10n.profilePhotoLimitsHint(
                          allowedTypesText,
                          appConfig.maxUploadMb,
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (resolvedPhotoErrorText != null) ...<Widget>[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          resolvedPhotoErrorText,
                          key: const ValueKey<String>(
                            'profile_photo_error_text',
                          ),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // 2. Read-only Employment & Organization Details
              _ProfileSectionCard(
                title: l10n.profileEmploymentSection,
                icon: Icons.business_center_outlined,
                child: Column(
                  children: <Widget>[
                    _ReadOnlyDetailRow(
                      label: l10n.profileEmployeeCodeLabel,
                      value: profile.employeeCode,
                    ),
                    _ReadOnlyDetailRow(
                      label: l10n.profileFullNameLabel,
                      value: profile.fullName,
                    ),
                    _ReadOnlyDetailRow(
                      label: l10n.profileEmailLabel,
                      value: profile.email,
                    ),
                    _ReadOnlyDetailRow(
                      label: l10n.profileRoleLabel,
                      value: profile.roleName ?? l10n.profileNotAssigned,
                    ),
                    _ReadOnlyDetailRow(
                      label: l10n.profileDepartmentLabel,
                      value: profile.departmentName ?? l10n.profileNotAssigned,
                    ),
                    _ReadOnlyDetailRow(
                      label: l10n.profileDesignationLabel,
                      value: profile.designation ?? l10n.profileNotAssigned,
                    ),
                    _ReadOnlyDetailRow(
                      label: l10n.profileManagerLabel,
                      value: profile.managerName ?? l10n.profileNotAssigned,
                    ),
                    _ReadOnlyDetailRow(
                      label: l10n.profileJoiningDateLabel,
                      value: _formatJoiningDate(
                        profile.joiningDate,
                        formatters,
                      ),
                    ),
                    if (profile.attendancePolicyName != null &&
                        profile.attendancePolicyName!.isNotEmpty)
                      _ReadOnlyDetailRow(
                        label: l10n.profileAttendancePolicyLabel,
                        value: profile.attendancePolicyName!,
                        isLast: true,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // 3. Self-Editable Personal Contact Card
              _ProfileSectionCard(
                title: l10n.profilePersonalEditSection,
                icon: Icons.edit_note_outlined,
                child: Form(
                  key: _profileFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      AppTextField(
                        key: const ValueKey<String>('profile_phone_field'),
                        controller: _phoneController,
                        label: l10n.profilePhoneLabel,
                        hint: l10n.profilePhoneHint,
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        errorText: profileState.profileFieldError(
                          'phone_number',
                        ),
                        validator: (value) {
                          final trimmed = value?.trim() ?? '';
                          if (trimmed.length > 20) {
                            return l10n.validationMaxLength(20);
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppButton(
                        key: const ValueKey<String>('profile_save_button'),
                        label: l10n.profileSaveButton,
                        icon: Icons.save_outlined,
                        isLoading: profileState.isSavingProfile,
                        onPressed: () => _handleSaveProfile(profile),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],

            // 4. Account Security Card (Change Password + Biometric Toggle)
            _ProfileSectionCard(
              title: l10n.profileSecuritySection,
              icon: Icons.security_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AppButton(
                    key: const ValueKey<String>(
                      'profile_change_password_button',
                    ),
                    label: l10n.profileChangePasswordButton,
                    icon: Icons.lock_reset_outlined,
                    variant: AppButtonVariant.secondary,
                    onPressed: _showChangePasswordSheet,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SwitchListTile(
                    key: const ValueKey<String>('profile_biometric_switch'),
                    contentPadding: EdgeInsets.zero,
                    secondary: const Icon(Icons.fingerprint),
                    title: Text(l10n.profileBiometricToggleTitle),
                    subtitle: Text(
                      profileState.isBiometricSupported
                          ? l10n.profileBiometricToggleSubtitle
                          : l10n.profileBiometricUnsupportedSubtitle,
                    ),
                    value: profileState.isBiometricEnabled,
                    onChanged: profileState.isBiometricSupported
                        ? (enabled) {
                            unawaited(
                              ref
                                  .read(profileControllerProvider.notifier)
                                  .toggleBiometric(
                                    enabled: enabled,
                                    localizedReason: l10n.authBiometricReason,
                                  ),
                            );
                          }
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // 5. Appearance & Language Card
            _ProfileSectionCard(
              title: l10n.profilePreferencesSection,
              icon: Icons.tune_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    l10n.profileThemeLabel,
                    style: theme.textTheme.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SegmentedButton<ThemeMode>(
                    key: const ValueKey<String>('profile_theme_segmented'),
                    segments: <ButtonSegment<ThemeMode>>[
                      ButtonSegment<ThemeMode>(
                        value: ThemeMode.system,
                        label: Text(l10n.devGalleryThemeSystem),
                        icon: const Icon(Icons.brightness_auto_outlined),
                      ),
                      ButtonSegment<ThemeMode>(
                        value: ThemeMode.light,
                        label: Text(l10n.devGalleryThemeLight),
                        icon: const Icon(Icons.light_mode_outlined),
                      ),
                      ButtonSegment<ThemeMode>(
                        value: ThemeMode.dark,
                        label: Text(l10n.devGalleryThemeDark),
                        icon: const Icon(Icons.dark_mode_outlined),
                      ),
                    ],
                    selected: <ThemeMode>{themeMode},
                    onSelectionChanged: (selected) {
                      if (selected.isNotEmpty) {
                        unawaited(
                          ref
                              .read(themeModeControllerProvider.notifier)
                              .setThemeMode(selected.first),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.profileLanguageLabel,
                    style: theme.textTheme.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SegmentedButton<String>(
                    key: const ValueKey<String>('profile_language_segmented'),
                    segments: <ButtonSegment<String>>[
                      ButtonSegment<String>(
                        value: 'en',
                        label: Text(l10n.devGalleryLocaleEnglish),
                        icon: const Icon(Icons.language_outlined),
                      ),
                      ButtonSegment<String>(
                        value: 'hi',
                        label: Text(l10n.devGalleryLocaleHindi),
                        icon: const Icon(Icons.translate_outlined),
                      ),
                    ],
                    selected: <String>{locale?.languageCode ?? 'en'},
                    onSelectionChanged: (selected) {
                      if (selected.isNotEmpty) {
                        unawaited(
                          ref
                              .read(localeControllerProvider.notifier)
                              .setLocale(Locale(selected.first)),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // 6. Device & App Information Card
            _ProfileSectionCard(
              title: l10n.profileDeviceInfoSection,
              icon: Icons.perm_device_information_outlined,
              child: Column(
                children: <Widget>[
                  _ReadOnlyDetailRow(
                    label: l10n.profileAppVersionLabel,
                    value:
                        '$currentVersion (${buildEnvConfig.environment.value})',
                  ),
                  _ReadOnlyDetailRow(
                    label: l10n.profileDeviceIdLabel,
                    value:
                        profileState.deviceMetadata?.deviceId ??
                        l10n.profileNotAssigned,
                  ),
                  _ReadOnlyDetailRow(
                    label: l10n.profileDeviceModelLabel,
                    value:
                        profileState.deviceMetadata?.modelName ??
                        l10n.profileNotAssigned,
                  ),
                  _ReadOnlyDetailRow(
                    label: l10n.profileDeviceOsLabel,
                    value:
                        profileState.deviceMetadata?.osVersion ??
                        l10n.profileNotAssigned,
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // 7. Session Management Card
            _ProfileSectionCard(
              title: l10n.profileSessionSection,
              icon: Icons.logout_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AppButton(
                    key: const ValueKey<String>('profile_logout_button'),
                    label: l10n.authLogoutButton,
                    icon: Icons.logout_outlined,
                    variant: AppButtonVariant.secondary,
                    onPressed: _handleLogout,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppButton(
                    key: const ValueKey<String>('profile_logout_all_button'),
                    label: l10n.authLogoutAllButton,
                    icon: Icons.phonelink_erase_outlined,
                    variant: AppButtonVariant.destructive,
                    onPressed: _handleLogoutAll,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _ProfileSectionCard extends StatelessWidget {
  const _ProfileSectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: AppSpacing.lg),
            child,
          ],
        ),
      ),
    );
  }
}

class _ReadOnlyDetailRow extends StatelessWidget {
  const _ReadOnlyDetailRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

/// Modal bottom sheet for changing the current user's password
/// (`POST /api/v1/auth/change-password`) with dynamic policy hints from
/// [RuntimeAppConfig.passwordPolicy] and 422 field error mapping.
class ChangePasswordBottomSheet extends ConsumerStatefulWidget {
  const ChangePasswordBottomSheet({super.key});

  @override
  ConsumerState<ChangePasswordBottomSheet> createState() =>
      _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState
    extends ConsumerState<ChangePasswordBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _candidatePassword = '';

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit(PasswordPolicySummary policy) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final l10n = context.l10n;
    final failure = await ref
        .read(profileControllerProvider.notifier)
        .changePassword(
          currentPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
        );

    if (!mounted) return;
    if (failure == null) {
      Navigator.of(context).pop();
      AppSnackbar.showSuccess(context, l10n.authChangePasswordSuccess);
    } else if (failure is! ValidationFailure) {
      AppSnackbar.showError(
        context,
        switch (failure) {
          UnauthorizedFailure(:final message) =>
            message ?? l10n.errorStateDefaultTitle,
          NetworkFailure(:final message) =>
            message ?? l10n.networkOfflineBanner,
          _ => l10n.errorStateDefaultMessage,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final profileState = ref.watch(profileControllerProvider);
    final policy = ref.watch(runtimeAppConfigControllerProvider).passwordPolicy;
    final violations = PasswordPolicyValidator.evaluate(
      _candidatePassword,
      policy,
    ).toSet();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          MediaQuery.viewInsetsOf(context).bottom + AppSpacing.md,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  l10n.profileChangePasswordSheetTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  key: const ValueKey<String>(
                    'change_password_current_field',
                  ),
                  controller: _currentPasswordController,
                  label: l10n.authCurrentPasswordLabel,
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  errorText: profileState.passwordFieldError(
                    'current_password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.validationRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  key: const ValueKey<String>('change_password_new_field'),
                  controller: _newPasswordController,
                  label: l10n.authNewPasswordLabel,
                  obscureText: true,
                  prefixIcon: Icons.key_outlined,
                  errorText: profileState.passwordFieldError('new_password'),
                  onChanged: (value) {
                    setState(() {
                      _candidatePassword = value;
                    });
                  },
                  validator: (value) {
                    final candidate = value ?? '';
                    if (candidate.isEmpty) {
                      return l10n.validationRequired;
                    }
                    if (!PasswordPolicyValidator.isValid(candidate, policy)) {
                      return l10n.validationMinLength(policy.minLength);
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  key: const ValueKey<String>('change_password_confirm_field'),
                  controller: _confirmPasswordController,
                  label: l10n.authConfirmPasswordLabel,
                  obscureText: true,
                  prefixIcon: Icons.verified_user_outlined,
                  validator: (value) {
                    if (value != _newPasswordController.text) {
                      return l10n.validationPasswordsDoNotMatch;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),

                // Dynamic Password Policy Checklist from RuntimeAppConfig
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        l10n.profilePasswordPolicyHeading,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      _PolicyRuleItem(
                        label: l10n.profilePasswordMinLengthRule(
                          policy.minLength,
                        ),
                        isSatisfied:
                            _candidatePassword.isNotEmpty &&
                            !violations.contains(
                              PasswordPolicyViolation.tooShort,
                            ),
                      ),
                      if (policy.requireUppercase)
                        _PolicyRuleItem(
                          label: l10n.profilePasswordUppercaseRule,
                          isSatisfied:
                              _candidatePassword.isNotEmpty &&
                              !violations.contains(
                                PasswordPolicyViolation.missingUppercase,
                              ),
                        ),
                      if (policy.requireLowercase)
                        _PolicyRuleItem(
                          label: l10n.profilePasswordLowercaseRule,
                          isSatisfied:
                              _candidatePassword.isNotEmpty &&
                              !violations.contains(
                                PasswordPolicyViolation.missingLowercase,
                              ),
                        ),
                      if (policy.requireDigit)
                        _PolicyRuleItem(
                          label: l10n.profilePasswordDigitRule,
                          isSatisfied:
                              _candidatePassword.isNotEmpty &&
                              !violations.contains(
                                PasswordPolicyViolation.missingDigit,
                              ),
                        ),
                      if (policy.requireSpecial)
                        _PolicyRuleItem(
                          label: l10n.profilePasswordSpecialRule,
                          isSatisfied:
                              _candidatePassword.isNotEmpty &&
                              !violations.contains(
                                PasswordPolicyViolation.missingSpecial,
                              ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppButton(
                  key: const ValueKey<String>('change_password_submit_button'),
                  label: l10n.authUpdatePasswordButton,
                  icon: Icons.check_circle_outline,
                  isLoading: profileState.isChangingPassword,
                  onPressed: () => _submit(policy),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PolicyRuleItem extends StatelessWidget {
  const _PolicyRuleItem({
    required this.label,
    required this.isSatisfied,
  });

  final String label;
  final bool isSatisfied;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isSatisfied
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxs),
      child: Row(
        children: <Widget>[
          Icon(
            isSatisfied
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked,
            size: 16,
            color: color,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
