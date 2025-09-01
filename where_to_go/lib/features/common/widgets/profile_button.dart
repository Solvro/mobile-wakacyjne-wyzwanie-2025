import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../app/theme/app_theme.dart";
import "../../auth/auth_notifier.dart";

enum ProfileAction {
  logout,
}

class ProfileButton extends ConsumerWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return FutureBuilder<String>(
      future: authNotifier.getUserEmail(),
      builder: (context, snapshot) {
        final email = snapshot.data ?? "Loading...";

        return PopupMenuButton<ProfileAction>(
          icon: const Icon(Icons.person),
          onSelected: (ProfileAction action) async {
            if (action == ProfileAction.logout) {
              await authNotifier.logout();
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<ProfileAction>>[
            PopupMenuItem<ProfileAction>(
              enabled: false,
              child: Text(email, style: context.textTheme.bodyLarge),
            ),
            const PopupMenuItem<ProfileAction>(
              value: ProfileAction.logout,
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
