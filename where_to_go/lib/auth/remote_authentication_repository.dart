import "package:dio/dio.dart";

class RemoteAuthenticationRepository {
  final Dio _dio;

  RemoteAuthenticationRepository({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: "https://backend-api.w.solvro.pl/",
              connectTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5),
            ));

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>("auth/login", data: {
        "email": email,
        "password": password,
      });

      if (response.data != null) {
        final accessToken = response.data!["accessToken"];
        final refreshToken = response.data!["refreshToken"];

        return {
          "accessToken": accessToken,
          "refreshToken": refreshToken,
        };
      } else {
        throw Exception("Login failed with status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Failed to login: ${e.message}");
    }
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>("auth/register", data: {
        "email": email,
        "password": password,
      });

      if (response.data != null) {
        final accessToken = response.data!["accessToken"];
        final refreshToken = response.data!["refreshToken"];

        return {
          "accessToken": accessToken,
          "refreshToken": refreshToken,
        };
      } else {
        throw Exception("Registration failed with status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Failed to register: ${e.message}");
    }
  }

  Future<Map<String, dynamic>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        "auth/refresh",
        data: {
          "refreshToken": refreshToken,
        },
      );

      if (response.data != null) {
        final newAccessToken = response.data!["accessToken"];
        return {
          "accessToken": newAccessToken,
        };
      } else {
        throw Exception("Token refresh failed with status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Failed to refresh token: ${e.message}");
    }
  }
}
