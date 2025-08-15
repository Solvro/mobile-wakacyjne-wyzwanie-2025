import "package:flutter/material.dart";
import "gen/assets.gen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey[50],
        scaffoldBackgroundColor: const Color.fromARGB(255, 236, 219, 249),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[50],
          foregroundColor: Colors.black,
          elevation: 2,
        ),
      ),
      home: const DreamPlacesListScreen(),
    );
  }
}

final List<DreamPlaceScreen> places = [
  DreamPlaceScreen(
    title: "Tokio, Japonia",
    imagePath: Assets.images.tokio.path,
    placeName: "Wieża Tokio Tower",
    description:
        "Wysoka wieża widokowa, futurystyczne wieżowce z cyfrowymi bilbordami reklamowymi, czyste niebo i zadbana zieleń.",
    attractions: const [
      Attraction(icon: Icons.wb_sunny, label: "Słońce"),
      Attraction(icon: Icons.cell_tower, label: "Tokio Tower"),
      Attraction(icon: Icons.computer, label: "Technologia"),
      Attraction(icon: Icons.train, label: "Shinkansen"),
    ],
  ),
  DreamPlaceScreen(
    title: "Paryż, Francja",
    imagePath: Assets.images.paryz.path,
    placeName: "Wieża Eiffla",
    description:
        "Romantyczna atmosfera, pyszne croissanty i bagietki, zachwycające dzieła sztuki i zjawiskowa architektura.",
    attractions: const [
      Attraction(icon: Icons.location_city, label: "Miasto"),
      Attraction(icon: Icons.local_cafe, label: "Kawiarnie"),
      Attraction(icon: Icons.museum, label: "Muzea"),
      Attraction(icon: Icons.brush, label: "Sztuka"),
    ],
  ),
  DreamPlaceScreen(
    title: "Rzym, Włochy",
    imagePath: Assets.images.rzym.path,
    placeName: "Koloseum",
    description:
        "Historyczne ruiny osiągnięć przodków, starożytna architektura, wyjątkowa kuchnia oraz klimat śródziemnomorski",
    attractions: const [
      Attraction(icon: Icons.history, label: "Historia"),
      Attraction(icon: Icons.local_pizza, label: "Pizza"),
      Attraction(icon: Icons.church, label: "Bazyliki"),
      Attraction(icon: Icons.local_cafe, label: "Kawiarnie"),
    ],
  ),
  DreamPlaceScreen(
    title: "Nowy Jork, USA",
    imagePath: Assets.images.nowyJork.path,
    placeName: "Statua Wolności",
    description:
        "Ikoniczne miasto, które nigdy nie śpi, z niekończącą się energią, kulturą i rozrywką oraz kolosalnymi wieżowcami.",
    attractions: const [
      Attraction(icon: Icons.location_city, label: "Miasto"),
      Attraction(icon: Icons.shopping_bag, label: "Zakupy"),
      Attraction(icon: Icons.music_note, label: "Muzyka"),
      Attraction(icon: Icons.park, label: "Central Park"),
    ],
  ),
  DreamPlaceScreen(
    title: "Kair, Egipt",
    imagePath: Assets.images.kair.path,
    placeName: "Wielkie Piramidy w Gizie",
    description:
        "Starożytne cuda świata, pustynny krajobraz z wielbłądami oraz bogata historia starożytnej cywilizacji.",
    attractions: const [
      Attraction(icon: Icons.beach_access, label: "Pustynia"),
      Attraction(icon: Icons.sailing, label: "Nil"),
      Attraction(icon: Icons.museum, label: "Muzea"),
      Attraction(icon: Icons.landscape, label: "Piramidy"),
    ],
  ),
];

class DreamPlacesListScreen extends StatelessWidget {
  const DreamPlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Moje wymarzone miejsca")),
      body: ListView.separated(
        itemCount: places.length,
        separatorBuilder: (_, __) => const Divider(height: 4),
        itemBuilder: (context, index) {
          final place = places[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              horizontalTitleGap: 12,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  place.imagePath,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                place.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<DreamPlaceScreen>(
                    builder: (_) => place,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Attraction {
  final IconData icon;
  final String label;

  const Attraction({required this.icon, required this.label});
}

class DreamPlaceScreen extends StatefulWidget {
  final String title;
  final String imagePath;
  final String placeName;
  final String description;
  final List<Attraction> attractions;

  const DreamPlaceScreen({
    super.key,
    required this.title,
    required this.imagePath,
    required this.placeName,
    required this.description,
    required this.attractions,
  });

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[900],
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Hero(
                  tag: widget.title,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.placeName,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.attractions.map((attr) {
                return Column(
                  children: [
                    Icon(attr.icon, size: 40),
                    Text(attr.label),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
