import 'package:flutter/material.dart';
import 'package:hello_flutter/gen/assets.gen.dart';
import 'package:hello_flutter/models/activity_model.dart';
import 'package:hello_flutter/models/dream_place_model.dart';
import 'package:hello_flutter/widgets/appBar_widget.dart';

class DreamPlaceScreen extends StatefulWidget {
  final DreamPlace place;
  final Color backgroundColor;
  final Color iconColor;

  const DreamPlaceScreen({
    super.key,
    required this.place,
    this.backgroundColor = const Color.fromRGBO(39, 39, 87, 1),
    this.iconColor = Colors.white,
  });

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorited ? 'Dodano do ulubionych' : 'Usunięto z ulubionych',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth > 932 ? 900 : screenWidth * 0.95;

    return Scaffold(
      appBar: AppBarExample(
        appBarTitle: widget.place.title,
        isFavorited: _isFavorited,
        onFavoritePressed: _toggleFavorite,
      ),
      backgroundColor: widget.backgroundColor,
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
              backgroundImage: widget.place.image,
              descriptionImageText: widget.place.imageDescription,
              descriptionText: widget.place.placeDescription,
              activities: widget.place.activities,
              iconColor: widget.iconColor,
            ),
          ),
        ),
      ),
    );
  }
}

class MainContainer extends StatelessWidget {
  final AssetGenImage backgroundImage;
  final String descriptionImageText;
  final String descriptionText;
  final List<Activity> activities;
  final Color iconColor;

  const MainContainer({
    super.key,
    required this.backgroundImage,
    required this.descriptionImageText,
    required this.descriptionText,
    required this.activities,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
      color: Colors.white.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.12),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );

    return Column(
      children: [
        Container(
          decoration: boxDecoration,
          child: ImageWithText(
            backgroundImage: backgroundImage,
            descriptionImageText: descriptionImageText,
            descriptionText: descriptionText,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: boxDecoration,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: ActivitiesRow(activities: activities, iconColor: iconColor),
        ),
      ],
    );
  }
}

class ImageWithText extends StatelessWidget {
  final AssetGenImage backgroundImage;
  final String descriptionImageText;
  final String descriptionText;

  const ImageWithText({
    super.key,
    required this.backgroundImage,
    required this.descriptionImageText,
    required this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: backgroundImage.image(
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                descriptionImageText,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                descriptionText,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ActivitiesRow extends StatelessWidget {
  final List<Activity> activities;
  final Color iconColor;

  const ActivitiesRow({
    super.key,
    required this.activities,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: activities.map((activity) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ActivityIcon(
                  iconData: activity.icon,
                  iconColor: iconColor,
                  iconDescription: activity.name,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        const Text(
          'Wybierz aktywność',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

class ActivityIcon extends StatelessWidget {
  final IconData iconData;
  final String iconDescription;
  final Color iconColor;

  const ActivityIcon({
    super.key,
    required this.iconData,
    required this.iconDescription,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, color: iconColor, size: 40),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              iconDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
