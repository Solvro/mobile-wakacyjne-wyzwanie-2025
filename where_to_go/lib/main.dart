import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DreamPlaceScreen(),
    );
  }
}

class DreamPlaceScreen extends StatelessWidget {
  const DreamPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: const Text('Santorini, Grecja'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/santorini.jpg',

            fit: BoxFit.cover
          ),
        ],
      ),
    );
  }
}
