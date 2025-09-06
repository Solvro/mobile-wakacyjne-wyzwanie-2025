import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../features/auth/auth_provider.dart";
import "../features/places/dream_place_service_provider.dart";
import "../features/theme/theme_provider.dart";
import "../themes/enums/mode_theme.dart";
import "../themes/utils.dart";
import "../utils/error_handler.dart";
import "../widgets/build_list.dart";
import "create_dream_place_screen.dart";

class BucketListScreen extends ConsumerWidget {
  const BucketListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(dreamPlaceServiceProvider);
    final themeAsync = ref.watch(themeNotifierProvider);
    final authAsync = ref.watch(authNotifierProvider);
    final modeTheme = themeAsync.valueOrNull ?? ModeTheme.system;
    final isDark = _isDark(modeTheme, context);

    ref.listen(dreamPlaceServiceProvider, (previous, next) {
      if (next.hasError) {
        handleError(context, ref, next.error);
      }
    });

    return Scaffold(
        backgroundColor: context.colorScheme.primary,
        appBar: AppBar(
          backgroundColor: context.colorScheme.surface,
          surfaceTintColor: context.colorScheme.surfaceTint,
          title: const Text("Bucket List"),
          actions: [
            IconButton(onPressed: () => context.push(CreateDreamPlaceScreen.route), icon: const Icon(Icons.add)),
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
          error: (error, stack) => const Center(child: Text("Brak miejsc")),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
        drawer: Drawer(
            child: Column(children: [
          authAsync.when(
            data: (email) {
              return UserAccountsDrawerHeader(
                accountName: const Text("Witaj,"),
                accountEmail: Text(email!),
                decoration: BoxDecoration(color: context.colorScheme.primary),
              );
            },
            error: (error, stack) => const Center(child: Text("Brak miejsc")),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
              onPressed: () async {
                context.pop();
                await ref.read(authNotifierProvider.notifier).logout();
              },
              icon: const Icon(Icons.logout),
              label: const Text("Wyloguj się")),
        ])));
  }

  bool _isDark(ModeTheme modeTheme, BuildContext context) {
    return switch (modeTheme) {
      ModeTheme.dark => true,
      ModeTheme.light => false,
      ModeTheme.system => context.isDarkMode,
    };
  }
}
