import 'package:flutter/material.dart';
import '/pages/contents/contents.dart';

class WebDevBook extends StatelessWidget {
  const WebDevBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Web Dev's Handbook",
          style: TextStyle(color: Colors.deepPurpleAccent.shade100),
        ),
        TextButton(
            onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Contents()))
                },
            child: const Text("Go"))
      ],
    );
  }
}
