import 'package:flutter/material.dart';
import 'package:hello_flutter/screens/list_view_screen.dart';

// void main() {
//   runApp(
//     MaterialApp(home: ListViewScreen(), debugShowCheckedModeBanner: false),
//   );
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: ListViewScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
