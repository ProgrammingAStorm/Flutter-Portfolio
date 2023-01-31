import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  // TODO Allow gradient color changing
  // TODO Allow gradient mouse effect resizing
  // TODO Allow color theme changing
  // TODO Allow gradient speend changing
  // TODO Explaind gradient mouse effect with modal
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'Settings',
          style: TextStyle(color: Colors.deepPurpleAccent.shade100),
        )
      ],
    );
  }
}
