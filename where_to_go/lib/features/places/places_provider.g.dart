
part of 'places_provider.dart';



String _$placesHash() => r'6e74309efe6ab96c856ddcdae90b12a1ece45a78';

@ProviderFor(Places)
final placesProvider =
    AutoDisposeNotifierProvider<Places, List<Place>>.internal(
  Places.new,
  name: r'placesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$placesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Places = AutoDisposeNotifier<List<Place>>;
