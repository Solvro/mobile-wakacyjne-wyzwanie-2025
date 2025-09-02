import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../providers/places_provider.dart";
import "../providers/theme_provider.dart";

class DetailsScreen extends ConsumerWidget {
  const DetailsScreen({required this.id, super.key});
  final String id;

  static String get route => "DetailsScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placesProvider)[int.parse(id)];
    final theme = ref.watch(themesProvider);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(place.placeText, style: TextStyle(color: theme.color)),
        backgroundColor: theme.primary,
        actions: [
          IconButton(
              onPressed: () async {
                await ref.read(placesProvider.notifier).toggleFavorite(id);
              },
              icon: Icon(place.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: place.isFavorite ? theme.red : theme.color)
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            place.image,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.titleText,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(place.descriptionText, style: TextStyle(color: theme.black))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: place.attractions
                .map((att) => Column(
                      children: [
                        Icon(
                          IconData(
                            att.icon,
                            fontFamily: "MaterialIcons", // usually this is the font family for Flutter Material icons
                          ),
                          color: theme.black,
                        ),
                        Text(att.text, style: TextStyle(color: theme.black))
                      ],
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
