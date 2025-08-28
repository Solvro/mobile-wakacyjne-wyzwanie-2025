import "package:drift/drift.dart";

import "dream_places.dart";

enum AttractionValue {
  mountains,
  water,
  beach,
  landscapes,
  sunsets,
  history,
  culture,
  walks,
  food,
  views,
}

class Attractions extends Table {
  late final id = integer().references(DreamPlaces, #id)();
  late final attractionValue = intEnum<AttractionValue>()();
  @override
  Set<Column<Object>> get primaryKey => {id, attractionValue};
}
