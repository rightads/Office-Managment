import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

class RequestIdInterceptor extends Interceptor {
  const RequestIdInterceptor({this._uuid = const Uuid()});

  static const String headerName = 'X-Request-ID';
  final Uuid _uuid;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.putIfAbsent(headerName, _uuid.v4);
    handler.next(options);
  }
}
