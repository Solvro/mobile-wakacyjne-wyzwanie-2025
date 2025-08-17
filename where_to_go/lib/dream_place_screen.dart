import 'package:flutter/material.dart';
import 'place.dart';

class DreamPlaceScreen extends StatefulWidget {

  final Place place;

  const DreamPlaceScreen({super.key, required this.place});

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(widget.place.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              _isFavorited ? Icons.favorite : Icons.favorite_border,
              color: _isFavorited ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          widget.place.image.image(
            fit: BoxFit.cover,
            height: 250,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.place.subtitle,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.place.description,
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
              const Column(
                children: [
                  Icon(Icons.wb_sunny, color: Colors.orange, size: 40),
                  SizedBox(height: 8),
                  Text('Słońce'),
                ],
              ),
              const Column(
                children: [
                  Icon(Icons.beach_access, color: Colors.blueAccent, size: 40),
                  SizedBox(height: 8),
                  Text('Plaże'),
                ],
              ),
              const Column(
                children: [
                  Icon(Icons.restaurant, color: Colors.red, size: 40),
                  SizedBox(height: 8),
                  Text('Jedzenie'),
                ],
              ),
              const Column(
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
