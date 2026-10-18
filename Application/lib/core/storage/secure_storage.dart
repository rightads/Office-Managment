import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:right_ads/core/constants/storage_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage.g.dart';

class SecureStorageService {
  const SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  Future<String?> readAccessToken() async {
    try {
      return await _storage.read(key: StorageKeys.accessToken);
    } on MissingPluginException {
      return null;
    }
  }

  Future<void> writeAccessToken(String token) async {
    try {
      await _storage.write(key: StorageKeys.accessToken, value: token);
    } on MissingPluginException {
      // No-op in headless widget tests without platform channels.
    }
  }

  Future<String?> readRefreshToken() async {
    try {
      return await _storage.read(key: StorageKeys.refreshToken);
    } on MissingPluginException {
      return null;
    }
  }

  Future<void> writeRefreshToken(String token) async {
    try {
      await _storage.write(key: StorageKeys.refreshToken, value: token);
    } on MissingPluginException {
      // No-op in headless widget tests without platform channels.
    }
  }

  Future<void> clearTokens() async {
    try {
      await _storage.delete(key: StorageKeys.accessToken);
      await _storage.delete(key: StorageKeys.refreshToken);
    } on MissingPluginException {
      // No-op in headless widget tests without platform channels.
    }
  }

  Future<String?> readDeviceId() async {
    try {
      return await _storage.read(key: StorageKeys.deviceId);
    } on MissingPluginException {
      return null;
    }
  }

  Future<void> writeDeviceId(String deviceId) async {
    try {
      await _storage.write(key: StorageKeys.deviceId, value: deviceId);
    } on MissingPluginException {
      // No-op in headless widget tests without platform channels.
    }
  }
}

@Riverpod(keepAlive: true)
FlutterSecureStorage flutterSecureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(Ref ref) {
  return SecureStorageService(ref.watch(flutterSecureStorageProvider));
}
