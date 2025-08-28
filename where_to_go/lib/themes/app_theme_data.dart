import "package:flutter/material.dart";

abstract interface class AppThemeData {
  ThemeData get light => ThemeData.light();
  ThemeData get dark => ThemeData.dark();
}
