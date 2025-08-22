import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "/features/places/places_provider.dart";
import "dream_place_screen.dart";

class PlaceScreenList extends ConsumerWidget {
  const PlaceScreenList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Dream places")),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return ListTile(
            title: Text(place.title),
            subtitle: Text(place.description),
            trailing: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: place.isFavorite ? Colors.red : null,
            ),
            onTap:() async {
              await context.push("${DreamPlaceScreen.route}/${place.id}");
            },
          );
        },
      ),
    );
  }
}
