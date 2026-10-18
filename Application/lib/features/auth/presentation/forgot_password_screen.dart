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

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _requestSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final l10n = context.l10n;
    final failure = await ref
        .read(passwordRecoveryControllerProvider.notifier)
        .requestPasswordReset(email: _emailController.text);

    if (!mounted) return;
    if (failure != null) {
      final msg = switch (failure) {
        NetworkFailure(:final message) => message ?? l10n.authNetworkError,
        _ => failure.message ?? l10n.errorStateDefaultMessage,
      };
      AppSnackbar.showError(context, msg);
      return;
    }

    setState(() {
      _requestSent = true;
    });
    AppSnackbar.showSuccess(context, l10n.authForgotPasswordSuccess);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSubmitting = ref.watch(passwordRecoveryControllerProvider);

    return AppScaffold(
      title: l10n.authForgotPasswordTitle,
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
                          l10n.authForgotPasswordTitle,
                          style: theme.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.authForgotPasswordSubtitle,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        if (_requestSent) ...<Widget>[
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              l10n.authForgotPasswordSuccess,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                        ],
                        AppTextField(
                          controller: _emailController,
                          label: l10n.authEmailLabel,
                          hint: l10n.authEmailHint,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          enabled: !isSubmitting,
                          validator: AppValidators.compose(
                            <FormFieldValidator<String>>[
                              AppValidators.required(l10n),
                              AppValidators.email(l10n),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppButton(
                          label: l10n.authSendResetLinkButton,
                          icon: Icons.send_outlined,
                          isLoading: isSubmitting,
                          expanded: true,
                          onPressed: _submit,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppButton(
                          label: l10n.authHaveResetTokenLink,
                          variant: AppButtonVariant.tonal,
                          expanded: true,
                          onPressed: () =>
                              context.push(RoutePaths.resetPassword),
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
