import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hello_flutter/models/place_model.dart';

part 'places_provider.g.dart';

const _initialPlaces = [
  Place(
    id: '1',
    title: 'Santorini, Grecja',
    description: 'Białe domki nad morzem',
  ),
  Place(id: '2', title: 'Kioto, Japonia', description: 'Świątynie i ogrody'),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p,
    ];
  }
}
