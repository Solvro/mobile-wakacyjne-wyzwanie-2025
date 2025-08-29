import "dart:async";
import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "local_theme_repository.dart";

part "theme_provider.g.dart";

@Riverpod(keepAlive: true)
class ThemeNotifier extends _$ThemeNotifier {
  late final LocalThemeRepository _repo;

  @override
  ThemeMode build() {
    _repo = LocalThemeRepository();

    unawaited(_loadTheme());

    return ThemeMode.system;
  }

  Future<void> _loadTheme() async {
    final saved = await _repo.loadTheme();
    if (saved == null) {
      state = ThemeMode.system;
    } else if (saved == AppTheme.light) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }

  Future<void> setTheme(AppTheme theme) async {
    state = theme == AppTheme.light ? ThemeMode.light : ThemeMode.dark;
    await _repo.saveTheme(theme);
  }
}
