import "package:dio/dio.dart";
import "package:flutter/foundation.dart";

abstract class RemoteAuthenticationRepository {
  Future<(String, String)> logIn(String email, String password);
  Future<(String, String)> signIn(String email, String password);
  Future<String?> refreshToken(String refreshToken);
}

class RemoteAuthenticationRepositoryImpl implements RemoteAuthenticationRepository {
  final dio = Dio(BaseOptions(baseUrl: "https://backend-api.w.solvro.pl/"));
  @override
  Future<(String, String)> logIn(String email, String password) async {
    final response = await dio.post<Map<String, dynamic>>("/auth/login", data: {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      final data = response.data;
      if (data != null) {
        final accessToken = data["accessToken"] as String;
        final refreshToken = data["refreshToken"] as String;
        return (accessToken, refreshToken);
      }
    }
    throw Exception("Login failed");
  }

  @override
  Future<(String, String)> signIn(String email, String password) async {
    final response = await dio.post<Map<String, dynamic>>("/auth/register", data: {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      final data = response.data;
      if (data != null) {
        // backend may return different key names depending on endpoint/version
        final accessToken = (data["accessToken"] ?? data["access_token"]) as String?;
        final refreshToken = (data["refreshToken"] ?? data["refresh_token"]) as String?;
        if (accessToken != null && refreshToken != null) {
          return (accessToken, refreshToken);
        }
      }
    }
    throw Exception("Sign in failed");
  }

  @override
  Future<String?> refreshToken(String refreshToken) async {
    try {
      final resp = await dio.post<Map<String, dynamic>>("/auth/refresh", data: {"refreshToken": refreshToken});
      if (resp.data != null) {
        final data = resp.data!;
        final access = (data["accessToken"] ?? data["access_token"]) as String?;
        return access;
      } else {
        return null;
      }
    } on Object catch (e) {
      // keep logging for debugging; consider using a logger instead of debugPrint
      debugPrint("Error during token refresh: $e");
      return null;
    }
  }
}
