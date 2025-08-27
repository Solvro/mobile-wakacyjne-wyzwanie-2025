import "package:drift/drift.dart";

// I know that this has imports from different modules, but this is just for development
import "../../../../data/places.dart";
import "../../../../repository/implementation/attraction_converter_helper.dart";
import "../drift_database.dart";

extension Seeder on AppDatabase {
  Future<void> seedIfEmpty() async {
    final existingPlaces = await select(dreamPlaces).get();
    if (existingPlaces.isNotEmpty) return;
    await transaction(() async {
      for (final place in dreamPlacesList) {
        final companion = DreamPlacesCompanion.insert(
          name: place.title,
          description: place.description,
          location: place.location,
          imageUrl: place.imagePath,
          isFavorited: Value(place.isFavorited),
        );

        final attractionValues = place.attractions.map(valueFromAttraction).toList();

        await insertDreamPlaceWithAttractions(
          placeCompanion: companion,
          attractionsList: attractionValues,
        );
      }
    });
  }
}
