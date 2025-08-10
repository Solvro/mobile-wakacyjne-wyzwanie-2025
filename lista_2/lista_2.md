## Lista 2 (Zarządzanie stanem aplikacji i routing)

W pierwszej liście ożywiliśmy naszą aplikację za pomocą `StatefulWidget`. To dobra metoda na lokalny stan, ale ma pewne ograniczenia i czasem jest trochę "ciężka" w użyciu. W tej części wprowadzimy nowocześniejsze podejście do stanu — **Flutter Hooks** — które pozwala pisać bardziej zwięzły i czytelny kod.

Następnie zajmiemy się problemem globalnego stanu, czyli tego, który chcemy udostępnić w wielu miejscach aplikacji. Poznamy **Riverpod** do zarządzania globalnym stanem oraz **GoRouter** do deklaratywnego routing’u.

### 1. Hooki Flutter — lżejsza alternatywa dla `StatefulWidget`

#### Dlaczego hooki?

* Hooki pozwalają na zarządzanie stanem bez rozdzielania widgetów na dwie klasy — używamy funkcji i hooków w `HookWidget`.
* Kod jest bardziej zwięzły i łatwiejszy do czytania.
* Pozwalają na korzystanie z gotowych hooków np. do efektów ubocznych (`useEffect`), animacji, kontrolerów itd.

#### Jak użyć hooków w naszej aplikacji?

* Dodaj do `pubspec.yaml`:

```yaml
dependencies:
  flutter_hooks: <najnowsza_wersja>
```


```dart
import 'package:flutter_hooks/flutter_hooks.dart';

class DreamPlaceScreen extends HookWidget {
  const DreamPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hook do stanu bool
    final isFavorited = useState(false);

    void toggleFavorite() {
      isFavorited.value = !isFavorited.value;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Santorini, Grecja'),
        actions: [
          IconButton(
            onPressed: toggleFavorite,
            icon: Icon(
              isFavorited.value ? Icons.favorite : Icons.favorite_border,
              color: isFavorited.value ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: // ...
    );
  }
}
```

**Korzyści:**

* Nie trzeba tworzyć klasy stanu — cały stan jest blisko miejsca użycia.
* Kod jest krótszy i bardziej deklaratywny.
* Możemy łatwo dodawać więcej hooków do innych celów (np. `useEffect`, `useAnimationController`).

### 2. Problem: "Prop Drilling" (przekazywanie stanu przez wiele widgetów)

* Gdy nasza aplikacja rośnie, często potrzebujemy udostępnić stan wielu widgetom.
* Przekazywanie przez wiele warstw widgetów danych i funkcji staje się uciążliwe i utrudnia konserwację.
* Przykład: w `DreamPlaceScreen` przenieśliśmy `IconButton` z `AppBar` do dedykowanego `AttractionsWidget`.
* Jak teraz `AttractionsWidget` ma wiedzieć, czy miejsce jest ulubione i jak wywołać funkcję zmiany stanu?

#### Rozwiązanie tymczasowe: dodanie do `AttractionsWidget` pól i przekazywanie ich:

```dart
class AttractionsWidget extends StatelessWidget {
  final bool isFavorited;
  final VoidCallback onFavoritePressed;

  const AttractionsWidget({
    super.key,
    required this.isFavorited,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // inne ikony
        IconButton(
          icon: Icon(
            isFavorited ? Icons.favorite : Icons.favorite_border,
            color: isFavorited ? Colors.red : null,
          ),
          onPressed: onFavoritePressed,
        ),
      ],
    );
  }
}
```

* W `DreamPlaceScreen` przekazujemy te wartości do `AttractionsWidget`.
* Działa, ale jeśli drzewo widgetów jest głębokie, trzeba przekazywać te dane przez wiele widgetów pośrednich — to jest właśnie **prop drilling**.

### 3. Historyczne rozwiązanie: `InheritedWidget`

* Flutter oferuje `InheritedWidget` do udostępniania danych całemu poddrzewu widgetów.
* Mechanizm ten stosowany jest np. w `Theme.of(context)` czy `MediaQuery.of(context)`.
* Jest jednak dość skomplikowany w użyciu — wymaga napisania dodatkowego kodu (statyczna metoda `of`, `updateShouldNotify`).
* Dla prostych przypadków jest to ok, ale przy bardziej skomplikowanych stanach i wielu providerach staje się trudny do utrzymania.

### 4. Nowoczesne zarządzanie stanem: Riverpod

#### Czym jest Riverpod?

