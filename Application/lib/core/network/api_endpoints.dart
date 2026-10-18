/// Relative API endpoint paths matching `docs/backend/openapi.json`.
///
/// Because `AppConfig.apiBaseUrl` ends with `/api/v1` (e.g.
/// `http://10.0.2.2:8000/api/v1`), these paths are relative to `/api/v1`.
abstract final class ApiEndpoints {
  static const String health = '/health';

  // Authentication
  static const String authLogin = '/auth/login';
  static const String authRefresh = '/auth/refresh';
  static const String authLogout = '/auth/logout';
  static const String authLogoutAll = '/auth/logout-all';
  static const String authChangePassword = '/auth/change-password';
  static const String authForgotPassword = '/auth/forgot-password';
  static const String authResetPassword = '/auth/reset-password';
  static const String authMe = '/auth/me';

  // App Config, Navigation & Modules (Backend Addendum A1)
  static const String appConfig = '/app/config';
  static const String meNavigation = '/me/navigation';
  static const String meAttendancePolicy = '/me/attendance-policy';
  static const String appModules = '/app-modules';

  // Employee Self-Service & Profile (Prompt 05)
  static const String employeesMe = '/employees/me';

  /// Endpoints that do not require an `Authorization: Bearer` header or
  /// automatic 401 token refresh.
  static const Set<String> publicPaths = <String>{
    health,
    appConfig,
    authLogin,
    authRefresh,
    authForgotPassword,
    authResetPassword,
  };

  static bool isPublicPath(String path) {
    return publicPaths.any(path.endsWith);
  }
}
