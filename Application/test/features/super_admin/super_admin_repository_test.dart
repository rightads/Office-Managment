import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/features/super_admin/data/super_admin_repository.dart';

class _FakeDio extends Fake implements Dio {
  dynamic nextGetResponse;
  dynamic nextPostResponse;
  dynamic nextPatchResponse;

  String? lastGetPath;
  String? lastPostPath;
  Map<String, dynamic>? lastPostData;
  Map<String, dynamic>? lastGetQueryParams;

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    lastGetPath = path;
    lastGetQueryParams = queryParameters;
    return Response<T>(
      data: nextGetResponse as T,
      statusCode: 200,
      requestOptions: RequestOptions(path: path),
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    lastPostPath = path;
    lastPostData = data as Map<String, dynamic>?;
    return Response<T>(
      data: nextPostResponse as T,
      statusCode: 200,
      requestOptions: RequestOptions(path: path),
    );
  }

  @override
  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return Response<T>(
      data: nextPatchResponse as T,
      statusCode: 200,
      requestOptions: RequestOptions(path: path),
    );
  }
}

void main() {
  late _FakeDio fakeDio;
  late SuperAdminRepository repository;

  setUp(() {
    fakeDio = _FakeDio();
    repository = SuperAdminRepository(fakeDio);
  });

  group('SuperAdminRepository Tests', () {
    test('getRoles calls correct endpoint and returns parsed roles', () async {
      fakeDio.nextGetResponse = [
        {
          'id': 'role_1',
          'name': 'Admin',
          'description': 'Admin role',
          'is_system': true,
          'user_count': 5,
          'permissions': [
            {
              'id': 'perm_1',
              'code': 'users.manage_roles',
              'description': 'Manage roles',
            },
          ],
        },
      ];

      final roles = await repository.getRoles();
      expect(roles.length, 1);
      expect(roles.first.name, 'Admin');
      expect(roles.first.isSystem, isTrue);
      expect(fakeDio.lastGetPath, ApiEndpoints.roles);
    });

    test(
      'getPermissions calls permissions endpoint and returns list',
      () async {
        fakeDio.nextGetResponse = [
          {
            'id': 'perm_1',
            'code': 'users.manage_roles',
            'description': 'Manage roles',
          },
        ];

        final perms = await repository.getPermissions();
        expect(perms.length, 1);
        expect(perms.first.code, 'users.manage_roles');
        expect(fakeDio.lastGetPath, ApiEndpoints.permissions);
      },
    );

    test('getSystemSettings parses and returns list', () async {
      fakeDio.nextGetResponse = [
        {
          'key': 'app.allow_registration',
          'value': 'false',
          'description': 'Registration setting',
        },
      ];

      final settings = await repository.getSystemSettings();
      expect(settings.length, 1);
      expect(settings.first.key, 'app.allow_registration');
      expect(fakeDio.lastGetPath, ApiEndpoints.systemSettings);
    });

    test('updateSystemSetting posts payload to systemSettings', () async {
      fakeDio.nextPostResponse = {'status': 'success'};

      await repository.updateSystemSetting('app.allow_registration', 'true');

      expect(fakeDio.lastPostPath, ApiEndpoints.systemSettings);
      expect(fakeDio.lastPostData?['key'], 'app.allow_registration');
      expect(fakeDio.lastPostData?['value'], 'true');
    });

    test(
      'getAuditLogs sends query params and returns parsed response',
      () async {
        fakeDio.nextGetResponse = {
          'items': [
            {
              'id': 'log_100',
              'actor_id': 'admin-1',
              'action': 'UPDATE',
              'entity_type': 'role',
              'entity_id': '1',
              'created_at': '2026-10-22T00:00:00Z',
            },
          ],
          'total': 1,
          'page': 1,
          'size': 50,
        };

        final result = await repository.getAuditLogs(
          action: 'UPDATE',
          size: 50,
        );
        expect(result.items.length, 1);
        expect(result.items.first.action, 'UPDATE');
        expect(fakeDio.lastGetPath, ApiEndpoints.auditLogs);
        expect(fakeDio.lastGetQueryParams?['action'], 'UPDATE');
        expect(fakeDio.lastGetQueryParams?['size'], 50);
      },
    );
  });
}
