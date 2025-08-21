import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../persistance/shared_preferences.dart";
import "../theme/theme_mode.dart";

part "local_theme_repository.g.dart";

abstract class ThemeRepository {
  Future<void> saveThemeMode(ThemeMode themeMode);
  Future<ThemeMode> getThemeMode();
}

class LocalThemeRepository implements ThemeRepository {
  const LocalThemeRepository(this._sharedPreferences);

  static const _themeKey = "themeMode";
  final SharedPreferencesWithCache _sharedPreferences;

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await _sharedPreferences.setString(_themeKey, themeMode.name);
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final themeMode = _sharedPreferences.getString(_themeKey) ?? ThemeMode.system.name;
    return ThemeMode.fromString(themeMode);
  }
}

@riverpod
Future<ThemeRepository> localThemeRepository(Ref ref) async {
  final sharedPreferences = await ref.read(sharedPreferencesWithCacheProvider.future);
  return LocalThemeRepository(sharedPreferences);
}
