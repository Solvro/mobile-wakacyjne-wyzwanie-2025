import "package:riverpod_annotation/riverpod_annotation.dart";
import "repository/implementation/authentication_repository_impl.dart";

part "auth_notifier.g.dart";

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<String?> build() {
    final repository = ref.read(authenticationRepositoryProvider);
    return repository.getToken();
  }

  Future<void> login(String email, String password) async {
    final repository = ref.read(authenticationRepositoryProvider);
    await repository.login(email: email, password: password);
    state = AsyncData(await repository.getToken());
  }

  Future<void> logout() async {
    final repository = ref.read(authenticationRepositoryProvider);
    await repository.logout();
    state = AsyncData(await repository.getToken());
  }
}
