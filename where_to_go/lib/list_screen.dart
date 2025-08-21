import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "dream_places_screen.dart";
import "places_provider.dart";

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
