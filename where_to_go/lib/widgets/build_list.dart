import "package:flutter/material.dart";

import "../models/place.dart";
import "../views/dream_place_screen_hook.dart";

class BuildList extends StatelessWidget {
  final Place place;
  final int index;

  const BuildList({super.key, required this.place, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            PageRouteBuilder<void>(
              pageBuilder: (context, animation, secondaryAnimation) => DreamPlaceScreenHook(place: place),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0, 1);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(place.path, width: double.infinity, height: 200, fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(place.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )))
          ],
        ),
      ),
    );
  }
}
