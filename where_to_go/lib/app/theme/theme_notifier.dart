import "package:riverpod_annotation/riverpod_annotation.dart";
import "../repository/local_theme_repository.dart";
import "theme_mode.dart";

part "theme_notifier.g.dart";

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  Future<ThemeMode> build() async {
    final repository = await ref.read(localThemeRepositoryProvider.future);
    return repository.getThemeMode();
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final currentState = state.valueOrNull ?? ThemeMode.system;
    if (currentState == themeMode) return;
    state = AsyncData(themeMode);
    final repository = await ref.read(localThemeRepositoryProvider.future);
    await repository.saveThemeMode(themeMode);
  }
}
