import "package:flutter/material.dart";

void main() {
  runApp(const DreamPlaceScreen()); //runApp
}

class DreamPlaceScreen extends StatelessWidget {
  const DreamPlaceScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 119, 42, 42),
      appBar: AppBar(
        title: const Text("Rzucić wszystko, wyjechać w Bieszczady..."),
      ),
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height / 2),
            child: Image.asset(fit: BoxFit.scaleDown, "images/toryUherce.jpg"),
          )
        ],
      ),
    ));
  }
}
