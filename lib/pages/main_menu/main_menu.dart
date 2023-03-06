import 'package:flutter/material.dart';
import './components/gradient.dart';
import './components/folder.dart';
import './components/logo.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<Color> _colors = const [
    Color(0xFF3F51B5),
    Color(0xFF7C4DFF),
    Color(0xFFE91E63),
  ];
  double _scale = 1;
  String _tween = "Mouse";

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

  void _setTween(String selection) {
    setState(() {
      _tween = selection;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => showAlert(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientWid(
              colors: _colors,
              scale: _scale,
              tweenSelection: _tween,
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Logo(),
                      Folder(
                          setScale: _setScale,
                          setColors: _setColors,
                          setTween: _setTween)
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.deepPurpleAccent,
              contentPadding: const EdgeInsets.all(5),
              actions: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(
                                  color: Colors.deepPurple, strokeAlign: 1.0))),
                      child: Text(
                        "Got it",
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                )
              ],
              content: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  color: Colors.deepPurple,
                  child: Column(children: [
                    Text(
                      "This website is best experienced in fullscreen.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "If you would like to make the page fullscreen, press F11.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      "This website is also meant to experienced on larger screens.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "If possible, please use a device larger than a smart phone.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      "These are merely suggestions and are not required to experience the website.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "Thank you for understanding.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ]),
                ),
              ));
        });
  }
}
