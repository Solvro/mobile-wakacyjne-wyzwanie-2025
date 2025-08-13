import "package:flutter/material.dart";
import "gen/assets.gen.dart";

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

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

  @override
  // State<MyApp> createState() => _DreamPlaceScreen(appBarText, headerText, descriptionText, image, attractions);
  State<MyApp> createState() => _HomeScreen(data);
}

class _HomeScreen extends State<MyApp> {
  _HomeScreen(this.data);

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
    // Fallback
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
        children: <Widget>[
          ...data.map((entry) => GestureDetector(
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute<void>(
                        builder: (context) => DreamPlaceScreen(
                            appBarText: entry["name"] as String,
                            headerText: entry["name"] as String,
                            descriptionText: entry["description"] as String,
                            image: entry["image"] as AssetGenImage,
                            attractions: entry["attractions"] as Map<String, IconData>)),
                  );
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
                          child: (entry["image"] as AssetGenImage).image(
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          entry["name"] as String? ?? "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class DreamPlaceScreen extends StatefulWidget {
  final String appBarText;
  final String headerText;
  final String descriptionText;
  final dynamic image;
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
  State<DreamPlaceScreen> createState() =>
      _DreamPlaceScreenState(appBarText, headerText, descriptionText, image as AssetGenImage, attractions);
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  var _isFavourited = false;
  var _icon = Icons.favorite_border;

  final String appBarText;
  final String headerText;
  final String descriptionText;
  final AssetGenImage image;
  final Map<String, IconData> attractions;

  _DreamPlaceScreenState(this.appBarText, this.headerText, this.descriptionText, this.image, this.attractions);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText),
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
          image.image(
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(headerText,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Text(descriptionText),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...attractions.entries.map((entry) => Column(
                      children: [
                        Icon(entry.value),
                        Text(entry.key),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
