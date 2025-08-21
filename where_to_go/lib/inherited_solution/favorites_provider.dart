import "package:flutter/material.dart";

class FavoritesProvider extends InheritedWidget {
  final Set<String> favorites;
  final void Function(String place) toggleFavorite;

  const FavoritesProvider({
    super.key,
    required super.child,
    required this.favorites,
    required this.toggleFavorite,
  });

  static FavoritesProvider of(BuildContext context) {
    final FavoritesProvider? result = context.dependOnInheritedWidgetOfExactType<FavoritesProvider>();
    assert(result != null, "Brak FavoritesProvidera w tym kontekście");
    return result!;
  }

  @override
  bool updateShouldNotify(FavoritesProvider oldWidget) {
    return oldWidget.favorites != favorites;
  }
}
