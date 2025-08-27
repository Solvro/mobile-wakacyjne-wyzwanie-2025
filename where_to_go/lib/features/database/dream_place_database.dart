import "dart:io";
import "package:drift/drift.dart";
import "package:drift/native.dart";
import "package:path/path.dart" as p;
import "package:path_provider/path_provider.dart";
import "../../gen/assets.gen.dart";
import "dream_places_table.dart";

part "dream_place_database.g.dart";

@DriftDatabase(tables: [DreamPlaces])
class DreamPlaceDatabase extends _$DreamPlaceDatabase {
  DreamPlaceDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<DreamPlace>> getAllPlaces() => select(dreamPlaces).get();

  Future<int> insertPlace(DreamPlacesCompanion entry) => into(dreamPlaces).insert(entry);

  Future<void> updatePlace(DreamPlace place) => update(dreamPlaces).replace(place);

  Future<void> deletePlace(int id) => (delete(dreamPlaces)..where((tbl) => tbl.id.equals(id))).go();
  Future<void> seedDatabase() async {
    final existingPlaces = await getAllPlaces();
    if (existingPlaces.isNotEmpty) return;

    final samplePlaces = [
      DreamPlacesCompanion.insert(
        name: "Tokio, Japonia",
        description:
            "Wysoka wieża widokowa, futurystyczne wieżowce z cyfrowymi bilbordami reklamowymi, czyste niebo i zadbana zieleń.",
        imagePath: Assets.images.tokio.path,
        isFavourite: const Value(false),
      ),
      DreamPlacesCompanion.insert(
        name: "Paryż, Francja",
        description:
            "Romantyczna atmosfera, pyszne croissanty i bagietki, zachwycające dzieła sztuki i zjawiskowa architektura.",
        imagePath: Assets.images.paryz.path,
        isFavourite: const Value(false),
      ),
      DreamPlacesCompanion.insert(
        name: "Rzym, Włochy",
        description:
            "Historyczne ruiny osiągnięć przodków, starożytna architektura, wyjątkowa kuchnia oraz klimat śródziemnomorski.",
        imagePath: Assets.images.rzym.path,
        isFavourite: const Value(false),
      ),
      DreamPlacesCompanion.insert(
        name: "Nowy Jork, USA",
        description:
            "Ikoniczne miasto, które nigdy nie śpi, z niekończącą się energią, kulturą i rozrywką oraz kolosalnymi wieżowcami.",
        imagePath: Assets.images.nowyJork.path,
        isFavourite: const Value(false),
      ),
      DreamPlacesCompanion.insert(
        name: "Kair, Egipt",
        description:
            "Starożytne cuda świata, pustynny krajobraz z wielbłądami oraz bogata historia starożytnej cywilizacji.",
        imagePath: Assets.images.kair.path,
        isFavourite: const Value(false),
      ),
    ];

    await batch((batch) => batch.insertAll(dreamPlaces, samplePlaces));
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, "dream_places.sqlite"));
    return NativeDatabase(file);
  });
}
