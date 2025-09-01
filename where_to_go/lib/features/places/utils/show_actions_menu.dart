import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../service/dream_place_service.dart";

enum Actions {
  delete,
}

Future<void> showDeleteMenu({
  required BuildContext context,
  required Offset position,
  required WidgetRef ref,
  required int placeId,
}) async {
  final selected = await showMenu<Actions>(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      position.dx,
      position.dy,
    ),
    items: const [
      PopupMenuItem<Actions>(
        value: Actions.delete,
        child: Text("Delete"),
      ),
    ],
  );

  if (selected == Actions.delete) {
    await ref.read(dreamPlaceServiceProvider.notifier).deleteDreamPlace(placeId);
  }
}
