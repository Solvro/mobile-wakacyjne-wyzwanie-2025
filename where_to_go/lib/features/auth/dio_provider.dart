import "package:dio/dio.dart";
import "package:riverpod/riverpod.dart";

import "authentication_repository.dart";
import "authentication_repository_provider.dart";

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: "https://backend-api.w.solvro.pl/",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      try {
        final AuthenticationRepository authRepo = ref.read(authenticationRepositoryProvider);
        final tokens = await authRepo.readTokens();
        final accessToken = tokens.$1;
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $accessToken";
        }
      } catch (e) {
        throw Exception("Error occurred while adding auth token: $e");
      }
      return handler.next(options);
    },
    onError: (err, handler) {
      // Add any error interceptors here
      return handler.next(err);
    },
  ));

  return dio;
});
