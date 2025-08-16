import "package:flutter/material.dart";
import "gen/assets.gen.dart";

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class Destination {
  final String name;
  final String description;
  final AssetGenImage image;
  final Map<String, IconData> attractions;

  Destination(this.name, this.description, this.image, this.attractions);
}

class MyApp extends StatefulWidget {
  MyApp({super.key}) {
    destinations = data.map((entry) {
      final destination = Destination(
        entry["name"]! as String,
        entry["description"]! as String,
        entry["image"]! as AssetGenImage,
        Map<String, IconData>.from(entry["attractions"]! as Map),
      );
      return destination;
    }).toList();
  }

  final data = [
    {
      "name": "Auckland, New Zealand",
      "description": "Gdzie nowoczesne miasto spotyka się z zapierającymi dech w piersiach krajobrazami.",
      "image": Assets.images.auckland,
      "attractions": {
        "Sky Tower": Icons.location_city,
        "Waiheke Island": Icons.beach_access,
        "Hobbiton": Icons.movie,
      },
    },
    {
      "name": "Kyoto, Japan",
      "description": "Starożytna stolica pełna świątyń, tradycyjnych ogrodów i malowniczych uliczek.",
      "image": Assets.images.kyoto,
      "attractions": {
        "Kinkaku-ji": Icons.location_city,
        "Arashiyama Bamboo Grove": Icons.nature,
      },
    },
    {
      "name": "Santorini, Greece",
      "description": "Bajkowa wyspa z białymi domami i błękitnymi kopułami nad lazurowym morzem.",
      "image": Assets.images.santorini,
      "attractions": {
        "Oia": Icons.location_city,
        "Fira": Icons.beach_access,
        "Akrotiri": Icons.history,
      }
    },
    {
      "name": "Machu Picchu, Peru",
      "description": "Tajemnicze ruiny inkaskiego miasta ukryte wysoko w Andach.",
      "image": Assets.images.macchuPicchu,
      "attractions": {
        "Inti Punku": Icons.location_city,
        "Sacsayhuamán": Icons.history,
      }
    },
    {
      "name": "Reykjavik, Iceland",
      "description": "Kraina zorzy polarnej, gejzerów i zapierających dech krajobrazów wulkanicznych.",
      "image": Assets.images.reykjavik,
      "attractions": {
        "Hallgrímskirkja": Icons.church,
        "Geysir": Icons.thermostat,
        "Blue Lagoon": Icons.pool,
      }
    }
  ];

  late final List<Destination> destinations;

  @override
  State<MyApp> createState() => _HomeScreen(destinations, data);
}

class _HomeScreen extends State<MyApp> {
  _HomeScreen(this.destinations, this.data);

  final List<Destination> destinations;
  final List<Map<String, dynamic>> data;

  Widget getImageWidget(dynamic imageSource) {
    if (imageSource is String) {
      return Image.asset(
        imageSource,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (imageSource is AssetGenImage) {
      return imageSource.image(
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
    return const ColoredBox(
      color: Colors.grey,
      child: Icon(Icons.image_not_supported, size: 50),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorite Places", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      ),
      body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: destinations
              .map((entry) => GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (context) => DreamPlaceScreen(
                          appBarText: entry.name,
                          headerText: entry.name,
                          descriptionText: entry.description,
                          image: entry.image,
                          attractions: entry.attractions,
                        ),
                      ));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: entry.image.image(
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              entry.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList()),
    );
  }
}

class DreamPlaceScreen extends StatefulWidget {
  final String appBarText;
  final String headerText;
  final String descriptionText;
  final AssetGenImage image;
  final Map<String, IconData> attractions;

  const DreamPlaceScreen({
    required this.appBarText,
    required this.headerText,
    required this.descriptionText,
    required this.image,
    required this.attractions,
    super.key,
  });

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  var _isFavourited = false;
  var _icon = Icons.favorite_border;

  _DreamPlaceScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarText),
        actions: [
          IconButton(
            icon: Icon(
              _icon,
              color: _isFavourited ? Colors.red : Colors.black,
              size: 28,
            ),
            onPressed: () {
              setState(() {
                _isFavourited = !_isFavourited;
                _icon = _isFavourited ? Icons.favorite : Icons.favorite_border;
              });
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          widget.image.image(
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.headerText,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Text(widget.descriptionText),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.attractions.entries
                  .map((entry) => Column(
                        children: [
                          Icon(entry.value),
                          Text(entry.key),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
