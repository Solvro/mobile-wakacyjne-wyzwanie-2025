import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../app/persistance/repository/local_authentication_repository_impl.dart";
import "../../../../app/remote/repository/remote_authentication_repository_impl.dart";
import "../../../../app/remote/retrofit_client.dart";
import "../authentication_repository.dart";
import "../local_authentication_repository.dart";
import "../remote_authentication_repository.dart";

part "authentication_repository_impl.g.dart";

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final LocalAuthenticationRepository localAuth;
  final RemoteAuthenticationRepository remoteAuth;

  const AuthenticationRepositoryImpl({required this.localAuth, required this.remoteAuth});

  @override
  Future<String> login({required String email, required String password}) async {
    final (accessToken, refreshToken) = await remoteAuth.login(email: email, password: password);
    await localAuth.saveTokens(accessToken: accessToken, refreshToken: refreshToken);
    return accessToken;
  }

  @override
  Future<String> register({required String email, required String password}) async {
    final (accessToken, refreshToken) = await remoteAuth.register(email: email, password: password);
    await localAuth.saveTokens(accessToken: accessToken, refreshToken: refreshToken);
    return accessToken;
  }

  @override
  Future<void> logout() async {
    await localAuth.removeTokens();
  }

  @override
  Future<String?> getToken() async {
    final (accessToken, _) = await localAuth.readTokens();
    return accessToken;
  }

  @override
  Future<String?> refreshToken() async {
    final (_, refreshToken) = await localAuth.readTokens();
    if (refreshToken == null) return null;
    final newToken = await remoteAuth.refreshAccessToken(refreshToken: refreshToken);
    await localAuth.saveTokens(accessToken: newToken, refreshToken: refreshToken);
    return newToken;
  }

  @override
  Future<bool> isSignedIn() async {
    final (accessToken, refreshToken) = await localAuth.readTokens();
    return accessToken != null && refreshToken != null;
  }
}

@riverpod
AuthenticationRepository authenticationRepository(Ref ref) {
  return AuthenticationRepositoryImpl(
      localAuth: LocalAuthenticationRepositoryImpl(const FlutterSecureStorage()),
      remoteAuth: RemoteAuthenticationRepositoryImpl(ref.watch(clientProvider())));
}
