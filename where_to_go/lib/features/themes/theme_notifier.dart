import "package:riverpod_annotation/riverpod_annotation.dart";
import "local_theme_repository.dart";
import "local_theme_repository_provider.dart";

part "theme_notifier.g.dart";

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  Future<AppTheme> build() async {
    final repo = ref.watch(localThemeRepositoryProvider);
    return repo.getTheme();
  }

  Future<void> toggleTheme() async {
    final repo = ref.watch(localThemeRepositoryProvider);

    final myState = state.valueOrNull ?? AppTheme.system;
    final newTheme = switch (myState) {
      AppTheme.light => AppTheme.dark,
      AppTheme.dark => AppTheme.light,
      AppTheme.system => AppTheme.light,
    };

    state = AsyncData(newTheme);
    await repo.setTheme(newTheme);
  }
}
