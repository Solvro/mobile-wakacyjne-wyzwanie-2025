import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../auth/auth_notifier.dart";
import "../views/places_list_view.dart";

class HomePage extends ConsumerWidget {
  static const route = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlacesListView(onError: () async {
      await ref.read(authNotifierProvider.notifier).attemptRefreshToken();
    });
  }
}
