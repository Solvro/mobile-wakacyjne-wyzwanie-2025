import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hello_flutter/gen/assets.gen.dart';
import 'package:hello_flutter/models/activity_model.dart';
import 'package:hello_flutter/models/dream_place_model.dart';
import 'package:hello_flutter/widgets/appBar_widget.dart';
import 'package:hello_flutter/features/favorite/favorite_provider.dart';
import 'package:hello_flutter/screens/dream_place_screen.dart';

class DreamPlaceScreen extends ConsumerWidget {
  final DreamPlace place;
  final Color backgroundColor;
  final Color iconColor;
  final Widget? actionButton;

  const DreamPlaceScreen({
    super.key,
    required this.place,
    this.backgroundColor = const Color.fromRGBO(39, 39, 87, 1),
    this.iconColor = Colors.white,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorited = ref.watch(favoriteProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth > 932 ? 900 : screenWidth * 0.95;

    void toggleFavorite() {
      ref.read(favoriteProvider.notifier).toggle();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            !isFavorited ? 'Dodano do ulubionych' : 'Usunięto z ulubionych',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBarExample(
        appBarTitle: place.title,
        favoriteButton:
            actionButton ??
            IconButton(
              icon: isFavorited
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_border, color: iconColor),
              tooltip: 'Ulubione',
              onPressed: toggleFavorite,
            ),
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: containerWidth,
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
  }
}
