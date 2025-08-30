import "package:dio/dio.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:retrofit/retrofit.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../data/models/create_place.dart";
import "../../data/models/dream_place.dart";
import "../../data/models/paginated_dream_places.dart";
import "../../data/models/refresh_request.dart";
import "../../data/models/refresh_response.dart";
import "../../data/models/tokens.dart";
import "../../data/models/user_data.dart";
import "paths.dart";

part "retrofit_client.g.dart";

@RestApi(baseUrl: apiPath)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST("/auth/login")
  Future<Tokens> login(@Body() UserData user);

  @POST("/auth/register")
  Future<Tokens> register(@Body() UserData user);

  @POST("/auth/refresh")
  Future<RefreshResponse> refresh(@Body() RefreshRequest token);

  @GET("/places")
  Future<PaginatedDreamPlaces> getPlaces(@Query("sort") String sort, @Query("sortBy") String sortBy);

  @GET("/places/{id}")
  Future<DreamPlace> getPlace(@Path() int id);

  @DELETE("/places/{id}")
  Future<DreamPlace> deletePlace(@Path() int id);

  @PUT("/places/{id}")
  Future<DreamPlace> updatePlace(@Path() int id, @Body() CreatePlace place);

  @POST("/places")
  Future<DreamPlace> postPlace(@Body() CreatePlace place);
}

@riverpod
RestClient client(Ref ref, {String? token}) {
  final dio = Dio();
  dio.options.headers["Authorization"] = (token != null) ? "Bearer $token" : null;

  return RestClient(dio);
}
