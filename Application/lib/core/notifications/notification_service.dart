import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:right_ads/core/notifications/notification_channel_config.dart';
import 'package:right_ads/core/notifications/notification_payload_parser.dart';
import 'package:right_ads/core/router/app_router.dart';
import 'package:right_ads/core/storage/preferences_storage.dart';
import 'package:right_ads/core/utils/app_logger.dart';
import 'package:right_ads/features/communication/application/notifications_controller.dart';
import 'package:right_ads/features/communication/data/communication_repository.dart';
import 'package:right_ads/features/communication/domain/communication_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'notification_service.g.dart';

/// Top-level background message handler required by FirebaseMessaging.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    debugPrint('FCM background message received: ${message.messageId}');
  }
}

/// Central notification service managing FCM, local notification channels,
/// background/foreground processing, and deep linking.
class NotificationService {
  NotificationService({
    required this.repository,
    required this.prefs,
    required this.logger,
    FlutterLocalNotificationsPlugin? localNotifications,
    this.messaging,
    this.onNavigate,
  }) : _localNotifications =
           localNotifications ?? FlutterLocalNotificationsPlugin();

  final CommunicationRepository repository;
  final SharedPreferences prefs;
  final AppLogger logger;
  final FlutterLocalNotificationsPlugin _localNotifications;
  FirebaseMessaging? messaging;
  void Function(String route)? onNavigate;

  static const String _deviceIdPrefKey = 'fcm_installation_device_id';
  static const String _lastTokenPrefKey = 'fcm_last_registered_token';

  bool _isInitialized = false;
  bool _isFirebaseAvailable = false;
  StreamSubscription<String>? _tokenRefreshSub;
  StreamSubscription<RemoteMessage>? _foregroundSub;
  StreamSubscription<RemoteMessage>? _openedAppSub;

  /// Unique stable hardware/installation ID persisted across sessions.
  String getDeviceId() {
    var id = prefs.getString(_deviceIdPrefKey);
    if (id == null || id.isEmpty) {
      id = const Uuid().v4();
      unawaited(prefs.setString(_deviceIdPrefKey, id));
    }
    return id;
  }

