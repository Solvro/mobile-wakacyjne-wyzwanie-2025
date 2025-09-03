import "local_authentication_repository.dart";
import "remote_authentication_repository.dart";

class AuthenticationRepository {
  final LocalAuthenticationRepository _localRepo;
  final RemoteAuthenticationRepository _remoteRepo;

  AuthenticationRepository({
    LocalAuthenticationRepository? localRepo,
    RemoteAuthenticationRepository? remoteRepo,
  })  : _localRepo = localRepo ?? LocalAuthenticationRepository(),
        _remoteRepo = remoteRepo ?? RemoteAuthenticationRepository();

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final remoteResult = await _remoteRepo.login(
        email: email,
        password: password,
      );
      await _localRepo.saveTokens(
        accessToken: remoteResult["accessToken"] as String,
        refreshToken: remoteResult["refreshToken"] as String,
      );
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    try {
      final remoteResult = await _remoteRepo.register(
        email: email,
        password: password,
      );
      await _localRepo.saveTokens(
        accessToken: remoteResult["accessToken"] as String,
        refreshToken: remoteResult["refreshToken"] as String,
      );
      return true;
    } on Exception {
      return false;
    }
  }

  Future<void> logout() async {
    await _localRepo.clearTokens();
  }

  Future<String?> getAccessToken() async {
    return _localRepo.getAccessToken();
  }

  Future<String?> getRefreshToken() async {
    return _localRepo.getRefreshToken();
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    return _remoteRepo.refreshToken(refreshToken: refreshToken);
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    return _localRepo.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<void> clearTokens() async {
    return _localRepo.clearTokens();
  }
}
