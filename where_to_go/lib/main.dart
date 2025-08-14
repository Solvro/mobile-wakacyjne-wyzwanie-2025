import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
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
  final List<Iconka> ikony;
  const DreamPlace(
      {required this.title,
      required this.title2,
      required this.description,
      required this.imagePath,
      required this.ikony});
}

final listofplaces = [
  DreamPlace(
    title: "Mostar, Bośnia i Hercegowina",
    title2: "Stary Most w Mostarze",
    description: "Przy odrobinie szczęścia można spotkać osoby wykonujące ekstremalne skoki z mostu do rzeki.",
    imagePath: Assets.images.mostar.path,
    ikony: [const Iconka(icona: Icons.wallet, podpis: "cotoxd"), const Iconka(icona: Icons.wallet, podpis: "cotoxd")],
  ),
  DreamPlace(
    title: "Wilno, Litwa",
    title2: "Kościół św. Anny w Wilnie",
    description:
        "Jeden z najbardziej rozpoznawalnych symboli Wilna. Jeden w wielu pięknych kościołów do zobaczenia w tym mieście. ",
    imagePath: Assets.images.wilno.path,
    ikony: [const Iconka(icona: Icons.wallet, podpis: "cotoxd"), const Iconka(icona: Icons.wallet, podpis: "cotoxd")],
  ),
  DreamPlace(
    title: "Berlin, Niemcy",
    title2: "Brama Brandenburska",
    description: "Najbardziej rozpoznawalny zabytek Berlina, obowiązkowy punkt każdej wizyty.",
    imagePath: Assets.images.berlin.path,
    ikony: [const Iconka(icona: Icons.wallet, podpis: "cotoxd"), const Iconka(icona: Icons.wallet, podpis: "cotoxd")],
  ),
  DreamPlace(
    title: "Szklarska Poręba, Polska",
    title2: "Wodospad Kamieńczyka",
    description: "Najwyższy wodospoad w polskich Sudetach.",
    imagePath: Assets.images.szklarska.path,
    ikony: [const Iconka(icona: Icons.wallet, podpis: "cotoxd"), const Iconka(icona: Icons.wallet, podpis: "cotoxd")],
  ),
  DreamPlace(
    title: "Bukareszt, Rumunia",
    title2: "Pałac Parlamentu w Bukareszcie",
    description: "Jeden z największych budynków na świecie, a zarazem symbol minionego komunizmu w Rumunii.",
    imagePath: Assets.images.bukareszt.path,
    ikony: [const Iconka(icona: Icons.wallet, podpis: "cotoxd"), const Iconka(icona: Icons.wallet, podpis: "cotoxd")],
  )
];

class Iconka {
  final IconData icona;
  final String podpis;

  const Iconka({required this.icona, required this.podpis});
}

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: listofplaces
          .map(
            (e) => Card(
              child: ListTile(
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (context) => DreamPlaceScreen(place: e)),
                  );
                },
                title: Text(e.title),
              ),
            ),
          )
          .toList(),
    ));
  }
}

class DreamPlaceScreen extends StatefulWidget {
  const DreamPlaceScreen({super.key, required this.place});
  final DreamPlace place;

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    const fioletowy = Color.fromARGB(255, 84, 26, 119);
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image.asset(
          widget.place.imagePath,
          fit: BoxFit.cover,
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.place.title2,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.place.description,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            )),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.place.ikony
                .map(
                  (e) => Column(
                    children: [
                      Icon(
                        e.icona,
                        size: 35,
                        color: fioletowy,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 40,
                        child: Text(
                          e.podpis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
                .toList()
            // children: [
            //   Column(
            //     children: [
            //       Icon(
            //         Icons.water,
            //         size: 35,
            //         color: fioletowy,
            //       ),
            //       SizedBox(
            //         height: 6,
            //       ),
            //       SizedBox(
            //         height: 40,
            //         child: Text(
            //           "Rzeka\nNeretwa",
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ],
            //   ),
            //   Column(
            //     children: [
            //       Icon(
            //         Icons.landscape,
            //         size: 35,
            //         color: Color.fromARGB(255, 84, 26, 119),
            //       ),
            //       SizedBox(
            //         height: 6,
            //       ),
            //       SizedBox(
            //         height: 40,
            //         child: Text("Widoczki"),
            //       ),
            //     ],
            //   ),
            //   Column(
            //     children: [
            //       Icon(
            //         Icons.storefront,
            //         size: 35,
            //         color: Color.fromARGB(255, 84, 26, 119),
            //       ),
            //       SizedBox(
            //         height: 8,
            //       ),
            //       SizedBox(
            //         height: 40,
            //         child: Text(
            //           "Tradycyjne\nbudownictwo",
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ],
            //   ),
            //   Column(
            //     children: [
            //       Icon(
            //         Icons.mosque,
            //         size: 35,
            //         color: Color.fromARGB(255, 84, 26, 119),
            //       ),
            //       SizedBox(
            //         height: 6,
            //       ),
            //       SizedBox(
            //         height: 40,
            //         child: Text("Meczety"),
            //       ),
            //     ],
            //   ),
            // ],
            )
      ]),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.place.title),
        titleTextStyle: const TextStyle(
          fontSize: 18,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 84, 26, 119),
        actions: [
          IconButton(
              onPressed: _toggleFavorite,
              icon: Icon(
                _isFavorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: _isFavorited ? const Color.fromARGB(255, 174, 14, 14) : Colors.white,
              ))
        ],
      ),
    );
  }
}
