import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/network/api_endpoints.dart';
import 'package:right_ads/features/admin/data/admin_repository.dart';
import 'package:right_ads/features/admin/domain/admin_models.dart';

class _FakeDio extends Fake implements Dio {
  dynamic nextGetResponse;
  dynamic nextPostResponse;
  dynamic nextPatchResponse;

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
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
    return Response<T>(
      data: nextPostResponse as T,
      statusCode: 201,
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
  late AdminRepository repository;

  setUp(() {
    fakeDio = _FakeDio();
    repository = AdminRepository(fakeDio);
  });

  group('AdminRepository', () {
    test('getEmployees returns parsed list of EmployeeItem', () async {
      fakeDio.nextGetResponse = <dynamic>[
        <String, dynamic>{
          'id': 'e1',
          'employee_code': 'RA01',
          'email': 'a@b.com',
          'full_name': 'Alice',
          'is_active': true,
          'must_change_password': false,
          'role_id': 'r1',
          'created_at': '2026-01-01',
        },
      ];

      final list = await repository.getEmployees();
      expect(list.length, 1);
      expect(list.first.fullName, 'Alice');
      expect(list.first.employeeCode, 'RA01');
    });

    test('createEmployee calls POST /employees and parses response', () async {
      const payload = EmployeeCreatePayload(
        email: 'b@b.com',
        fullName: 'Bob',
        roleId: 'r2',
      );

      fakeDio.nextPostResponse = <String, dynamic>{
        'id': 'e2',
        'employee_code': 'RA02',
        'email': 'b@b.com',
        'full_name': 'Bob',
        'is_active': true,
        'must_change_password': true,
        'role_id': 'r2',
        'created_at': '2026-01-01',
      };

      final created = await repository.createEmployee(payload);
      expect(created.id, 'e2');
      expect(created.mustChangePassword, true);
    });

    test('getMasterDataList returns generic catalog list', () async {
      fakeDio.nextGetResponse = <dynamic>[
        <String, dynamic>{
          'id': 'd1',
          'name': 'Tech',
          'description': 'Tech Dept',
        },
      ];

      final list = await repository.getMasterDataList('/departments');
      expect(list.length, 1);
      expect(list.first.name, 'Tech');
    });
  });
}
