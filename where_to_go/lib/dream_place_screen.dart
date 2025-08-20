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

List<DreamPlaceScreenConsumerWidget> places = [
  DreamPlaceScreenConsumerWidget(
    title: "Rejkiawik, Islandia",
    image: Assets.images.reykjavikView,
    placeName: "Rejkiawik",
    placeDescription: "Stolica Islandii, znana z pięknych widoków i kultury.",
    infoColumns: const [
      InfoColumnData(icon: Icons.restaurant, text: "Restauracje"),
      InfoColumnData(icon: Icons.terrain, text: "Góry i wulkany"),
      InfoColumnData(icon: Icons.auto_awesome, text: "Zorze polarne"),
    ],
  ),
  DreamPlaceScreenConsumerWidget(
    title: "Zermatt, Szwajcaria",
    image: Assets.images.zermattView,
    placeName: "Zermatt",
    placeDescription: "Malownicza miejscowość u stóp Matterhorn, raj dla narciarzy i turystów górskich.",
    infoColumns: const [
      InfoColumnData(icon: Icons.downhill_skiing, text: "Narciarstwo"),
      InfoColumnData(icon: Icons.landscape, text: "Alpy i trekking"),
      InfoColumnData(icon: Icons.train, text: "Panoramiczne pociągi"),
    ],
  ),
  DreamPlaceScreenConsumerWidget(
    title: "Kioto, Japonia",
    image: Assets.images.kyotoView,
    placeName: "Kioto",
    placeDescription: "Dawna stolica Japonii, znana z świątyń, ogrodów i kwitnącej wiśni.",
    infoColumns: const [
      InfoColumnData(icon: Icons.park, text: "Świątynie i ogrody"),
      InfoColumnData(icon: Icons.local_florist, text: "Kwitnąca wiśnia"),
      InfoColumnData(icon: Icons.ramen_dining, text: "Kuchnia japońska"),
    ],
  ),
  DreamPlaceScreenConsumerWidget(
    title: "Sydney, Australia",
    image: Assets.images.sydneyView,
    placeName: "Sydney",
    placeDescription: "Tętniące życiem miasto znane z Opery, plaż i pięknych widoków nad zatoką.",
    infoColumns: const [
      InfoColumnData(icon: Icons.theaters, text: "Opera w Sydney"),
      InfoColumnData(icon: Icons.beach_access, text: "Plaże"),
      InfoColumnData(icon: Icons.sailing, text: "Rejsy w zatoce"),
    ],
  ),
  DreamPlaceScreenConsumerWidget(
    title: "Kapsztad, RPA",
    image: Assets.images.capeTownView,
    placeName: "Kapsztad",
    placeDescription: "Malownicze miasto między górami a oceanem, pełne przyrody i kultury.",
    infoColumns: const [
      InfoColumnData(icon: Icons.terrain, text: "Góra Stołowa"),
      InfoColumnData(icon: Icons.water, text: "Ocean Atlantycki"),
      InfoColumnData(icon: Icons.wine_bar, text: "Winnice"),
    ],
  ),
  DreamPlaceScreenConsumerWidget(
    title: "Paryż, Francja",
    image: Assets.images.parisView,
    placeName: "Paryż",
    placeDescription: "Romantyczna stolica Francji, pełna sztuki, mody i kulinarnych przysmaków.",
    infoColumns: const [
      InfoColumnData(icon: Icons.location_city, text: "Wieża Eiffla"),
      InfoColumnData(icon: Icons.museum, text: "Luwr"),
      InfoColumnData(icon: Icons.coffee, text: "Kawiarnie"),
    ],
  ),
  DreamPlaceScreenConsumerWidget(
    title: "Rio de Janeiro, Brazylia",
    image: Assets.images.rioView,
    placeName: "Rio de Janeiro",
    placeDescription: "Miasto samby, karnawału i spektakularnych plaż w otoczeniu gór.",
    infoColumns: const [
      InfoColumnData(icon: Icons.landscape, text: "Góra Corcovado"),
      InfoColumnData(icon: Icons.beach_access, text: "Plaża Copacabana"),
      InfoColumnData(icon: Icons.celebration, text: "Karnawał"),
    ],
  ),
];
