import "../models/authentication_tokens.dart";
import "local_authentication_repository.dart";
import "remote_authentication_repository.dart";

class AuthenticationRepository {
  final LocalAuthenticationRepository _localAuthenticationRepository;
  final RemoteAuthenticationRepository _remoteAuthenticationRepository;
  AuthenticationTokens? _tokens;

  AuthenticationRepository({
    required LocalAuthenticationRepository localAuthenticationRepository,
    required RemoteAuthenticationRepository remoteAuthenticationRepository,
  })  : _localAuthenticationRepository = localAuthenticationRepository,
        _remoteAuthenticationRepository = remoteAuthenticationRepository;

  Future<void> initialize() async {
    _tokens = await _localAuthenticationRepository.getTokens();
  }

  Future<bool> get isLoggedIn => _localAuthenticationRepository.isUserLoggedIn();

  AuthenticationTokens? get tokens => _tokens;

  Future<AuthenticationTokens?> login(String email, String password) async {
    final response = await _remoteAuthenticationRepository.login(email: email, password: password);

    if (response != null) {
      _tokens = response;
      return response;
    }
    return null;
  }

  Future<AuthenticationTokens?> register(String email, String password) async {
    final response = await _remoteAuthenticationRepository.register(email: email, password: password);

    if (response != null) {
      _tokens = response;
      return response;
    }
    return null;
  }

  Future<void> logout() async {
    await _localAuthenticationRepository.deleteTokens();
    _tokens = null;
  }

  Future<AuthenticationTokens?> refreshToken() async {
    final refreshed = await _remoteAuthenticationRepository.refreshToken();
    if (refreshed != null) {
      _tokens = refreshed;
    }
    return refreshed;
  }
}
