import "package:flutter/material.dart";

import "gen/assets.gen.dart";

class DreamPlaceScreen extends StatefulWidget {
  const DreamPlaceScreen(
      {super.key,
      required this.title,
      required this.image,
      required this.placeName,
      required this.placeDescription,
      required this.infoColumns});

  final String title;
  final AssetGenImage image;
  final String placeName;
  final String placeDescription;
  final List<InfoColumnData> infoColumns;

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
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                child: Icon(
                  _isFavorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  key: ValueKey<bool>(_isFavorited),
                  color: _isFavorited ? Colors.redAccent.shade400 : null,
                ),
              ),
              onPressed: _toggleFavorite,
            )
          ],
        ),
        body: Column(
          children: [
            Hero(
              tag: widget.title,
              child: Image.asset(
                widget.image.path,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.placeName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                    width: double.infinity,
                  ),
                  Text(widget.placeDescription)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoColumn(
                  icon: widget.infoColumns[0].icon,
                  text: widget.infoColumns[0].text,
                ),
                InfoColumn(
                  icon: widget.infoColumns[1].icon,
                  text: widget.infoColumns[1].text,
                ),
                InfoColumn(
                  icon: widget.infoColumns[2].icon,
                  text: widget.infoColumns[2].text,
                ),
              ],
            )
          ],
        ));
  }
}

class InfoColumn extends StatelessWidget {
  const InfoColumn({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
        const SizedBox(
          height: 4,
        ),
        Text(text)
      ],
    );
  }
}

class InfoColumnData {
  const InfoColumnData({required this.icon, required this.text});

  final IconData icon;
  final String text;
}
