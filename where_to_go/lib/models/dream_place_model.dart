import 'package:hello_flutter/gen/assets.gen.dart';
import 'activity_model.dart';

class DreamPlace {
  final String title;
  final AssetGenImage image;
  final String imageDescription;
  final String placeDescription;
  final List<Activity> activities;

  const DreamPlace({
    required this.title,
    required this.image,
    required this.imageDescription,
    required this.placeDescription,
    required this.activities,
  });
}
