import "package:flutter/material.dart";
import "../../../data/places.dart";
import "../../../models/dream_place.dart";
import "places_inherited_provider.dart";

class PlacesInheritedWrapper extends StatefulWidget {
  final Widget child;

  const PlacesInheritedWrapper({super.key, required this.child});

  @override
  State<PlacesInheritedWrapper> createState() => _PlacesInheritedWrapperState();
}

class _PlacesInheritedWrapperState extends State<PlacesInheritedWrapper> {
  List<DreamPlace> _places = dreamPlacesList;

  void toggleFavorite(String id) {
    setState(() {
      _places = [
        for (final p in _places)
          if (p.id == id) p.copyWith(isFavorited: !p.isFavorited) else p
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DreamPlacesInheritedProvider(
      places: _places,
      toggleFavorite: toggleFavorite,
      child: widget.child,
    );
  }
}
