import 'package:flutter/material.dart';

// TODO Look into alternatives to the implementation of the effect
// TODO Mess with having multiple tweens
// TODO Allow for scale effecting default animation
// TODO Alow for duration tweeking
class GradientWid extends StatefulWidget {
  const GradientWid(
      {super.key,
      required this.colors,
      required this.scale,
      required this.child,
      required this.tweenSelection});

  final List<Color> colors;
  final double scale;
  final Widget child;
  final String tweenSelection;

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

  DecorationTween _getTween(BuildContext context) {
    Alignment beginBegin;
    Alignment beginEnd;
    Alignment endBegin;
    Alignment endEnd;

    if (_x == -0 || _y == -0) {
      beginBegin = Alignment.topRight;
      beginEnd = Alignment.bottomLeft;
      endBegin = Alignment.topLeft;
      endEnd = Alignment.bottomRight;
    } else {
      final double viewWidth = MediaQuery.of(context).size.width;
      final double viewHeight = MediaQuery.of(context).size.height;

      final double rotationSquareWidth = viewWidth / widget.scale;
      final double rotationSquareHeight = viewHeight / widget.scale;

      final Map<String, Map<String, double>> rotationPoints = {
        "a": {
          "x": _x - (rotationSquareWidth / 2),
          "y": _y - (rotationSquareHeight / 2)
        },
        "b": {
          "x": _x + (rotationSquareWidth / 2),
          "y": _y - (rotationSquareHeight / 2)
        },
        "c": {
          "x": _x + (rotationSquareWidth / 2),
          "y": _y + (rotationSquareHeight / 2)
        },
        "d": {
          "x": _x - (rotationSquareWidth / 2),
          "y": _y + (rotationSquareHeight / 2)
        }
      };

      beginBegin = Alignment(
          ((2 * rotationPoints["b"]!["x"]!) - viewWidth) / viewWidth,
          ((2 * rotationPoints["b"]!["y"]!) - viewHeight) / viewHeight);
      beginEnd = Alignment(
          ((2 * rotationPoints["d"]!["x"]!) - viewWidth) / viewWidth,
          ((2 * rotationPoints["d"]!["y"]!) - viewHeight) / viewHeight);
      endBegin = Alignment(
          ((2 * rotationPoints["a"]!["x"]!) - viewWidth) / viewWidth,
          ((2 * rotationPoints["a"]!["y"]!) - viewHeight) / viewHeight);
      endEnd = Alignment(
          ((2 * rotationPoints["c"]!["x"]!) - viewWidth) / viewWidth,
          ((2 * rotationPoints["c"]!["y"]!) - viewHeight) / viewHeight);
    }

    return DecorationTween(
        begin: BoxDecoration(
          gradient: LinearGradient(
            begin: beginBegin,
            end: beginEnd,
            colors: widget.colors,
          ),
        ),
        end: BoxDecoration(
          gradient: LinearGradient(
            begin: endBegin,
            end: endEnd,
            colors: widget.colors,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: MouseRegion(
        onHover: _updateLocation,
        onExit: _clearLocation,
        child: DecoratedBoxTransition(
          decoration: _getTween(context).animate(_animationController),
          child: widget.child,
        ),
      ),
    );
  }
}
