abstract class AuthenticationRepository {
  Future<void> login({required String email, required String password});
  Future<void> register({required String email, required String password});
  Future<void> logout();
  Future<String?> getToken();
  Future<String?> refreshToken();
  Future<bool> isSignedIn();
}
