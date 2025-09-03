import "package:flutter/material.dart";
import "dream_places_list_hook_widget.dart";

class MyAppHook extends StatelessWidget {
  const MyAppHook({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const DreamPlacesListScreenHook(),
    );
  }
}
