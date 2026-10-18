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
import 'package:right_ads/core/widgets/app_text_field.dart';
import 'package:right_ads/features/auth/application/session_controller.dart';
import 'package:right_ads/features/auth/domain/entities/auth_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isSubmitting = false;
  AppFailure? _submitFailure;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isSubmitting = true;
      _submitFailure = null;
    });

    final failure = await ref
        .read(sessionControllerProvider.notifier)
        .login(
          email: _emailController.text,
          password: _passwordController.text,
        );

    if (!mounted) return;
    setState(() {
      _isSubmitting = false;
      _submitFailure = failure;
    });
  }

  String _resolveErrorMessage(BuildContext context, AppFailure failure) {
    final l10n = context.l10n;
    return switch (failure) {
      NetworkFailure(:final message) => message ?? l10n.authNetworkError,
      UnauthorizedFailure(:final message) =>
        message ?? l10n.authGenericLoginError,
      ValidationFailure(:final message) =>
        message ?? l10n.authGenericLoginError,
      ForbiddenFailure(:final message) ||
      NotFoundFailure(:final message) ||
      ConflictFailure(:final message) ||
      ServerFailure(:final message) ||
      UnknownFailure(
        :final message,
      ) => message ?? l10n.errorStateDefaultMessage,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final authState = ref.watch(sessionControllerProvider);

    String? bannerMessage;
    if (_submitFailure != null) {
      bannerMessage = _resolveErrorMessage(context, _submitFailure!);
    } else if (authState is AuthUnauthenticated &&
        authState.expiryReason != null) {
      bannerMessage = switch (authState.expiryReason!) {
        SessionExpiryReason.expired => l10n.authSessionExpiredMessage,
        SessionExpiryReason.tokenReuse => l10n.authTokenReuseMessage,
      };
    }

    return AppScaffold(
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
                          Icons.campaign_outlined,
                          size: AppSpacing.xxl,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          l10n.authLoginTitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.authLoginSubtitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        if (bannerMessage != null) ...<Widget>[
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.error_outline,
                                  color: colorScheme.onErrorContainer,
                                  size: AppSpacing.iconMd,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Expanded(
                                  child: Text(
                                    bannerMessage,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onErrorContainer,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
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
                          textInputAction: TextInputAction.next,
                          enabled: !_isSubmitting,
                          validator: AppValidators.compose(
                            <FormFieldValidator<String>>[
                              AppValidators.required(l10n),
                              AppValidators.email(l10n),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          controller: _passwordController,
                          label: l10n.authPasswordLabel,
                          obscureText: true,
                          prefixIcon: Icons.lock_outline,
                          textInputAction: TextInputAction.done,
                          enabled: !_isSubmitting,
                          onFieldSubmitted: (_) => _submit(),
                          validator: AppValidators.required(l10n),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Align(
                          alignment: Alignment.centerRight,
                          child: AppButton(
                            label: l10n.authForgotPasswordLink,
                            variant: AppButtonVariant.text,
                            onPressed: _isSubmitting
                                ? null
                                : () => context.push(RoutePaths.forgotPassword),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppButton(
                          label: l10n.authSignInButton,
                          icon: Icons.login,
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
