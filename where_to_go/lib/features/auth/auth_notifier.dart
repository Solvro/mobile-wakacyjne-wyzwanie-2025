import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../app/remote/repository/user_repository_impl.dart";
import "repository/implementation/authentication_repository_impl.dart";

part "auth_notifier.g.dart";

class AuthState {
  final bool isAuthed;
  final String? token;

  const AuthState({
    required this.isAuthed,
    this.token,
  });

  AuthState copyWith({
    bool? isAuthed,
    String? token,
  }) {
    return AuthState(
      isAuthed: isAuthed ?? this.isAuthed,
      token: token ?? this.token,
    );
  }
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthState> build() async {
    final token = await ref.read(authenticationRepositoryProvider).getToken();
    return AuthState(
      isAuthed: token != null,
      token: token,
    );
  }

  Future<String?> getToken() => ref.read(authenticationRepositoryProvider).getToken();

  Future<void> login(String email, String password) async {
    final repository = ref.read(authenticationRepositoryProvider);
    final token = await repository.login(email: email, password: password);
    state = AsyncData(AuthState(isAuthed: true, token: token));
  }

  Future<void> register(String email, String password) async {
    final repository = ref.read(authenticationRepositoryProvider);
    final token = await repository.register(email: email, password: password);
    state = AsyncData(AuthState(isAuthed: true, token: token));
  }

  Future<void> logout() async {
    final repository = ref.read(authenticationRepositoryProvider);
    await repository.logout();
    state = const AsyncData(AuthState(isAuthed: false));
  }

  Future<void> attemptRefreshToken() async {
    final repository = ref.read(authenticationRepositoryProvider);
    final newToken = await repository.refreshToken();
    final current = await future;
    state = AsyncData(current.copyWith(token: newToken, isAuthed: true));
  }

  Future<String> getUserEmail() async {
    final repository = await ref.read(userRepositoryProvider.future);
    return repository.getUserEmail();
  }
}
