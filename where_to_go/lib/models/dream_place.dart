import 'package:hive/hive.dart';

part 'dream_place.g.dart';

@HiveType(typeId: 0)
class DreamPlace extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String imageUrl;

  DreamPlace({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}
