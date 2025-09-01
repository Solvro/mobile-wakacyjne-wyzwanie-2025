import "./local_authentication_repository.dart";
import "./remote_authentication_repository.dart";

abstract class AuthenticationRepository {
  Future<(String?, String?)> readTokens();
  Future<void> saveTokens(String accessToken, String refreshToken);
  Future<(String, String)> logIn(String email, String password);
  Future<(String, String)> signIn(String email, String password);
  Future<void> deleteTokens();
  Future<dynamic> refreshToken(String refreshToken);
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final _remote = RemoteAuthenticationRepositoryImpl();
  final _local = LocalAuthenticationRepositoryImpl();

  @override
  Future<(String?, String?)> readTokens() => _local.readTokens();

  @override
  Future<(String, String)> logIn(String email, String password) => _remote.logIn(email, password);

  @override
  Future<(String, String)> signIn(String email, String password) => _remote.signIn(email, password);

  @override
  Future<void> deleteTokens() => _local.deleteTokens();

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) => _local.saveTokens(accessToken, refreshToken);

  @override
  Future<dynamic> refreshToken(String refreshToken) => _remote.refreshToken(refreshToken);
}
