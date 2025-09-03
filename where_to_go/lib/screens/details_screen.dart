// details_screen.dart
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "../controllers/dream_places_controller.dart";

class DetailsScreen extends ConsumerWidget {
  static const route = "/details";

  final int placeId;

  const DetailsScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(dreamPlacesControllerProvider);
    final DreamPlace? place = places.cast<DreamPlace?>().firstWhere(
          (p) => p?.id == placeId,
          orElse: () => null,
        );

    if (place == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go("/"),
          ),
          title: const Text("Szczegóły"),
        ),
        body: const Center(child: Text("Nie znaleziono miejsca")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go("/"),
        ),
        title: Text(place.name),
        actions: [
          IconButton(
            icon: Icon(place.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: place.isFavorite ? Colors.red : null,
            onPressed: () async {
              await ref.read(dreamPlacesControllerProvider.notifier).toggleFavorite(place);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (place.imageUrl != null && place.imageUrl!.isNotEmpty)
              Image.network(
                place.imageUrl!,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => const SizedBox(
                  height: 300,
                  child: Center(child: Icon(Icons.broken_image)),
                ),
              )
            else
              const SizedBox(
                height: 300,
                child: Center(child: Icon(Icons.image)),
              ),
            const SizedBox(height: 20),
            Text(place.name, style: const TextStyle(fontSize: 32)),
            if (place.description != null && place.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  place.description!,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
