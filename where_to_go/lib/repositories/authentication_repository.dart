//authentication_repository.dart
import "local_authentication_repository.dart";
import "remote_authentication_repository.dart";

class AuthenticationRepository {
  final LocalAuthenticationRepository _localAuthenticationRepository;
  final RemoteAuthenticationRepository _remoteAuthenticationRepository;
  Map<String, dynamic> tokens;

  AuthenticationRepository(
    this.tokens, {
    required LocalAuthenticationRepository localAuthenticationRepository,
    required RemoteAuthenticationRepository remoteAuthenticationRepository,
  })  : _localAuthenticationRepository = localAuthenticationRepository,
        _remoteAuthenticationRepository = remoteAuthenticationRepository;

  Future<Map<String, dynamic>?> isLogged() async {
    tokens = _localAuthenticationRepository.getTokens() as Map<String, dynamic>;
    if (tokens.isEmpty) {
      return null;
    } else {
      return tokens;
    }
  }

  Future<void> logIn(String email, String password) async {
    final response = await _remoteAuthenticationRepository.login(email: email, password: password);
    if (response != null) {
      tokens = response.toJson();
    }
  }

  Future<void> register(String email, String password) async {
    final response = await _remoteAuthenticationRepository.register(email: email, password: password);
    if (response != null) {
      tokens = response.toJson();
    }
  }

  Future<void> logOut() async {
    await _localAuthenticationRepository.deleteTokens();
  }
}
