import "package:drift/drift.dart";
import "package:drift/native.dart";
import "../../gen/assets.gen.dart"; // <-- Import your assets
import "dream_place.dart";

part "dream_place_repository.g.dart";

@DriftDatabase(tables: [DreamPlaces])
class DreamPlaceRepository extends _$DreamPlaceRepository {
  DreamPlaceRepository() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  Future<int> addDreamPlace(DreamPlacesCompanion entry) => into(dreamPlaces).insert(entry);

  Future<List<DreamPlace>> getAllDreamPlaces() => select(dreamPlaces).get();

  Future<bool> updateDreamPlace(DreamPlace place) => update(dreamPlaces).replace(place);

  Future<int> deleteDreamPlace(int id) => (delete(dreamPlaces)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> toggleFavourite(int id) async {
    final place = await (select(dreamPlaces)..where((tbl) => tbl.id.equals(id))).getSingle();
    await update(dreamPlaces).replace(
      place.copyWith(isFavourite: !place.isFavourite),
    );
  }

  Future<void> initDatabase() async {
    final existing = await getAllDreamPlaces();
    if (existing.isEmpty) {
      await batch((batch) {
        batch.insertAll(dreamPlaces, [
          DreamPlacesCompanion.insert(
            name: "Auckland, New Zealand",
            description: "Gdzie nowoczesne miasto spotyka się z zapierającymi dech w piersiach krajobrazami.",
            image: Assets.images.auckland.path,
            isFavourite: const Value(false),
          ),
          DreamPlacesCompanion.insert(
            name: "Kyoto, Japan",
            description: "Starożytna stolica pełna świątyń, tradycyjnych ogrodów i malowniczych uliczek.",
            image: Assets.images.kyoto.path,
            isFavourite: const Value(false),
          ),
          DreamPlacesCompanion.insert(
            name: "Santorini, Greece",
            description: "Bajkowa wyspa z białymi domami i błękitnymi kopułami nad lazurowym morzem.",
            image: Assets.images.santorini.path,
            isFavourite: const Value(false),
          ),
          DreamPlacesCompanion.insert(
            name: "Machu Picchu, Peru",
            description: "Tajemnicze ruiny inkaskiego miasta ukryte wysoko w Andach.",
            image: Assets.images.macchuPicchu.path,
            isFavourite: const Value(false),
          ),
          DreamPlacesCompanion.insert(
            name: "Reykjavik, Iceland",
            description: "Kraina zorzy polarnej, gejzerów i zapierających dech krajobrazów wulkanicznych.",
            image: Assets.images.reykjavik.path,
            isFavourite: const Value(false),
          ),
        ]);
      });
    }
  }
}
