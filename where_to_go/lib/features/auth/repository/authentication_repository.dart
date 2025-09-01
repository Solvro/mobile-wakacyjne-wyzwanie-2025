abstract class AuthenticationRepository {
  Future<String> login({required String email, required String password});
  Future<String> register({required String email, required String password});
  Future<void> logout();
  Future<String?> getToken();
  Future<String?> refreshToken();
  Future<bool> isSignedIn();
}
