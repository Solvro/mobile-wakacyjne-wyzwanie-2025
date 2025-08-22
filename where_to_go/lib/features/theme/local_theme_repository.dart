import "package:shared_preferences/shared_preferences.dart";

enum LocalTheme {
  light,
  dark,
  system,
}

abstract class ThemeRepository {
  Future<LocalTheme> getTheme();
  Future<void> setTheme(LocalTheme theme);
}

class LocalThemeRepository extends ThemeRepository {
  final _key = "app_theme";

  @override
  Future<LocalTheme> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);
    return value != null ? LocalTheme.values.firstWhere((e) => e.toString() == value) : LocalTheme.system;
  }

  @override
  Future<void> setTheme(LocalTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, theme.toString());
  }
}
