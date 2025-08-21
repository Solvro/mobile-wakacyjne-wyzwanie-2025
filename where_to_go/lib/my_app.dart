import "package:flutter/material.dart";
import "app_router.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey[50],
        scaffoldBackgroundColor: const Color.fromARGB(255, 236, 219, 249),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[50],
          foregroundColor: Colors.black,
          elevation: 2,
        ),
      ),
    );
  }
}
