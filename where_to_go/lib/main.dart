import "package:flutter/material.dart";
import "gen/assets.gen.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "app_router.dart";
import "package:go_router/go_router.dart";
import "features/places/places_provider.dart";

void main() {
  runApp(ProviderScope(
      child: MaterialApp.router(
    routerConfig: goRouter,
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeScreen();
  }
}

class _HomeScreen extends ConsumerWidget {
  const _HomeScreen();

  Widget getImageWidget(dynamic imageSource) {
    if (imageSource is String) {
      return Image.asset(
        imageSource,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (imageSource is AssetGenImage) {
      return imageSource.image(
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
    return const ColoredBox(
      color: Colors.grey,
      child: Icon(Icons.image_not_supported, size: 50),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("My Favorite Places", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        ),
        body: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              for (final place in places)
                GestureDetector(
                  onTap: () async {
                    await context.push("/details/${place.id}");
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: place.image.image(
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  place.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(
                                place.isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: place.isFavorite ? Colors.red : null,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ].toList()));
  }
}

class DreamPlaceScreen extends ConsumerWidget {
  final String id;

  const DreamPlaceScreen({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavourited = ref.watch(placesProvider.select((places) => places.firstWhere((p) => p.id == id).isFavorite));
    final icon = isFavourited ? Icons.favorite : Icons.favorite_border;

    final places = ref.watch(placesProvider);
    final place = places.firstWhere((p) => p.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
        actions: [
          IconButton(
            icon: Icon(
              icon,
              color: isFavourited ? Colors.red : Colors.black,
              size: 28,
            ),
            onPressed: () {
              ref.read(placesProvider.notifier).toggleFavorite(id);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          place.image.image(
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Text(place.description),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: place.attractions.entries
                  .map((entry) => Column(
                        children: [
                          Icon(entry.value),
                          Text(entry.key),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
