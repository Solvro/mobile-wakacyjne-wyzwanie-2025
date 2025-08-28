import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'local_theme.dart';

final localThemeRepositoryProvider = Provider<LocalThemeRepository>((ref) {
  return LocalThemeRepositoryPrefs();
});

class ThemeChoiceController extends AsyncNotifier<AppThemeChoice> {
  @override
  Future<AppThemeChoice> build() async {
    final repo = ref.read(localThemeRepositoryProvider);
    final saved = await repo.readThemeChoice();
    return saved ?? AppThemeChoice.system;
  }

  Future<void> setChoice(AppThemeChoice choice) async {
    state = AsyncValue.data(choice);
    final repo = ref.read(localThemeRepositoryProvider);
    await repo.writeThemeChoice(choice);
  }
}

final themeChoiceProvider =
    AsyncNotifierProvider<ThemeChoiceController, AppThemeChoice>(
  ThemeChoiceController.new,
);

ThemeMode mapChoiceToThemeMode(
  AppThemeChoice choice,
  Brightness platformBrightness,
) {
  switch (choice) {
    case AppThemeChoice.light:
      return ThemeMode.light;
    case AppThemeChoice.dark:
      return ThemeMode.dark;
    case AppThemeChoice.system:
      return ThemeMode.system;
  }
}
