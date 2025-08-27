import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../app/persistance/database/drift_database.dart";
import "../dream_place_repository.dart";

part "dream_place_repository_impl.g.dart";

@riverpod
class DreamPlaceRepositoryImpl extends _$DreamPlaceRepositoryImpl implements DreamPlaceRepository {
  late final AppDatabase database = ref.read(appDatabaseProvider);
}
