import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeChoice { system, light, dark }

abstract class LocalThemeRepository {
  Future<AppThemeChoice?> readThemeChoice();
  Future<void> writeThemeChoice(AppThemeChoice choice);
}

class LocalThemeRepositoryPrefs implements LocalThemeRepository {
  static const _key = 'app_theme_choice';

  @override
  Future<AppThemeChoice?> readThemeChoice() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);
    if (value == null) return null;
    return AppThemeChoice.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AppThemeChoice.system,
    );
  }

  @override
  Future<void> writeThemeChoice(AppThemeChoice choice) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, choice.name);
  }
}
