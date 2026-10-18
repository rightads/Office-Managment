import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/l10n/l10n.dart';
import 'package:right_ads/core/router/route_paths.dart';
import 'package:right_ads/core/theme/app_spacing.dart';
import 'package:right_ads/core/utils/validators.dart';
import 'package:right_ads/core/widgets/app_button.dart';
import 'package:right_ads/core/widgets/app_scaffold.dart';
import 'package:right_ads/core/widgets/app_snackbar.dart';
import 'package:right_ads/core/widgets/app_text_field.dart';
import 'package:right_ads/features/auth/application/password_recovery_controller.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tokenController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _tokenController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final l10n = context.l10n;
    final failure = await ref
        .read(passwordRecoveryControllerProvider.notifier)
        .confirmPasswordReset(
          token: _tokenController.text,
          newPassword: _newPasswordController.text,
        );

    if (!mounted) return;
    if (failure != null) {
      final msg = switch (failure) {
        NetworkFailure(:final message) => message ?? l10n.authNetworkError,
        _ => failure.message ?? l10n.errorStateDefaultMessage,
      };
      AppSnackbar.showError(context, msg);
      return;
    }

    AppSnackbar.showSuccess(context, l10n.authResetPasswordSuccess);
    context.go(RoutePaths.login);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSubmitting = ref.watch(passwordRecoveryControllerProvider);

    return AppScaffold(
      title: l10n.authResetPasswordTitle,
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
                        Text(
                          l10n.authResetPasswordTitle,
                          style: theme.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.authResetPasswordSubtitle,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AppTextField(
                          controller: _tokenController,
                          label: l10n.authResetTokenLabel,
                          prefixIcon: Icons.vpn_key_outlined,
                          enabled: !isSubmitting,
                          validator: AppValidators.required(l10n),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          controller: _newPasswordController,
                          label: l10n.authNewPasswordLabel,
                          obscureText: true,
                          prefixIcon: Icons.lock_outline,
                          enabled: !isSubmitting,
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
                          prefixIcon: Icons.lock_reset_outlined,
                          enabled: !isSubmitting,
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
                          label: l10n.authResetPasswordButton,
                          icon: Icons.check_circle_outline,
                          isLoading: isSubmitting,
                          expanded: true,
                          onPressed: _submit,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        AppButton(
                          label: l10n.authBackToLoginLink,
                          variant: AppButtonVariant.text,
                          onPressed: () => context.go(RoutePaths.login),
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
