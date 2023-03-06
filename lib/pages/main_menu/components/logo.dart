import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        //height: ScreenUtil().radius(200),
        child: Wrap(
          children: [
            Stack(
              children: [
                Text(
                  "Programming",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "Programming",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
            Stack(
              children: [
                Text(
                  "AStorm",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "AStorm",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ],
        ));
  }
}
