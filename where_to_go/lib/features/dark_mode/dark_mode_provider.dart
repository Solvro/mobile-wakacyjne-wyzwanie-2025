import "package:riverpod_annotation/riverpod_annotation.dart";

part "dark_mode_provider.g.dart";

@riverpod
class DarkMode extends _$DarkMode {
  @override
  bool build() {
    return false; // stan początkowy
  }

  void toggle() {
    // metoda pozwaląca zmienić stan providera
    state = !state;
  }
}
