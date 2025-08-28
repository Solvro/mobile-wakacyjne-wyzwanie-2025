import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "../features/places/places_provider.dart";
import "details_screen.dart";

class DreamPlaceScreen extends ConsumerWidget {
  const DreamPlaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8DD),
      appBar: AppBar(
        title: const Text("Ulubione miejsca!", style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.amber[200],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return GestureDetector(
            onTap: () => GoRouter.of(context).push("${DetailsScreen.route}/${place.id}"),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.yellow[600],
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        place.imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              place.title,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Icon(
                            place.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: place.isFavorite ? Colors.red : Colors.black,
                            size: 18,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
