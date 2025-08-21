import 'package:flutter/material.dart';
import 'package:hello_flutter/gen/assets.gen.dart';
import 'dart:math';
import 'package:hello_flutter/models/activity_model.dart';
import 'package:hello_flutter/models/dream_place_model.dart';
import 'package:hello_flutter/screens/dream_place_screen.dart';
import 'package:hello_flutter/widgets/appBar_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FavoriteProvider extends InheritedWidget {
  final bool isFavorited;
  final VoidCallback toggleFavorite;

  const FavoriteProvider({
    super.key,
    required this.isFavorited,
    required this.toggleFavorite,
    required super.child,
  });

  static FavoriteProvider of(BuildContext context) {
    final FavoriteProvider? result = context
        .dependOnInheritedWidgetOfExactType<FavoriteProvider>();
    assert(result != null, 'No FavoriteProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(FavoriteProvider oldWidget) {
    return isFavorited != oldWidget.isFavorited;
  }
}

class DreamPlaceScreen_InheritanceWidget extends HookWidget {
  const DreamPlaceScreen_InheritanceWidget({
    super.key,
    required this.place,
    this.backgroundColor = const Color.fromRGBO(39, 39, 87, 1),
    this.iconColor = Colors.white,
    this.actionButton,
  });
  static const String route = '/inheritance';
  final DreamPlace place;
  final Color backgroundColor;
  final Color iconColor;
  final Widget? actionButton;

  @override
  Widget build(BuildContext context) {
    final isFavorited = useState(false);

    void toggleFavorite() {
      isFavorited.value = !isFavorited.value;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isFavorited.value
                ? 'Dodano do ulubionych'
                : 'Usunięto z ulubionych',
          ),
        ),
      );
    }

    return FavoriteProvider(
      isFavorited: isFavorited.value,
      toggleFavorite: toggleFavorite,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBarExample(
              appBarTitle: place.title,
              favoriteButton:
                  actionButton ??
                  IconButton(
                    icon: FavoriteProvider.of(context).isFavorited
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite_border, color: iconColor),
                    tooltip: 'Ulubione',
                    onPressed: FavoriteProvider.of(context).toggleFavorite,
                  ),
            ),
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width > 932
                      ? 900
                      : MediaQuery.of(context).size.width * 0.95,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: MainContainer(
                    backgroundImage: place.image,
                    descriptionImageText: place.imageDescription,
                    descriptionText: place.placeDescription,
                    activities: place.activities,
                    iconColor: iconColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