* Riverpod to nowoczesny, bezpieczny i elastyczny system zarządzania stanem.
* Działa globalnie i pozwala na łatwy dostęp i modyfikację stanu z dowolnego miejsca aplikacji — bez przekazywania przez widgety.
* Nie wymaga `BuildContext` do działania, co pozwala na lepsze testowanie i modularność.

#### Konfiguracja

Szczegółowo opisana w dokumentacji [Riverpod](https://riverpod.dev/docs/introduction/getting_started)

* Częsty błąd - pamiętaj aby owinąć aplikacje w `ProviderScope`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```
Jeśli tego nie zrobisz wszystkie następne wykonane kroki nie będą działać poprawnie.

### 5. Refaktoryzacja stanu ulubionych do Riverpoda

* Stwórz plik `lib/features/favorite/favorite_provider.dart`:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_provider.g.dart';

@riverpod
class Favorite extends _$Favorite {
  @override
  bool build() {
    return false; // stan początkowy
  }

  void toggle() { // metoda pozwaląca zmienić stan providera
    state = !state;
  }
}
```

* Uruchom generator kodu:

```bash
flutter pub run build_runner build -d
```

* W `dream_place_screen.dart` użyj `ConsumerWidget` i providera:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/favorite/favorite_provider.dart';

class DreamPlaceScreen extends ConsumerWidget {
  const DreamPlaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorited = ref.watch(favoriteProvider); // obserwujemy stan providera, przy jego zmianie metoda build widgeta uruchomi się jeszcze raz odświerzając nam ui z nowym jej stanem

    return Scaffold(
      appBar: AppBar(
        title: const Text('Santorini, Grecja'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(favoriteProvider.notifier).toggle(); // tutaj odczytujemy jednorazowo stan notifiera ponieważ nie chcemy nasłuchiwać zmian na obiekcie do zarządzania stanem
            },
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : null,
            ),
          ),
        ],
      ),
      // reszta body...
    );
  }
}
```

### 6. Globalny stan i nawigacja z GoRouter

* Riverpod świetnie działa z routingiem, a do nawigacji użyjemy **go\_router** — narzędzia rekomendowanego przez zespół Fluttera.


#### 6.1. Model i źródło danych z Riverpod (code generation)

Zamiast trzymać dane „na sztywno” w ekranie, stworzymy model i globalne źródło danych.

* Stwórz model `Place`:

```dart
class Place {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.title,
    required this.description,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      description: description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
```

* Stwórz plik `lib/features/places/places_provider.dart`:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'place.dart';

part 'places_provider.g.dart';

final _initialPlaces = [
  Place(id: '1', title: 'Santorini, Grecja', description: 'Białe domki nad morzem'),
  Place(id: '2', title: 'Kioto, Japonia', description: 'Świątynie i ogrody'),
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
```

Uruchom generator kodu:

```bash
flutter pub run build_runner build -d
```

Teraz masz automatycznie wygenerowany `placesProvider`.

#### 6.2. Konfiguracja `go_router`

W pliku `lib/app_router.dart`:

```dart
final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '${DetailsScreen.route}/:id', // dynamiczny parametr
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DetailsScreen(id: id);
      },
    ),
  ],
);
```

#### 6.3. Pobieranie danych w ekranach

* **HomeScreen**: `ref.watch(placesProvider)` i lista miejsc z przyciskiem nawigacji.
* **DetailsScreen**: `ref.watch(placesProvider)` i wyszukanie konkretnego miejsca po `id`, plus przycisk do `ref.read(placesProvider.notifier).toggleFavorite(id)`.

### 7. Ekran główny i nawigacja

Kliknięcie w kafelek:

```dart
GoRouter.of(context).push("${DetailsScreen.route}/$id");
```

### 8. Uruchom i sprawdź

1. Uruchom aplikację.
2. Na ekranie głównym widać listę miejsc z ikonami serca.
3. Kliknij miejsce → przejście do szczegółów.
4. Kliknij serce w szczegółach → powrót do listy pokaże zaktualizowany stan.

### Podsumowanie

* **Hooki** — prostszy lokalny stan.
* **Prop drilling** — problem rozwiązany przez providery.
* **InheritedWidget** — historyczne rozwiązanie, dziś raczej rzadziej stosowane.
* **Riverpod** (z code generation) — nowoczesny globalny stan z automatycznie generowanymi providerami.
* **GoRouter** — deklaratywna nawigacja, współpracuje z Riverpod.
* Model + provider = aplikacja działa na prawdziwych danych, stan zsynchronizowany między ekranami.

