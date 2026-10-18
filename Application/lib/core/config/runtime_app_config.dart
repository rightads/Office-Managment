import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'runtime_app_config.freezed.dart';
part 'runtime_app_config.g.dart';

/// Non-secret runtime configuration populated by `GET /api/v1/app/config`
/// (in Prompt 04). Provides timezone, locale, currency, and pagination limits
/// to formatting helpers and list views.
@freezed
abstract class RuntimeAppConfig with _$RuntimeAppConfig {
  const factory RuntimeAppConfig({
    @Default('UTC') String timezone,
    @Default('en_IN') String localeCode,
    @Default('INR') String currencyCode,
    @Default(20) int defaultPageSize,
    @Default(100) int maxPageSize,
    @Default(10) int maxUploadMb,
  }) = _RuntimeAppConfig;
}

@Riverpod(keepAlive: true)
class RuntimeAppConfigController extends _$RuntimeAppConfigController {
  @override
  RuntimeAppConfig build() => const RuntimeAppConfig();

  // Riverpod notifier state updates use methods rather than property setters.
  // ignore: use_setters_to_change_properties
  void updateConfig(RuntimeAppConfig next) {
    state = next;
  }
}
