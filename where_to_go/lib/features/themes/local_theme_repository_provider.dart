import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../shared_preferences/shared_preferences_provider.dart";
import "local_theme_repository.dart";

part "local_theme_repository_provider.g.dart";

@riverpod
LocalThemeRepository localThemeRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider).maybeWhen(
        data: (prefs) => prefs,
        orElse: () => throw Exception("SharedPreferences not initialized"),
      );
  return LocalThemeRepository(prefs);
}
