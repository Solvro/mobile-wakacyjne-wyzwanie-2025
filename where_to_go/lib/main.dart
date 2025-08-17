import "package:flutter/material.dart";
import "gen/assets.gen.dart";

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
          Assets.images.santorini.image(
            fit: BoxFit.cover
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Perła Cyklad na Morzu Egejskim',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Odkryj magiczne białe domki zawieszone na klifach i zanurz '
                      'się w błękicie morza, podziwiając najpiękniejsze zachody '
                      'słońca na świecie.',
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.wb_sunny, color: Colors.orange, size: 40),
                  SizedBox(height: 8),
                  Text('Słońce'),
                ],
              ),

              Column(
                children: [
                  Icon(Icons.beach_access, color: Colors.blueAccent, size: 40),
                  SizedBox(height: 8),
                  Text('Plaże'),
                ],
              ),

              Column(
                children: [
                  Icon(Icons.restaurant, color: Colors.red[400], size: 40),
                  SizedBox(height: 8),
                  Text('Jedzenie'),
                ],
              ),

              Column(
                children: [
                  Icon(Icons.landscape, color: Colors.green, size: 40),
                  SizedBox(height: 8),
                  Text('Widoki'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
