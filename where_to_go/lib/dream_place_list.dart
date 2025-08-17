import "package:flutter/material.dart";

import "dream_place_screen.dart";
import "gen/assets.gen.dart";
import "place.dart";

class DreamPlaceList extends StatelessWidget {
  DreamPlaceList({super.key});

  final places = <Place>[
    Place(
      title: "Santorini, Grecja",
      subtitle: "Perła Cyklad na Morzu Egejskim",
      description: "Odkryj magiczne białe domki zawieszone na klifach i zanurz się w błękicie morza.",
      image: Assets.images.santorini,
    ),
    Place(
      title: "Kyoto, Japonia",
      subtitle: "Serce tradycyjnej Japonii",
      description: "Przechadzaj się wśród starożytnych świątyń, bambusowych lasów i ogrodów gejsz.",
      image: Assets.images.kyoto,
    ),
    Place(
      title: "Malediwy",
      subtitle: "Rajskie atole na Oceanie Indyjskim",
      description: "Zamieszkaj w domku na wodzie i ciesz się krystalicznie czystą wodą i białym piaskiem.",
      image: Assets.images.maldives,
    ),
    Place(
      title: "Islandia",
      subtitle: "Kraina lodu, ognia i zorzy polarnej",
      description: "Zobacz potężne wodospady, gejzery i lodowce w jednym z najbardziej epickich krajobrazów.",
      image: Assets.images.iceland,
    ),
    Place(
      title: "Patagonia, Argentyna",
      subtitle: "Surowe piękno na końcu świata",
      description: "Wędruj pośród monumentalnych gór, turkusowych jezior i bezkresnych stepów.",
      image: Assets.images.patagonia,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wymarzone miejsca"),
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: place.image.image(
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(place.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                place.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => DreamPlaceScreen(place: place),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
