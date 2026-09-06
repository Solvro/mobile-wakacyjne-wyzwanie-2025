import "dart:io";

import "package:drift/drift.dart";
import "package:drift/native.dart";
import "package:path/path.dart" as p;
import "package:path_provider/path_provider.dart";

import "tables/dream_places_table.dart";

part "app_database.g.dart";

@DriftDatabase(tables: [DreamPlaces])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection()); // otwarcie polaczenia z baza danych

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // funkcja otwierajaca polaczenie
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory(); // folder w ktorym ma byc zapisana baza danych
    final file = File(p.join(dbFolder.path, "app_database.sqlite")); // sciezka pliku bazy danych
    return NativeDatabase.createInBackground(file); // stworzenie pliku bazy danych
  });
}
