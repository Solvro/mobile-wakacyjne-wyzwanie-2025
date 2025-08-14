import "package:flutter/material.dart";

import "gen/assets.gen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DreamPlaceScreen(
          "Fuerteventura",
          "Fuerteventura to piękna wyspa na Oceanie Atlantyckim w Archipelagu Kanaryjskim, znana z słonecznych plaż i idealnych warunków do uprawiania sportów wodnych.",
          "assets/images/fuerteventura.jpg",
          Icons.beach_access,
          Icons.surfing,
          Icons.sunny,
          "Plaże",
          "Sport",
          "Słońce"),
    );
  }
}

class DreamPlaceScreen extends StatefulWidget {
  final String title;
  final String desc;
  final String image;
  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final String iconText1;
  final String iconText2;
  final String iconText3;
  const DreamPlaceScreen(this.title, this.desc, this.image, this.icon1, this.icon2, this.icon3, this.iconText1,
      this.iconText2, this.iconText3,
      {super.key});

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
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 88, 66, 27),
          title: Text(widget.title, style: const TextStyle(color: Colors.white)),
          actions: [
            if (_isFavorited)
              IconButton(onPressed: _toggleFavorite, icon: const Icon(Icons.favorite), color: Colors.white)
            else
              IconButton(
                  onPressed: _toggleFavorite,
                  icon: const Icon(Icons.favorite),
                  color: const Color.fromARGB(98, 0, 0, 0))
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 255, 243, 221),
        body: Column(children: [
          Image.asset(widget.image, fit: BoxFit.cover),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Text(
                  widget.desc,
                )
              ])),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(children: [Icon(widget.icon1), Text(widget.iconText1)]),
            Column(children: [Icon(widget.icon2), Text(widget.iconText2)]),
            Column(children: [Icon(widget.icon3), Text(widget.iconText3)])
          ])
        ]));
  }
}
