enum ModeTheme {
  light,
  dark,
  system;

  factory ModeTheme.fromString(String value) => ModeTheme.values.firstWhere(
        (e) => e.name == value,
        orElse: () => ModeTheme.system,
      );
}
