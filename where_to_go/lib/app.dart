import "package:flutter/material.dart";
import "app_router.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Dream Places",
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
    );
  }
}
