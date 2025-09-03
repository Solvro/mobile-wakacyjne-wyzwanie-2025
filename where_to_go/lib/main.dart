import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/database/dream_place_provider.dart";
import "hook_solution/my_app_hook.dart"; // ignore: unused_import
import "inherited_solution/my_app_inherited.dart"; // ignore: unused_import
import "my_app.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  final db = container.read(dreamPlaceDatabaseProvider);
  await db.seedDatabase();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
