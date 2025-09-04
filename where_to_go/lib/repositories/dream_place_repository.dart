//lib/repositories/dream_place_repository.dart

import "dart:convert";

import "package:http/http.dart" as http;

import "../models/dream_place.dart";

class DreamPlaceRepository {
  final String apiUrl;

  DreamPlaceRepository({required this.apiUrl});

  // Dodaj nowe wymarzone miejsce do API
  Future<void> addDreamPlace(DreamPlace place) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": place.name,
        "description": place.description,
        "imageUrl": place.imageUrl,
        "isFavorite": place.isFavorite,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to add dream place");
    }
  }

  // Zaktualizuj istniejące wymarzone miejsce w API
  Future<void> updateDreamPlace(DreamPlace place, int id) async {
    final response = await http.put(
      Uri.parse("$apiUrl/$id"), // Zakładamy, że miejsce ma pole 'id' (dodaj je do modelu, jeśli go nie ma)
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": place.name,
        "description": place.description,
        "imageUrl": place.imageUrl,
        "isFavorite": place.isFavorite,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update dream place");
    }
  }

  // Usuwanie wymarzonego miejsca z API
  Future<void> deleteDreamPlace(int id) async {
    final response = await http.delete(Uri.parse("$apiUrl/$id"));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete dream place");
    }
  }

  // Pobierz wymarzone miejsce z API
  Future<List<DreamPlace>> fetchDreamPlaces(int id) async {
    final response = await http.get(Uri.parse("$apiUrl/$id"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((item) => DreamPlace.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Failed to load dream places");
    }
  }
}
