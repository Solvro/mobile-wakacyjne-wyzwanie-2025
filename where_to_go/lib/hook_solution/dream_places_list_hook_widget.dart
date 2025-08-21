import "package:flutter/material.dart";
import "../features/places/dream_places.dart";
import "dream_place_screen_hook_widget.dart";

class DreamPlacesListScreenHook extends StatelessWidget {
  const DreamPlacesListScreenHook({super.key});

  @override
  Widget build(BuildContext context) {
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
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute<DreamPlaceScreenHookWidget>(
                    builder: (_) => DreamPlaceScreenHookWidget(place: place),
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
