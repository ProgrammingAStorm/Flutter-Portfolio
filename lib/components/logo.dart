import 'package:flutter/material.dart';

// TODO Deal with smaller screen sizes
// TODO Maybe add animation
class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 33, left: 55),
      child: Container(
        alignment: Alignment.topLeft,
        width: 500,
        height: 80,
        child: Center(
            child: Stack(
          children: [
            Text(
              "ProgrammingAStorm",
              style: TextStyle(
                  fontFamily: "BigMisterC",
                  fontSize: 60,
                  //fontWeight: FontWeight.bold
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 5
                    ..color = Colors.indigo),
            ),
            const Text(
              "ProgrammingAStorm",
              style: TextStyle(
                  fontFamily: "BigMisterC",
                  fontSize: 60,
                  fontWeight: FontWeight.w300,
                  color: Colors.deepPurpleAccent,
                  shadows: [
                    Shadow(
                        color: Colors.pink,
                        blurRadius: 2,
                        offset: Offset(2.0, 2.0)),
                  ]),
            )
          ],
        )),
      ),
    );
  }
}
