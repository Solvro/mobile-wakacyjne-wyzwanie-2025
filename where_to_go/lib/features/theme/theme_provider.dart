import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../themes/enums/mode_theme.dart";
import "repository_provider.dart";

part "theme_provider.g.dart";

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  Future<ModeTheme> build() async {
    final repository = await ref.watch(localThemeRepositoryProvider.future);
    return repository.getTheme();
  }

  Future<void> setTheme(ModeTheme theme) async {
    state = AsyncData(theme);
    final repository = await ref.read(localThemeRepositoryProvider.future);
    await repository.setTheme(theme);
  }

  Future<void> toggleTheme() async {
    final myState = state.valueOrNull ?? ModeTheme.system;
    final ModeTheme newTheme = myState == ModeTheme.light ? ModeTheme.dark : ModeTheme.light;
    await setTheme(newTheme);
  }
}
