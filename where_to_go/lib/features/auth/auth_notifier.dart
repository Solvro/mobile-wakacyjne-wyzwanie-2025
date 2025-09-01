import "package:dio/dio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../app/remote/repository/user_repository_impl.dart";
import "repository/implementation/authentication_repository_impl.dart";

part "auth_notifier.g.dart";

enum AuthState {
  authed,
  unauthed,
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthState> build() async {
    final token = await ref.read(authenticationRepositoryProvider).getToken();
    return token == null ? AuthState.unauthed : AuthState.authed;
  }

  Future<String?> getToken() => ref.watch(authenticationRepositoryProvider).getToken();

  Future<bool> login(String email, String password) async {
    final repository = ref.read(authenticationRepositoryProvider);
    try {
      await repository.login(email: email, password: password);
      state = const AsyncData(AuthState.authed);
    } on DioException catch (e) {
      print(e.response);
      return false;
    }
    return true;
  }

  Future<bool> register(String email, String password) async {
    final repository = ref.read(authenticationRepositoryProvider);
    try {
      await repository.register(email: email, password: password);
      state = const AsyncData(AuthState.authed);
    } on DioException catch (e) {
      print(e.response);
      return false;
    }
    return true;
  }

  Future<void> logout() async {
    final repository = ref.read(authenticationRepositoryProvider);
    await repository.logout();
    state = const AsyncData(AuthState.unauthed);
  }

  Future<void> attemptRefreshToken() async {
    print("refreshing!");
    final repository = ref.read(authenticationRepositoryProvider);
    await repository.refreshToken();
  }

  Future<String> getUserEmail() async {
    print("Asking");
    final repository = await ref.read(userRepositoryProvider.future);
    return repository.getUserEmail();
  }
}
