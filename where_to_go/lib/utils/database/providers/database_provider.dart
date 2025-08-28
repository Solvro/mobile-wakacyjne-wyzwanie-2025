import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../dream_places_database.dart";
import "../seeder.dart";

part "database_provider.g.dart";

@Riverpod(keepAlive: true)
Future<DreamPlacesDatabase> database(Ref ref) async {
  final db = DreamPlacesDatabase();
  await db.seedDatabase();

  return db;
}
