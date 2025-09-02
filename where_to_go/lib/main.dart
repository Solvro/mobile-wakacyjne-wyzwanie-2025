import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive_flutter/hive_flutter.dart";

import "app.dart";
import "models/dream_place.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(DreamPlaceAdapter());

  await Hive.openBox<DreamPlace>("dream_places_box");

  runApp(const ProviderScope(child: MyApp()));
}
