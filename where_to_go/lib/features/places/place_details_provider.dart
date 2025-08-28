import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../place.dart";
import "places_provider.dart";

part "place_details_provider.g.dart";

@riverpod
Place place(Ref ref, {required String id}) {
  final places = ref.watch(placesProvider);
  return places.firstWhere((place) => place.id == id);
}
