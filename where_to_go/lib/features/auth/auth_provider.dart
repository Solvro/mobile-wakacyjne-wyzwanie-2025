import "package:riverpod_annotation/riverpod_annotation.dart";

import "repository_providers.dart";

part "auth_provider.g.dart";

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<String?> build() async {
    final authRepository = await ref.watch(authenticationRepositoryProvider.future);
    final isLoggedIn = await authRepository.isLoggedIn();

    if (isLoggedIn) {
      return authRepository.getCurrentUser();
    }

    return null;
  }

  Future<void> login(String email, String password) async {
    try {
      final authRepository = await ref.read(authenticationRepositoryProvider.future);
      await authRepository.login(email, password);
      ref.invalidate(accessTokenProvider);
      state = AsyncValue.data(email);
    } on Exception catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> register(String email, String password) async {
    try {
      final authRepository = await ref.read(authenticationRepositoryProvider.future);
      await authRepository.register(email, password);
      ref.invalidate(accessTokenProvider);
      state = AsyncValue.data(email);
    } on Exception catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> logout() async {
    try {
      final authRepository = await ref.read(authenticationRepositoryProvider.future);
      await authRepository.logout();
      ref.invalidate(accessTokenProvider);
      state = const AsyncValue.data(null);
    } on Exception catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
