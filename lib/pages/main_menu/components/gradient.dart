import 'package:flutter/material.dart';

// TODO Look into alternatives to the implementation of the effect
class GradientWid extends StatefulWidget {
  const GradientWid({super.key, required this.colors, this.scale = 1});

  final List<Color> colors;
  final double scale;

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

  DecorationTween _getTween(BuildContext context, double mouseX, double mouseY,
      double scale, List<Color> colors) {
    Alignment beginBegin;
    Alignment beginEnd;
    Alignment endBegin;
    Alignment endEnd;

    if (mouseX == -0 || mouseY == -0) {
      beginBegin = Alignment.topRight;
      beginEnd = Alignment.bottomLeft;
      endBegin = Alignment.topLeft;
      endEnd = Alignment.bottomRight;
    } else {
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

      beginBegin = Alignment(
          (-viewWidth + (2 * rotationPoints["a"]!["x"]!)) / viewWidth,
          (-viewHeight + (2 * rotationPoints["a"]!["y"]!)) / viewHeight);
      beginEnd = Alignment(
          (-viewWidth + (2 * rotationPoints["c"]!["x"]!)) / viewWidth,
          (-viewHeight + (2 * rotationPoints["c"]!["y"]!)) / viewHeight);
      endBegin = Alignment(
          (-viewWidth + (2 * rotationPoints["b"]!["x"]!)) / viewWidth,
          (-viewHeight + (2 * rotationPoints["b"]!["y"]!)) / viewHeight);
      endEnd = Alignment(
          (-viewWidth + (2 * rotationPoints["d"]!["x"]!)) / viewWidth,
          (-viewHeight + (2 * rotationPoints["d"]!["y"]!)) / viewHeight);
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
            begin: endEnd,
            end: endBegin,
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
          decoration: _getTween(context, _x, _y, widget.scale, widget.colors)
              .animate(_animationController),
          child: Container(),
        ),
      ),
    );
  }
}
