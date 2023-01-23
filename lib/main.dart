import 'package:flutter/material.dart';
import 'package:portfolio/pages/main_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // TODO Set up theme with light and dark color palettes
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MainMenu()
        // IMPORTANT
        // This scaffold marks the beginning
        //   appBar: AppBar(
        //     title: const Text('Portfolio'),
        //   ),
        //   body: Column(
        //     children: [],
        //   ),
        // ),
        );
  }
}
