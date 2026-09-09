import "package:dio/dio.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

class AuthenticationRepository {
  AuthenticationRepository(this._client, this._storage);

  static const accessTokenKey = "access_token";
  static const refreshTokenKey = "refresh_token";

  final Dio _client;
  final FlutterSecureStorage _storage;

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: accessTokenKey);
    return token != null && token.isNotEmpty;
  }

  Future<void> login({required String identifier, required String password}) {
    return _authenticate("/auth/login", {
      "email": identifier,
      "password": password,
    });
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    await _client.post<void>(
      "/auth/register",
      data: {
        "email": email,
        "username": username,
        "password": password,
      },
    );
    await login(identifier: email, password: password);
  }

  Future<void> logout() async {
    await _storage.delete(key: accessTokenKey);
    await _storage.delete(key: refreshTokenKey);
  }

  Future<void> _authenticate(String path, Map<String, dynamic> data) async {
    final response = await _client.post<Map<String, dynamic>>(path, data: data);
    final body = response.data ?? const <String, dynamic>{};
    final accessToken =
        body["accessToken"] ?? body["access_token"] ?? body["token"];

    if (accessToken is! String || accessToken.isEmpty) {
      throw const FormatException("API nie zwróciło tokenu dostępu.");
    }
    await _storage.write(key: accessTokenKey, value: accessToken);

    final refreshToken = body["refreshToken"] ?? body["refresh_token"];
    if (refreshToken is String && refreshToken.isNotEmpty) {
      await _storage.write(key: refreshTokenKey, value: refreshToken);
    }
  }
}
