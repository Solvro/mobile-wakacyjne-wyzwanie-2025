import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../theme/repository/local_theme_repository.dart";
import "../../theme/theme_mode.dart";
import "../shared_preferences.dart";

part "local_theme_repository_impl.g.dart";

class LocalThemeRepositoryImpl implements LocalThemeRepository {
  const LocalThemeRepositoryImpl(this._sharedPreferences);

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
Future<LocalThemeRepository> localThemeRepository(Ref ref) async {
  final sharedPreferences = await ref.read(sharedPreferencesWithCacheProvider.future);
  return LocalThemeRepositoryImpl(sharedPreferences);
}
