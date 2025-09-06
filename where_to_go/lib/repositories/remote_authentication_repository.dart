import "../models/auth_response.dart";
import "../models/me_dto.dart";

abstract class RemoteAuthenticationRepository {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(String email, String password);
  Future<AuthResponse> refreshToken(String refresToken);
  Future<MeDto> getMe();
}
