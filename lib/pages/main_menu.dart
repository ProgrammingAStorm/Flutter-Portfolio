import 'package:flutter/material.dart';
import 'package:portfolio/components/gradient.dart';
import 'package:portfolio/pages/contents.dart';
import '../components/folder.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: const GradientWid(child: Folder()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Contents()))
        },
      ),
    );
  }
}
