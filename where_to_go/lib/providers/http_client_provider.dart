import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../providers/auth_providers.dart";

final authenticationRepositoryProvider = Provider<Dio>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  final dio = Dio(BaseOptions(
    baseUrl: "https://backend-api.w.solvro.pl",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 20),
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final token = authRepo.tokens?.accessToken;
      if (token != null && token.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $token";
      }
      return handler.next(options);
    },
    onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        try {
          await authRepo.refreshToken();
          final newToken = await dio.fetch<dynamic>(error.requestOptions);
          return handler.resolve(newToken);
        } on DioException catch (e) {
          await authRepo.logout();
          return handler.reject(e);
        }
      }
      return handler.next(error);
    },
  ));

  return dio;
});
