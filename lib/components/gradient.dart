import 'package:flutter/material.dart';

// TODO Change colors to match theme
// TODO Find a way to add some mouse interactivity
class GradientWid extends StatefulWidget {
  const GradientWid({
    super.key,
  });

  @override
  State<GradientWid> createState() => _GradientWidState();
}

class _GradientWidState extends State<GradientWid>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  double _x = 0.0;
  double _y = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this)
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      _x = details.position.dx;
      _y = details.position.dy;
    });
  }

  void _clearLocation(PointerEvent details) {
    setState(() {
      _x = -0;
      _y = -0;
    });
  }

  DecorationTween _getTween(
      BuildContext context, double mouseX, double mouseY, double scale) {
    final double viewWidth = MediaQuery.of(context).size.width;
    final double viewHeight = MediaQuery.of(context).size.height;

    final double rotationWidth = viewWidth / scale;
    final double rotationHeight = viewHeight / scale;

    final Map<String, Map<String, double>> rotationPoints = {
      "a": {
        "x": mouseX - (rotationWidth / 2),
        "y": mouseY - (rotationHeight / 2)
      },
      "b": {
        "x": mouseX + (rotationWidth / 2),
        "y": mouseY - (rotationHeight / 2)
      },
      "c": {
        "x": mouseX + (rotationWidth / 2),
        "y": mouseY + (rotationHeight / 2)
      },
      "d": {
        "x": mouseX - (rotationWidth / 2),
        "y": mouseY + (rotationHeight / 2)
      }
    };

    Alignment beginBegin = Alignment(
        (-viewWidth + (2 * rotationPoints["a"]!["x"]!)) / viewWidth,
        (-viewHeight + (2 * rotationPoints["a"]!["y"]!)) / viewHeight);
    Alignment beginEnd = Alignment(
        (-viewWidth + (2 * rotationPoints["c"]!["x"]!)) / viewWidth,
        (-viewHeight + (2 * rotationPoints["c"]!["y"]!)) / viewHeight);
    Alignment endBegin = Alignment(
        (-viewWidth + (2 * rotationPoints["b"]!["x"]!)) / viewWidth,
        (-viewHeight + (2 * rotationPoints["b"]!["y"]!)) / viewHeight);
    Alignment endEnd = Alignment(
        (-viewWidth + (2 * rotationPoints["d"]!["x"]!)) / viewWidth,
        (-viewHeight + (2 * rotationPoints["d"]!["y"]!)) / viewHeight);

    // print("x $x");
    // print("y $y");

    // final xPos = x / viewWidth;
    // final yPos = y / viewHeight;

    // print("xPos $xPos");
    // print("yPos $yPos");

    // final a = (-viewWidth + (2 * x)) / viewWidth;
    // final b = (-viewHeight + (2 * y)) / viewHeight;

    // print("a $a");
    // print("b $b");

    // Alignment beginBegin = Alignment(a + xPos, b - yPos);
    // Alignment beginEnd = Alignment(-a + xPos, -b - yPos);
    // Alignment endBegin = Alignment(b - yPos, a + xPos);
    // Alignment endEnd = Alignment(-b - yPos, -a + xPos);

    if (mouseX == -0 || mouseY == -0) {
      beginBegin = Alignment.topRight;
      beginEnd = Alignment.bottomLeft;
      endBegin = Alignment.topLeft;
      endEnd = Alignment.bottomRight;
    }

    // const Alignment beginBegin = Alignment.topRight;
    // const Alignment beginEnd = Alignment.bottomLeft;
    // const Alignment endBegin = Alignment.topLeft;
    // const Alignment endEnd = Alignment.bottomRight;

    return DecorationTween(
        begin: BoxDecoration(
          gradient: LinearGradient(
            begin: beginBegin,
            end: beginEnd,
            colors: const <Color>[
              Colors.indigo,
              Colors.deepPurpleAccent,
              Colors.pink,
            ],
          ),
        ),
        end: BoxDecoration(
          gradient: LinearGradient(
            begin: endEnd,
            end: endBegin,
            colors: const <Color>[
              Colors.indigo,
              Colors.deepPurpleAccent,
              Colors.pink,
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _updateLocation,
      onExit: _clearLocation,
      child: DecoratedBoxTransition(
        decoration: _getTween(context, _x, _y, 2).animate(_animationController),
        child: const Center(child: null),
      ),
    );
  }
}
