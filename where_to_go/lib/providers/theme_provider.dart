// lib/features/theme/theme_provider.dart
import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../features/theme/local_theme_repository.dart";

// Provider for LocalThemeRepository
final localThemeRepositoryProvider = Provider<LocalThemeRepository>((ref) {
  return LocalThemeRepository();
});

// StateNotifierProvider to manage ThemeMode state
final themeControllerProvider = StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  final repo = ref.read(localThemeRepositoryProvider);
  return ThemeController(repo);
});

// Define light and dark themes
final light = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
  appBarTheme: const AppBarTheme(centerTitle: false),
  useMaterial3: true,
);

final dark = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber, brightness: Brightness.dark),
  appBarTheme: const AppBarTheme(centerTitle: false),
  useMaterial3: true,
);

// ThemeController to manage theme state
class ThemeController extends StateNotifier<ThemeMode> {
  final LocalThemeRepository _repo;

  ThemeController(this._repo) : super(ThemeMode.system) {
    unawaited(_init());
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
