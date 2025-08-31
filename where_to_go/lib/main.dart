import "package:flutter/material.dart";
import "gen/assets.gen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PlaceListScreen(),
    );
  }
}

class Place {
  final String placeName;
  final String placeDescription;
  final String placeImage;

  Place({required this.placeName, required this.placeDescription, required this.placeImage});
}

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Place> places = [
      Place(
        placeName: "Sagrada Familia",
        placeDescription:
            "Jeden z najbardziej rozpoznawalnych budynków na świecie - dzieło życia architekta, Antoniego Gaudiego. Jego budowa trwa od 1882 roku (143 lata), a termin jej ukończenia jest wciąż nieznany.",
        placeImage: Assets.images.sagrada.path,
      ),
      Place(
        placeName: "Park Guell",
        placeDescription:
            "Nietypowy park zaprojektowany przez Antoniego Gaudiego z pięknym widokiem na panoramę Barcelony. Teren zachwyca różnorodnością, nietypowym podejściem do kształtowania przestrzeni oraz mozaikami z potłuczonych kawałków ceramicznych płytek.",
        placeImage: Assets.images.park.path,
      ),
      Place(
        placeName: "Pałac Muzyki Katalońskiej",
        placeDescription:
            "Sala koncertowa z wielobarwną, witrażową kopółą przez którą do środka dociera światło o różnym natężeniu i kolorze w zależności od pory dnia. Równie interesujący jest front budynku, który ozdabiają kolumny pokryte mozaiką tworzącą kwieciste wzory.",
        placeImage: Assets.images.palac.path,
      ),
      Place(
        placeName: "Camp Nou",
        placeDescription:
            "Stadion piłkarski klubu FC Barcelona. Jego trybuny mieszczą 99 354 osób (obecnie jest przebudowywany przez co jego pojemność wzrośnie do 105 000 osób), co czyni go największym piłkarskim stadionem w Europie i jednym z największych na świecie. ",
        placeImage: Assets.images.camp.path,
      ),
      Place(
        placeName: "Casa Batlo",
        placeDescription:
            "Budynek mieszkalny, przebudowany przez Antoniego Gaudiego w 1904 roku na zlecenie prodzucenta tekstyliów Josepha Batlo. Budynek jest bogato zdobiony, elewacja zawiera elementy zwierzęce jak np. łuski smoka.",
        placeImage: Assets.images.casa.path,
      )
    ];

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 196, 194, 194),
        appBar: AppBar(
            title: const Text(
          "Hiszpania, Barcelona",
        )),
        body: ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute<DreamPlaceScreen>(
                        builder: (context) => DreamPlaceScreen(
                          myPlaceName: place.placeName,
                          myPlaceDescription: place.placeDescription,
                          myPlaceImage: place.placeImage,
                        ),
                      ),
                    );
                  },
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  place.placeImage,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(width: 12),
                            Expanded(
                                child: ListTile(
                                    title: Text(place.placeName,
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
                                    onTap: () async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute<DreamPlaceScreen>(
                                              builder: (context) => DreamPlaceScreen(
                                                    myPlaceName: place.placeName,
                                                    myPlaceDescription: place.placeDescription,
                                                    myPlaceImage: place.placeImage,
                                                  )));
                                    }))
                          ]))));
            }));
  }
}

class DreamPlaceScreen extends StatefulWidget {
  const DreamPlaceScreen(
      {super.key, required this.myPlaceName, required this.myPlaceDescription, required this.myPlaceImage});

  final String myPlaceName;
  final String myPlaceDescription;
  final String myPlaceImage;

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState(myPlaceName, myPlaceDescription, myPlaceImage);
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  _DreamPlaceScreenState(this.myPlaceName, this.myPlaceDescription, this.myPlaceImage);

  bool _isFavorited = false;
  final String myPlaceName;
  final String myPlaceDescription;
  final String myPlaceImage;

  void toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 196, 194, 194),
        appBar: AppBar(
          title: const Text("Barcelona, Hiszpania"),
          actions: [
            IconButton(icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border), onPressed: toggleFavorite)
          ],
        ),
        body: Column(children: [
          Image.asset(
            myPlaceImage,
            fit: BoxFit.cover,
          ),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 8),
                Text(myPlaceName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                const SizedBox(height: 8),
                Text(myPlaceDescription,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
                const SizedBox(height: 12),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  bottomRowColumn(Icons.wb_sunny, const Color.fromARGB(255, 186, 144, 20), "pogoda"),
                  bottomRowColumn(Icons.map, const Color.fromARGB(255, 31, 41, 61), "zabytki"),
                  bottomRowColumn(Icons.restaurant, const Color.fromARGB(255, 70, 19, 2), "jedzenie"),
                ])
              ]))
        ]));
  }
}

// This is the theme of your application.
//
// TRY THIS: Try running your application with "flutter run". You'll see
// the application has a purple toolbar. Then, without quitting the app,
// try changing the seedColor in the colorScheme below to Colors.green
// and then invoke "hot reload" (save your changes or press the "hot
// reload" button in a Flutter-supported IDE, or press "r" if you used
// the command line to start the app).
//
// Notice that the counter didn't reset back to zero; the application
// state is not lost during the reload. To reset the state, use hot
// restart instead.
//
// This works for code too, not just values: Most code changes can be
// tested with just a hot reload.
/*colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Flutter Demo Home Page"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "You have pushed the button this many times:",
            ),
            Text(
              "$_counter",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: "Increment",
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/
