import "package:dio/dio.dart";

abstract class RemoteAuthenticationRepository {
  Future<void> logIn(String email, String password);
  Future<void> signIn(String email, String password);
  Future<void> refreshToken(String refreshToken);
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
    final response = await dio.post<Map<String, String>>("/auth/register", data: {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      final data = response.data;
      if (data != null && data.containsKey("access_token")) {
        final accessToken = data["access_token"]!;
        final refreshToken = data["refresh_token"]!;
        return (accessToken, refreshToken);
      }
    }
    throw Exception("Sign in failed");
  }

  @override
  Future<String?> refreshToken(String refreshToken) async {
    final response = await dio.post<Map<String, String>>("/auth/refresh", data: {"refreshToken": refreshToken});

    if (response.statusCode == 200) {
      return response.data?["accessToken"];
    } else {
      throw Exception("Token refresh failed");
    }
  }
}
