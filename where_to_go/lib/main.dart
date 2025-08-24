import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "app_router.dart";
import "data_classes/place.dart";
import "dream_places/details_screen.dart";
import "dream_places/dream_place_screen_consumer_widget.dart";
import "dream_places/dream_place_screen_hook_widget.dart";
import "dream_places/dream_place_screen_inherited_widget.dart";
import "gen/assets.gen.dart";

void main() {
  runApp(const ProviderScope(
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: goRouter);
  }
}



final List<Place> places = [
  Place(
    id: "0",
    placeText: "Wrocław, Polska",
    image: Assets.images.wroclaw.path,
    titleText: "Panorama miasta",
    descriptionText: "A w tle najwyższy budynek we Wrocławiu",
    attractions: [
      const Attraction(icon: Icons.wb_sunny, text: "Słońce"),
      const Attraction(icon: Icons.park, text: "Parki"),
      const Attraction(icon: Icons.restaurant, text: "Restauracje")
    ],
  ),
  Place(
    id: "1",
    placeText: "Paryż, Francja",
    image: Assets.images.paris.path,
    titleText: "Wieża Eiffla",
    descriptionText: "Symbol miłości i jedno z najczęściej odwiedzanych miejsc w Europie",
    attractions: [
      const Attraction(icon: Icons.camera_alt, text: "Zabytki"),
      const Attraction(icon: Icons.local_cafe, text: "Kawiarnie"),
      const Attraction(icon: Icons.shopping_bag, text: "Zakupy")
    ],
  ),
  Place(
    id: "2",
    placeText: "Nowy Jork, USA",
    image: Assets.images.manhattan.path,
    titleText: "Manhattan nocą",
    descriptionText: "Miasto, które nigdy nie śpi, pełne świateł i energii",
    attractions: [
      const Attraction(icon: Icons.apartment, text: "Wieżowce"),
      const Attraction(icon: Icons.directions_boat, text: "Rejsy"),
      const Attraction(icon: Icons.theaters, text: "Broadway")
    ],
  ),
  Place(
    id: "3",
    placeText: "Tokio, Japonia",
    image: Assets.images.tokio.path,
    titleText: "Tokio nocą",
    descriptionText: "Bardzo nowoczesca zabudowa",
    attractions: [
      const Attraction(icon: Icons.directions_transit, text: "Transport"),
      const Attraction(icon: Icons.ramen_dining, text: "Kuchnia japońska"),
      const Attraction(icon: Icons.videogame_asset, text: "Gry i anime")
    ],
  ),
  Place(
    id: "4",
    placeText: "Sydney, Australia",
    image: Assets.images.sydney.path,
    titleText: "Opera w Sydney",
    descriptionText: "Ikoniczny budynek nad zatoką, symbol Australii",
    attractions: [
      const Attraction(icon: Icons.beach_access, text: "Plaże"),
      const Attraction(icon: Icons.sailing, text: "Żeglowanie"),
      const Attraction(icon: Icons.music_note, text: "Koncerty")
    ],
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 123, 144, 118),
        appBar: AppBar(
          title: const Text("Strona główna", style: TextStyle(color: Color.fromARGB(255, 248, 231, 148))),
          backgroundColor: const Color.fromARGB(255, 40, 65, 57),
        ),
        body: ListView(
          children:
            places.map((place) => GestureDetector(
                  onTap: () async {
                    await GoRouter.of(context).push("/${DetailsScreen.route}/${place.id}");
                  },
                  //┏━━━┳━━━┓
                  //┃ | ┃| |┃
                  //┣━━━╋━━━┫
                  //┃|| ┃|__┃
                  //┗━━━┻━━━┛
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 40, 65, 57), borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Image.asset(
                          place.image,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          place.placeText,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 248, 231, 148)),
                        ),
                      ],
                    ),
                  ),
                )).toList(),
        ));
  }
}
