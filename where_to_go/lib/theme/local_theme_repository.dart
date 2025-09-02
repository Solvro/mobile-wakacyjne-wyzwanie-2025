import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../shared_preferences_provider.dart";

abstract class ThemeRepository {
  Future<AppThemeMode> loadTheme();
  Future<void> saveTheme(AppThemeMode theme);
}

class LocalThemeRepository implements ThemeRepository {
  final SharedPreferences prefs;
  LocalThemeRepository(this.prefs);

  @override
  Future<AppThemeMode> loadTheme() async {
    final themeName = prefs.getString(themeKey) ?? AppThemeMode.light.name;
    return AppThemeMode.fromString(themeName);
  }

  @override
  Future<void> saveTheme(AppThemeMode theme) async {
    await prefs.setString(themeKey, theme.name);
  }
}

const themeKey = "app_theme";

enum AppThemeMode {
  light,
  dark,
  system;

  factory AppThemeMode.fromString(String value) => AppThemeMode.values.firstWhere(
        (e) => e.name == value,
        orElse: () => AppThemeMode.system,
      );
}

final themeRepositoryProvider = FutureProvider<ThemeRepository>((ref) async {
  final prefs = await ref.read(sharedPreferencesProvider.future);
  return LocalThemeRepository(prefs);
});
