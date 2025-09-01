import "../theme_mode.dart";

abstract class LocalThemeRepository {
  Future<void> saveThemeMode(ThemeMode themeMode);
  Future<ThemeMode> getThemeMode();
}
