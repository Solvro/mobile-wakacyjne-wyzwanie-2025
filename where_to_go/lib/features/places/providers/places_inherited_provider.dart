import "package:flutter/material.dart";
import "../../../data/models/dream_place.dart";

class DreamPlacesInheritedProvider extends InheritedWidget {
  final List<DreamPlace> places;
  final void Function(String id) toggleFavorite;

  const DreamPlacesInheritedProvider({
    super.key,
    required super.child,
    required this.places,
    required this.toggleFavorite,
  });

  static DreamPlacesInheritedProvider of(BuildContext context) {
    final DreamPlacesInheritedProvider? result =
        context.dependOnInheritedWidgetOfExactType<DreamPlacesInheritedProvider>();
    assert(result != null, "No DreamPlacesProvider found in context");
    return result!;
  }

  @override
  bool updateShouldNotify(DreamPlacesInheritedProvider oldWidget) {
    return places != oldWidget.places;
  }
}
