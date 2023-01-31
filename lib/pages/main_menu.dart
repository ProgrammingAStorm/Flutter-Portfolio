import 'package:flutter/material.dart';
import 'package:portfolio/components/gradient.dart';
import '../components/folder.dart';
import '../components/logo.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientWid(),
          SingleChildScrollView(
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: const [Logo(), Folder()],
            ),
          )
        ],
      ),
    );
  }
}
