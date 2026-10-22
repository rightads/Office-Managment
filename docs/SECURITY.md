# Security Architecture & Policies - Right Ads Mobile & Web

This document outlines the security controls, policies, and operational practices implemented in the Right Ads client application and its integration with the FastAPI backend.

---

## 1. Authentication & Session Management
- **Token Storage**:
  - `access_token` and `refresh_token` are stored strictly in `FlutterSecureStorage` (backed by Android Keystore on Android and Keychain with `kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly` on iOS).
  - Tokens and sensitive credentials are never stored in `SharedPreferences`, logs, or Git.
- **Silent Refresh & Concurrent Protection**:
  - `TokenRefreshInterceptor` queues concurrent 401 requests and executes a single rotation call (`POST /auth/refresh`).
  - Upon successful rotation, queued requests replay seamlessly with updated bearer tokens.
- **Replay Attack & Leak Detection**:
  - The FastAPI backend stores SHA-256 hashes of issued refresh tokens. If a previously rotated or revoked token is reused, all active user sessions are invalidated immediately.
- **Account Lockout**:
  - Progressive lockout policy (`MAX_LOGIN_ATTEMPTS = 5`, `LOCKOUT_MINUTES = 15`) defends against brute-force credential stuffing.

---

## 2. Server-Side Truth & Attendance Integrity (Part B Rule 4)
- **Zero Client Timestamp Trust**:
  - Attendance check-in and check-out requests **NEVER** transmit or trust client timestamps. The backend server system clock (`get_server_time()`) is the sole authoritative timestamp.
- **No Offline Queuing for Attendance**:
  - Attendance check-ins/outs cannot be queued offline. If the device lacks an active network connection, the action is blocked immediately (`AttendanceActionOfflineProhibited`) with an explanatory localized alert.
- **Geofencing & Mock Location Defense**:
  - Geofence validations evaluate Great-Circle (Haversine) distances against dynamic office locations retrieved from `/app/config`.
  - Mock location flags (`is_mock_location`) are captured via `geolocator` and verified by the server. Check-ins from mock locations are rejected and flagged for audit.
- **Hardware Device Binding**:
  - User accounts bind to physical hardware identifiers (`device_id`) on first attendance check-in. Attempts to check in from alternate devices are denied until an administrator performs a device reset.

---

## 3. Offline Data & Synchronization Security
- **Data Caching**:
  - Read-only catalogs (navigation structure, system config, my tasks, announcements) are stored locally in `SharedPreferences` as last-good read states.
  - When offline, cached views display the localized `offlineDataNotice` banner.
- **Safe Sync Queue**:
  - Non-attendance mutations (work report drafts, task comments, dynamic record drafts) are safely staged in `SyncQueueManager`.
  - Replayed sequentially with exponential backoff on reconnection.
  - Conflicts (HTTP 409) safely preserve server state without clobbering remote data.

---

## 4. Client Hardening & Performance
- **Prohibition of Hardcoding**:
  - No secret keys, credentials, role names, or status codes in client code.
  - Zero raw user-facing string literals in presentation code (enforced by `no_hardcoded_strings_test.dart`).
- **Clipboard Hygiene**:
  - Temporary passwords and session credentials can be cleared automatically via `SecurityService.clearSensitiveClipboard()`.
- **Release Sanitization**:
  - Debug logs stripped in release mode via `kReleaseMode` filters in custom log printers.
  - Code obfuscation (`--obfuscate --split-debug-info`) enabled for release artifact generation.
- **Transport Security**:
  - Strict HTTPS TLS 1.3/1.2 requirement in production environments.
