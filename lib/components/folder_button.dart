import 'package:flutter/material.dart';

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

  // TODO Fix button styles to look more congruent
  static final theme = <String, dynamic>{
    "button": <String, dynamic>{
      "picked": <bool, ButtonStyle>{
        true: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey.shade400,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                side: BorderSide(
                    color: Colors.blueGrey, strokeAlign: StrokeAlign.outside))),
        false: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                side: BorderSide(
                    color: Colors.blueGrey, strokeAlign: StrokeAlign.outside))),
      }
    },
    "padding": <bool, dynamic>{
      true: const EdgeInsets.only(top: 5, left: 5, right: 5),
      false: const EdgeInsets.only(top: 0, left: 0, right: 0)
    }
  };

  static Color? getTabShading(selected) {
    if (selected) {
      return Colors.blueGrey.shade400;
    }
    return Colors.blueGrey.shade300;
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
    return Container(
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
                // Text of the button
                widget.title,
                style: TextStyle(color: Colors.blueGrey.shade900) // Text Style,
                )),
      ),
    );
  }
}
