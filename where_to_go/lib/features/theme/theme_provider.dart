// lib/features/theme/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local_theme_repository.dart';

final localThemeRepositoryProvider = Provider<LocalThemeRepository>((ref) {
  return LocalThemeRepository();
});

final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  final repo = ref.read(localThemeRepositoryProvider);
  return ThemeController(repo);
});

class ThemeController extends StateNotifier<ThemeMode> {
  final LocalThemeRepository _repo;

  ThemeController(this._repo) : super(ThemeMode.system) {
    _init();
  }

  Future<void> _init() async {
    final choice = await _repo.load();
    state = _mapChoice(choice);
  }

  ThemeMode _mapChoice(ThemeChoice c) {
    switch (c) {
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
