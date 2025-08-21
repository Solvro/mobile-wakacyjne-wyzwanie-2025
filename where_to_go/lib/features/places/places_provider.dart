import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hello_flutter/models/dream_place_model.dart';
import 'package:hello_flutter/gen/assets.gen.dart';
import 'package:hello_flutter/models/activity_model.dart';
import 'package:flutter/material.dart';
part 'places_provider.g.dart';

final _initialPlaces = [
  DreamPlace(
    title: 'Santorini',
    image: Assets.images.santorini,
    imageDescription: 'Białe miasteczko Oia',
    placeDescription:
        'Santorini to grecka wyspa znana z białych domów z niebieskimi kopułami, malowniczych widoków i romantycznych zachodów słońca.',
    activities: [
      Activity(
        icon: Icons.beach_access,
        name: 'Plaże',
        description: 'Najlepsze plaże tutaj',
      ),
      Activity(
        icon: Icons.dinner_dining,
        name: 'Jedzenie',
        description: 'Smaczne jedzenie',
      ),
      Activity(
        icon: Icons.surfing_rounded,
        name: 'Surfing',
        description: 'Surfing dla każdego',
      ),
      Activity(
        icon: Icons.directions_walk_rounded,
        name: 'Spacery',
        description: 'Spacer po plaży',
      ),
    ],
  ),
  DreamPlace(
    title: 'Rodos',
    image: Assets.images.rodos,
    imageDescription: 'Starożytne ruiny i piękne plaże',
    placeDescription:
        'Rodos to grecka wyspa znana z pięknych plaż, starożytnych ruin i urokliwych miasteczek.',
    activities: [
      Activity(
        icon: Icons.beach_access,
        name: 'Plaże',
        description: 'Najlepsze plaże tutaj',
      ),
      Activity(
        icon: Icons.dinner_dining,
        name: 'Jedzenie',
        description: 'Smaczne jedzenie',
      ),
      Activity(
        icon: Icons.church,
        name: 'Zabytki',
        description: 'Starożytne ruiny',
      ),
      Activity(
        icon: Icons.directions_walk_rounded,
        name: 'Spacery',
        description: 'Spacer po plaży',
      ),
    ],
  ),
  DreamPlace(
    title: 'Kreta',
    image: Assets.images.kreta,
    imageDescription: 'Plaża z lazurową wodą',
    placeDescription:
        'Kreta to największa grecka wyspa, znana z bogatej historii, pięknych plaż i pysznej kuchni.',
    activities: [
      Activity(
        icon: Icons.beach_access,
        name: 'Plaże',
        description: 'Najlepsze plaże tutaj',
      ),
      Activity(
        icon: Icons.dinner_dining,
        name: 'Jedzenie',
        description: 'Smaczne jedzenie',
      ),
      Activity(
        icon: Icons.sunny,
        name: 'Opalanie',
        description: 'Opalanie na plaży',
      ),
      Activity(
        icon: Icons.directions_walk_rounded,
        name: 'Spacery',
        description: 'Spacer po plaży',
      ),
    ],
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<DreamPlace> build() => _initialPlaces;

  void toggleFavorite(String title) {
    state = [
      for (final p in state)
        if (p.title == title) p.copyWith(isFavorite: !p.isFavorite) else p,
    ];
  }
}
