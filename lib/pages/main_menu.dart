import 'package:flutter/material.dart';
import 'package:portfolio/components/gradient.dart';
import '../components/folder.dart';
import '../components/logo.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<Color> _colors = [
    Colors.indigo,
    Colors.deepPurpleAccent,
    Colors.pink,
  ];
  double _scale = 1;

  // TODO Look into statemangement to make this whole process more streamlined
  void _setScale(double scale) {
    setState(() {
      _scale = scale;
    });
  }

  void _setColors(List<Color> colors) {
    setState(() {
      _colors = colors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientWid(colors: _colors, scale: _scale),
          SingleChildScrollView(
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: [
                const Logo(),
                Folder(
                  setScale: _setScale,
                  setColors: _setColors,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
