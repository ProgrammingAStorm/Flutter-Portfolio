import 'package:flutter/material.dart';
import 'dart:math';

// TODO Deal with too small text on smaller screen widths
class FolderButton extends StatefulWidget {
  const FolderButton(
      {super.key,
      required this.title,
      required this.count,
      this.selected = false,
      required this.setTab});

  final String title;
  final int count;
  final bool selected;
  final Function setTab;

  static final theme = <String, dynamic>{
    "button": <String, dynamic>{
      "picked": <bool, ButtonStyle>{
        true: TextButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                side: BorderSide(
                    color: Colors.deepPurpleAccent,
                    strokeAlign: StrokeAlign.outside))),
        false: TextButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              side: BorderSide(
                  color: Colors.deepPurple, strokeAlign: StrokeAlign.outside)),
        ),
      }
    },
    // TODO Make it so I don't need to do it like this
    "padding": <bool, dynamic>{
      true: const EdgeInsets.only(top: 3, left: 3, right: 3),
      false: const EdgeInsets.only(top: 3, left: 3, right: 3)
    }
  };

  static Color? getTabShading(selected) {
    if (selected) {
      return Colors.deepPurpleAccent;
    }
    return Colors.deepPurple;
  }

  static EdgeInsetsGeometry getTabPadding(selected) {
    return theme["padding"][selected];
  }

  @override
  State<FolderButton> createState() => _FolderButtonState();
}

class _FolderButtonState extends State<FolderButton> {
  void changeSelected() {}

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 100,
        // Button Container
        decoration: BoxDecoration(
            // Container Decorations
            color: FolderButton.getTabShading(widget.selected),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            )),
        // Button Padding
        child: Padding(
          padding: FolderButton.getTabPadding(widget.selected),
          // Button
          child: TextButton(
              onPressed: () {
                widget.setTab(widget.count);
              },
              // Style of button itself
              style: FolderButton.theme["button"]?["picked"][widget.selected],
              child: Text(
                  textAlign: TextAlign.center,
                  textScaleFactor: ScaleSize.textScaleFactor(context,
                      maxTextScaleFactor: 1.5),
                  // Text of the button
                  widget.title,
                  style: TextStyle(
                      color: Colors.deepPurpleAccent.shade100,
                      fontSize: 10,
                      height: 1))),
        ),
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
