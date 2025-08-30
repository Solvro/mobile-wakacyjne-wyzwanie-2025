import "package:dio/dio.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:retrofit/retrofit.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../data/models/refresh_request.dart";
import "../../data/models/refresh_response.dart";
import "../../data/models/tokens.dart";
import "../../data/models/user_data.dart";

part "retrofit_client.g.dart";

@RestApi(baseUrl: "https://backend-api.w.solvro.pl")
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST("/auth/login")
  Future<Tokens> login(@Body() UserData user);

  @POST("/auth/register")
  Future<Tokens> register(@Body() UserData user);

  @POST("/auth/refresh")
  Future<RefreshResponse> refresh(@Body() RefreshRequest token);
}

@riverpod
RestClient client(Ref ref, {String? token}) {
  final dio = Dio();
  dio.options.headers["Authorization"] = (token != null) ? "Bearer $token" : null;
  return RestClient(dio);
}
