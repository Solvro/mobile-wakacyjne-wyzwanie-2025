import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/favorite/favorite_provider.dart";

import "gen/assets.gen.dart";

class DreamPlaceScreenConsumerWidget extends ConsumerWidget {
  const DreamPlaceScreenConsumerWidget({
    super.key,
    required this.title,
    required this.image,
    required this.placeName,
    required this.placeDescription,
    required this.infoColumns,
  });

  final String title;
  final AssetGenImage image;
  final String placeName;
  final String placeDescription;
  final List<InfoColumnData> infoColumns;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorited = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
              child: Icon(
                isFavorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                key: ValueKey<bool>(isFavorited),
                color: isFavorited ? Colors.redAccent.shade400 : null,
              ),
            ),
            onPressed: () {
              ref.read(favoriteProvider.notifier).toggle();
            },
          )
        ],
      ),
      body: Column(
        children: [
          Hero(
            tag: title,
            child: Image.asset(
              image.path,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                  width: double.infinity,
                ),
                Text(placeDescription)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: infoColumns
                .map((e) => InfoColumn(
                      icon: e.icon,
                      text: e.text,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

class DreamPlaceScreenHookWidget extends HookWidget {
  const DreamPlaceScreenHookWidget({
    super.key,
    required this.title,
    required this.image,
    required this.placeName,
    required this.placeDescription,
    required this.infoColumns,
  });

  final String title;
  final AssetGenImage image;
  final String placeName;
  final String placeDescription;
  final List<InfoColumnData> infoColumns;

  @override
  Widget build(BuildContext context) {
    final isFavorited = useState(false);

    void toggleFavorite() {
      isFavorited.value = !isFavorited.value;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
              child: Icon(
                isFavorited.value ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                key: ValueKey<bool>(isFavorited.value),
                color: isFavorited.value ? Colors.redAccent.shade400 : null,
              ),
            ),
            onPressed: toggleFavorite,
          )
        ],
      ),
      body: Column(
        children: [
          Hero(
            tag: title,
            child: Image.asset(
              image.path,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                  width: double.infinity,
                ),
                Text(placeDescription)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: infoColumns
                .map((e) => InfoColumn(
                      icon: e.icon,
                      text: e.text,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

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
              children: widget.infoColumns
                  .map((e) => InfoColumn(
                        icon: e.icon,
                        text: e.text,
                      ))
                  .toList(),
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
