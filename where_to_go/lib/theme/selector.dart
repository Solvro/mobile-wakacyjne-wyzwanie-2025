import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "local_theme.dart";
import "providers.dart";

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeChoiceAsync = ref.watch(themeChoiceProvider);
    final controller = ref.read(themeChoiceProvider.notifier);

    return themeChoiceAsync.when(
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text("Błąd: $e"),
      data: (choice) {
        return DropdownButton<AppThemeChoice>(
          value: choice,
          items: const [
            DropdownMenuItem(
              value: AppThemeChoice.system,
              child: Text("Systemowy"),
            ),
            DropdownMenuItem(
              value: AppThemeChoice.light,
              child: Text("Jasny"),
            ),
            DropdownMenuItem(
              value: AppThemeChoice.dark,
              child: Text("Ciemny"),
            ),
          ],
          onChanged: (newChoice) async {
            if (newChoice != null) {
              await controller.setChoice(newChoice);
            }
          },
        );
      },
    );
  }
}
