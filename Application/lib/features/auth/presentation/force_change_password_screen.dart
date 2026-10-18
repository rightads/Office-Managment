import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/utils/validators.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/core/widgets/app_scaffold.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/app_text_field.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';

class ForceChangePasswordScreen extends ConsumerStatefulWidget {
  const ForceChangePasswordScreen({super.key});

  @override
  ConsumerState<ForceChangePasswordScreen> createState() =>
      _ForceChangePasswordScreenState();
}

class _ForceChangePasswordScreenState
    extends ConsumerState<ForceChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSubmitting = false;
  AppFailure? _failure;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isSubmitting = true;
      _failure = null;
    });

    final l10n = context.l10n;
    final failure = await ref
        .read(sessionControllerProvider.notifier)
        .changePassword(
          currentPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
        );

    if (!mounted) return;
    setState(() {
      _isSubmitting = false;
      _failure = failure;
    });

    if (failure == null) {
      AppSnackbar.showSuccess(context, l10n.authChangePasswordSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppScaffold(
      title: l10n.authForceChangePasswordTitle,
      actions: <Widget>[
        AppButton(
          label: l10n.authLogoutButton,
          variant: AppButtonVariant.text,
          icon: Icons.logout,
          onPressed: _isSubmitting
              ? null
              : () => ref.read(sessionControllerProvider.notifier).logout(),
        ),
      ],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSpacing.maxContentWidth,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                          Icons.security_update_warning_outlined,
                          size: AppSpacing.xxl,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          l10n.authForceChangePasswordTitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.authForceChangePasswordSubtitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        if (_failure != null) ...<Widget>[
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              _failure!.message ??
                                  l10n.errorStateDefaultMessage,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onErrorContainer,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                        ],
                        AppTextField(
                          controller: _currentPasswordController,
                          label: l10n.authCurrentPasswordLabel,
                          obscureText: true,
                          prefixIcon: Icons.lock_clock_outlined,
                          enabled: !_isSubmitting,
                          validator: AppValidators.required(l10n),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          controller: _newPasswordController,
                          label: l10n.authNewPasswordLabel,
                          obscureText: true,
                          prefixIcon: Icons.lock_outline,
                          enabled: !_isSubmitting,
                          validator: AppValidators.compose(
                            <FormFieldValidator<String>>[
                              AppValidators.required(l10n),
                              AppValidators.minLength(l10n, 6),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          controller: _confirmPasswordController,
                          label: l10n.authConfirmPasswordLabel,
                          obscureText: true,
                          prefixIcon: Icons.verified_user_outlined,
                          enabled: !_isSubmitting,
                          validator: (value) {
                            final reqError = AppValidators.required(l10n)(
                              value,
                            );
                            if (reqError != null) return reqError;
                            if (value != _newPasswordController.text) {
                              return l10n.validationPasswordsDoNotMatch;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AppButton(
                          label: l10n.authUpdatePasswordButton,
                          icon: Icons.save_outlined,
                          isLoading: _isSubmitting,
                          expanded: true,
                          onPressed: _submit,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
