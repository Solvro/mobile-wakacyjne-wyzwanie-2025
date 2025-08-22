import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_fonts/google_fonts.dart";
import "dream_place_screen.dart";
import "gen/assets.gen.dart";

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.robotoTextTheme(),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 177, 208, 223),
            titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        home: PlaceScreenList());
  }
}

class Place {
  final String titleText;
  final ImageProvider image;
  final Column feature1;
  final Column feature2;
  final Column feature3;
  final Center placeName;
  final Center catchPhrase;

  Place({
    required this.titleText,
    required this.image,
    required this.placeName,
    required this.catchPhrase,
    required this.feature1,
    required this.feature2,
    required this.feature3,
  });
}

class PlaceScreenList extends StatelessWidget {
  final places = [
    Place(
      titleText: "Cool place",
      image: Assets.images.snowdin.provider(),
      placeName: const Center(child: Text("Snowdin", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      catchPhrase: const Center(child: Text("here lives the GREAT Papyrus")),
      feature1: const Column(children: [Icon(Icons.wb_sunny), Text("No sun")]),
      feature2: const Column(children: [Icon(Icons.beach_access), Text("No beach")]),
      feature3: const Column(children: [Icon(Icons.restaurant), Text("Tasty pasta")]),
    ),
    Place(
      titleText: "The longest city in Europe",
      image: Assets.images.kr.provider(),
      placeName: const Center(child: Text("Kryvyi Rih", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      catchPhrase: const Center(child: Text("A life-long city")),
      feature1: const Column(children: [Icon(Icons.iron), Text("Metals!")]),
      feature2: const Column(children: [Icon(Icons.pets), Text("Green dogs")]),
      feature3: const Column(children: [Icon(Icons.do_not_disturb), Text("Less criminal then before")]),
    ),
    Place(
      titleText: "Big snowy mountains",
      image: Assets.images.zakopane.provider(),
      placeName: const Center(child: Text("Zakopane", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      catchPhrase: const Center(child: Text("Zakopane - najbliżej Tatr")),
      feature1: const Column(children: [Icon(Icons.snowboarding), Text("Snow sports!")]),
      feature2: const Column(children: [Icon(Icons.hiking), Text("Cool routes to go hiking")]),
      feature3: const Column(children: [Icon(Icons.water), Text("Oko morskie!")]),
    ),
    Place(
      titleText: "GAMBLING",
      image: Assets.images.gambling.provider(),
      placeName: const Center(child: Text("Las Vegas", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      catchPhrase: const Center(child: Text("LET`S GO GAMBLING")),
      feature1: const Column(children: [Icon(Icons.money_off), Text("GAMBLING")]),
      feature2: const Column(children: [Icon(Icons.attach_money), Text("GAMBLING")]),
      feature3: const Column(children: [Icon(Icons.monetization_on), Text("GAMBLING")]),
    ),
    Place(
      titleText: "I need to get there",
      image: Assets.images.pentagon.provider(),
      placeName: const Center(child: Text("Pentagon", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      catchPhrase: const Center(child: Text("You know they built it in 1943?")),
      feature1: const Column(children: [Icon(Icons.house), Text("5 sides")]),
      feature2: const Column(children: [Icon(Icons.build), Text("Looks cozy")]),
      feature3: const Column(
          children: [Icon(Icons.build_circle), Text("5 aboveground floors,\nand 2 underground,\nofficially")]),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dream places"),
      ),
      body: ListView.builder(
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];
            return InkWell(
                onTap: () async {
                  await Navigator.push<void>(
                      context, MaterialPageRoute<void>(builder: (_) => DreamPlaceScreen(place: place)));
                },
                child: Card(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image(image: place.image, height: 200, fit: BoxFit.cover),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(place.titleText, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }
}
