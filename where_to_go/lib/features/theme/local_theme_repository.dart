import "package:shared_preferences/shared_preferences.dart";

/// 3 opcje: system (czyli brak zapisu = bierz z urządzenia), light, dark
enum ThemeChoice { system, light, dark }

class LocalThemeRepository {
  static const _key = "theme_choice"; // klucz w SharedPreferences

  /// Odczyt wyboru. Jeśli brak – traktujemy jako system.
  Future<ThemeChoice> load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);
    switch (value) {
      case "light":
        return ThemeChoice.light;
      case "dark":
        return ThemeChoice.dark;
      default:
        return ThemeChoice.system;
    }
  }

  /// Zapis wyboru. Jeśli system – usuwamy klucz.
  Future<void> save(ThemeChoice choice) async {
    final prefs = await SharedPreferences.getInstance();
    if (choice == ThemeChoice.system) {
      await prefs.remove(_key);
    } else {
      await prefs.setString(_key, choice.name);
    }
  }
}
