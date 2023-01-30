import 'package:flutter/material.dart';
import 'package:portfolio/pages/main_menu.dart';

void main() {
  runApp(const MyApp());
}

// TODO In general make sure to go back and clean up and refactor code as need once the main page is done
// TODO Make sure everything is well commented
// TODO Organize files better by usage
// TODO Make sure app is mobile responsive
// TODO Look into fonts
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // TODO Set up theme with light and dark color palettes
        theme: ThemeData(),
        home: const MainMenu());
  }
}
