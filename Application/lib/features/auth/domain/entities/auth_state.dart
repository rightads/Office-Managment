import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:right_ads/features/auth/domain/entities/auth_user.dart';

part 'auth_state.freezed.dart';

enum SessionExpiryReason {
  expired,
  tokenReuse,
}

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.loading() = AuthLoading;

  const factory AuthState.unauthenticated({
    SessionExpiryReason? expiryReason,
  }) = AuthUnauthenticated;

  const factory AuthState.mustChangePassword({
    required AuthUser user,
  }) = AuthMustChangePassword;

  const factory AuthState.authenticated({
    required AuthUser user,
    @Default(false) bool isBiometricLocked,
  }) = AuthAuthenticated;
}
