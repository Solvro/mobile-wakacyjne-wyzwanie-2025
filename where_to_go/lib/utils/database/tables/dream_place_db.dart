import "package:drift/drift.dart";

class DreamPlaceDb extends Table {
  late final id = integer().autoIncrement()();
  late final name = text()();
  late final description = text()();
  late final imageUrl = text()();
  late final isFavorite = boolean().withDefault(const Constant(false))();
}
