import "package:flutter/material.dart";

import "gen/assets.gen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class Attraction {
  final IconData icon;
  final String text;

  const Attraction({required this.icon, required this.text});
}

class Place {
  final String placeText;
  final String image;
  final String titleText;
  final String descriptionText;
  final List<Attraction> attractions;

  const Place(
      {required this.placeText,
      required this.image,
      required this.titleText,
      required this.descriptionText,
      required this.attractions});
}

final List<Place> places = [
  Place(
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
        //z ListView i ListTiles nie chciało mi działać dlatego poszedłem w column
        body: ListView(
          children: [
            ...places.map((place) => GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute<dynamic>(builder: (context) => DreamPlaceScreen(place: place)),
                    );
                  },
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
                ))
          ],
        ));
  }
}

class DreamPlaceScreen extends StatefulWidget {
  const DreamPlaceScreen({required this.place, super.key});

  final Place place;

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 123, 144, 118),
      appBar: AppBar(
        title: Text(widget.place.placeText, style: const TextStyle(color: Color.fromARGB(255, 248, 231, 148))),
        backgroundColor: const Color.fromARGB(255, 40, 65, 57),
        actions: [
          IconButton(
              onPressed: _toggleFavorite,
              icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
              color: const Color.fromARGB(255, 248, 231, 148))
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            widget.place.image,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.place.titleText,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(widget.place.descriptionText)
                //Dodać 4
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...widget.place.attractions.map((att) => Column(
                    children: [Icon(att.icon), Text(att.text)],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
