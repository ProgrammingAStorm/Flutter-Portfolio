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
      body: GradientWid(
          child: Center(
              child: Container(
                  width: 600,
                  height: 600,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey.shade200,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.blueGrey)),
                  child: const Padding(
                      padding: EdgeInsets.all(15.0), child: Folder())))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Contents()))
        },
      ),
    );
  }
}
