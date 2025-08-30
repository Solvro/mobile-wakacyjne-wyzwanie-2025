import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../app/remote/retrofit_client.dart";
import "../authentication_repository.dart";
import "../local_authentication_repository.dart";
import "../remote_authentication_repository.dart";
import "local_authentication_repository_impl.dart";
import "remote_authentication_repository_impl.dart";

part "authentication_repository_impl.g.dart";

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final LocalAuthenticationRepository localAuth;
  final RemoteAuthenticationRepository remoteAuth;

  const AuthenticationRepositoryImpl({required this.localAuth, required this.remoteAuth});

  @override
  Future<void> login({required String email, required String password}) async {
    final (accessToken, refreshToken) = await remoteAuth.login(email: email, password: password);
    await localAuth.saveTokens(accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  Future<void> register({required String email, required String password}) async {
    final (accessToken, refreshToken) = await remoteAuth.register(email: email, password: password);
    await localAuth.saveTokens(accessToken: accessToken, refreshToken: refreshToken);
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
    return remoteAuth.refreshAccessToken(refreshToken: refreshToken);
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
