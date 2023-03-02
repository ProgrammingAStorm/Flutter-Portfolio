import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

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
  static late Map<String, Function> _tweens;

  late AnimationController _animationController;
  late Function _tween;

  double _x = 0.0;
  double _y = 0.0;

  late double _percentOfDayElapsed;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this)
          ..repeat(reverse: true);

    _tweens = {
      "Mouse": (BuildContext context) {
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
      },
      "Daily": (BuildContext context) {
        Alignment begin;
        Alignment end;

        if (_percentOfDayElapsed == null) {
          begin = const Alignment(-1, 0);
          end = const Alignment(1, 2);

          return DecorationTween(
              begin: BoxDecoration(
                  gradient: LinearGradient(
                      colors: widget.colors, begin: begin, end: end)),
              end: BoxDecoration(
                  gradient: LinearGradient(
                      colors: widget.colors, begin: begin, end: end)));
        } else {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          // Circle is intended to be screen width
          // Radius then is half the width of the screen
          double radius = width / 2;

          // Center of the circle.
          // Intended to be the very bottom center of the screen
          double centerX = radius;
          double centerY = height;

          // Using x = r * sin(a) and y = r * cos(a) to get the coordinates of the start and end points
          // The angle is elapsed percent of 360 degrees
          double beginVectorX = radius * sin(2 * pi * _percentOfDayElapsed);
          double beginVectorY = radius * cos(2 * pi * _percentOfDayElapsed);

          // The end coordinates need to always be on the opposite end of the circle
          // The angle is the same as the start coordinates but shifted 180 degrees
          double endVectorX =
              radius * sin((2 * pi * _percentOfDayElapsed) + pi);
          double endVectorY =
              radius * cos((2 * pi * _percentOfDayElapsed) + pi);

          // The coordinates then need to be added to the center to get the points relative to the position of the circle
          double beginX = centerX + beginVectorX;
          double beginY = centerY + beginVectorY;
          double endX = centerX + endVectorX;
          double endY = centerY + endVectorY;

          // The coordinates then need to be converted from absolute X, Y to relative alignment
          // Relative alignment means: (-1, -1) is top left, (0, 0) is center, and (1, 1) is bottom right
          // Conversion forumli: (2 * x - w) / w and (2 * y - h) / h
          begin = Alignment(
              (2 * beginX - width) / width, (2 * beginY - height) / height);
          end = Alignment(
              (2 * endX - width) / width, (2 * endY - height) / height);

          // The colors are reversed simple because its a better solution to flip the colors than manual offsets
          return DecorationTween(
              begin: BoxDecoration(
                  gradient: LinearGradient(
                      colors: widget.colors.reversed.toList(),
                      begin: begin,
                      end: end)),
              end: BoxDecoration(
                  gradient: LinearGradient(
                      colors: widget.colors.reversed.toList(),
                      begin: begin,
                      end: end)));
        }
      }
    };

    _tween = _tweens[widget.tweenSelection] as Function;

    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final now = DateTime.now();

      setState(() {
        _percentOfDayElapsed =
            ((now.hour * 3600) + (now.minute * 60) + now.second) / 86400;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();

    timer.cancel();
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

  @override
  Widget build(BuildContext context) {
    _tween = _tweens[widget.tweenSelection] as Function;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: MouseRegion(
        onHover: _updateLocation,
        onExit: _clearLocation,
        child: DecoratedBoxTransition(
          decoration: _tween(context).animate(_animationController),
          child: widget.child,
        ),
      ),
    );
  }
}
