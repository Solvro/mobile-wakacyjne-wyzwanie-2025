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
      title: "Sycylia, Włochy",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const DreamPlaceScreen(),
    );
  }
}

List<String> favoritePlaces = [
  "Sycylia, Włochy",
  "Santorini, Grecja",
  "Bali, Indonezja",
  "Nowy Jork, USA",
  "Tokio, Japonia",
];

List<String> descriptionPlaces = [
  "Sycylia to największa wyspa Morza Śródziemnego, znana z pięknych plaż, wulkanu Etna i bogatej historii.",
  "Santorini to grecka wyspa słynąca z białych domów z niebieskimi kopułami, spektakularnych zachodów słońca i wulkanicznych plaż.",
  "Bali to indonezyjska wyspa znana z tropikalnych plaż, świątyń i bogatej kultury.",
  "Nowy Jork to amerykańskie miasto znane z ikonicznych wieżowców, Central Parku i różnorodności kulturowej.",
  "Tokio to japońska metropolia łącząca nowoczesność z tradycją, znana z technologii, kuchni i kultury.",
];

final List<AssetGenImage> assetImages = [
  Assets.images.sycylia,
  Assets.images.santorini,
  Assets.images.bali,
  Assets.images.nowyJork,
  Assets.images.tokio,
];

class DreamPlaceScreen extends StatefulWidget {
  const DreamPlaceScreen({super.key});

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    void toggleFavorite() {
      setState(() {
        isFavorited = !isFavorited;
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8DD),
      appBar: AppBar(
        title: const Text("Ulubione miejsca!", style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.amber[200],
        actions: [
          IconButton(
            icon: isFavorited ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
            color: isFavorited ? Colors.red : Colors.white,
            onPressed: toggleFavorite,
            tooltip: isFavorited ? "Usuń z ulubionych" : "Dodaj do ulubionych",
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: favoritePlaces.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(6),
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute<MyDetailPage>(
                          builder: (context) => MyDetailPage(
                            placeName: favoritePlaces[index],
                            image: assetImages[index],
                            desc: descriptionPlaces[index],
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: Container(
                        color: Colors.yellow[600],
                        child: Column(
                          children: [
                            Expanded(
                              child: Hero(
                                tag: favoritePlaces[index],
                                child: assetImages[index].image(
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                favoritePlaces[index],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.wb_sunny),
                    Text("Słońce"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.beach_access),
                    Text("Plaża"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.restaurant),
                    Text("Jedzonko"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyDetailPage extends StatelessWidget {
  final String placeName;
  final AssetGenImage image;
  final String desc;

  const MyDetailPage({
    super.key,
    required this.placeName,
    required this.image,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8DD),
      appBar: AppBar(
        title: Text(placeName, style: const TextStyle(fontSize: 24)),
        backgroundColor: Colors.amber[200],
      ),
      body: Column(
        children: [
          Hero(
            tag: placeName,
            child: SizedBox(
              height: 300,
              width: double.infinity,
              child: image.image(
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            placeName,
            style: const TextStyle(fontSize: 32),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              desc,
              style: const TextStyle(fontSize: 18, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
