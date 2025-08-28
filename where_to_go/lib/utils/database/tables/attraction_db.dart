import "package:drift/drift.dart";

class AttractionDb extends Table {
  late final id = integer().autoIncrement()();
  late final name = text()();
  late final iconName = text()();
}
