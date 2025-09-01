import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "../../../features/auth/repository/local_authentication_repository.dart";

class LocalAuthenticationRepositoryImpl implements LocalAuthenticationRepository {
  static const _accessTokenKey = "access_token";
  static const _refreshTokenKey = "refresh_token";

  final FlutterSecureStorage _storage;

  LocalAuthenticationRepositoryImpl(this._storage);

  @override
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  @override
  Future<(String?, String?)> readTokens() async {
    final accessToken = await _storage.read(key: _accessTokenKey);
    final refreshToken = await _storage.read(key: _refreshTokenKey);
    return (accessToken, refreshToken);
  }

  @override
  Future<void> removeTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
