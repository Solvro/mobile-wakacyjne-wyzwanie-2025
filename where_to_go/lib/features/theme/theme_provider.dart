import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "local_theme_repository.dart";

final localThemeRepositoryProvider = Provider<LocalThemeRepository>((ref) {
  return LocalThemeRepository();
});

final themeControllerProvider = StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  return ThemeController(ref.read(localThemeRepositoryProvider));
});

class ThemeController extends StateNotifier<ThemeMode> {
  ThemeController(this._repo) : super(ThemeMode.system) {
    _init();
  }

  final LocalThemeRepository _repo;

  Future<void> _init() async {
    final choice = await _repo.load();
    state = _mapChoice(choice);
  }

  ThemeMode _mapChoice(ThemeChoice choice) {
    switch (choice) {
      case ThemeChoice.light:
        return ThemeMode.light;
      case ThemeChoice.dark:
        return ThemeMode.dark;
      case ThemeChoice.system:
        return ThemeMode.system;
    }
  }

  Future<void> setChoice(ThemeChoice choice) async {
    await _repo.save(choice);
    state = _mapChoice(choice);
  }
}
