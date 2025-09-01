abstract class RemoteAuthenticationRepository {
  Future<(String, String)> login({required String email, required String password});
  Future<(String, String)> register({required String email, required String password});
  Future<String> refreshAccessToken({required String refreshToken});
}
