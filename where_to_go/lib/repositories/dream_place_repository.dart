import "dart:convert";
import "package:http/http.dart" as http;

import "../models/dream_place.dart";

class DreamPlaceRepository {
  final String apiUrl;

  DreamPlaceRepository({required this.apiUrl});

  // Dodaj nowe wymarzone miejsce do API → zwróć obiekt z ID
  Future<DreamPlace> addDreamPlace(DreamPlace place) async {
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

    if (response.statusCode == 201) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return DreamPlace.fromJson(data);
    } else {
      throw Exception("Failed to add dream place");
    }
  }

  // Zaktualizuj istniejące wymarzone miejsce
  Future<void> updateDreamPlace(DreamPlace place) async {
    if (place.id == null) {
      throw Exception("Cannot update place without id");
    }

    final response = await http.put(
      Uri.parse("$apiUrl/${place.id}"),
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

  // Usuń wymarzone miejsce
  Future<void> deleteDreamPlace(int id) async {
    final response = await http.delete(Uri.parse("$apiUrl/$id"));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete dream place");
    }
  }

  // Pobierz wszystkie miejsca
  Future<List<DreamPlace>> fetchDreamPlaces() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((item) => DreamPlace.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Failed to load dream places");
    }
  }

  // Pobierz jedno miejsce po ID
  Future<DreamPlace> fetchDreamPlace(int id) async {
    final response = await http.get(Uri.parse("$apiUrl/$id"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return DreamPlace.fromJson(data);
    } else {
      throw Exception("Failed to load dream place with id $id");
    }
  }
}
