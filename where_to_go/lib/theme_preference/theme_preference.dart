import "package:shared_preferences/shared_preferences.dart";

class ThemePreference {
  static late SharedPreferences _preferences;

  static const _keyTheme = "theme";

  static Future<dynamic> init() async => _preferences = await SharedPreferences.getInstance();

  static Future<dynamic> setTheme({required bool isDark}) async => _preferences.setBool(_keyTheme, isDark);

  static bool? getTheme() => _preferences.getBool(_keyTheme);
}
