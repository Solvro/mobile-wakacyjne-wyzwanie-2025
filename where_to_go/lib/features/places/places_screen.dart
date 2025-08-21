import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "details_screen.dart";
import "places_provider.dart";

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dream Place"), // stały tytuł na stronie głównej
      ),
      body: ListView.separated(
        itemCount: places.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, i) {
          final p = places[i];
          return ListTile(
              leading: Image.asset(
                p.imagePath,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
              title: Text(p.title),
              subtitle: Text(p.subtitle),
              trailing: Icon(
                p.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: p.isFavorite ? Colors.red : null,
              ),
              onTap: () {
                final id = p.id;
                unawaited(context.push("${DetailsScreen.route}/$id"));
                //GoRouter.of(context).push("${DetailsScreen.route}/$id");
              });
        },
      ),
    );
  }
}