  /// Platform string conforming to backend schema ('android', 'ios', 'web').
  String get platformName {
    if (kIsWeb) return 'web';
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return 'android';
    }
  }

  /// Initializes local notifications, Android channels, and attaches Firebase listeners.
  ///
  /// Protected by try-catch to ensure graceful fallback if Google Services configuration
  /// files are absent.
  Future<void> initialize({void Function()? onNotificationReceived}) async {
    if (_isInitialized) return;

    // 1. Initialize Flutter Local Notifications
    await _initLocalNotifications();

    // 2. Initialize Firebase if possible
    await _initFirebase(onNotificationReceived: onNotificationReceived);

    _isInitialized = true;
  }

  Future<void> _initLocalNotifications() async {
    try {
      const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );
      const darwinSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: darwinSettings,
        macOS: darwinSettings,
      );

      await _localNotifications.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: _onLocalNotificationTapped,
      );

      // Create Android Notification Channels from structured config
      final androidPlugin = _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (androidPlugin != null) {
        for (final channel in NotificationChannelConfig.allChannels) {
          await androidPlugin.createNotificationChannel(
            channel.toAndroidNotificationChannel(),
          );
        }
      }
    } on Object catch (e, st) {
      logger.warning(
        'Failed to initialize local notifications plugin: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> _initFirebase({void Function()? onNotificationReceived}) async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
      messaging ??= FirebaseMessaging.instance;
      _isFirebaseAvailable = true;

      // Register background handler
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      // Handle message that opened the app from terminated state
      final initialMessage = await messaging!.getInitialMessage();
      if (initialMessage != null) {
        _handleIncomingPayload(initialMessage.data);
      }

      // Handle message that opened the app from background
      _openedAppSub = FirebaseMessaging.onMessageOpenedApp.listen((message) {
        _handleIncomingPayload(message.data);
      });

      // Handle foreground notifications
      _foregroundSub = FirebaseMessaging.onMessage.listen((message) {
        unawaited(_showForegroundNotification(message));
        onNotificationReceived?.call();
      });

      // Token refresh listener for FCM push token rotation.
      // ignore: deprecated_member_use
      _tokenRefreshSub = messaging!.onTokenRefresh.listen((newToken) {
        unawaited(registerDeviceToken(fcmTokenOverride: newToken));
      });
    } on Object catch (e) {
      _isFirebaseAvailable = false;
      logger.info(
        'Firebase not available or unconfigured. Running in local notification mode: $e',
      );
    }
  }

  /// Requests notification permission at a sensible moment (not blindly on first launch).
  ///
  /// Call this when the user visits the Notifications / Announcements screen,
  /// or when they interact with the permission banner.
  Future<bool> requestPermission() async {
    var granted = false;

    // 1. Request via Firebase Messaging if available
    if (_isFirebaseAvailable && messaging != null) {
      try {
        final settings = await messaging!.requestPermission();
        granted =
            settings.authorizationStatus == AuthorizationStatus.authorized ||
            settings.authorizationStatus == AuthorizationStatus.provisional;
      } on Object catch (e) {
        logger.warning('Error requesting Firebase messaging permissions: $e');
      }
    }

    // 2. Request Android 13+ POST_NOTIFICATIONS via local notifications
    try {
      final androidPlugin = _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (androidPlugin != null) {
        final androidGranted = await androidPlugin
            .requestNotificationsPermission();
        if (androidGranted != null) {
          granted = androidGranted;
        }
      }
    } on Object catch (e) {
      logger.warning(
        'Error requesting Android local notification permission: $e',
      );
    }

    if (granted) {
      // Register device token with backend immediately
      unawaited(registerDeviceToken());
    }

    return granted;
  }

  /// Registers or refreshes the FCM token with the backend (`POST /api/v1/notifications/devices`).
  Future<void> registerDeviceToken({String? fcmTokenOverride}) async {
    try {
      var token = fcmTokenOverride;
      if (token == null && _isFirebaseAvailable && messaging != null) {
        // FCM token retrieval on mobile platforms.
        // ignore: deprecated_member_use
        token = await messaging!.getToken();
      }

      if (token == null || token.isEmpty) {
        return;
      }

      final deviceId = getDeviceId();
      final payload = DeviceTokenRegisterPayload(
        fcmToken: token,
        deviceId: deviceId,
        platform: platformName,
      );

      final (_, failure) = await repository.registerDeviceToken(payload);
      if (failure == null) {
        await prefs.setString(_lastTokenPrefKey, token);
        logger.info('Device FCM token successfully registered with backend.');
      } else {
        logger.warning(
          'Failed to register FCM device token: ${failure.message}',
        );
      }
    } on Object catch (e, st) {
      logger.warning(
        'Exception during FCM device registration: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Unregisters the device FCM token on logout (`DELETE /api/v1/notifications/devices/{device_id}`).
  Future<void> unregisterDeviceToken() async {
    try {
      final deviceId = getDeviceId();
      final failure = await repository.unregisterDeviceToken(deviceId);
      if (failure == null) {
        await prefs.remove(_lastTokenPrefKey);
        logger.info('Device FCM token unregistered from backend.');
      } else {
        logger.warning('Failed to unregister FCM token: ${failure.message}');
      }
    } on Object catch (e) {
      logger.warning('Exception during FCM device unregistration: $e');
    }
  }

  /// Shows foreground notifications via flutter_local_notifications.
  Future<void> _showForegroundNotification(RemoteMessage message) async {
    try {
      final title =
          message.notification?.title ??
          message.data['title'] as String? ??
          'Right Ads';
      final body =
          message.notification?.body ?? message.data['body'] as String? ?? '';

      final type = message.data['type'] as String?;
      final channel = NotificationChannelConfig.resolve(type);

      final androidDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: channel.importance,
        priority: Priority.high,
        playSound: channel.playSound,
        enableVibration: channel.enableVibration,
      );

      const darwinDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final details = NotificationDetails(
        android: androidDetails,
        iOS: darwinDetails,
      );

      final payloadJson = jsonEncode(message.data);
      final id = message.hashCode & 0x7FFFFFFF;

      await _localNotifications.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: details,
        payload: payloadJson,
      );
    } on Object catch (e, st) {
      logger.warning(
        'Error displaying foreground notification: $e',
        error: e,
        stackTrace: st,
      );
    }
  }

  void _onLocalNotificationTapped(NotificationResponse response) {
    final payloadString = response.payload;
    if (payloadString == null || payloadString.isEmpty) {
      _handleIncomingPayload(null);
      return;
    }

    try {
      final data = jsonDecode(payloadString) as Map<String, dynamic>;
      _handleIncomingPayload(data);
    } on Object catch (_) {
      _handleIncomingPayload(null);
    }
  }

  void _handleIncomingPayload(Map<String, dynamic>? data) {
    final link = NotificationPayloadParser.parse(data);
    if (onNavigate != null) {
      onNavigate!(link.targetPath);
    } else {
      logger.info('Notification tapped: target route is ${link.targetPath}');
    }
  }

  Future<void> dispose() async {
    await _tokenRefreshSub?.cancel();
    await _foregroundSub?.cancel();
    await _openedAppSub?.cancel();
  }
}

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) {
  final repo = ref.watch(communicationRepositoryProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  final logger = ref.watch(appLoggerProvider);

  final service = NotificationService(
    repository: repo,
    prefs: prefs,
    logger: logger,
    onNavigate: (route) {
      final router = ref.read(appRouterProvider);
      unawaited(router.push(route));
    },
  );

  // Initialize notifications with live unread count hook
  unawaited(
    service.initialize(
      onNotificationReceived: () {
        unawaited(
          ref
              .read(unreadNotificationCountControllerProvider.notifier)
              .loadCount(),
        );
        unawaited(
          ref.read(notificationsListControllerProvider.notifier).loadInitial(),
        );
      },
    ),
  );

  ref.onDispose(() => unawaited(service.dispose()));
  return service;
}
