import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "auth_repository.dart";

const apiBaseUrl = "https://backend-api.w.solvro.pl";

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final apiClientProvider = Provider<Dio>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final client = Dio(BaseOptions(baseUrl: apiBaseUrl));

  client.interceptors
      .add(LogInterceptor(requestBody: true, responseBody: true));
  client.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await storage.read(
          key: AuthenticationRepository.accessTokenKey,
        );
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $accessToken";
        }
        handler.next(options);
      },
    ),
  );
  return client;
});

final authenticationRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) => AuthenticationRepository(
    ref.watch(apiClientProvider),
    ref.watch(secureStorageProvider),
  ),
);

class AuthNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() {
    return ref.read(authenticationRepositoryProvider).isLoggedIn();
  }

  Future<void> login({required String identifier, required String password}) {
    return _run(() => ref.read(authenticationRepositoryProvider).login(
          identifier: identifier,
          password: password,
        ));
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) {
    return _run(() => ref.read(authenticationRepositoryProvider).register(
          email: email,
          username: username,
          password: password,
        ));
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authenticationRepositoryProvider).logout();
      return false;
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await action();
      return true;
    });
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, bool>(
  AuthNotifier.new,
);
