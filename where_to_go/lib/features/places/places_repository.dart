import 'package:dio/dio.dart';
import 'place_model.dart';

class DreamPlacesRepository {
  final Dio _client;

  DreamPlacesRepository(this._client);

  Future<List<DreamPlace>> getPlaces() async {
    final response = await _client.get('/places');
    final data = response.data as Map<String, dynamic>;
    final list = (data['results'] ?? []) as List;

    return list
        .map((json) => DreamPlace.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> addPlace(DreamPlace place, String token) async {
    await _client.post(
      '/places',
      data: place.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<void> toggleFavorite(int id, bool currentStatus) async {
    await _client.patch('/places/$id', data: {
      'isFavourite': !currentStatus,
    });
  }
}