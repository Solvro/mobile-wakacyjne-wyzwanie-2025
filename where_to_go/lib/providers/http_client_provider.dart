//lib/providers/http_client_provider.dart
import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../providers/auth_providers.dart";

final authenticationRepositoryProvider = Provider<Dio>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  final dio = Dio(BaseOptions(
    baseUrl: "https://backend-api.w.solvro.pl/",
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  ));

  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    final token = authRepo.tokens?.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }

    return handler.next(options);
  }, onError: (DioException error, ErrorInterceptorHandler handler) async {
    // Sprawdź, czy błąd jest związany z autoryzacją (np. 401 Unauthorized)
    if (error.response?.statusCode == 401) {
      try {
        // Spróbuj odświeżyć token
        await authRepo.refreshToken();

        // Pobierz nowy token
        final newToken = await dio.fetch<dynamic>(error.requestOptions);
        return handler.resolve(newToken);
      } on DioException catch (e) {
        // Jeśli odświeżenie tokena się nie powiodło, wyloguj użytkownika oraz powiedz o błędzie
        await authRepo.logout();
        return handler.reject(e);
      }
    }
    // Przekaż błąd dalej, jeśli nie jest to błąd autoryzacji lub odświeżenie tokena się nie powiodło
    return handler.next(error);
  }));

  return dio;
});
