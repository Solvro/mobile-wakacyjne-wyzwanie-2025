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

  // CREATE: Tworzenie nowego miejsca
  Future<void> createPlace(DreamPlace place) async {
    await _client.post('/places', data: place.toJson());
  }

  // UPDATE: Edycja istniejącego miejsca (nazwa, opis, imageUrl)
  Future<void> updatePlace(int id, DreamPlace place) async {
    await _client.put('/places/$id', data: place.toJson());
  }

  // DELETE: Usuwanie miejsca
  Future<void> deletePlace(int id) async {
    await _client.delete('/places/$id');
  }

  Future<void> toggleFavorite(int id, bool currentStatus) async {
    await _client.patch('/places/$id', data: {
      'isFavourite': !currentStatus,
    });
  }
}
