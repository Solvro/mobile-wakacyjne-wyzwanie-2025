import "package:drift/drift.dart";

import "dream_places_table.dart";

class InfoColumns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get dreamPlaceId => integer().references(DreamPlaces, #id)();
  TextColumn get iconName => text().withLength(min: 1, max: 100)();
  TextColumn get infoText => text().withLength(min: 1, max: 100)();
}
