import "package:flutter/material.dart";
import "../features/places/dream_places.dart";
import "dream_place_screen_inherited_widget.dart";
import "favorites_provider.dart";

class DreamPlacesListScreenInherited extends StatefulWidget {
  const DreamPlacesListScreenInherited({super.key});

  @override
  State<DreamPlacesListScreenInherited> createState() => _DreamPlacesListScreenInheritedState();
}

class _DreamPlacesListScreenInheritedState extends State<DreamPlacesListScreenInherited> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoritesProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Moje wymarzone miejsca")),
      body: ListView.separated(
        itemCount: places.length,
        separatorBuilder: (_, __) => const Divider(height: 4),
        itemBuilder: (context, index) {
          final place = places[index];
          final isFavorited = provider.favorites.contains(place.title);

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
                isFavorited ? Icons.favorite : Icons.favorite_border,
                color: isFavorited ? Colors.red : null,
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute<DreamPlaceScreenInheritedWidget>(
                    builder: (_) => DreamPlaceScreenInheritedWidget(place: place),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
