import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "features/places/places_provider.dart";
import "gen/assets.gen.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen();

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
