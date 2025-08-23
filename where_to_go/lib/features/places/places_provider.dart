import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../gen/assets.gen.dart";
import "place.dart";

part "places_provider.g.dart";

final _initialPlaces = [
  Place(
    id: "1",
    title: "Santorini, Grecja",
    subtitle: "Perła Cyklad na Morzu Egejskim",
    description: "Odkryj magiczne białe domki zawieszone na klifach i zanurz się w błękicie morza.",
    image: Assets.images.santorini
  ),
  Place(
    id: "2",
    title: "Kyoto, Japonia",
    subtitle: "Serce tradycyjnej Japonii",
    description: "Przechadzaj się wśród starożytnych świątyń, bambusowych lasów i ogrodów gejsz.",
    image: Assets.images.kyoto,
  ),
  Place(
    id: "3",
    title: "Malediwy",
    subtitle: "Rajskie atole na Oceanie Indyjskim",
    description: "Zamieszkaj w domku na wodzie i ciesz się krystalicznie czystą wodą i białym piaskiem.",
    image: Assets.images.maldives,
  ),
  Place(
    id: "4",
    title: "Islandia",
    subtitle: "Kraina lodu, ognia i zorzy polarnej",
    description: "Zobacz potężne wodospady, gejzery i lodowce w jednym z najbardziej epickich krajobrazów.",
    image: Assets.images.iceland,
  ),
  Place(
    id: "5",
    title: "Patagonia, Argentyna",
    subtitle: "Surowe piękno na końcu świata",
    description: "Wędruj pośród monumentalnych gór, turkusowych jezior i bezkresnych stepów.",
    image: Assets.images.patagonia,
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p
    ];
  }
}
