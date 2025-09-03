import "package:shared_preferences/shared_preferences.dart";

enum AppTheme {
  light,
  dark,
  system;

  factory AppTheme.fromString(String? value) => AppTheme.values.firstWhere(
        (e) => e.name == value,
        orElse: () => AppTheme.system,
      );
}

class LocalThemeRepository {
  final SharedPreferences _prefs;
  static const _themeKey = "app_theme";

  LocalThemeRepository(this._prefs);

  AppTheme getTheme() {
    final themeString = _prefs.getString(_themeKey);
    return AppTheme.fromString(themeString);
  }

  Future<void> setTheme(AppTheme theme) async {
    await _prefs.setString(_themeKey, theme.name);
  }
}
