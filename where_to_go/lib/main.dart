import 'package:flutter/material.dart';
import 'gen/assets.gen.dart';
import 'package:google_fonts/google_fonts.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 177, 208, 223),
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: PlaceScreenList()
    );
  }
}

class Place{
  final String titleText;
  final ImageProvider image;
  final Column feature1;
  final Column feature2;
  final Column feature3;
  final Center placeName;
  final Center catchPhrase;

  Place({required this.titleText,
    required this.image,
    required this.placeName,
    required this.catchPhrase,
    required this.feature1,
    required this.feature2,
    required this.feature3,});
}

class PlaceScreenList extends StatelessWidget {
  final List<Place> places = [
    Place(
      titleText: 'Cool place',
      image: Assets.images.snowdin.provider(),
      placeName: Center(child: const Text('Snowdin', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      catchPhrase: Center(child: const Text('here lives the GREAT Papyrus')),
      feature1: Column(children: const [Icon(Icons.wb_sunny), Text('No sun')]),
      feature2: Column(children: const [Icon(Icons.beach_access), Text('No beach')]),
      feature3: Column(children: const [Icon(Icons.restaurant), Text('Tasty pasta')]),
    ),
    Place(
      titleText: 'The longest city in Europe',
      image: Assets.images.kr.provider(),
      placeName: Center(child: const Text('Kryvyi Rih', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      catchPhrase: Center(child: const Text('A life-long city')),
      feature1: Column(children: const [Icon(Icons.iron), Text('Metals!')]),
      feature2: Column(children: const [Icon(Icons.pets), Text('Green dogs')]),
      feature3: Column(children: const [Icon(Icons.do_not_disturb), Text('Less criminal then before')]),
    ),
    Place(
      titleText: 'Big snowy mountains',
      image: Assets.images.zakopane.provider(),
      placeName: Center(child: const Text('Zakopane', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      catchPhrase: Center(child: const Text('Zakopane - najbliżej Tatr')),
      feature1: Column(children: const [Icon(Icons.snowboarding), Text('Snow sports!')]),
      feature2: Column(children: const [Icon(Icons.hiking), Text('Cool routes to go hiking')]),
      feature3: Column(children: const [Icon(Icons.water), Text('Oko morskie!')]),
    ),
    Place(
      titleText: 'GAMBLING',
      image: Assets.images.gambling.provider(),
      placeName: Center(child: const Text('Las Vegas', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      catchPhrase: Center(child: const Text('LET`S GO GAMBLING')),
      feature1: Column(children: const [Icon(Icons.money_off), Text('GAMBLING')]),
      feature2: Column(children: const [Icon(Icons.attach_money), Text('GAMBLING')]),
      feature3: Column(children: const [Icon(Icons.monetization_on), Text('GAMBLING')]),
    ),
    Place(
      titleText: 'I need to get there',
      image: Assets.images.pentagon.provider(),
      placeName: Center(child: const Text('Pentagon', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      catchPhrase: Center(child: const Text('You know they built it in 1943?')),
      feature1: Column(children: const [Icon(Icons.house), Text('5 sides')]),
      feature2: Column(children: const [Icon(Icons.build), Text('Looks cozy')]),
      feature3: Column(children: const [Icon(Icons.build_circle), Text('5 aboveground floors,\nand 2 underground,\nofficially')]),
    ),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Dream places'),),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DreamPlaceScreen(place: place)
                )
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Image(image: place.image, height: 200, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(place.titleText,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          );
        }
      ),
    );
  }
}

class DreamPlaceScreen extends StatefulWidget {

  final Place place;

  const DreamPlaceScreen({
    super.key, 
    required this.place
    });

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();

}

class _DreamPlaceScreenState extends State<DreamPlaceScreen>{

  bool _isFavored = false;

  void _toggleFavorite(){
    setState(() {
      _isFavored = !_isFavored;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(196, 195, 218, 230),
      appBar: AppBar(
        title: Text(widget.place.titleText),
        actions: [
          IconButton(onPressed: _toggleFavorite, icon: _isFavored ? Icon(Icons.favorite) : Icon(Icons.favorite_border))
        ],
      ),
      body: Column(
        children: [
            Image(image: widget.place.image, height: 250, fit: BoxFit.cover),          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.place.placeName,
                SizedBox(
                  height: 8,
                ),
                widget.place.catchPhrase
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              widget.place.feature1,
              widget.place.feature2,
              widget.place.feature3
            ],
          )
        ],
      ),
    );    
  }
}