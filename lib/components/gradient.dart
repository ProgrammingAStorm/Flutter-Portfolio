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

  double x = 0.0;
  double y = 0.0;

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
      x = details.position.dx;
      y = details.position.dy;
      print(x);
      print(y);
    });
  }

  DecorationTween _getTween() {
    return DecorationTween(
        begin: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[
              Colors.indigo,
              Colors.deepPurpleAccent,
              Colors.pink,
            ],
          ),
        ),
        end: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
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
      child: DecoratedBoxTransition(
        decoration: _getTween().animate(_animationController),
        child: const Center(child: null),
      ),
    );
  }
}
