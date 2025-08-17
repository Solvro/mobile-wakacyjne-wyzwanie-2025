import 'gen/assets.gen.dart';

class Place {
  final String title;
  final String subtitle;
  final String description;
  final AssetGenImage image;

  const Place({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
  });
}
