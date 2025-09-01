import 'package:hive/hive.dart';

part 'dream_place.g.dart';

@HiveType(typeId: 0)
class DreamPlace extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? imageUrl;

  @HiveField(3)
  bool isFavorite;

  DreamPlace({
    required this.name,
    this.description,
    this.imageUrl,
    this.isFavorite = false,
  });
}
