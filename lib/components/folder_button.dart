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

  static Color getBackground(bool selected) {
    if (selected) {
      return Colors.deepPurpleAccent;
    }

    return Colors.deepPurple;
  }

  @override
  State<FolderButton> createState() => _FolderButtonState();
}

class _FolderButtonState extends State<FolderButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      decoration: BoxDecoration(
          color: FolderButton.getBackground(widget.selected),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                side: BorderSide(color: Colors.deepPurple, strokeAlign: 1.0))),
        onPressed: () => {widget.setTab(widget.count)},
        child: Text(
          widget.title,
          style: TextStyle(
              color: Colors.deepPurpleAccent.shade100,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
