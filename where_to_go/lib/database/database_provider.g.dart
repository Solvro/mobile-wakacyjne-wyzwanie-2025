// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<AppDatabase>(value));
  }
}

String _$appDatabaseHash() => r'18ce5c8c4d8ddbfe5a7d819d8fb7d5aca76bf416';

@ProviderFor(dreamPlacesRepository)
final dreamPlacesRepositoryProvider = DreamPlacesRepositoryProvider._();

final class DreamPlacesRepositoryProvider
    extends $FunctionalProvider<DreamPlacesRepository, DreamPlacesRepository, DreamPlacesRepository>
    with $Provider<DreamPlacesRepository> {
  DreamPlacesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dreamPlacesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dreamPlacesRepositoryHash();

  @$internal
  @override
  $ProviderElement<DreamPlacesRepository> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  DreamPlacesRepository create(Ref ref) {
    return dreamPlacesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DreamPlacesRepository value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<DreamPlacesRepository>(value));
  }
}

String _$dreamPlacesRepositoryHash() => r'c587df30188e66519cac7f07b329835d72bd67ff';
