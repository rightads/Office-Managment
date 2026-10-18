import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';

@freezed
sealed class AppFailure with _$AppFailure {
  const factory AppFailure.network({String? message}) = NetworkFailure;
  const factory AppFailure.unauthorized({String? message}) =
      UnauthorizedFailure;
  const factory AppFailure.forbidden({String? message}) = ForbiddenFailure;
  const factory AppFailure.validation({
    String? message,
    @Default(<String, List<String>>{}) Map<String, List<String>> fieldErrors,
  }) = ValidationFailure;
  const factory AppFailure.notFound({String? message}) = NotFoundFailure;
  const factory AppFailure.conflict({String? message}) = ConflictFailure;
  const factory AppFailure.server({String? message, int? statusCode}) =
      ServerFailure;
  const factory AppFailure.unknown({String? message, Object? cause}) =
      UnknownFailure;
}
