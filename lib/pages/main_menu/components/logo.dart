import 'package:flutter/material.dart';
import 'dart:math';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
      //width: min(500, MediaQuery.of(context).size.width),
      height: 80,
      child: Stack(
        children: [
          Text(
            "ProgrammingAStorm",
            style: TextStyle(
                fontFamily: "BigMisterC",
                fontSize: 55,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5
                  ..color = Colors.indigo),
            // textScaleFactor:
            //     ScaleSize.textScaleFactor(context, maxTextScaleFactor: 1.6),
          ),
          const Text(
            "ProgrammingAStorm",
            style: TextStyle(
                fontFamily: "BigMisterC",
                fontSize: 55,
                fontWeight: FontWeight.w300,
                color: Colors.deepPurpleAccent,
                shadows: [
                  Shadow(
                      color: Colors.pink,
                      blurRadius: 2,
                      offset: Offset(2.0, 2.0)),
                ]),
            // textScaleFactor:
            //     ScaleSize.textScaleFactor(context, maxTextScaleFactor: 1.6),
          )
        ],
      ),
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
