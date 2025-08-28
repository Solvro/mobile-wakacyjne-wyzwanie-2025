import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../repositories/dream_places_repository.dart";
import "../../../repositories/dream_places_repository_impl.dart";
import "database_provider.dart";

part "database_repository_provider.g.dart";

@Riverpod(keepAlive: true)
Future<DreamPlacesRepository> databaseRepository(Ref ref) async {
  final db = await ref.watch(databaseProvider.future);

  return DreamPlacesRepositoryImpl(db);
}
