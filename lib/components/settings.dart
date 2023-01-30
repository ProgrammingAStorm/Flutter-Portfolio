import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Settings',
          style: TextStyle(color: Colors.deepPurpleAccent.shade100),
        )
      ],
    );
  }
}
