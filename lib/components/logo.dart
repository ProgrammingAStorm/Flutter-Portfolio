import 'package:flutter/material.dart';
import 'dart:math';

// TODO Deal with smaller screen sizes
class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(top: 20, left: 20, bottom: 1, right: 20),
      width: min(500, MediaQuery.of(context).size.width),
      height: 80,
      child: Center(
          child: Stack(
        children: [
          Text(
            "ProgrammingAStorm",
            style: TextStyle(
                fontFamily: "BigMisterC",
                fontSize: 35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5
                  ..color = Colors.indigo),
            textScaleFactor:
                ScaleSize.textScaleFactor(context, maxTextScaleFactor: 1.6),
          ),
          Text(
            "ProgrammingAStorm",
            style: const TextStyle(
                fontFamily: "BigMisterC",
                fontSize: 35,
                fontWeight: FontWeight.w300,
                color: Colors.deepPurpleAccent,
                shadows: [
                  Shadow(
                      color: Colors.pink,
                      blurRadius: 2,
                      offset: Offset(2.0, 2.0)),
                ]),
            textScaleFactor:
                ScaleSize.textScaleFactor(context, maxTextScaleFactor: 1.6),
          )
        ],
      )),
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
