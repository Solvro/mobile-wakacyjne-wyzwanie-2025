import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
//import "features/favorite/favorite_provider.dart";
//import "features/places/place.dart";
import "app_router.dart";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
    );
  }
}

/*class Place {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;
  final String subtitle;
  final String imagePath;
  final Color backgroundColor;
  const Place({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.subtitle,
    required this.imagePath,
    required this.backgroundColor,
  });
  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      description: description,
      isFavorite: isFavorite ?? this.isFavorite,
      subtitle: subtitle,
      imagePath: imagePath,
      backgroundColor: backgroundColor,
    );
  }
}

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final places = <Place>[
      const Place(
        id: "1",
        title: "Manchester, Anglia",
        subtitle: "Miasto futbolu",
        imagePath: "assets/images/manchester.jpg",
        description: "• Piłka nożna\n• Architektura",
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        isFavorite: false,
      ),
      const Place(
        id: "2",
        title: "Santorini, Grecja",
        subtitle: "Grecja",
        imagePath: "assets/images/santorini.jpg",
        description: "• Zachody słońca\n• Morze",
        backgroundColor: Color(0xFF1E88E5),
        isFavorite: false,
      ),
      const Place(
        id: "3",
        title: "Barcelona, Hiszpania",
        subtitle: "Katalonia",
        imagePath: "assets/images/barcelona.jpg",
        description: "• FcBarcelona\n• Plaże i tapas",
        backgroundColor: Color.fromARGB(255, 255, 123, 0),
        isFavorite: false,
      ),
      const Place(
        id: "4",
        title: "Rzym, Włochy",
        subtitle: "Makaron",
        imagePath: "assets/images/rzym.jpg",
        description: "• Koloseum\n• Pizza i espresso",
        backgroundColor: Color.fromARGB(255, 94, 255, 0),
        isFavorite: false,
      ),
      const Place(
        id: "5",
        title: "Paryż, Francja",
        subtitle: "Wieża",
        imagePath: "assets/images/paryz.jpg",
        description: "• Wieża Eiffla\n• Korki",
        backgroundColor: Color.fromARGB(255, 0, 17, 255),
        isFavorite: false,
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

class DreamPlaceScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorited = ref.watch(favoriteProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(favoriteProvider.notifier).toggle();
            },
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
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
*/
