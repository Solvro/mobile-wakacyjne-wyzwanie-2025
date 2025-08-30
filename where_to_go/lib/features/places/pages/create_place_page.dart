import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../views/create_place_view.dart";

class CreatePlacePage extends ConsumerWidget {
  static const route = "/create_place";

  const CreatePlacePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CreatePlaceView(
      onSubmit: (Map<String, Object?> values) {
        print('Name: ${values['name']}');
        print('Description: ${values['description']}');
        print('Favourite: ${values['isFavourite']}');
        print('Image File: ${(values['image']! as File).path}');
        print("uaaau!");
        // ref.read(authNotifierProvider.notifier).logout();
      },
    );
  }
}
