import "package:drift/drift.dart";

class DreamPlaces extends Table {
  IntColumn get id => integer().autoIncrement()();
  late final name = text().withLength(min: 5, max: 50)();
  late final description = text().withLength(max: 255)();
  late final location = text().withLength(max: 50)();
  late final imageUrl = text().withLength(max: 255)();
  late final isFavourited = boolean().withDefault(const Constant(false))();
}
