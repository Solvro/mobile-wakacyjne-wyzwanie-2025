import "package:riverpod_annotation/riverpod_annotation.dart";
import "local_theme_repository.dart";

part "theme_notifier.g.dart";

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  Future<AppThemeMode> build() async {
    final repository = await ref.read(themeRepositoryProvider.future);
    return repository.loadTheme();
  }

  Future<void> toggleTheme() async {
    final repository = await ref.read(themeRepositoryProvider.future);
    final myState = state.valueOrNull ?? AppThemeMode.system;
    final newTheme = myState == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light;
    state = AsyncValue.data(newTheme);
    await repository.saveTheme(newTheme);
  }
}
