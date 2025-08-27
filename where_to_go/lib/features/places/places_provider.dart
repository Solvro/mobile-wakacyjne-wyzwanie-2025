import "package:riverpod_annotation/riverpod_annotation.dart";
import "/gen/assets.gen.dart";
import "../../classes/place.dart";

part "places_provider.g.dart";

final _initialPlaces = [
  Place(
    id: "0",
    title: "Sagrada Familia",
    description:
        "Jeden z najbardziej rozpoznawalnych budynków na świecie - dzieło życia architekta, Antoniego Gaudiego. Jego budowa trwa od 1882 roku (143 lata), a termin jej ukończenia jest wciąż nieznany.",
    image: Assets.images.sagrada.path,
  ),
  Place(
    id: "1",
    title: "Park Guell",
    description:
        "Nietypowy park zaprojektowany przez Antoniego Gaudiego z pięknym widokiem na panoramę Barcelony. Teren zachwyca różnorodnością, nietypowym podejściem do kształtowania przestrzeni oraz mozaikami z potłuczonych kawałków ceramicznych płytek.",
    image: Assets.images.park.path,
  ),
  Place(
    id: "2",
    title: "Pałac Muzyki Katalońskiej",
    description:
        "Sala koncertowa z wielobarwną, witrażową kopółą przez którą do środka dociera światło o różnym natężeniu i kolorze w zależności od pory dnia. Równie interesujący jest front budynku, który ozdabiają kolumny pokryte mozaiką tworzącą kwieciste wzory.",
    image: Assets.images.palac.path,
  ),
  Place(
    id: "3",
    title: "Camp Nou",
    description:
        "Stadion piłkarski klubu FC Barcelona. Jego trybuny mieszczą 99 354 osób (obecnie jest przebudowywany przez co jego pojemność wzrośnie do 105 000 osób), co czyni go największym piłkarskim stadionem w Europie i jednym z największych na świecie. ",
    image: Assets.images.camp.path,
  ),
  Place(
    id: "4",
    title: "Casa Batlo",
    description:
        "Budynek mieszkalny, przebudowany przez Antoniego Gaudiego w 1904 roku na zlecenie prodzucenta tekstyliów Josepha Batlo. Budynek jest bogato zdobiony, elewacja zawiera elementy zwierzęce jak np. łuski smoka.",
    image: Assets.images.casa.path,
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  Place getPlaceById(String id) {
    return state.firstWhere((place) => place.id == id);
  }

  int getListLength() => state.length;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p,
    ];
  }
}
