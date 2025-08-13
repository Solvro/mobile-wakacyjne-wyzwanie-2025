import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "dream_place_screen.dart";
import "gen/assets.gen.dart";

void main() {
  runApp(const MyApp());
}

// TODOfix states of DreamPlaceScreens
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 100, 180, 255),
    );

    return MaterialApp(
      title: "Dream Place App",
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(),
        colorScheme: appColorScheme,
        scaffoldBackgroundColor: appColorScheme.surfaceContainer,
        cardTheme: CardThemeData(
          color: appColorScheme.surfaceBright,
          elevation: 4,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: appColorScheme.primary,
          foregroundColor: appColorScheme.onPrimary,
          centerTitle: true,
        ),
      ),
      home: PlacesList(places: places),
    );
  }
}

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<DreamPlaceScreen> places;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista Miejsc"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 3 / 2,
        ),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return GestureDetector(
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Hero(
                      tag: place.title,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                        child: Image.asset(
                          place.image.path,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      place.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute<Widget>(builder: (context) => place));
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Strona główna",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: "Ulubione",
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 32,
        onTap: (index) {
          // TODOHandle navigation
        },
      ),
    );
  }
}

// TODOcreate favorites view

List<DreamPlaceScreen> places = [
  DreamPlaceScreen(
    title: "Rejkiawik, Islandia",
    image: Assets.images.reykjavikView,
    placeName: "Rejkiawik",
    placeDescription: "Stolica Islandii, znana z pięknych widoków i kultury.",
    infoColumns: const [
      InfoColumnData(icon: Icons.restaurant, text: "Restauracje"),
      InfoColumnData(icon: Icons.terrain, text: "Góry i wulkany"),
      InfoColumnData(icon: Icons.auto_awesome, text: "Zorze polarne"),
    ],
  ),
  DreamPlaceScreen(
    title: "Zermatt, Szwajcaria",
    image: Assets.images.zermattView,
    placeName: "Zermatt",
    placeDescription: "Malownicza miejscowość u stóp Matterhorn, raj dla narciarzy i turystów górskich.",
    infoColumns: const [
      InfoColumnData(icon: Icons.downhill_skiing, text: "Narciarstwo"),
      InfoColumnData(icon: Icons.landscape, text: "Alpy i trekking"),
      InfoColumnData(icon: Icons.train, text: "Panoramiczne pociągi"),
    ],
  ),
  DreamPlaceScreen(
    title: "Kioto, Japonia",
    image: Assets.images.kyotoView,
    placeName: "Kioto",
    placeDescription: "Dawna stolica Japonii, znana z świątyń, ogrodów i kwitnącej wiśni.",
    infoColumns: const [
      InfoColumnData(icon: Icons.park, text: "Świątynie i ogrody"),
      InfoColumnData(icon: Icons.local_florist, text: "Kwitnąca wiśnia"),
      InfoColumnData(icon: Icons.ramen_dining, text: "Kuchnia japońska"),
    ],
  ),
  DreamPlaceScreen(
    title: "Sydney, Australia",
    image: Assets.images.sydneyView,
    placeName: "Sydney",
    placeDescription: "Tętniące życiem miasto znane z Opery, plaż i pięknych widoków nad zatoką.",
    infoColumns: const [
      InfoColumnData(icon: Icons.theaters, text: "Opera w Sydney"),
      InfoColumnData(icon: Icons.beach_access, text: "Plaże"),
      InfoColumnData(icon: Icons.sailing, text: "Rejsy w zatoce"),
    ],
  ),
  DreamPlaceScreen(
    title: "Kapsztad, RPA",
    image: Assets.images.capeTownView,
    placeName: "Kapsztad",
    placeDescription: "Malownicze miasto między górami a oceanem, pełne przyrody i kultury.",
    infoColumns: const [
      InfoColumnData(icon: Icons.terrain, text: "Góra Stołowa"),
      InfoColumnData(icon: Icons.water, text: "Ocean Atlantycki"),
      InfoColumnData(icon: Icons.wine_bar, text: "Winnice"),
    ],
  ),
  DreamPlaceScreen(
    title: "Paryż, Francja",
    image: Assets.images.parisView,
    placeName: "Paryż",
    placeDescription: "Romantyczna stolica Francji, pełna sztuki, mody i kulinarnych przysmaków.",
    infoColumns: const [
      InfoColumnData(icon: Icons.location_city, text: "Wieża Eiffla"),
      InfoColumnData(icon: Icons.museum, text: "Luwr"),
      InfoColumnData(icon: Icons.coffee, text: "Kawiarnie"),
    ],
  ),
  DreamPlaceScreen(
    title: "Rio de Janeiro, Brazylia",
    image: Assets.images.rioView,
    placeName: "Rio de Janeiro",
    placeDescription: "Miasto samby, karnawału i spektakularnych plaż w otoczeniu gór.",
    infoColumns: const [
      InfoColumnData(icon: Icons.landscape, text: "Góra Corcovado"),
      InfoColumnData(icon: Icons.beach_access, text: "Plaża Copacabana"),
      InfoColumnData(icon: Icons.celebration, text: "Karnawał"),
    ],
  ),
];
