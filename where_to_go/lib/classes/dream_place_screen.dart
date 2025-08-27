import "package:flutter/material.dart";
//import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../features/places/places_provider.dart";
import "place_list_screen.dart";

/*class DreamPlaceScreen extends HookWidget {

  DreamPlaceScreen({super.key, required this.place});

  final Place place;

  Column bottomRowColumn(IconData iconType, Color iconColor, String iconText) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(
        iconType,
        color: iconColor,
        size: 40,
      ),
      Text(iconText, style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold))
    ]);
  }
  static const darkYellow =  Color.fromARGB(255, 186, 144, 20);
  static const darkBlue =   Color.fromARGB(255, 31, 41, 61);
  static const redhead =  Color.fromARGB(255, 70, 19, 2);

  @override
  Widget build(BuildContext context) {
    final _isFavorited = useState(false);
    return Scaffold(
        backgroundColor: beige,
        appBar: AppBar(
          title: const Text("Hiszpania - Barcelona",
            style: TextStyle (
              fontWeight: FontWeight.bold
            )
          ),
          actions: [
            IconButton(
              icon: Icon(
                _isFavorited.value ? Icons.favorite : Icons.favorite_border,
                color: _isFavorited.value ? Colors.red :  Colors.grey,
                size: 40,
              ),
              onPressed: () {
                  _isFavorited.value = !_isFavorited.value;
              }
            )
          ],
        ),
        body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    place.placeImage,
                    fit: BoxFit.cover,
                  )
                ),

                const SizedBox(width: 16),

                Expanded (
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column (crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                        Text(place.placeName,
                          style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          )
                        ),
                        const SizedBox(height: 16),

                        Text(place.placeDescription,
                          style: const TextStyle(
                            fontSize: 12, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.black
                          )
                        ),
                        const SizedBox(height: 20),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                          children: [
                            bottomRowColumn(Icons.wb_sunny, darkYellow, "pogoda"),
                            bottomRowColumn(Icons.map, darkBlue, "zabytki"),
                            bottomRowColumn(Icons.restaurant, redhead, "jedzenie"),
                          ]
                        )
                      ]
                    )
                  )
                )
              ]
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(place.placeImage,
                  fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(place.placeName,
                          style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          )
                        ),
                        const SizedBox(height: 8),
                        Text(place.placeDescription,
                          style: const TextStyle(
                            fontSize: 12, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.black
                            )
                        ),
                        const SizedBox(height: 12),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                          children: [
                            bottomRowColumn(Icons.wb_sunny, darkYellow, "pogoda"),
                            bottomRowColumn(Icons.map, darkBlue, "zabytki"),
                            bottomRowColumn(Icons.restaurant, redhead, "jedzenie"),
                          ]
                        )
                      ]
                    )
                  )
                ]
              )
            );
          }
        }
      )
    );
  }
}*/

class DreamPlaceScreen extends ConsumerWidget {
  static const route = "/dreamPlace";
  final String id;

  const DreamPlaceScreen({super.key, required this.id});

  Column bottomRowColumn(IconData iconType, Color iconColor, String iconText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(iconType, color: iconColor, size: 40),
        Text(
          iconText,
          style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  static const darkYellow = Color.fromARGB(255, 186, 144, 20);
  static const darkBlue = Color.fromARGB(255, 31, 41, 61);
  static const redhead = Color.fromARGB(255, 70, 19, 2);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    final place = places.firstWhere((p) => p.id == id);

    return Scaffold(
      backgroundColor: beige,
      appBar: AppBar(
        title: const Text("Hiszpania - Barcelona", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(placesProvider.notifier).toggleFavorite(place.id);
            },
            icon: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: place.isFavorite ? Colors.red : Colors.grey,
              size: 35,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 500) {
            return Row(
              children: [
                Expanded(child: Image.asset(place.image, fit: BoxFit.cover)),

                const SizedBox(width: 16),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.title,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(height: 16),

                        Text(
                          place.description,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            bottomRowColumn(Icons.wb_sunny, darkYellow, "pogoda"),
                            bottomRowColumn(Icons.map, darkBlue, "zabytki"),
                            bottomRowColumn(Icons.restaurant, redhead, "jedzenie"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(place.image, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          place.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          place.description,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            bottomRowColumn(Icons.wb_sunny, darkYellow, "pogoda"),
                            bottomRowColumn(Icons.map, darkBlue, "zabytki"),
                            bottomRowColumn(Icons.restaurant, redhead, "jedzenie"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
