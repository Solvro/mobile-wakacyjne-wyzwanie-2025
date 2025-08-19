import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hello_flutter/gen/assets.gen.dart';
import 'package:hello_flutter/models/activity_model.dart';
import 'package:hello_flutter/models/dream_place_model.dart';
import 'package:hello_flutter/widgets/appBar_widget.dart';
import 'package:hello_flutter/screens/dream_place_screen.dart';

class DreamPlaceScreen_Hook extends HookWidget {
  const DreamPlaceScreen_Hook({
    super.key,
    required this.place,
    this.backgroundColor = const Color.fromRGBO(39, 39, 87, 1),
    this.iconColor = Colors.white,
    this.customActionIcon,
    this.customActionTooltip,
    this.customActionOnPressed,
  });

  final DreamPlace place;
  final Color backgroundColor;
  final Color iconColor;

  final IconData? customActionIcon;
  final String? customActionTooltip;
  final VoidCallback? customActionOnPressed;

  void toggleFavorite(BuildContext context, ValueNotifier<bool> isFavorited) {
    isFavorited.value = !isFavorited.value;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorited.value ? 'Dodano do ulubionych' : 'Usunięto z ulubionych',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth > 932 ? 900 : screenWidth * 0.95;
    final isFavorited = useState(false);

    Widget actionButton;

    if (customActionIcon != null && customActionOnPressed != null) {
      actionButton = IconButton(
        icon: Icon(customActionIcon, color: iconColor),
        tooltip: customActionTooltip,
        onPressed: customActionOnPressed,
      );
    } else {
      actionButton = IconButton(
        icon: isFavorited.value
            ? const Icon(Icons.favorite, color: Colors.red)
            : Icon(Icons.favorite_border, color: iconColor),
        tooltip: 'Ulubione',
        onPressed: () => toggleFavorite(context, isFavorited),
      );
    }
    return Scaffold(
      appBar: AppBarExample(
        appBarTitle: place.title,
        favoriteButton: actionButton,
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
