import "package:flutter/widgets.dart";

import "../../models/place.dart";
import "../../utils/place_list.dart";
import "../../utils/places_widget_inherited.dart";

class PlacesInherited extends StatefulWidget {
  final Widget child;

  const PlacesInherited({super.key, required this.child});

  @override
  State<PlacesInherited> createState() => _PlaceInheritedState();
}

class _PlaceInheritedState extends State<PlacesInherited> {
  List<Place> _initialPlaces = placesList;

  void toggleFavorite(String id) {
    setState(() {
      _initialPlaces = _initialPlaces
          .map((place) => place.id == id ? place.copyWith(isFavorite: !place.isFavorite) : place)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlacesWidgetInherited(places: _initialPlaces, toggleFavorite: toggleFavorite, child: widget.child);
  }
}
