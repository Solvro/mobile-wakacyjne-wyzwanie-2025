import "package:flutter/material.dart" show Color;
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../data_classes/theme.dart";

part "theme_provider.g.dart"; // to tworzy plik .g.dart przy generowaniu kodu

final List<Theme> themes = [
  const Theme(
      color: Color.fromARGB(255, 248, 231, 148),
      backgroundColor: Color.fromARGB(255, 123, 144, 118),
      primary: Color.fromARGB(255, 40, 65, 57),
      red: Color.fromARGB(255, 255, 0, 0),
      black: Color.fromARGB(255, 0, 0, 0)),
  const Theme(
      color: Color.fromARGB(255, 250, 219, 62),
      backgroundColor: Color.fromARGB(255, 10, 10, 10),
      primary: Color.fromARGB(255, 29, 29, 29),
      red: Color.fromARGB(255, 255, 0, 0),
      black: Color.fromARGB(255, 255, 255, 255))
];

@riverpod
class Themes extends _$Themes {
  @override
  Theme build() => themes[0];

  void toggleTheme({required bool isDark}) {
    state = themes[isDark ? 1 : 0];
  }
}
