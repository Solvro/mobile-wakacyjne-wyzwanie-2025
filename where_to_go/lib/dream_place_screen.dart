import "package:flutter/material.dart";

class DreamPlaceScreen extends StatelessWidget {
  const DreamPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text("Malaga"),
      ),
      body: const Center(
        child: Text(
          "Welcome to Malaga!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF141414),
          ),
        ),
      ),
    );
  }
}
