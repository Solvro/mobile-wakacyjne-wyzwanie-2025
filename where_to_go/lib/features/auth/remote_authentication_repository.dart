import "package:dio/dio.dart";

abstract class RemoteAuthenticationRepository {
  Future<(String, String)> logIn(String email, String password);
  Future<(String, String)> signIn(String email, String password);
  Future<dynamic> refreshToken(String refreshToken);
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
  Future<dynamic> refreshToken(String refreshToken) async {
    var response;
    try {
      final response = await dio.post("/auth/refresh", data: {"refreshToken": refreshToken});
      return response.data["accessToken"];
    } catch (e) {
      print("Response from refreshToken: $response");
      print("Error during token refresh: $e");
    }
  }
}
