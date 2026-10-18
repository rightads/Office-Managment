enum AppEnvironment {
  dev('dev'),
  staging('staging'),
  prod('prod');

  const AppEnvironment(this.value);

  final String value;

  static AppEnvironment? tryParse(String raw) {
    final normalized = raw.trim().toLowerCase();
    for (final env in AppEnvironment.values) {
      if (env.value == normalized) {
        return env;
      }
    }
    return null;
  }
}
