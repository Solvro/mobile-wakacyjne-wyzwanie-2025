import 'package:hello_flutter/gen/assets.gen.dart';
import 'activity_model.dart';

class DreamPlace {
  final String title;
  final AssetGenImage image;
  final String imageDescription;
  final String placeDescription;
  final List<Activity> activities;
  final bool isFavorite;

  DreamPlace({
    required this.title,
    required this.image,
    required this.imageDescription,
    required this.placeDescription,
    required this.activities,
    this.isFavorite = false,
  });

  DreamPlace copyWith({
    String? title,
    AssetGenImage? image,
    String? imageDescription,
    String? placeDescription,
    List<Activity>? activities,
    bool? isFavorite,
  }) {
    return DreamPlace(
      title: title ?? this.title,
      image: image ?? this.image,
      imageDescription: imageDescription ?? this.imageDescription,
      placeDescription: placeDescription ?? this.placeDescription,
      activities: activities ?? this.activities,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
