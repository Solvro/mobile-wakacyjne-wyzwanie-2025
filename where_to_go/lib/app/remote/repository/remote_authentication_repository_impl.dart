import "../../../data/models/refresh_request.dart";
import "../../../data/models/user_data.dart";
import "../../../features/auth/repository/remote_authentication_repository.dart";
import "../retrofit_client.dart";

class RemoteAuthenticationRepositoryImpl implements RemoteAuthenticationRepository {
  final RestClient _client;

  RemoteAuthenticationRepositoryImpl(this._client);

  @override
  Future<(String, String)> login({required String email, required String password}) async {
    final response = await _client.login(UserData(email: email, password: password));
    return (response.accessToken, response.refreshToken);
  }

  @override
  Future<String> refreshAccessToken({required String refreshToken}) async {
    final response = await _client.refresh(RefreshRequest(refreshToken: refreshToken));
    return response.accessToken;
  }

  @override
  Future<(String, String)> register({required String email, required String password}) async {
    final response = await _client.register(UserData(email: email, password: password));
    return (response.accessToken, response.refreshToken);
  }
}
