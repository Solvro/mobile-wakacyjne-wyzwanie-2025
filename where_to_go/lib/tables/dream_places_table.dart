import "package:drift/drift.dart";

class DreamPlaces extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get placeName => text()();
  TextColumn get description => text()();
  TextColumn get imagePath => text()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
}
