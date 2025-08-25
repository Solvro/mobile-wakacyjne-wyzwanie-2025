import "dart:async";

import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "gen/assets.gen.dart";

const Color greenIcons = Color.fromARGB(255, 26, 89, 48);
const Color greenBackground = Color.fromARGB(255, 109, 197, 112);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.redHatTextTextTheme(),
      ),
      home: const DreamPlaceScreen(),
    );
  }
}

class DreamPlaceScreen extends StatelessWidget {
  const DreamPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: greenBackground,
        appBar: AppBar(
          title: const Text("Rzucam wszystko, jadę w Bieszczady",
              textAlign: TextAlign.right, style: TextStyle(fontSize: 18)),
          backgroundColor: greenBackground,
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            introHomePage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _placeButton(context, Icons.filter_hdr, "Skorodne", skorodnePage()),
                _placeButton(context, Icons.beach_access_rounded, "Solina", solinaPage()),
                _placeButton(context, Icons.castle_outlined, "Zagórz", zagorzPage()),
                _placeButton(context, Icons.bakery_dining_rounded, "Słodki Domek", slodkiDomekPage()),
              ],
            ), //end of Row
            skorodneImage(),
            solinaImage(),
            zagorzImage(),
            slodkiDomekImage(),
          ], //end of this page
        ));
  }

  Widget _placeButton(BuildContext context, IconData icon, String label, SinglePlaceView page) {
    return ElevatedButton(
      onPressed: () {
        unawaited(
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(builder: (context) => page),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 30, color: greenIcons),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  SingleImageView introHomePage() {
    return SingleImageView(
      imagePath: Assets.images.bieszczadyLaka.path,
      imageTitle: "Cudze chwalicie,\nswego nie znacie",
      imageDesc:
          "Bieszczady to nie tylko góry i nużące wędrowanie kotlinami, bo na zdobywanie szczytów nam brakuje siły. To także odpoczynek od szumu miejskiego na łące, nad jeziorem, rekreacja na nadzalewowej plaży czy sporo zwiedzania dla tych, którzy lubią posłuchać o architekturze i historii.",
    );
  }

  SingleImageView zagorzImage() =>
      SingleImageView(imagePath: Assets.images.zagorz.path, imageTitle: "Zagórz", imageDesc: "");

  SingleImageView slodkiDomekImage() =>
      SingleImageView(imagePath: Assets.images.slodkiDomek.path, imageTitle: "Słodki Domek, Lesko", imageDesc: "");

  SingleImageView solinaImage() =>
      SingleImageView(imagePath: Assets.images.solina.path, imageTitle: "Solina", imageDesc: "");

  SingleImageView skorodneImage() =>
      SingleImageView(imagePath: Assets.images.skorodneJezioro.path, imageTitle: "Skorodne", imageDesc: "");

  SinglePlaceView skorodnePage() {
    return SinglePlaceView(
        imagePath: Assets.images.skorodneJezioro.path,
        imageTitle: "Skorodne",
        imageDesc:
            "Za górami, za lasami, gdzie zasięg nie dosięga, znajduje się ostatnia ostoja cywilizacji... Digital detox, walka z muchami końskimi i piękne widoki. Cóż mam ci więcej mówić.",
        icon1: Icons.forest,
        icon1Desc: "miejsce zalesione",
        icon2: Icons.emoji_nature,
        icon2Desc: "lokalna fauna",
        icon3: Icons.gps_off,
        icon3Desc: "5km od zasięgu");
  }

  SinglePlaceView solinaPage() {
    return SinglePlaceView(
        imagePath: Assets.images.solina.path,
        imageTitle: "Solina",
        imageDesc: "Wakacje w Bieszczadach bez Soliny to skandal. Kłóć się ze ścianą.",
        icon1: Icons.bed_outlined,
        icon1Desc: "noclegi",
        icon2: Icons.local_attraction,
        icon2Desc: "https://pklsolina.pl/",
        icon3: Icons.beach_access_rounded,
        icon3Desc: "plaża");
  }

  SinglePlaceView slodkiDomekPage() {
    return SinglePlaceView(
        imagePath: Assets.images.slodkiDomek.path,
        imageTitle: "Słodki Domek, Lesko",
        imageDesc:
            "Skuś się na serniczka... albo na pucharek lodowy... a może jakaś kawa? Obiecuję, że lepsza niż z automatów na PWr.",
        icon1: Icons.bakery_dining_rounded,
        icon1Desc: "cukiernia",
        icon2: Icons.coffee,
        icon2Desc: "kawiarnia",
        icon3: Icons.icecream,
        icon3Desc: "lodziarnia");
  }

  SinglePlaceView zagorzPage() {
    return SinglePlaceView(
        imagePath: Assets.images.zagorz.path,
        imageTitle: "Zagórz",
        imageDesc:
            "Jak już dotrzesz na samą górę wzniesienia, nie zniechęcaj się hasłem muzeum - nieźle tu zmodernizowali. Ah, i jest zakonnik jumpscare na VR.",
        icon1: Icons.castle_outlined,
        icon1Desc: "interaktywne muzeum",
        icon2: Icons.local_movies,
        icon2Desc: "sala VR",
        icon3: Icons.hiking,
        icon3Desc: "miejsce na wzniesieniu");
  }
}

class SingleImageView extends StatelessWidget {
  const SingleImageView({
    required this.imagePath,
    required this.imageTitle,
    required this.imageDesc,
    super.key,
  });

  final String imagePath;
  final String imageTitle;
  final String imageDesc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRect(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 300,
              minWidth: double.infinity, // pełna szerokość
            ),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              fit: BoxFit.cover, // wypełnia szerokość, przycina wysokość
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                imageTitle,
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              )),
              const SizedBox(height: 4),
              Text(
                imageDesc,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SinglePlaceView extends StatefulWidget {
  const SinglePlaceView({
    required this.imagePath,
    required this.imageTitle,
    required this.imageDesc,
    required this.icon1,
    required this.icon1Desc,
    required this.icon2,
    required this.icon2Desc,
    required this.icon3,
    required this.icon3Desc,
    super.key,
  });

  final String imagePath;
  final String imageTitle;
  final String imageDesc;
  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final String icon1Desc;
  final String icon2Desc;
  final String icon3Desc;

  @override
  State<SinglePlaceView> createState() => _SinglePlaceViewState();
}

class _SinglePlaceViewState extends State<SinglePlaceView> {
  bool _isSaved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenBackground,
      appBar: AppBar(
        //"zapisz" [Icon(Icons.bookmark_added), Icon(Icons.bookmark_add_outlined)]
        title: Text(widget.imageTitle, textAlign: TextAlign.right, style: const TextStyle(fontSize: 18)),
        backgroundColor: greenBackground,
        actions: [
          IconButton(
            onPressed: _toggleSaved,
            icon: Icon(
              _isSaved ? Icons.bookmark_added : Icons.bookmark_add_outlined,
            ),
            color: _isSaved ? greenIcons : const Color(0xFF141414),
          )
        ],
      ),
      body: Column(children: [
        SingleImageView(imagePath: widget.imagePath, imageTitle: widget.imageTitle, imageDesc: widget.imageDesc),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [Icon(widget.icon1, color: greenIcons), Text(widget.icon1Desc)]),
            Column(children: [Icon(widget.icon2, color: greenIcons), Text(widget.icon2Desc)]),
            Column(children: [Icon(widget.icon3, color: greenIcons), Text(widget.icon3Desc)]),
          ],
        ),
      ]),
    );
  }

  void _toggleSaved() {
    setState(() {
      _isSaved = !_isSaved;
    });
  }
}
