// ignore_for_file: constant_identifier_names
enum AppEnvironment {
  DEV(
    env: 'dev',
    appTitle: 'App Dev',
    apiBaseUrl: 'https://q.agency',
    assetBaseUrl: 'ASSET_BASE_DEV',
  ),
  PROD(
    env: 'prod',
    appTitle: 'App Prod',
    apiBaseUrl: 'https://q.agency',
    assetBaseUrl: 'ASSET_BASE_PROD',
  ),
  STAGING(
    env: 'staging',
    appTitle: 'App Staging',
    apiBaseUrl: 'https://q.agency',
    assetBaseUrl: 'ASSET_BASE_STAGING',
  );

  final String env;
  final String appTitle;
  final String apiBaseUrl;
  final String assetBaseUrl;

  const AppEnvironment({
    required this.env,
    required this.appTitle,
    required this.apiBaseUrl,
    required this.assetBaseUrl,
  });
}

abstract class EnvInfo {
  static AppEnvironment _environment = AppEnvironment.DEV;

  static void initialize(AppEnvironment environment) {
    EnvInfo._environment = environment;
  }

  static String get envName => _environment.env;

  static String get appTitle => _environment.appTitle;

  static String get assetBaseUrl => _environment.assetBaseUrl;

  static String get apiBaseUrl => _environment.apiBaseUrl;

  static AppEnvironment get environment => _environment;

  static bool get isProduction => _environment == AppEnvironment.PROD;
}
