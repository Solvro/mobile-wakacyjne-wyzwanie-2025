import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../../theme/selector.dart";

import "details_screen.dart";
import "dreamplace.dart";
import "dreamplace_providers.dart";

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(dreamPlacesStreamProvider);
    final repo = ref.read(dreamPlacesRepositoryProvider);

    return placesAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        body: Center(child: Text("Błąd: $err")),
      ),
      data: (List<DreamPlace> places) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Dream Place"),
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ThemeSelector(),
              ),
            ],
          ),
          body: ListView.separated(
            itemCount: places.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final p = places[i];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    p.assetPath,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(p.name),
                subtitle: Text(p.description),
                trailing: IconButton(
                  icon: Icon(
                    p.isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: p.isFavourite ? Colors.red : null,
                  ),
                  onPressed: () => repo.toggleFavourite(p.id),
                ),
                onTap: () {
                  unawaited(context.push("${DetailsScreen.route}/${p.id}"));
                },
              );
            },
          ),
        );
      },
    );
  }
}
