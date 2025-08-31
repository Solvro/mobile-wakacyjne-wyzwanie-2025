import "package:riverpod_annotation/riverpod_annotation.dart";
import "local_theme_repository.dart";

part "local_theme_provider.g.dart";

@riverpod
class LocalThemeNotifier extends _$LocalThemeNotifier {
  late final LocalThemeRepository _repository;

  @override
  FutureOr<LocalTheme> build() async {
    _repository = LocalThemeRepository();
    return await _repository.getTheme();
  }

  Future<void> toggleTheme() async {
    final currentTheme = state.value ?? LocalTheme.system;
    LocalTheme newTheme;
    if (currentTheme == LocalTheme.light) {
      newTheme = LocalTheme.dark;
    } else {
      newTheme = LocalTheme.light;
    }
    await _repository.setTheme(newTheme);
    state = AsyncData(newTheme);
  }
}
