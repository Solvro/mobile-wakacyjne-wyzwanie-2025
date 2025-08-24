import "package:flutter/widgets.dart";

import "../models/place.dart";

class PlacesWidgetInherited extends InheritedWidget {
  final List<Place> places;
  final void Function(String) toggleFavorite;

  const PlacesWidgetInherited({super.key, required this.places, required this.toggleFavorite, required super.child});

  @override
  bool updateShouldNotify(covariant PlacesWidgetInherited oldWidget) {
    return places != oldWidget.places;
  }

  static PlacesWidgetInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PlacesWidgetInherited>()!;
  }
}
