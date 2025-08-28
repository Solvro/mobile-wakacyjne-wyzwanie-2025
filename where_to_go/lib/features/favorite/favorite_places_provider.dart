import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../place.dart";
import "../places/places_provider.dart";

part "favorite_places_provider.g.dart";

@riverpod
List<Place> favoritePlaces(Ref ref) {
  final places = ref.watch(placesProvider);
  return places.where((place) => place.isFavorite).toList();
}
