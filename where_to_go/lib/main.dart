import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PlacesListScreen(),
    );
  }
}

class Place {
  final String title;
  final String subtitle;
  final String imagePath;
  final String description;
  final Color backgroundColor;
  const Place({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.description,
    required this.backgroundColor,
  });
}

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final places = <Place>[
      const Place(
        title: "Manchester, Anglia",
        subtitle: "Miasto futbolu",
        imagePath: "assets/images/manchester.jpg",
        description: "• Piłka nożna\n• Architektura",
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
      ),
      const Place(
        title: "Santorini, Grecja",
        subtitle: "Grecja",
        imagePath: "assets/images/santorini.jpg",
        description: "• Zachody słońca\n• Morze",
        backgroundColor: Color(0xFF1E88E5),
      ),
      const Place(
        title: "Barcelona, Hiszpania",
        subtitle: "Katalonia",
        imagePath: "assets/images/barcelona.jpg",
        description: "• FcBarcelona\n• Plaże i tapas",
        backgroundColor: Color.fromARGB(255, 255, 123, 0),
      ),
      const Place(
        title: "Rzym, Włochy",
        subtitle: "Makaron",
        imagePath: "assets/images/rzym.jpg",
        description: "• Koloseum\n• Pizza i espresso",
        backgroundColor: Color.fromARGB(255, 94, 255, 0),
      ),
      const Place(
        title: "Paryż, Francja",
        subtitle: "Wieża",
        imagePath: "assets/images/paryz.jpg",
        description: "• Wieża Eiffla\n• Korki",
        backgroundColor: Color.fromARGB(255, 0, 17, 255),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Dream Place")),
      body: ListView.separated(
        itemCount: places.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, i) {
          final p = places[i];
          return ListTile(
            leading: Image.asset(p.imagePath, width: 56, height: 56, fit: BoxFit.cover),
            title: Text(p.title),
            subtitle: Text(p.subtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<DreamPlaceScreen>(
                  builder: (context) {
                    return DreamPlaceScreen(
                      title: p.title,
                      imagePath: p.imagePath,
                      description: p.description,
                      backgroundColor: p.backgroundColor,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DreamPlaceScreen extends StatefulWidget {
  const DreamPlaceScreen({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.backgroundColor,
  });

  final String title;
  final String imagePath;
  final String description;
  final Color backgroundColor;

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  bool isFavorited = false;

  void toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: toggleFavorite,
            icon: Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(widget.imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 16, height: 1.3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.wb_sunny, size: 28),
                  SizedBox(height: 4),
                  Text("Słońce", style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.beach_access, size: 28),
                  SizedBox(height: 4),
                  Text("Plaże", style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.restaurant, size: 28),
                  SizedBox(height: 4),
                  Text("Jedzenie", style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.sailing, size: 28),
                  SizedBox(height: 4),
                  Text("Rejsy", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
