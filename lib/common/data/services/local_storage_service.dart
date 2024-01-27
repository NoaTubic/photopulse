//ignore_for_file: unused_element
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oauth2/oauth2.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localStorageServiceProvider = Provider<LocalStorageService>(
  (_) => LocalStorageServiceImpl(
    const FlutterSecureStorage(),
    SharedPreferences.getInstance(),
  ),
);

abstract interface class LocalStorageService {
  Future<void> deleteAll();
  Future<void> writeOAuth2Credentials(Credentials credentials);
  Future<Credentials?> readOAuth2Credentials();
  Future<void> deleteOAuth2Credentials();
}

class LocalStorageServiceImpl implements LocalStorageService {
  final FlutterSecureStorage _secureStorage;
  final Future<SharedPreferences> _sharedPreferencesFuture;
  SharedPreferences? _sharedPreferencesInstance;

  LocalStorageServiceImpl(
    this._secureStorage,
    this._sharedPreferencesFuture,
  ) {
    _clearSecureStorageOnReinstall();
  }

  Future<SharedPreferences> get _sharedPrefs async {
    return _sharedPreferencesInstance ??= await _sharedPreferencesFuture;
  }

  @override
  Future<Credentials?> readOAuth2Credentials() async {
    final json = await _readSecure(LocalStorageKey.oauth2Credentials);
    if (json == null) {
      return null;
    }
    return Credentials.fromJson(json);
  }

  @override
  Future<void> writeOAuth2Credentials(Credentials credentials) async {
    await _writeSecure(
      key: LocalStorageKey.oauth2Credentials,
      value: credentials.toJson(),
    );
  }

  @override
  Future<void> deleteOAuth2Credentials() async {
    await _deleteSecure(LocalStorageKey.oauth2Credentials);
  }

  @override
  Future<void> deleteAll() async {
    await Future.wait([
      _deleteAllSharedPrefs(),
      _deleteAllSecure(),
    ]);
  }

  Future<T?> _read<T>(LocalStorageKey key) async =>
      (await _sharedPrefs).get(key.key) as T?;

  Future<String?> _readSecure(LocalStorageKey key) =>
      _secureStorage.read(key: key.key);

  Future<void> _write({
    required LocalStorageKey key,
    required String value,
  }) async {
    (await _sharedPrefs).setString(key.key, value);
  }

  Future<void> _writeSecure({
    required LocalStorageKey key,
    required String value,
  }) async {
    await _secureStorage.write(key: key.key, value: value);
  }

  Future<void> _delete(LocalStorageKey key) async =>
      (await _sharedPrefs).remove(key.key);

  Future<void> _deleteSecure(LocalStorageKey key) =>
      _secureStorage.delete(key: key.key);

  Future<void> _deleteAllSharedPrefs() async => (await _sharedPrefs).clear();

  Future<void> _deleteAllSecure() => _secureStorage.deleteAll();

  ///Necessary because of https://github.com/mogol/flutter_secure_storage/issues/88
  Future<void> _clearSecureStorageOnReinstall() async {
    const key = 'hasRunBefore';
    final sharedPreferences = await _sharedPrefs;
    if (sharedPreferences.getBool(key) != true) {
      await _deleteAllSecure();
      await sharedPreferences.setBool(key, true);
    }
  }
}

enum LocalStorageKey {
  token('token'),
  oauth2Credentials('oauth2Credentials');

  final String key;
  const LocalStorageKey(this.key);
}
