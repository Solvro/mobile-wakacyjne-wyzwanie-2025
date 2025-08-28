enum ThemeMode {
  system,
  light,
  dark;

  factory ThemeMode.fromString(String value) {
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.system,
    );
  }
}
