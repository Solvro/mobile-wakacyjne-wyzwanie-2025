import "package:shared_preferences/shared_preferences.dart";

enum AppTheme { light, dark }

class LocalThemeRepository {
  static const _themeKey = "app_theme";

  Future<void> saveTheme(AppTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme.name);
  }

  Future<AppTheme?> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_themeKey);
    if (value == null) return null;
    return AppTheme.values.firstWhere((t) => t.name == value);
  }
}
