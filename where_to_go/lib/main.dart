// zad 4
// import "package:flutter/material.dart";
// import "package:hooks_riverpod/hooks_riverpod.dart";

// import "utils/app_router.dart";

// void main() {
//   runApp(const ProviderScope(child: TravelApp()));
// }

// class TravelApp extends StatelessWidget {
//   const TravelApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: goRouter,
//       title: "Travel App",
//     );
//   }
// }

// zad2
import "package:flutter/material.dart";

import "features/places/places_inherited.dart";
import "utils/app_router_inherited.dart";

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlacesInherited(
        child: MaterialApp.router(
      routerConfig: goRouterInherited,
      title: "Travel App",
    ));
  }
}
