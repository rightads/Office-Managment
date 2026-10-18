import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';

@freezed
sealed class AppFailure with _$AppFailure {
  const factory AppFailure.network({String? message}) = NetworkFailure;
  const factory AppFailure.unauthorized({
    String? message,
    String? errorCode,
    @Default(false) bool isTokenReuse,
  }) = UnauthorizedFailure;
  const factory AppFailure.forbidden({
    String? message,
    String? errorCode,
  }) = ForbiddenFailure;
  const factory AppFailure.validation({
    String? message,
    String? errorCode,
    @Default(<String, List<String>>{}) Map<String, List<String>> fieldErrors,
  }) = ValidationFailure;
  const factory AppFailure.notFound({
    String? message,
    String? errorCode,
  }) = NotFoundFailure;
  const factory AppFailure.conflict({
    String? message,
    String? errorCode,
  }) = ConflictFailure;
  const factory AppFailure.server({
    String? message,
    int? statusCode,
    String? errorCode,
  }) = ServerFailure;
  const factory AppFailure.unknown({
    String? message,
    Object? cause,
  }) = UnknownFailure;
}
