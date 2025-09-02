import "package:drift/drift.dart";

class DreamPlaces extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
}
