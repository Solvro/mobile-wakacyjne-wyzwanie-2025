import "package:flutter/material.dart" hide ThemeMode;
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/theme/theme_mode.dart";
import "../../../app/theme/theme_notifier.dart";

class ThemeSelectorButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<ThemeMode>(
      icon: const Icon(Icons.color_lens),
      onSelected: (ThemeMode mode) async {
        await ref.read(themeNotifierProvider.notifier).setThemeMode(mode);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<ThemeMode>>[
        const PopupMenuItem<ThemeMode>(
          value: ThemeMode.light,
          child: Text("Light"),
        ),
        const PopupMenuItem<ThemeMode>(
          value: ThemeMode.dark,
          child: Text("Dark"),
        ),
        const PopupMenuItem<ThemeMode>(
          value: ThemeMode.system,
          child: Text("System"),
        ),
      ],
    );
  }
}
