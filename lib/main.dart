import 'package:flutter/material.dart';
import 'package:portfolio/pages/main_menu.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'components/gradient.dart';

void main() {
  runApp(const MyApp());
}

// TODO In general make sure to go back and clean up and refactor code as need once the main page is done
// TODO Make sure everything is well commented
// TODO Organize files better by usage
// TODO Make sure app is mobile responsive
// TODO Look into fonts
// TODO Look into making platform specific versions of the whole app
// TODO Update favicon
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'ProgrammingAStorm',
      // TODO Set up theme with light and dark color palettes
      //theme: ThemeData(),
      //home: const MainMenu(),
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        //maxWidth: 1200,
        minWidth: 450,
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
