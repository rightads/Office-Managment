import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:right_ads/core/errors/app_failure.dart';
import 'package:right_ads/core/errors/error_mapper.dart';

DioException _responseException(int statusCode, Map<String, dynamic> data) {
  final requestOptions = RequestOptions(path: '/test');
  return DioException(
    requestOptions: requestOptions,
    type: DioExceptionType.badResponse,
    response: Response<Map<String, dynamic>>(
      requestOptions: requestOptions,
      statusCode: statusCode,
      data: data,
    ),
  );
}

void main() {
  group('ErrorMapper', () {
    test('maps connection timeout and connection error to NetworkFailure', () {
      final timeoutErr = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );
      expect(ErrorMapper.mapException(timeoutErr), isA<NetworkFailure>());
    });

    test('maps 401 StandardErrorResponse to UnauthorizedFailure', () {
      final err = _responseException(401, <String, dynamic>{
        'success': false,
        'error': <String, dynamic>{
          'code': 'UNAUTHORIZED',
          'message': 'Invalid email or password',
        },
      });
      final failure = ErrorMapper.mapException(err);
      expect(failure, isA<UnauthorizedFailure>());
      final unauth = failure as UnauthorizedFailure;
      expect(unauth.message, 'Invalid email or password');
      expect(unauth.isTokenReuse, isFalse);
    });

    test('detects refresh token reuse in 401 response', () {
      final err = _responseException(401, <String, dynamic>{
        'success': false,
        'error': <String, dynamic>{
          'code': 'UNAUTHORIZED',
          'message':
              'Revoked refresh token reuse detected. All active sessions have been terminated.',
        },
      });
      final failure = ErrorMapper.mapException(err);
      expect(failure, isA<UnauthorizedFailure>());
      expect((failure as UnauthorizedFailure).isTokenReuse, isTrue);
    });

    test(
      'maps 403, 404, 409, and 500 to corresponding AppFailure subtypes',
      () {
        final forbidden = ErrorMapper.mapException(
          _responseException(403, <String, dynamic>{
            'success': false,
            'error': <String, dynamic>{
              'code': 'FORBIDDEN',
              'message': 'Missing permission',
            },
          }),
        );
        expect(forbidden, isA<ForbiddenFailure>());
        expect(forbidden.message, 'Missing permission');

        final notFound = ErrorMapper.mapException(
          _responseException(404, <String, dynamic>{
            'success': false,
            'error': <String, dynamic>{
              'code': 'NOT_FOUND',
              'message': 'Resource not found',
            },
          }),
        );
        expect(notFound, isA<NotFoundFailure>());

        final conflict = ErrorMapper.mapException(
          _responseException(409, <String, dynamic>{
            'success': false,
            'error': <String, dynamic>{
              'code': 'CONFLICT',
              'message': 'Already checked in',
            },
          }),
        );
        expect(conflict, isA<ConflictFailure>());

        final server = ErrorMapper.mapException(
          _responseException(502, <String, dynamic>{
            'success': false,
            'error': <String, dynamic>{
              'code': 'BAD_GATEWAY',
              'message': 'Upstream error',
            },
          }),
        );
        expect(server, isA<ServerFailure>());
        expect((server as ServerFailure).statusCode, 502);
      },
    );

    test(
      'maps 422 HTTPValidationError and StandardErrorResponse details to fieldErrors',
      () {
        final fastApiValidation = ErrorMapper.mapException(
          _responseException(422, <String, dynamic>{
            'detail': <Map<String, dynamic>>[
              <String, dynamic>{
                'loc': <dynamic>['body', 'email'],
                'msg': 'value is not a valid email address',
                'type': 'value_error.email',
              },
              <String, dynamic>{
                'loc': <dynamic>['body', 'new_password'],
                'msg': 'String should have at least 6 characters',
                'type': 'string_too_short',
              },
            ],
          }),
        );
        expect(fastApiValidation, isA<ValidationFailure>());
        final validation = fastApiValidation as ValidationFailure;
        expect(
          validation.fieldErrors['email'],
          contains('value is not a valid email address'),
        );
        expect(
          validation.fieldErrors['new_password'],
          contains('String should have at least 6 characters'),
        );
      },
    );
  });
}
