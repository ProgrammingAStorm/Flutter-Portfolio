import 'package:flutter/material.dart';

class Construction extends StatelessWidget {
  const Construction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(children: [
        Text("UNDER CONSTRUCTION",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge),
        Text(
          '''
    There's something I'm planning on putting here, but I'm either working on something I've deemed more important, or I'm am currrently working what's supposed to be here. Please check back later. Thanks for visiting.''',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ]),
    );
  }
}
