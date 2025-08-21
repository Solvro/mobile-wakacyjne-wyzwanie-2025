import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "app_router.dart" show goRouter;
import "places_provider.dart";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
    );
  }
}

class DreamPlace {
  final int id;
  final String title;
  final String imagePath;
  final String title2;
  final String description;
  final List<ListOfAtt> attractions;
  final bool isFavorite;
  const DreamPlace(
      {required this.id,
      required this.title,
      required this.title2,
      required this.description,
      required this.imagePath,
      required this.attractions,
      this.isFavorite = false});

  DreamPlace copyWith({required bool isFavourite}) {
    return DreamPlace(
      id: id,
      title: title,
      title2: title2,
      description: description,
      imagePath: imagePath,
      attractions: attractions,
      isFavorite: isFavourite,
    );
  }
}

class ListOfAtt {
  final IconData icon;
  final String subtitle;
  const ListOfAtt({required this.icon, required this.subtitle});
}

class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listofplaces = ref.watch(dreamPlacesProvider);
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
                      await context.push("/${DreamPlaceScreen.route}/${e.id}");
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

class DreamPlaceScreen extends ConsumerWidget {
  const DreamPlaceScreen({super.key, required this.id});
  final int id;

  static const route = "places";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(singleDreamPlaceProvider(id));

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
              onPressed: () {
                ref.read(dreamPlacesProvider.notifier).toggleFavorite(id);
              },
              icon: Icon(
                place.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: place.isFavorite ? const Color.fromARGB(255, 174, 14, 14) : colorAccent,
              ))
        ],
        iconTheme: const IconThemeData(
          color: colorAccent,
        ),
      ),
    );
  }
}
