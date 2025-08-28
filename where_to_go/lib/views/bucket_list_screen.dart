import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../features/places/places_provider.dart";
import "../features/theme/theme_provider.dart";
import "../themes/enums/mode_theme.dart";
import "../themes/utils.dart";
import "../widgets/build_list.dart";

class BucketListScreen extends ConsumerWidget {
  const BucketListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final modeTheme = themeAsync.valueOrNull ?? ModeTheme.system;

    final placesAsync = ref.watch(placesProvider);

    final isDark = _isDark(modeTheme, context);

    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        surfaceTintColor: context.colorScheme.surfaceTint,
        title: const Text("Bucket List"),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(themeNotifierProvider.notifier).toggleTheme();
            },
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          )
        ],
      ),
      body: placesAsync.when(
        data: (places) => ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (context, index) {
              return BuildList(place: places[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 24);
            },
            itemCount: places.length),
        error: (error, stack) => const Center(child: Text("Blad")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  bool _isDark(ModeTheme modeTheme, BuildContext context) {
    return switch (modeTheme) {
      ModeTheme.dark => true,
      ModeTheme.light => false,
      ModeTheme.system => context.isDarkMode,
    };
  }
}
