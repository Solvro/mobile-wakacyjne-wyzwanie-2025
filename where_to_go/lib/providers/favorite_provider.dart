import "package:riverpod_annotation/riverpod_annotation.dart";

part "favorite_provider.g.dart"; // to tworzy plik .g.dart przy generowaniu kodu

@riverpod
class Favorite extends _$Favorite {
  @override
  bool build() {
    return false; // stan początkowy
  }

  void toggle() {
    state = !state; // zmiana stanu ulubionych
  }
}
