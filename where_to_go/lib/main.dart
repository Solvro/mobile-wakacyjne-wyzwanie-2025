import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "gen/assets.gen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ListScreen(),
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
    );
  }
}

class DreamPlace {
  final String title;
  final String imagePath;
  final String title2;
  final String description;
  final List<ListOfAtt> attractions;
  const DreamPlace(
      {required this.title,
      required this.title2,
      required this.description,
      required this.imagePath,
      required this.attractions});
}

class ListOfAtt {
  final IconData icon;
  final String subtitle;
  const ListOfAtt({required this.icon, required this.subtitle});
}

final listofplaces = [
  DreamPlace(
    title: "Mostar, Bośnia i Hercegowina",
    title2: "Stary Most w Mostarze",
    description: "Przy odrobinie szczęścia można spotkać osoby wykonujące ekstremalne skoki z mostu do rzeki.",
    imagePath: Assets.images.mostar.path,
    attractions: [
      const ListOfAtt(icon: Icons.water, subtitle: "Rzeka\nNeretwa"),
      const ListOfAtt(icon: Icons.landscape, subtitle: "Widoczki"),
      const ListOfAtt(icon: Icons.storefront, subtitle: "Tradycyjne\nbudownictwo"),
      const ListOfAtt(icon: Icons.mosque, subtitle: "Meczety")
    ],
  ),
  DreamPlace(
    title: "Wilno, Litwa",
    title2: "Kościół św. Anny w Wilnie",
    description:
        "Jeden z najbardziej rozpoznawalnych symboli Wilna. Jeden w wielu pięknych kościołów do zobaczenia w tym mieście. ",
    imagePath: Assets.images.wilno.path,
    attractions: [
      const ListOfAtt(icon: Icons.park, subtitle: "Parki"),
      const ListOfAtt(icon: Icons.church, subtitle: "Budownictwo\nsakralne"),
      const ListOfAtt(icon: Icons.bakery_dining_rounded, subtitle: "Kibiny")
    ],
  ),
  DreamPlace(
    title: "Berlin, Niemcy",
    title2: "Brama Brandenburska",
    description: "Najbardziej rozpoznawalny zabytek Berlina, obowiązkowy punkt każdej wizyty.",
    imagePath: Assets.images.berlin.path,
    attractions: [
      const ListOfAtt(icon: Icons.account_balance_rounded, subtitle: "Brama\nBrandenburska"),
      const ListOfAtt(icon: Icons.sports_bar_rounded, subtitle: "Piwo"),
      const ListOfAtt(icon: Icons.flutter_dash_rounded, subtitle: "Fluttercon\n2025")
    ],
  ),
  DreamPlace(
    title: "Szklarska Poręba, Polska",
    title2: "Wodospad Kamieńczyka",
    description: "Najwyższy wodospoad w polskich Sudetach.",
    imagePath: Assets.images.szklarska.path,
    attractions: [
      const ListOfAtt(icon: Icons.hiking_rounded, subtitle: "Piesze\nwycieczki"),
      const ListOfAtt(icon: Icons.landscape, subtitle: "Góry"),
      const ListOfAtt(icon: Icons.forest, subtitle: "Natura"),
      const ListOfAtt(icon: Icons.waves_rounded, subtitle: "Wodospady")
    ],
  ),
  DreamPlace(
    title: "Bukareszt, Rumunia",
    title2: "Pałac Parlamentu w Bukareszcie",
    description: "Jeden z największych budynków na świecie, a zarazem symbol słusznie minionego komunizmu w Rumunii.",
    imagePath: Assets.images.bukareszt.path,
    attractions: [
      const ListOfAtt(icon: Icons.museum, subtitle: "Muzea"),
      const ListOfAtt(icon: Icons.location_city, subtitle: "Zróżnicowana\narchitektura"),
      const ListOfAtt(icon: Icons.park, subtitle: "Parki")
    ],
  )
];

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Wakacyjno Wyzwaniownik"),
        ),
        body: ListView(
          children: listofplaces
              .map(
                (e) => Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(builder: (context) => DreamPlaceScreen(place: e)),
                      );
                    },
                    title: Text(
                      e.title,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      e.title2,
                      style: const TextStyle(fontSize: 12),
                    ),
                    leading: Image.asset(
                      e.imagePath,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
              .toList(),
        ));
  }
}

class DreamPlaceScreen extends HookWidget {
  const DreamPlaceScreen({super.key, required this.place});
  final DreamPlace place;
  @override
  Widget build(BuildContext context) {
    final isFavorited = useState(false);

    const colorAccent = Color.fromARGB(255, 154, 63, 11);
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image.asset(
          place.imagePath,
          fit: BoxFit.cover,
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.title2,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  place.description,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            )),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: place.attractions
                .map(
                  (e) => Column(
                    children: [
                      Icon(
                        e.icon,
                        size: 35,
                        color: colorAccent,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 40,
                        child: Text(
                          e.subtitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
                .toList())
      ]),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(place.title),
        titleTextStyle: const TextStyle(
          fontSize: 17,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => isFavorited.value = !isFavorited.value,
              icon: Icon(
                isFavorited.value ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: isFavorited.value ? const Color.fromARGB(255, 174, 14, 14) : colorAccent,
              ))
        ],
        iconTheme: const IconThemeData(
          color: colorAccent,
        ),
      ),
    );
  }
}
