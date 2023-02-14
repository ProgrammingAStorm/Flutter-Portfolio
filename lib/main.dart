import 'package:flutter/material.dart';
import 'package:portfolio/pages/main_menu/main_menu.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

// TODO In general make sure to go back and clean up and refactor code as need once the main page is done
// TODO Make sure everything is well commented
// TODO Make sure app is mobile responsive
// TODO Look into fonts
// TODO Update favicon
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProgrammingAStorm',
      // TODO Set up theme
      // TODO Allow theme manipulation
      theme: ThemeData(
          // buttonTheme: const ButtonThemeData(
          //     buttonColor: Colors.deepPurple,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(5),
          //             topRight: Radius.circular(5)),
          //         side:
          //             BorderSide(color: Colors.deepPurple, strokeAlign: 1.0))),
          textTheme: TextTheme(
        displayLarge: TextStyle(
            color: Colors.deepPurpleAccent.shade100,
            fontFamily: "ProzaLibre",
            fontSize: 70),
        displayMedium: TextStyle(
            color: Colors.deepPurpleAccent.shade100,
            fontFamily: "ProzaLibre",
            fontSize: 55),
        displaySmall: TextStyle(
            color: Colors.deepPurpleAccent.shade100,
            fontFamily: "ProzaLibre",
            fontSize: 20),
        bodyLarge: TextStyle(
            color: Colors.deepPurpleAccent.shade100,
            fontFamily: "ProzaLibre",
            fontSize: 60),
        bodyMedium: TextStyle(
            color: Colors.deepPurpleAccent.shade100,
            fontFamily: "ProzaLibre",
            fontSize: 30),
        bodySmall: TextStyle(
            color: Colors.deepPurpleAccent.shade100,
            fontFamily: "ProzaLibre",
            fontSize: 20),
      )),
      //home: const MainMenu(),
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        //maxWidth: 1200,
        //minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      initialRoute: '/',
      routes: {'/': (context) => const MainMenu()},
    );
  }
}
