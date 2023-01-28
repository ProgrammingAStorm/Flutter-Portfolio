import 'package:flutter/material.dart';
import 'package:portfolio/components/gradient.dart';
import '../components/folder.dart';
import '../components/logo.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO Make logo a child of Appbar,
      body: Stack(children: const [GradientWid(), Logo(), Folder()]),
    );
  }
}
