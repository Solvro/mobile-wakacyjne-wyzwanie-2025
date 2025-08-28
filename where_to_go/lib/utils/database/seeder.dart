import "dream_places_database.dart";

extension Seeder on DreamPlacesDatabase {
  Future<void> seedDatabase() async {
    // Sprawdź czy baza jest już zaseedowana
    final existingPlaces = await select(dreamPlaceDb).get();
    if (existingPlaces.isNotEmpty) {
      // Baza już ma dane, nie seeduj ponownie
      return;
    }

    // Dane do zaseedowania
    final samplePlaces = [
      DreamPlaceDbCompanion.insert(
        name: "Guangzhou, Chiny",
        description: "Furtka państwa środka na świat",
        imageUrl: "assets/images/guangzhou-1.jpg",
      ),
      DreamPlaceDbCompanion.insert(
        name: "Saint-Tropez, Francja",
        description: "Śladami Żandarma",
        imageUrl: "assets/images/saint-tropez-1.jpg",
      ),
      DreamPlaceDbCompanion.insert(
        name: "Bamberg, Niemcy",
        description: "Poznaj historię pochodzenia Bambrów",
        imageUrl: "assets/images/bamberg-1.jpg",
      ),
      DreamPlaceDbCompanion.insert(
        name: "Fuzhou, Chiny",
        description: "Wypij najlepszą herbatę na świecie",
        imageUrl: "assets/images/fuzhou-1.jpg",
      ),
      DreamPlaceDbCompanion.insert(
        name: "Nowy Jork, USA",
        description: "Miasto, które nigdy nie śpi",
        imageUrl: "assets/images/new-york-1.jpg",
      ),
    ];

    final sampleAttractions = [
      AttractionDbCompanion.insert(
        name: "Ostre jedzenie",
        iconName: "local_fire_department",
      ),
      AttractionDbCompanion.insert(
        name: "Muzea",
        iconName: "museum",
      ),
      AttractionDbCompanion.insert(
        name: "Opera",
        iconName: "music_note",
      ),
      AttractionDbCompanion.insert(
        name: "Plaża",
        iconName: "beach_access",
      ),
      AttractionDbCompanion.insert(
        name: "Słońce",
        iconName: "sunny",
      ),
      AttractionDbCompanion.insert(
        name: "Widoki",
        iconName: "landscape",
      ),
      AttractionDbCompanion.insert(
        name: "Historia",
        iconName: "menu_book",
      ),
      AttractionDbCompanion.insert(
        name: "Szlaki",
        iconName: "nordic_walking",
      ),
      AttractionDbCompanion.insert(
        name: "Jedzenie",
        iconName: "food_bank",
      ),
      AttractionDbCompanion.insert(
        name: "Herbaciarnie",
        iconName: "coffee",
      ),
      AttractionDbCompanion.insert(
        name: "Dostęp do morza",
        iconName: "waves",
      ),
      AttractionDbCompanion.insert(
        name: "Wieżowce",
        iconName: "vertical_shades_closed",
      ),
      AttractionDbCompanion.insert(
        name: "Nocne życie",
        iconName: "nightlife",
      ),
    ];

    final placeMap = <String, int>{};
    final attractionMap = <String, int>{};

    for (final place in samplePlaces) {
      final id = await into(dreamPlaceDb).insert(place);
      placeMap[place.name.value] = id;
    }

    for (final attraction in sampleAttractions) {
      final id = await into(attractionDb).insert(attraction);
      attractionMap[attraction.name.value] = id;
    }

    final samplePlaceAttractions = [
      DreamPlaceAttractionsDbCompanion.insert(
          //Guangzhou
          dreamPlaceId: placeMap["Guangzhou, Chiny"]!,
          attractionId: attractionMap["Ostre jedzenie"]!),
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Guangzhou, Chiny"]!, attractionId: attractionMap["Muzea"]!),
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Guangzhou, Chiny"]!, attractionId: attractionMap["Opera"]!),
      //Saint-Tropez
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Saint-Tropez, Francja"]!, attractionId: attractionMap["Plaża"]!),
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Saint-Tropez, Francja"]!, attractionId: attractionMap["Muzea"]!),
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Saint-Tropez, Francja"]!, attractionId: attractionMap["Słońce"]!),
      //Bamberg
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Bamberg, Niemcy"]!, attractionId: attractionMap["Widoki"]!),
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Bamberg, Niemcy"]!, attractionId: attractionMap["Historia"]!),
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Bamberg, Niemcy"]!, attractionId: attractionMap["Szlaki"]!),
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Bamberg, Niemcy"]!, attractionId: attractionMap["Jedzenie"]!),
      //Fuzhou
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Fuzhou, Chiny"]!, attractionId: attractionMap["Jedzenie"]!),
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Fuzhou, Chiny"]!, attractionId: attractionMap["Herbaciarnie"]!),
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Fuzhou, Chiny"]!, attractionId: attractionMap["Dostęp do morza"]!),
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Nowy Jork, USA"]!, attractionId: attractionMap["Wieżowce"]!),
      //Nowy Jork
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Nowy Jork, USA"]!, attractionId: attractionMap["Muzea"]!),
      DreamPlaceAttractionsDbCompanion.insert(
          dreamPlaceId: placeMap["Nowy Jork, USA"]!, attractionId: attractionMap["Nocne życie"]!),
    ];

    // Zapisz dane do bazy
    await batch((batch) {
      batch.insertAll(dreamPlaceAttractionsDb, samplePlaceAttractions);
    });
  }
}
