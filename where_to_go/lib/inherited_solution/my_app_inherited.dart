import "package:flutter/material.dart";
import "dream_places_list_inherited_widget.dart";
import "favorites_provider.dart";

class MyAppInherited extends StatefulWidget {
  const MyAppInherited({super.key});

  @override
  State<MyAppInherited> createState() => _MyAppInheritedState();
}

class _MyAppInheritedState extends State<MyAppInherited> {
  Set<String> _favorites = {};

  void _toggleFavorite(String place) {
    setState(() {
      final newFavorites = Set<String>.from(_favorites);
      if (newFavorites.contains(place)) {
        newFavorites.remove(place);
      } else {
        newFavorites.add(place);
      }
      _favorites = newFavorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FavoritesProvider(
      favorites: _favorites,
      toggleFavorite: _toggleFavorite,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.grey[50],
          scaffoldBackgroundColor: const Color.fromARGB(255, 236, 219, 249),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[50],
            foregroundColor: Colors.black,
            elevation: 2,
          ),
        ),
        home: const DreamPlacesListScreenInherited(),
      ),
    );
  }
}
