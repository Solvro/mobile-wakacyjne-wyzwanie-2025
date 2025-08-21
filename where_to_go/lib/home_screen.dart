import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "details_screen.dart";
import "features/places/places_provider.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

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
              trailing: Icon(
                place.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: place.isFavorite ? Colors.red : null,
              ),
              onTap: () async {
                await GoRouter.of(context).push("${DetailsScreen.route}/${place.id}");
              },
            ),
          );
        },
      ),
    );
  }
}
